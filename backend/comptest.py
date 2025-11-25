import os
from io import BytesIO
from PIL import Image, ImageDraw, ImageFont

class BadgeCompositor:
    """
    Simple engine that uses Pillow to combine a badge template + photo + text.
    No Django dependencies.
    """

    def __init__(self, template_path="badge_template.png", font_path="times.ttf"):
        self.template_path = template_path
        self.font_path = font_path

    def create_badge(self, user_data: dict, photo_path: str, output_path: str = None) -> str:
        """
        Create a badge with user data and photo.

        Args:
            user_data (dict): Dictionary with keys: first_name, last_name, id_code, dob
            photo_path (str): Path to the photo file
            output_path (str): Path to save the final badge (default: badge_<id_code>.png)

        Returns:
            str: Path to the saved badge image
        """

        # 1. Load Base Template
        template = Image.open(self.template_path).convert("RGBA")

        # 2. Load and Resize Photo
        face = Image.open(photo_path).convert("RGBA")
        face = face.resize((250, 360))  # adjust size
        template.paste(face, (60, 180), face)  # adjust coordinates

        # 3. Draw Text Data
        draw = ImageDraw.Draw(template)

        try:
            font_header = ImageFont.truetype(self.font_path, 35)
            font_body = ImageFont.truetype(self.font_path, 35)
        except IOError:
            print("why")
            font_header = ImageFont.load_default()
            font_body = ImageFont.load_default()
            
        draw.text((420, 215), f"{user_data['id_code']}", font=font_body, fill="black")
        draw.text((400, 275), f"{user_data['last_name']}", font=font_header, fill="black", )
        draw.text((400, 335), f"{user_data['first_name']}", font=font_header, fill="black", )
        draw.text((400, 390), f"{user_data['nationality']}", font=font_header, fill="black", )
        draw.text((400, 450), f"{user_data['lob']}", font=font_body, fill="black")

        # 4. Save Badge
        if not output_path:
            output_path = f"badge_{user_data['id_code']}.png"

        template.save(output_path, format="PNG")
        return output_path


# Example usage
if __name__ == "__main__":
    user_info = {
        "first_name": "Daniel",
        "last_name": "Trompeta",
        "nationality": "Ungur",
        "id_code": "0212059536198",
        "lob": "Beius, Bihor"
    }

    compositor = BadgeCompositor(
        template_path="backend/CIROU_temp2.png",  # must exist in current folder
        font_path="times.ttf"          # optional, falls back if missing
    )

    result_path = compositor.create_badge(user_info, "backend/djtb.jpeg")
    print(f"Badge created: {result_path}")
