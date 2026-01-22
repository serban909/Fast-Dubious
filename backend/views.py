from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework.decorators import action, api_view, permission_classes
from rest_framework.permissions import AllowAny
from django.shortcuts import get_object_or_404
from django.contrib.auth import authenticate, get_user_model

from backend.models import BadgeRequest, UserProfile
from serializers import BadgeRequestSerializer, UserProfileSerializer
from orchestrator import BadgeGenerationService
from ai_provider import BananaFaceAdapter

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
        # Ensure we don't duplicate if one exists
        if UserProfile.objects.filter(user_id=user_id).exists():
             return Response({"error": "Profile already exists"}, status=status.HTTP_400_BAD_REQUEST)
        
        # We need to set the 'user' field on the UserProfile
        # The serializer expects 'user' to be a User instance or PK? 
        # UserProfileSerializer defined in previous read_file did NOT include 'user' field in 'fields'.
        # I should update serializer or handle creation manually.
        
        # Manual creation for simplicity with the link
        try:
             photo = request.FILES.get('profile_photo')
             profile = UserProfile.objects.create(
                 user_id=user_id,
                 id_code=data.get('id_code', f"TMP{user_id}"), # Fallback
                 first_name=data.get('first_name', ''),
                 last_name=data.get('last_name', ''),
                 date_of_birth=data.get('date_of_birth', '2000-01-01'),
                 profile_photo=photo
             )
             return Response(UserProfileSerializer(profile).data, status=status.HTTP_201_CREATED)
        except Exception as e:
             return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
        
@action(detail=False, methods=['get'])
def me(self, request):
    # Endpoint to get profile by user_id query param
    user_id = request.query_params.get('user_id')
    profile = get_object_or_404(UserProfile, user_id=user_id)
    return Response(UserProfileSerializer(profile).data)

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
        
        # user_id passed is likely the Django Auth User ID.
        # We need the UserProfile.
        user_profile = get_object_or_404(UserProfile, user_id=user_id)
        
        # 2. Create Audit Record
        badge_req = BadgeRequest.objects.create(
            user=user_profile, # Changed from user to user_profile because BadgeRequest links to UserProfile?
            # Wait, BadgeRequest model definition: 'user' field links to UserProfile?
            # Let's check model definition. Yes: user = models.ForeignKey(UserProfile, ...)
            ai_prompt_modifiers=modifiers,
            status=BadgeRequest.Status.PROCESSING
        )

        # 3. Trigger Processing
        # CRITICAL: In a real enterprise app, pass 'badge_req.id' to Celery here.
        # For this example, we run synchronously.
        adapter = BananaFaceAdapter()
        service = BadgeGenerationService(ai_adapter=adapter)
        service.process_request(badge_req.id)

        # 4. Return Status
        badge_req.refresh_from_db()
        return Response({
            "request_id": badge_req.id,
            "status": badge_req.status,
            "badge_url": badge_req.final_badge.url if badge_req.final_badge else None
        }, status=status.HTTP_201_CREATED)

    @action(detail=True, methods=['get'])
    def status(self, request, pk=None):
        badge_req = get_object_or_404(BadgeRequest, pk=pk)
        return Response({
            "status": badge_req.status,
            "badge_url": badge_req.final_badge.url if badge_req.final_badge else None
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