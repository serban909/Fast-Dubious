import os
import django

# Must configure Django before importing models
if not os.environ.get('DJANGO_SETTINGS_MODULE'):
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'settings')
    try:
        django.setup()
    except Exception as e:
        print(f"Failed to setup Django: {e}")
        import sys
        sys.exit(1)

try:
    from backend.models import UserProfile, IdentityCard
except ImportError:
    from models import UserProfile, IdentityCard

import datetime
import random
import os
from PIL import Image, ImageDraw, ImageFont

class BadgeCompositor:
    """
    Compositor for Identity Card badges aligned with Database models.
    """

    def __init__(self, template_path="CIROU_temp2.png", font_path="times.ttf"):
        self.template_path = template_path
        self.font_path = font_path

    def create_badge(self, identity_card, photo_path: str, output_path: str = None) -> str:
        """
        Create a badge with user data and photo using Database object.
        """

        # 1. Load Base Template
        try:
            template = Image.open(self.template_path).convert("RGBA")
        except FileNotFoundError:
            print(f"Error: Template not found at {self.template_path}")
            return None

        # 2. Load and Resize Photo (Left side - original color)
        try:
            face = Image.open(photo_path).convert("RGBA")
            face = face.resize((250, 360))
            template.paste(face, (60, 180), face)

            # 2b. Add second copy on the right side - black & white + transparent
            face_bw = Image.open(photo_path).convert("L")
            face_bw = face_bw.resize((130, 180))
            face_bw_rgba = face_bw.convert("RGBA")
            white_bg = Image.new("RGBA", face_bw_rgba.size, (255, 255, 255, 255))
            face_bw_with_white_bg = Image.alpha_composite(white_bg, face_bw_rgba)
            face_bw_with_white_bg.putalpha(96)
            template.paste(face_bw_with_white_bg, (990, 180), face_bw_with_white_bg)
        except Exception as e:
            print(f"Warning: Could not process photo ({e}). Skipping photo.")

        # 3. Draw Text Data
        draw = ImageDraw.Draw(template)

        try:
            font_header = ImageFont.truetype(self.font_path, 35)
            font_body = ImageFont.truetype(self.font_path, 35)
        except IOError:
            font_header = ImageFont.load_default()
            font_body = ImageFont.load_default()
        
        # Draw ID code
        id_code = identity_card.cnp if identity_card.cnp else ""
        x_position = 420
        y_position = 215

        # Draw Series and Number
        draw.text((690, 180), f"{identity_card.series}", font=font_body, fill="black")
        draw.text((780, 180), f"{identity_card.number}", font=font_body, fill="black")
        
        if len(id_code) == 13:
            draw.text((x_position, y_position), id_code[0], font=font_body, fill="red")
            bbox = draw.textbbox((x_position, y_position), id_code[0], font=font_body)
            offset1 = bbox[2] - bbox[0]
            
            draw.text((x_position + offset1, y_position), id_code[1:7], font=font_body, fill="blue")
            bbox = draw.textbbox((x_position + offset1, y_position), id_code[1:7], font=font_body)
            offset2 = offset1 + (bbox[2] - bbox[0])
            
            draw.text((x_position + offset2, y_position), id_code[7:13], font=font_body, fill="red")
        else:
            draw.text((x_position, y_position), id_code, font=font_body, fill="black")
            
        draw.text((400, 275), f"{identity_card.user.last_name.upper()}", font=font_header, fill="black")
        draw.text((400, 335), f"{identity_card.user.first_name.upper()}", font=font_header, fill="black")
        draw.text((400, 390), f"{identity_card.nationality}", font=font_header, fill="black")
        draw.text((1050, 390), f"{identity_card.sex}", font=font_header, fill="black")
        draw.text((400, 450), f"{identity_card.place_of_birth}", font=font_body, fill="black")
        draw.text((400, 510), f"{identity_card.address}", font=font_body, fill="black")
        draw.text((400, 630), f"{identity_card.issued_by}", font=font_body, fill="black")       
        
        val_text = f"{identity_card.validity_start.strftime('%d.%m.%Y')} - {identity_card.validity_end.strftime('%d.%m.%Y')}"
        draw.text((810, 630), val_text, font=font_body, fill="black")

        # 4. Save Badge
        if not output_path:
            output_path = f"badge_{identity_card.number}.png"

        template.save(output_path, format="PNG")
        print(f"✅ ID Badge created: {output_path}")
        return output_path


# Example usage
if __name__ == "__main__":
    import django
    import sys
    
    # Add project root to path so 'backend.models' can be imported if running as script
    sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'settings')
    try:
        django.setup()
    except Exception as e:
        pass # Already setup

    from backend.models import UserProfile, IdentityCard

    # 1. Fetch User (Popescu)
    user = UserProfile.objects.filter(last_name__iexact="Ion").first()
    if not user:
        # Fallback to any user
        user = UserProfile.objects.first()
    
    if user:
        print(f"👤 Generating badge for: {user.first_name} {user.last_name}")

        # 2. Get or Create Identity Card for this user
        card = IdentityCard.objects.filter(user=user).first()
        if not card:
            # Create dummy card data if missing
            card = IdentityCard.objects.create(
                user=user,
                series="ZR",
                number=str(random.randint(100000, 999999)),
                cnp=user.id_code,
                nationality="Romana / ROU",
                sex="M",
                place_of_birth="Mun. Bucuresti / Sec. 1",
                address=user.address or "Str. Principala 1",
                issued_by="SPCLEP Sec 1",
                validity_start=datetime.date(2023, 1, 1),
                validity_end=datetime.date(2033, 1, 1)
            )
            print("Created new Identity Card record.")
        
        compositor = BadgeCompositor(
            template_path="CIROU_temp2.png", 
            font_path="times.ttf"
        )
        
        # Use existing photo or fallback
        photo = "djtb.jpeg"
        if hasattr(user, 'profile_photo') and user.profile_photo:
             # Check if file exists roughly
             if os.path.exists(user.profile_photo.path):
                 photo = user.profile_photo.path
        
        compositor.create_badge(card, photo, f"badge_{card.number}.png")

    else:
        print("No user found in database.")
