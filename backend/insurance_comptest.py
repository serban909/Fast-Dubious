import os
import django
import random
from PIL import Image, ImageDraw, ImageFont

# Setup Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'settings')
django.setup()

from models import UserProfile

class InsuranceCompositor:
    """
    Compositor for Insurance (RCA) documents.
    """

    def __init__(self, template_path="Contract-de-asigurare-RCA-1.png", font_path="times.ttf"):
        self.template_path = template_path
        self.font_path = font_path

    def create_insurance(self, data: dict, output_path: str = None) -> str:
        """
        Create an insurance document with the provided data.

        Args:
            data (dict): Dictionary containing all the insurance fields.
            output_path (str): Path to save the final image.

        Returns:
            str: Path to the saved image.
        """

        # 1. Load Template
        try:
            template = Image.open(self.template_path).convert("RGBA")
        except FileNotFoundError:
            print(f"Error: Template not found at {self.template_path}")
            return None

        draw = ImageDraw.Draw(template)

        # 2. Setup Fonts
        try:
            # Adjust sizes as needed based on the template resolution
            font_regular = ImageFont.truetype(self.font_path, 20)
            font_bold = ImageFont.truetype(self.font_path, 22)
            font_small = ImageFont.truetype(self.font_path, 16)
        except IOError:
            print("Warning: Font file not found. Using default font.")
            font_regular = ImageFont.load_default()
            font_bold = ImageFont.load_default()
            font_small = ImageFont.load_default()

        # 3. Draw Fields
        # Helper function to keep code clean
        def draw_text(key, x, y, font=font_regular, color="black"):
            if key in data:
                draw.text((x, y), str(data[key]), font=font, fill=color)

        # --- COORDINATES (PLACEHOLDERS - NEED ADJUSTMENT BASED ON ACTUAL TEMPLATE PIXEL DIMENSIONS) ---
        
        # Header Info
        # 'DENUMIRE ASIGURATOR' is usually pre-printed or placed top-left
        draw_text('insurer_name', 220, 38, font_regular) 
        draw_text('insurer_tel_fax', 78, 85)
        
        # Series / Number (Top Right)
        # "Seria RO <series> / <nr>"
        draw_text('contract_series', 855, 12, font_bold)
        draw_text('nr_header', 995, 12, font_bold)
        draw_text('contract_number', 830, 38, font_regular)
        draw_text('insurer_cui', 1000, 38, font_regular)
        
        # Agency / Broker
        draw_text('branch_agency', 160, 63, font_regular)
        draw_text('broker_name', 812, 63, font_regular)
        draw_text('broker_code', 1035, 85, font_regular)

        # --- LEFT COLUMN (INSURED INFO) ---
        # Nume/Denumire Asigurat Proprietar
        draw_text('owner_name', 230, 125, font_regular)
        
        # C.U.I./C.N.P. Proprietar
        draw_text('owner_id', 230, 175, font_regular)
        
        # Nume/Denumire Asigurat Utilizator
        draw_text('user_name', 230, 225, font_regular)
        
        # C.U.I./C.N.P. Utilizator
        draw_text('user_id', 230, 280, font_regular)
        
        # Adresa Asigurat
        # Might need word wrapping if address is long
        draw_text('owner_address', 230, 335, font_regular)
        
        # Conducatori auto (Drivers)
        draw_text('drivers', 230, 400, font_regular)

        # --- RIGHT COLUMN (VEHICLE INFO) ---
        col_right_x = 775
        
        # Fel, Tip, Marca Model Vehicul
        draw_text('vehicle_type_make_model', col_right_x, 125, font_regular)
        
        # Nr.inmatriculare/Inregistrare
        draw_text('vehicle_registration', col_right_x, 175, font_regular)
        
        # Nr.identificare - Serie CIV...
        draw_text('vehicle_vin', col_right_x, 225, font_regular)
        
        # Cap.cilindrica/Putere
        draw_text('vehicle_engine_power', col_right_x, 280, font_regular)
        
        # Nr.locuri/masa totala...
        draw_text('vehicle_seats_mass', col_right_x, 335, font_regular)

        # --- BOTTOM SECTION (VALIDITY & PRICES) ---
        
        # Valabilitate Contract de la... pana la...
        # "Valabilitate Contract de la  <start>  pana la  <end>"
        draw_text('validity_start', 200, 435, font_regular)
        draw_text('validity_end', 335, 435, font_regular)
        
        # Contract emis in data de... ora...
        draw_text('issue_date', 595, 435, font_regular)
        
        # Prima de asigurare
        draw_text('premium_amount', 165, 455, font_regular)  # "Prima de asigurare <amount> Lei"
        draw_text('direct_settlement_premium', 400, 455, font_regular) # "Prima decontare directa <amount> Lei"
        draw_text('total_premium', 537, 455, font_regular) # "Prima totala <amount> Lei"
        
        # Nr. rate / Scadente / Bonus-Malus
        draw_text('installments_count', 80, 475, font_regular)
        draw_text('valoare_rate', 185, 475, font_regular)
        draw_text('due_dates', 340, 475, font_regular)
        draw_text('bonus_malus', 560, 475, font_regular)

        # Payment Info
        draw_text('incasata_cu', 105, 495, font_regular)
        draw_text('in_data_de', 275, 495, font_regular)
        
        # Limita de despagubire (Limits)
        # Top boxes for limits usually have values like "6.070.000 EURO" or "1.220.000 EURO"
        draw_text('limit_bodily_injury', 710, 525, font_regular) 
        draw_text('limit_property_damage', 710, 555, font_regular)
        
        # Acoperiri si servicii suplimentare (Additional services)
        draw_text('additional_services', 505, 585, font_regular)

        # Observatii
        draw_text('observations', 505, 615, font_regular)

        # 4. Save Image
        if not output_path:
            output_path = f"insurance_{data.get('contract_number', 'gen')}.png"

        template.save(output_path, format="PNG")
        print(f"✅ Insurance document created: {output_path}")
        return output_path


