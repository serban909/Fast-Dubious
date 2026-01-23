from backend.models import BadgeRequest
from backend.ai_editor import AIEditor
# Use the logic from comptest.py directly as requested
from comptest import BadgeCompositor, get_random_place
import os
from django.conf import settings
import datetime

class BadgeGenerationService:
    def __init__(self):
        # Robust path finding for templates
        base_dir = settings.BASE_DIR
        
        # Use CIROU_temp2.png first
        template_path = os.path.join(base_dir, "templates", "CIROU_temp2.png")
        if not os.path.exists(template_path):
             # Try backend subdirectory
             template_path = os.path.join(base_dir, "backend", "templates", "CIROU_temp2.png")
             
        # Fallback to CIROU_temp.png if temp2 is missing
        if not os.path.exists(template_path):
             template_path = os.path.join(base_dir, "templates", "CIROU_temp.png")
             if not os.path.exists(template_path):
                 template_path = os.path.join(base_dir, "backend", "templates", "CIROU_temp.png")

        font_path = os.path.join(base_dir, "assets", "fonts", "Roboto-Bold.ttf")
        if not os.path.exists(font_path):
             font_path = os.path.join(base_dir, "backend", "assets", "fonts", "Roboto-Bold.ttf")
             # Fallback to times.ttf which might be in root
             if not os.path.exists(font_path):
                 font_path = "times.ttf"

        self.compositor = BadgeCompositor(template_path=template_path, font_path=font_path)

    def process_request(self, request_id: str):
        badge_req = BadgeRequest.objects.get(id=request_id)
        user = badge_req.user

        try:
            # Step 1: Call AI to alter the face
            # We use the user's existing profile photo from MySQL
            modifiers = badge_req.ai_prompt_modifiers
            prompt_str = ""
            if isinstance(modifiers, dict):
                 prompt_str = modifiers.get('description', '')
            elif isinstance(modifiers, str):
                 prompt_str = modifiers
                 
            if not prompt_str:
                prompt_str = "make it professional"

            # Use absolute path for safety
            if badge_req.source_image:
                 source_path = badge_req.source_image.path
            else:
                 source_path = user.profile_photo.path
            
            try:
                # Try AI Generation (Directly using AIEditor)
                editor = AIEditor.get_instance()
                
                # Prepare output path
                # AIEditor requires an output path.
                output_dir = os.path.join(settings.MEDIA_ROOT, 'badges', 'temp_faces')
                os.makedirs(output_dir, exist_ok=True)
                output_filename = f"altered_{user.id_code}_{badge_req.id}.png"
                output_path = os.path.join(output_dir, output_filename)
                
                print(f"Orchestrator calling AIEditor with prompt: {prompt_str}")
                editor.edit_image(
                    image_path=source_path,
                    prompt=prompt_str,
                    output_path=output_path
                )
                
                # Save to model
                # Ideally we just re-open the file we just wrote
                with open(output_path, 'rb') as f:
                     badge_req.ai_altered_face.save(output_filename, f)

            except Exception as ai_err:
                print(f"AI Generation failed: {ai_err}, using original photo")
                # Fallback: use usage original photo
                badge_req.ai_altered_face.save(f"original_{user.id_code}.png", user.profile_photo)
            
            badge_req.save()

            # Step 2: Prepare User Data (Augmenting with random data like comptest)
            # Fetch IdentityCard from DB
            from backend.models import IdentityCard
            id_card = IdentityCard.objects.filter(user=user).last()
            
            # Find places.csv (only needed if randomizing)
            places_csv = os.path.join(settings.BASE_DIR, "places.csv")
            if not os.path.exists(places_csv):
                 places_csv = os.path.join(settings.BASE_DIR, "backend", "places.csv")
            
            # Extract form overrides from modifiers if present
            # modifiers structure expected: {'description': '...', 'nationality': 'Romania', 'age': '24', ...}
            mods = {}
            if isinstance(modifiers, dict):
                mods = modifiers
            
            should_randomize = mods.get('randomize', False)
            place_data = {}

            if should_randomize:
                place_data = get_random_place(places_csv)
            
            # Construct Validity Dates
            now = datetime.date.today()
            end = now.replace(year=now.year + 5)
            valability_str = f"{now.strftime('%d.%m.%Y')} - {end.strftime('%d.%m.%Y')}"
            
            if id_card:
                # Use DB data (which was populated from form)
                # If randomization is ON, override with random data
                nationality = place_data.get('nationality') if should_randomize else id_card.nationality
                address = place_data.get('address') if should_randomize else (id_card.address or user.address)
                sex = id_card.sex 
                lob = place_data.get('location') if should_randomize else id_card.place_of_birth
                issued_by = place_data.get('issued_by') if should_randomize else id_card.issued_by
                series = place_data.get('series') if should_randomize else id_card.series
                number = place_data.get('number') if should_randomize else id_card.number
                cnp = id_card.cnp if id_card.cnp else place_data.get('number', '1990101123456') 
            else:
                 # Fallback if no identity card (shouldn't happen with new flow)
                 # Use modifiers or random IF requested
                 nationality = mods.get('nationality') or (place_data.get('nationality', 'Romana') if should_randomize else 'Romana')
                 address = mods.get('address') or (user.address if user.address else (place_data.get('address', '') if should_randomize else ''))
                 sex = mods.get('sex') or 'M'
                 lob = place_data.get('location', 'Bucharest') if should_randomize else 'Bucharest'
                 issued_by = place_data.get('issued_by', 'SPCLEP') if should_randomize else 'SPCLEP'
                 series = place_data.get('series', 'XR') if should_randomize else 'XR'
                 number = place_data.get('number', '123456') if should_randomize else '123456'
                 cnp = '1990101000000'

            user_data = {
                'first_name': user.first_name,
                'last_name': user.last_name,
                'id_code': cnp if cnp else user.id_code, 
                'dob': str(user.date_of_birth),
                
                # Filled from Form Data (via IdentityCard) or Random Place
                'nationality': nationality,
                'sex': sex,
                'lob': lob, 
                'address': address,
                'issued_by': issued_by,
                'valability': valability_str,
                'series': series,
                'number': number
            }

            # Step 3: Composite the Badge using Pillow
            # We use the AI altered face we just saved
            # BadgeCompositor logic expects a file path usually.
            
            face_path = badge_req.ai_altered_face.path
            
            # Create a temporary output path for the result
            out_filename = f"final_badge_{user.id_code}.png"
            out_path = os.path.join(settings.MEDIA_ROOT, "badges", "temp", out_filename)
            os.makedirs(os.path.dirname(out_path), exist_ok=True)
            
            generated_badge_path = self.compositor.create_badge(
                user_data=user_data,
                photo_path=face_path,
                output_path=out_path
            )

            # Step 4: Finalize
            # Read the generated file back into the Django Field
            with open(generated_badge_path, 'rb') as f:
                 badge_req.final_badge.save(out_filename, f)
                 
            badge_req.status = BadgeRequest.Status.COMPLETED

        except Exception as e:
            badge_req.status = BadgeRequest.Status.FAILED
            # In enterprise, log this to Sentry
            print(f"Error processing badge: {e}")
            import traceback
            traceback.print_exc()
        finally:
            badge_req.save()