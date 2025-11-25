import os
import csv
import random
from io import BytesIO
from PIL import Image, ImageDraw, ImageFont


def get_random_name(csv_path="names.csv"):
    """
    Get a random first name and last name from the CSV file.
    
    Args:
        csv_path (str): Path to the CSV file containing names
                       Options: 
                       - "names.csv" or "names_english.csv" (English)
                       - "names_romanian.csv" (Romanian)
                       - "names_hungarian.csv" (Hungarian)
                       - "names_chinese.csv" (Chinese)
        
    Returns:
        dict: Dictionary with 'first_name' and 'last_name' keys
    """
    names = []
    try:
        with open(csv_path, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                names.append({
                    'first_name': row['first_name'],
                    'last_name': row['last_name']
                })
        
        if not names:
            print(f"Warning: {csv_path} is empty. Using default name.")
            return {'first_name': 'John', 'last_name': 'Doe'}
            
        return random.choice(names)
        
    except FileNotFoundError:
        print(f"Warning: {csv_path} not found. Using default name.")
        return {'first_name': 'John', 'last_name': 'Doe'}
    except Exception as e:
        print(f"Error reading CSV: {e}. Using default name.")
        return {'first_name': 'John', 'last_name': 'Doe'}


def get_random_name_by_language(language="english"):
    """
    Get a random name based on language.
    
    Args:
        language (str): Language choice - "english", "romanian", "hungarian", or "chinese"
        
    Returns:
        dict: Dictionary with 'first_name' and 'last_name' keys
    """
    language_files = {
        "english": "names.csv",
        "romanian": "names_romanian.csv",
        "hungarian": "names_hungarian.csv",
        "chinese": "names_chinese.csv"
    }
    
    csv_file = language_files.get(language.lower(), "names.csv")
    return get_random_name(csv_file)


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

        # 2. Load and Resize Photo (Left side - original color)
        face = Image.open(photo_path).convert("RGBA")
        face = face.resize((250, 360))  # adjust size
        template.paste(face, (60, 180), face)  # adjust coordinates

        # 2b. Add second copy on the right side - black & white + transparent
        face_bw = Image.open(photo_path).convert("L")  # Convert to grayscale (L mode)
        face_bw = face_bw.resize((130, 180))  # same size as original
        
        # Convert grayscale to RGBA
        face_bw_rgba = face_bw.convert("RGBA")
        
        # Create a white background
        white_bg = Image.new("RGBA", face_bw_rgba.size, (255, 255, 255, 255))
        
        # Composite the B&W image onto the white background
        # This replaces any transparent areas with white
        face_bw_with_white_bg = Image.alpha_composite(white_bg, face_bw_rgba)
        
        # Apply transparency to the entire image
        alpha = 96  # 0=fully transparent, 255=fully opaque (128 = 50% transparent)
        face_bw_with_white_bg.putalpha(alpha)
        
        # Paste the transparent B&W image with white background on the right side
        template.paste(face_bw_with_white_bg, (990, 180), face_bw_with_white_bg)  # adjust coordinates as needed

        # 3. Draw Text Data
        draw = ImageDraw.Draw(template)

        try:
            font_header = ImageFont.truetype(self.font_path, 35)
            font_body = ImageFont.truetype(self.font_path, 35)
        except IOError:
            print("why")
            font_header = ImageFont.load_default()
            font_body = ImageFont.load_default()
        
        # Draw ID code with colored parts
        # Format: 0(red) 212059(blue) 536198(red)
        id_code = user_data['id_code']
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
            
        draw.text((400, 275), f"{user_data['last_name'].upper()}", font=font_header, fill="black", )
        draw.text((400, 335), f"{user_data['first_name'].upper()}", font=font_header, fill="black", )
        draw.text((400, 390), f"{user_data['nationality']}", font=font_header, fill="black", )
        draw.text((400, 450), f"{user_data['lob']}", font=font_body, fill="black")

        # 4. Save Badge
        if not output_path:
            output_path = f"badge_{user_data['id_code']}.png"

        template.save(output_path, format="PNG")
        return output_path


# Example usage
if __name__ == "__main__":
    # Get random name from CSV
    # Choose one of the following:
    # random_name = get_random_name("names.csv")              # English (default)
    # random_name = get_random_name("names_romanian.csv")     # Romanian
    # random_name = get_random_name("names_hungarian.csv")    # Hungarian
    # random_name = get_random_name("names_chinese.csv")      # Chinese
    
    # OR use the helper function:
    random_name = get_random_name_by_language("english")  # Change to: romanian, hungarian, or chinese
    
    print(f"🎲 Using random name: {random_name['first_name']} {random_name['last_name']}")
    
    user_info = {
        "first_name": random_name['first_name'],
        "last_name": random_name['last_name'],
        "nationality": "Ungur / HU",
        "id_code": "0212059536198",
        "lob": "Beius, Bihor"
    }

    compositor = BadgeCompositor(
        template_path="CIROU_temp2.png",  # must exist in current folder
        font_path="times.ttf"          # optional, falls back if missing
    )

    result_path = compositor.create_badge(user_info, "djtb.jpeg")
    print(f"✅ Badge created: {result_path}")