# Example usage
if __name__ == "__main__":
    
    # Fetch a random user from the database
    user = None
    try:
        users = list(UserProfile.objects.all())
        if users:
            user = random.choice(users)
            print(f"👤 Found user: {user.first_name} {user.last_name} ({user.id_code})")
        else:
            print("⚠️ No users found in database. Using fallback data.")
    except Exception as e:
        print(f"⚠️ Error fetching from database: {e}")

    # Fallback/Default values if no user found
    first_name = "POPESCU"
    last_name = "ION"
    id_code = "1800101123456"
    address = "Str. Principala Nr. 10, Bucuresti, Sector 1"
    
    if user:
        first_name = user.first_name.upper()
        last_name = user.last_name.upper()
        id_code = user.id_code
        # Address is not in UserProfile currently, would need to be added or faked
        # address = user.address if hasattr(user, 'address') else address

    # Sample data structure matching the fields in the template
    sample_data = {
        # Header
        "insurer_name": "INSURANCE CO. S.A.",
        "insurer_tel_fax": "021.123.45.67",
        "contract_series": "RO/01",
        "nr_header": str(random.randint(10000, 99999)),
        "contract_number": str(random.randint(100000000, 999999999)),
        "insurer_cui": "RO12345678",
        "branch_agency": "Bucharest Agency 1",
        "broker_name": "Best Broker SRL",
        "broker_code": "BRK-001",
        
        # Insured
        "owner_name": f"{first_name} {last_name}",
        "owner_id": id_code,
        "user_name": f"{first_name} {last_name}",  # Often same as owner
        "user_id": id_code,
        "owner_address": address,
        "drivers": f"{first_name} {last_name} ({id_code})",
        
        # Vehicle
        "vehicle_type_make_model": "Autoturism / DACIA / LOGAN",
        "vehicle_registration": "B 101 ABC",
        "vehicle_vin": "UU1SD435555555",
        "vehicle_engine_power": "1390 cm3 / 55 kW",
        "vehicle_seats_mass": "5 locuri / 1500 kg",
        
        # Contract Details
        "validity_start": "01/01/2024",
        "validity_end": "31/12/2024",
        "issue_date": "20/12/2023",
        "premium_amount": "500",
        "direct_settlement_premium": "50",
        "total_premium": "550",
        "installments_count": "Integral",
        "valoare_rate": "550 Lei",
        "due_dates": "-",
        "bonus_malus": "B8",
        "incasata_cu": "OP",
        "in_data_de": "20.12.2023",
        
        # Limits
        "limit_bodily_injury": "6.070.000 EURO",
        "limit_property_damage": "1.220.000 EURO",
        
        # Other
        "additional_services": "Asistenta Rutiera (Basic)",
        "observations": "Polita emisa electronic."
    }

    compositor = InsuranceCompositor(
        template_path="Contract-de-asigurare-RCA-1.png", 
        font_path="times.ttf"
    )
    
    # Note: Ensure 'Contract-de-asigurare-RCA-1.png' exists in the directory or provide absolute path
    # If using placeholders, the text might not align perfectly without adjustment.
    compositor.create_insurance(sample_data, "test_insurance.png")
