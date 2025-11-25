from models import BadgeRequest
from adapters.ai_provider import IFaceModifier
from compositor import BadgeCompositor

class BadgeGenerationService:
    def __init__(self, ai_adapter: IFaceModifier):
        self.ai_adapter = ai_adapter
        self.compositor = BadgeCompositor()

    def process_request(self, request_id: str):
        badge_req = BadgeRequest.objects.get(id=request_id)
        user = badge_req.user

        try:
            # Step 1: Call AI to alter the face
            # We use the user's existing profile photo from MySQL
            altered_face_file = self.ai_adapter.alter_face(
                source_image_path=user.profile_photo.path,
                modifiers=badge_req.ai_prompt_modifiers
            )
            
            # Save intermediate result
            badge_req.ai_altered_face.save('altered.png', altered_face_file)
            badge_req.save()

            # Step 2: Composite the Badge using Pillow
            user_data = {
                'first_name': user.first_name,
                'last_name': user.last_name,
                'id_code': user.id_code,
                'dob': str(user.date_of_birth),
            }

            # We open the just-saved altered face
            final_badge_file = self.compositor.create_badge(
                user_data=user_data,
                face_image_field=badge_req.ai_altered_face
            )

            # Step 3: Finalize
            badge_req.final_badge.save('final.png', final_badge_file)
            badge_req.status = BadgeRequest.Status.COMPLETED

        except Exception as e:
            badge_req.status = BadgeRequest.Status.FAILED
            # In enterprise, log this to Sentry
            print(f"Error processing badge: {e}")
        finally:
            badge_req.save()