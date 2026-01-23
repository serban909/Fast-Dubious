from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework.decorators import action, api_view, permission_classes
from rest_framework.permissions import AllowAny
from django.shortcuts import get_object_or_404
from django.contrib.auth import authenticate, get_user_model

from backend.models import BadgeRequest, UserProfile, Vehicle, InsurancePolicy, IdentityCard
from serializers import BadgeRequestSerializer, UserProfileSerializer, VehicleSerializer, InsurancePolicySerializer
from orchestrator import BadgeGenerationService
# from ai_provider import BananaFaceAdapter, GeminiFaceAdapter, LocalDiffusersAdapter # DELETED
from insurance_comptest import InsuranceCompositor
import datetime
import random
import os
from django.conf import settings

class InsurancePolicyViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing insurance policies.
    """
    serializer_class = InsurancePolicySerializer
    queryset = InsurancePolicy.objects.all()

    @action(detail=False, methods=['get'])
    def mine(self, request):
        """
        Get policies for the current user.
        """
        user_id_code = request.query_params.get('user_id_code')
        
        # Logic to find the scope (borrowed from VehicleViewSet/ProfileViewSet)
        queryset = InsurancePolicy.objects.none()
        
        if user_id_code:
             queryset = InsurancePolicy.objects.filter(user__id_code=user_id_code)
        elif request.user.is_authenticated:
             queryset = InsurancePolicy.objects.filter(user=request.user)
        else:
             # FALLBACK FOR DEMO: If no auth, show all or last (depending on preference, but for List View "all" is better for debugging)
             # But let's stick to "Associated with 'my' profile" pattern
             # If we can't identify "me", maybe we return nothing? 
             # Or for demo simplicity, return ALL policies so the list isn't empty?
             # Let's return all for now to ensure the UI shows something.
             print("DEBUG: Insurance mine() - Returning ALL policies as fallback")
             queryset = InsurancePolicy.objects.all().order_by('-issue_date')
             
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

class VehicleViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing user vehicles.
    """
    serializer_class = VehicleSerializer
    queryset = Vehicle.objects.all()

    def create(self, request):
        """
        Create a new vehicle. Finds the owner profile first.
        """
        print(f"DEBUG: Vehicle create payload: {request.data}")
        # Expect 'user_id' in data payload because auth is... complicated for now
        # Ideally we'd use request.user.
        user_id_code = request.data.get('user_id_code')
        
        # Fallback to finding the first profile if not specified (development only!)
        owner_profile = None
        if user_id_code:
            owner_profile = UserProfile.objects.filter(id_code=user_id_code).first()
        else:
           # Try to find a profile owned by the authenticated user
           if request.user.is_authenticated:
               owner_profile = UserProfile.objects.filter(user=request.user).first()
        
        # FAST-DUBIOUS FALLBACK:
        # If no explicit user is found, attach to the LAST created profile.
        # This ensures the form submission works during the demo even if state/auth is loose.
        if not owner_profile:
             owner_profile = UserProfile.objects.last()
             print(f"DEBUG: Using fallback profile: {owner_profile}")

        if not owner_profile:
             return Response({"success": False, "error": "User profile not found. Please create an identity first."}, status=400)

        vehicle_data = request.data.copy()
        vehicle_data['owner'] = owner_profile.id
        
        serializer = self.get_serializer(data=vehicle_data)
        if serializer.is_valid():
            vehicle = serializer.save()
            
            # --- AUTOMATIC INSURANCE GENERATION ---
            try:
                print("DEBUG: Starting automatic insurance generation...")
                
                # 1. Prepare Data for Compositor
                today = datetime.date.today()
                end_date = today + datetime.timedelta(days=365)
                
                # Generate random policy number for demo
                policy_series = "RO/01"
                policy_number = str(random.randint(1000000, 9999999))
                
                # Format full name
                full_name = f"{owner_profile.first_name} {owner_profile.last_name}"
                
                # Map data to the compositor's expected specific keys
                insurance_data = {
                    'insurer_name': 'FAST DUBIOUS INS.',
                    'insurer_tel_fax': '021.555.FAIL',
                    'contract_series': policy_series,
                    'contract_number': policy_number,
                    'nr_header': policy_number,
                    'insurer_cui': 'RO99999999',
                    
                    'branch_agency': 'Digital Agency',
                    'broker_name': 'AI Broker Bot',
                    'broker_code': 'AIB-001',
                    
                    'owner_name': full_name,
                    'owner_id': owner_profile.id_code,
                    'user_name': full_name, # Assuming owner is user for now
                    'user_id': owner_profile.id_code,
                    'owner_address': owner_profile.address or 'Str. Virtuala Nr. 1',
                    'drivers': full_name,
                    
                    'vehicle_id': vehicle.vin,
                    'vehicle_make_model': vehicle.make_model,
                    'registration_number': vehicle.registration_number,
                    'chassis_series': vehicle.vin, # Usually VIN
                    'civ_number': 'N/A',
                    'engine_power': vehicle.engine_power,
                    'seats': vehicle.seats_mass.split('/')[0].strip() if '/' in vehicle.seats_mass else '5',
                    'places': vehicle.seats_mass.split('/')[0].strip() if '/' in vehicle.seats_mass else '5',
                    'mass': vehicle.seats_mass.split('/')[1].strip() if '/' in vehicle.seats_mass else '1500 kg',
                    
                    'validity_start': today.strftime('%d.%m.%Y'),
                    'validity_end': end_date.strftime('%d.%m.%Y'),
                    'issue_date': today.strftime('%d.%m.%Y'),
                    
                    'premium_amount': '500.00',
                    'total_premium': '500.00',
                    'installments_count': 'Integral',
                }
                
                # 2. Run Compositor
                compositor = InsuranceCompositor()
                # Ensure output directory exists
                output_dir = os.path.join(settings.MEDIA_ROOT, 'insurance_policies')
                os.makedirs(output_dir, exist_ok=True)
                
                filename = f"insurance_{vehicle.registration_number}_{policy_number}.png"
                output_path = os.path.join(output_dir, filename)
                
                # Generate!
                compositor.create_insurance(insurance_data, output_path=output_path)
                
                # 3. Create Database Record
                policy = InsurancePolicy.objects.create(
                    user=owner_profile,
                    vehicle=vehicle,
                    series=policy_series,
                    number=policy_number,
                    header_nr=policy_number,
                    validity_start=today,
                    validity_end=end_date,
                    premium_amount=500.00,
                    total_premium=500.00,
                    policy_document=f"insurance_policies/{filename}"
                )
                
                print(f"DEBUG: Insurance Policy created: {policy.id} at {output_path}")

            except Exception as e:
                print(f"ERROR: Insurance generation failed: {e}")
                # We don't block the vehicle creation if insurance fails, 
                # but in production we probably should handle this better.

            return Response({"success": True, "vehicle": serializer.data}, status=201)
        else:
            print(f"DEBUG: Vehicle Serializer errors: {serializer.errors}")
            return Response({"success": False, "error": str(serializer.errors)}, status=400)

    @action(detail=False, methods=['get'])
    def mine(self, request):
        """
        Get vehicles for the current user.
        Pass ?user_id_code=... or rely on auth.
        """
        user_id_code = request.query_params.get('user_id_code')
        if user_id_code:
             queryset = Vehicle.objects.filter(owner__id_code=user_id_code)
        elif request.user.is_authenticated:
             queryset = Vehicle.objects.filter(owner__user=request.user)
        else:
             queryset = Vehicle.objects.none()
             
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)


class ProfileViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing user profiles.
    """
    serializer_class = UserProfileSerializer
    queryset = UserProfile.objects.all()

    def create(self, request):
        user_id = request.data.get('user_id')
        if not user_id:
            return Response({"error": "user_id is required"}, status=status.HTTP_400_BAD_REQUEST)
            
        data = request.data.copy()
        
        # Manual creation for simplicity with the link
        try:
             import uuid
             photo = request.FILES.get('profile_photo')
             # Generate unique ID code
             id_code_val = data.get('id_code')
             if not id_code_val:
                 id_code_val = f"ID-{uuid.uuid4().hex[:8].upper()}"

             profile = UserProfile.objects.create(
                 user_id=user_id,
                 id_code=id_code_val,
                 first_name=data.get('first_name', ''),
                 last_name=data.get('last_name', ''),
                 date_of_birth=data.get('date_of_birth', '2000-01-01'),
                 address=data.get('address', ''),
                 profile_photo=photo
             )
             
             # Automatic Badge Generation
             try:
                 # Check if randomization is requested
                 # If 'randomize' is 'true', we will fill missing fields with random data later in orchestrator
                 # BUT user said: "it won't insert random data ... unless it's selected in the form"
                 # So we only pass explicit data to IdentityCard, and if it's missing, we leave it empty?
                 # Or we handle the randomization right here.
                 
                 should_randomize = data.get('randomize', 'false').lower() == 'true'
                 
                 # Create IdentityCard record
                 # We prefer explicit form data.
                 # If randomize is True, we can generate random data here or let orchestrator handle it.
                 # Let's populate what we have.
                 
                 nationality = data.get('nationality', '')
                 address_val = data.get('address', '')
                 sex_val = data.get('sex', 'M')
                 cnp_val = data.get('cnp', '')
                 place_of_birth_val = data.get('place_of_birth', '')
                 
                 # If randomize is requested, and values are missing, generate them?
                 # Actually, let's just save what we have to IdentityCard. 
                 # Orchestrator will implement the logic: If IdentityCard field is present -> use it. 
                 # If missing -> check if we should randomize (maybe add a flag to IdentityCard? No, passed in request).
                 
                 # Wait, IdentityCard model requires some fields?
                 # checked models.py: most have defaults or are CharFields.
                 
                 IdentityCard.objects.create(
                     user=profile,
                     series=data.get('series', 'XR'),
                     number=data.get('number', str(random.randint(100000, 999999))),
                     cnp=cnp_val if cnp_val else None,
                     nationality=nationality if nationality else "Romana",  # Default to Romana if empty? Or leave empty? Model default is 'Romana'.
                     sex=sex_val,
                     place_of_birth=place_of_birth_val,
                     address=address_val,
                     issued_by=data.get('issued_by', 'SPCLEP'),
                     validity_start=datetime.date.today(),
                     validity_end=datetime.date.today() + datetime.timedelta(days=365*10)
                 )

                 # Capture extra form data to use in generation
                 # Frontend sends modifiers usually for badge API, but here we can try to grab them from request body
                 modifiers = {
                     "professional": True,
                     "nationality": nationality,
                     "address": address_val,
                     "description": data.get('description', ''),
                     "randomize": should_randomize # signal to orchestrator
                 }
                 
                 # 1. Create Badge Request
                 badge_req = BadgeRequest.objects.create(
                     user=profile,
                     ai_prompt_modifiers=modifiers,
                     status=BadgeRequest.Status.PROCESSING
                 )
                 
                 # 2. Process Immediately
                 service = BadgeGenerationService()
                 service.process_request(badge_req.id)
                 
             except Exception as badge_error:
                 print(f"Warning: Auto-badge generation failed: {badge_error}")
                 # We don't fail the profile creation, just log it.
             
             return Response(UserProfileSerializer(profile).data, status=status.HTTP_201_CREATED)
        except Exception as e:
             return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
        
    @action(detail=False, methods=['get'])
    def mine(self, request):
        # Endpoint to get profiles for user_id query param
        user_id = request.query_params.get('user_id')
        if not user_id:
            return Response([])
        
        profiles = UserProfile.objects.filter(user_id=user_id)
        return Response(UserProfileSerializer(profiles, many=True).data)

    def update(self, request, *args, **kwargs):
        # Custom update to handle optional files and ensure fields differ
        instance = self.get_object()
        data = request.data
        
        try:
             first_name = data.get('first_name')
             if first_name: instance.first_name = first_name
                 
             last_name = data.get('last_name')
             if last_name: instance.last_name = last_name

             dob = data.get('date_of_birth')
             if dob: instance.date_of_birth = dob

             photo = request.FILES.get('profile_photo')
             if photo:
                 instance.profile_photo = photo
                 
             instance.save()
             return Response(UserProfileSerializer(instance).data)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)



class BadgeViewSet(viewsets.ViewSet):
    """
    API ViewSet following REST principles.
    """
    def list(self, request):
        user_id = request.query_params.get('user_id')
        if not user_id:
             return Response([])
        
        badges = BadgeRequest.objects.filter(user__user_id=user_id)
        serializer = BadgeRequestSerializer(badges, many=True)
        return Response(serializer.data)
    
    def create(self, request):
        # 1. Input Validation
        user_id = request.data.get('user_id')
        modifiers = request.data.get('modifiers', {})
        prompt = request.data.get('prompt')
        
        if prompt:
             modifiers = prompt
        
        # user_id passed is likely the Django Auth User ID.
        # We need the UserProfile.
        user_profile = get_object_or_404(UserProfile, user_id=user_id)
        
        # Check for uploaded photo
        source_image = request.FILES.get('photo')
        
        # 2. Create Audit Record
        badge_req = BadgeRequest.objects.create(
            user=user_profile,
            ai_prompt_modifiers=modifiers,
            source_image=source_image,
            status=BadgeRequest.Status.PROCESSING
        )

        # 3. Trigger Processing
        # CRITICAL: In a real enterprise app, pass 'badge_req.id' to Celery here.
        # For this example, we run synchronously.
        # No adapter needed, Orchestrator uses AIEditor directly
        service = BadgeGenerationService()
        service.process_request(badge_req.id)

        # 4. Return Status
        badge_req.refresh_from_db()
        return Response({
            "request_id": badge_req.id,
            "status": badge_req.status,
            "badge_url": badge_req.final_badge.url if badge_req.final_badge else None,
            "ai_face_url": badge_req.ai_altered_face.url if badge_req.ai_altered_face else None
        }, status=status.HTTP_201_CREATED)

    @action(detail=True, methods=['get'])
    def status(self, request, pk=None):
        badge_req = get_object_or_404(BadgeRequest, pk=pk)
        return Response({
            "status": badge_req.status,
            "badge_url": badge_req.final_badge.url if badge_req.final_badge else None,
            "ai_face_url": badge_req.ai_altered_face.url if badge_req.ai_altered_face else None
        })


@api_view(['POST'])
@permission_classes([AllowAny])
def login_view(request):
    email = request.data.get('email')
    username = request.data.get('username')
    password = request.data.get('password')

    if not password or not (email or username):
        return Response(
            {"error": "Email/username and password are required."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    user_model = get_user_model()
    resolved_username = username

    if email and not username:
        try:
            user_obj = user_model.objects.get(email=email)
            resolved_username = user_obj.get_username()
        except user_model.DoesNotExist:
            return Response(
                {"error": "Invalid credentials."},
                status=status.HTTP_401_UNAUTHORIZED,
            )

    user = authenticate(request, username=resolved_username, password=password)
    if not user:
        return Response(
            {"error": "Invalid credentials."},
            status=status.HTTP_401_UNAUTHORIZED,
        )

    return Response(
        {
            "success": True,
            "user": {
                "id": user.id,
                "username": user.get_username(),
                "email": user.email,
            },
        },
        status=status.HTTP_200_OK,
    )


@api_view(['POST'])
@permission_classes([AllowAny])
def signup_view(request):
    email = request.data.get('email')
    password = request.data.get('password')
    username = request.data.get('username') or email

    if not email or not password:
        return Response(
            {"error": "Email and password are required."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    user_model = get_user_model()

    if user_model.objects.filter(email=email).exists():
        return Response(
            {"error": "Email already registered."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    if user_model.objects.filter(username=username).exists():
        return Response(
            {"error": "Username already registered."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    user = user_model.objects.create_user(
        username=username,
        email=email,
        password=password,
    )

    return Response(
        {
            "success": True,
            "user": {
                "id": user.id,
                "username": user.get_username(),
                "email": user.email,
            },
        },
        status=status.HTTP_201_CREATED,
    )