from PIL import Image, ImageDraw, ImageFont
import os
from django.conf import settings
from io import BytesIO
from django.core.files.base import ContentFile

class BadgeCompositor:
    def __init__(self, template_path=None, font_path=None):
        from django.conf import settings
        base_dir = getattr(settings, "BASE_DIR", os.getcwd())
        self.TEMPLATE_PATH = template_path or os.path.join(base_dir, "templates", "CIROU_temp.png")
        self.FONT_PATH = font_path or os.path.join(base_dir, "assets", "fonts", "Roboto-Bold.ttf")
    
    #TEMPLATE_PATH = os.path.join(settings.BASE_DIR, 'templates', 'CIROU_temp.png')
    #FONT_PATH = os.path.join(settings.BASE_DIR, 'assets', 'fonts', 'Roboto-Bold.ttf')

    def create_badge(self, user_data: dict, face_image_field) -> ContentFile:
        # 1. Load Base Template
        with Image.open(self.TEMPLATE_PATH) as template:
            template = template.convert("RGBA")
            
            # 2. Load and Resize AI Altered Face
            with Image.open(face_image_field) as face:
                face = face.convert("RGBA")
                # Resize face to fit the template box (Coordinates are hypothetical)
                face = face.resize((300, 300)) 
                # Paste face at specific coordinates (x=50, y=100)
                template.paste(face, (50, 100), face)

            # 3. Draw Text Data
            draw = ImageDraw.Draw(template)
            
            # Handle Fonts (Fallbacks included for safety)
            try:
                font_header = ImageFont.truetype(self.FONT_PATH, 40)
                font_body = ImageFont.truetype(self.FONT_PATH, 24)
            except IOError:
                font_header = ImageFont.load_default()
                font_body = ImageFont.load_default()

            # Write Data
            # (Coordinates need to be calibrated to your specific template)
            draw.text((400, 100), f"{user_data['first_name']} {user_data['last_name']}", font=font_header, fill="black")
            draw.text((400, 160), f"ID: {user_data['id_code']}", font=font_body, fill="gray")
            draw.text((400, 200), f"DOB: {user_data['dob']}", font=font_body, fill="gray")

            # 4. Save to Buffer
            output_buffer = BytesIO()
            template.save(output_buffer, format="PNG")
            
            return ContentFile(output_buffer.getvalue(), name=f"badge_{user_data['id_code']}.png")