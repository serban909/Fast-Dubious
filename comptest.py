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
                    'last_name': row['last_name'],
                    'sex': row.get('sex', 'M') # Default to M if missing
                })
        
        if not names:
            print(f"Warning: {csv_path} is empty. Using default name.")
            return {'first_name': 'John', 'last_name': 'Doe', 'sex': 'M'}
            
        return random.choice(names)
        
    except FileNotFoundError:
        print(f"Warning: {csv_path} not found. Using default name.")
        return {'first_name': 'John', 'last_name': 'Doe', 'sex': 'M'}
    except Exception as e:
        print(f"Error reading CSV: {e}. Using default name.")
        return {'first_name': 'John', 'last_name': 'Doe', 'sex': 'M'}


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


def generate_random_cnp(sex_char='M'):
    """
    Generate a realistic random CNP (Cod Numeric Personal).
    Format: S AA LL ZZ JJ NNN C
    S: Gender (1/5=Male, 2/6=Female)
    AA: Year (last 2 digits)
    LL: Month
    ZZ: Day
    JJ: County (01-52) - randomly simplified
    NNN: Serial (001-999) - randomly simplified
    C: Control digit (randomly simplified)
    """
    import datetime
    
    # 1. Determine Gender
    # 1/5 for Male, 2/6 for Female
    is_male = (sex_char.upper() == 'M')
    born_in_2000s = random.choice([True, False])
    
    if born_in_2000s:
        gender_digit = 5 if is_male else 6
        year_prefix = 20
    else:
        gender_digit = 1 if is_male else 2
        year_prefix = 19
        
    # 2. Generate Random Date of Birth
    # Random year between 00-99 (but realistically 50-99 for 1900s, 00-24 for 2000s)
    if born_in_2000s:
        year = random.randint(0, 24)
    else:
        year = random.randint(50, 99)
        
    month = random.randint(1, 12)
    
    # Determine valid days for the month
    if month == 2:
        # Simple leap year check
        full_year = year_prefix * 100 + year
        is_leap = (full_year % 4 == 0 and full_year % 100 != 0) or (full_year % 400 == 0)
        max_day = 29 if is_leap else 28
    elif month in [4, 6, 9, 11]:
        max_day = 30
    else:
        max_day = 31
        
    day = random.randint(1, max_day)
    
    # Format the parts
    s = str(gender_digit)
    aa = f"{year:02d}"
    ll = f"{month:02d}"
    zz = f"{day:02d}"
    
    # Randomize the rest (JJ NNN C)
    jj = f"{random.randint(1, 52):02d}"
    nnn = f"{random.randint(1, 999):03d}"
    c = str(random.randint(0, 9))
    
    return f"{s}{aa}{ll}{zz}{jj}{nnn}{c}"


def get_random_place(csv_path="places.csv"):
    """
    Get a random place (nationality/location/language) from the CSV.
    """
    places = []
    try:
        with open(csv_path, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                places.append(row)
        
        if not places:
            # Fallback
            return {
                'nationality': 'American / US', 
                'location': 'New York, NY', 
                'language': 'english', 
                'address': '123 Broadway Blvd', 
                'issued_by': 'SPCLEP New York',
                'valability': '01.01.2023 - 01.01.2028',
                'series': 'ZR',
                'number': '123456'
            }
            
        return random.choice(places)
    except Exception as e:
        print(f"Error reading places CSV: {e}")
        return {
            'nationality': 'American / US', 
            'location': 'New York, NY', 
            'language': 'english', 
            'address': '123 Broadway Blvd', 
            'issued_by': 'SPCLEP New York',
            'valability': '01.01.2023 - 01.01.2028',
            'series': 'ZR',
            'number': '123456'
        }


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

        # Draw Series and Number
        # Series at middle (~650), Y=185
        # Number after 90px gap
        draw.text((690, 180), f"{user_data.get('series', '')}", font=font_body, fill="black")
        draw.text((780, 180), f"{user_data.get('number', '')}", font=font_body, fill="black")
        
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
        draw.text((1050, 390), f"{user_data['sex']}", font=font_header, fill="black", )
        draw.text((400, 450), f"{user_data['lob']}", font=font_body, fill="black")
        draw.text((400, 510), f"{user_data.get('address', '')}", font=font_body, fill="black")
        draw.text((400, 630), f"{user_data.get('issued_by', '')}", font=font_body, fill="black");        
        draw.text((810, 630), f"{user_data.get('valability', '')}", font=font_body, fill="black")
        # 4. Save Badge
        if not output_path:
            output_path = f"badge_{user_data['id_code']}.png"

        template.save(output_path, format="PNG")
        return output_path


# Example usage
if __name__ == "__main__":
    # 1. Get random place settings (Nationality + Location + associated Language + Address)
    # This ensures consistency: Romanian location -> Romanian name -> Romanian Nationality
    place_data = get_random_place("places.csv")
    print(f"🌍 Selected Place: {place_data['location']} ({place_data['nationality']})")
    print(f"📍 Address: {place_data['address']}")
    
    # 2. Get random name based on the language of that place
    random_name = get_random_name_by_language(place_data.get('language', 'english'))
    sex = random_name.get('sex', 'M')
    
    print(f"🎲 Using random name: {random_name['first_name']} {random_name['last_name']} ({sex})")
    
    # 3. Generate a realistic CNP
    random_cnp = generate_random_cnp(sex)
    print(f"🆔 Generated CNP: {random_cnp}")

    user_info = {
        "first_name": random_name['first_name'],
        "last_name": random_name['last_name'],
        "sex": sex,
        "nationality": place_data['nationality'],
        "id_code": random_cnp,
        "lob": place_data['location'],
        "address": place_data['address'],
        "issued_by": place_data['issued_by'],
        "valability": place_data['valability'],
        "series": place_data['series'],
        "number": place_data['number']
    }

    compositor = BadgeCompositor(
        template_path="CIROU_temp2.png",  # Using the main template
        font_path="times.ttf"          # optional, falls back if missing
    )

    result_path = compositor.create_badge(user_info, "djtb.jpeg")
    print(f"✅ Badge created: {result_path}")
