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
                
                # 2b. Add second copy on the right side - black & white + transparent
                face_bw = face.convert("L")  # Convert to grayscale
                face_bw_rgba = face_bw.convert("RGBA")
                
                # Create a white background
                white_bg = Image.new("RGBA", face_bw_rgba.size, (255, 255, 255, 255))
                
                # Composite the B&W image onto the white background
                face_bw_with_white_bg = Image.alpha_composite(white_bg, face_bw_rgba)
                
                # Apply transparency
                face_bw_with_white_bg.putalpha(128)  # 0=transparent, 255=opaque
                
                # Paste the transparent B&W image with white background on the right side
                template.paste(face_bw_with_white_bg, (650, 100), face_bw_with_white_bg)

            # 3. Draw Text Data
            draw = ImageDraw.Draw(template)
            
            # Handle Fonts (Fallbacks included for safety)
            try:
                font_header = ImageFont.truetype(self.FONT_PATH, 40)
                font_body = ImageFont.truetype(self.FONT_PATH, 24)
            except IOError:
                font_header = ImageFont.load_default()
                font_body = ImageFont.load_default()

            # Write Data - adapted from comptest.py layout
            # Use safe .get lookups so missing optional fields won't raise KeyError
            
            # Draw ID code with colored parts
            # Format: 0(red) 212059(blue) 536198(red)
            id_code = user_data.get('id_code', '')
            x_position = 420
            y_position = 215
            
            if len(id_code) == 13:  # Assuming format: 0212059536198
                # First character (0) in red
                draw.text((x_position, y_position), id_code[0], font=font_body, fill="red")
                # Calculate width of first character to offset next part
                bbox = draw.textbbox((x_position, y_position), id_code[0], font=font_body)
                offset1 = bbox[2] - bbox[0]
                
                # Middle 6 digits (212059) in blue
                draw.text((x_position + offset1, y_position), id_code[1:7], font=font_body, fill="blue")
                bbox = draw.textbbox((x_position + offset1, y_position), id_code[1:7], font=font_body)
                offset2 = offset1 + (bbox[2] - bbox[0])
                
                # Last 6 digits (536198) in red
                draw.text((x_position + offset2, y_position), id_code[7:13], font=font_body, fill="red")
            else:
                # Fallback: draw entire ID in black if format doesn't match
                draw.text((x_position, y_position), id_code, font=font_body, fill="black")
            
            draw.text((400, 275), f"{user_data.get('last_name', '').upper()}", font=font_header, fill="black")
            draw.text((400, 335), f"{user_data.get('first_name', '').upper()}", font=font_header, fill="black")

            # Prefer optional fields (nationality, lob) if provided — otherwise show DOB as a fallback
            if user_data.get('nationality') or user_data.get('lob'):
                if user_data.get('nationality'):
                    draw.text((400, 390), f"{user_data.get('nationality')}", font=font_header, fill="black")
                if user_data.get('lob'):
                    draw.text((400, 450), f"{user_data.get('lob')}", font=font_body, fill="black")
            else:
                draw.text((400, 390), f"DOB: {user_data.get('dob', '')}", font=font_body, fill="gray")

            # 4. Save to Buffer
            output_buffer = BytesIO()
            template.save(output_buffer, format="PNG")
            
            return ContentFile(output_buffer.getvalue(), name=f"badge_{user_data['id_code']}.png")