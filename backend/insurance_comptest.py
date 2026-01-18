import os
import django
import random
from PIL import Image, ImageDraw, ImageFont

# Setup Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'settings')
django.setup()

from backend.models import UserProfile, Vehicle, InsurancePolicy
import datetime

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
    
    # 1. Get or Create User
    user = UserProfile.objects.first()
    if not user:
        # Create a dummy user
        try:
            user = UserProfile.objects.create(
                id_code="1800101123456",
                first_name="Popescu",
                last_name="Ion",
                date_of_birth="1980-01-01",
                address="Str. Principala Nr. 10, Bucuresti"
            )
            print("Created dummy user.")
        except Exception as e:
            print(f"Error creating user: {e}")
            user = UserProfile.objects.first()

    if user:
        print(f"👤 Using user: {user.first_name} {user.last_name}")

        # 2. Get or Create Vehicle
        vehicle = Vehicle.objects.filter(owner=user).first()
        if not vehicle:
            vehicle = Vehicle.objects.create(
                owner=user,
                make_model="Autoturism / DACIA / LOGAN",
                registration_number="B 101 ABC",
                vin="UU1SD435555555",
                engine_power="1390 cm3 / 55 kW",
                seats_mass="5 locuri / 1500 kg"
            )
            print("Created dummy vehicle.")
        
        # 3. Get or Create Policy
        policy = InsurancePolicy.objects.filter(user=user, vehicle=vehicle).first()
        if not policy:
            policy = InsurancePolicy.objects.create(
                user=user,
                vehicle=vehicle,
                number=str(random.randint(100000000, 999999999)),
                header_nr=str(random.randint(10000, 99999)),
                validity_start=datetime.date(2024, 1, 1),
                validity_end=datetime.date(2024, 12, 31),
                premium_amount=500.00,
                total_premium=550.00,
                valoare_rate="550 Lei",
                in_data_de=datetime.date(2023, 12, 20)
            )
            print("Created dummy policy.")

        # Map Policy to Data Dict
        sample_data = {
             # Header
            "insurer_name": policy.insurer_name,
            "insurer_tel_fax": policy.insurer_tel_fax,
            "contract_series": policy.series,
            "nr_header": policy.header_nr,
            "contract_number": policy.number,
            "insurer_cui": policy.insurer_cui,
            "branch_agency": policy.branch_agency,
            "broker_name": policy.broker_name,
            "broker_code": policy.broker_code,
            
            # Insured
            "owner_name": f"{user.first_name} {user.last_name}".upper(),
            "owner_id": user.id_code,
            "user_name": f"{user.first_name} {user.last_name}".upper(),
            "user_id": user.id_code,
            "owner_address": user.address or "",
            "drivers": f"{user.first_name} {user.last_name} ({user.id_code})".upper(),
            
            # Vehicle
            "vehicle_type_make_model": vehicle.make_model,
            "vehicle_registration": vehicle.registration_number,
            "vehicle_vin": vehicle.vin,
            "vehicle_engine_power": vehicle.engine_power,
            "vehicle_seats_mass": vehicle.seats_mass,
            
            # Contract Details
            "validity_start": policy.validity_start.strftime("%d/%m/%Y"),
            "validity_end": policy.validity_end.strftime("%d/%m/%Y"),
            "issue_date": policy.issue_date.strftime("%d/%m/%Y") if policy.issue_date else "", 
            "premium_amount": str(policy.premium_amount),
            "direct_settlement_premium": str(policy.direct_settlement_premium),
            "total_premium": str(policy.total_premium),
            "installments_count": policy.installments_count,
            "valoare_rate": policy.valoare_rate,
            "due_dates": policy.due_dates,
            "bonus_malus": policy.bonus_malus,
            "incasata_cu": policy.incasata_cu,
            "in_data_de": policy.in_data_de.strftime("%d.%m.%Y") if policy.in_data_de else "",
            
            # Limits
            "limit_bodily_injury": policy.limit_bodily_injury,
            "limit_property_damage": policy.limit_property_damage,
            
            # Other
            "additional_services": policy.additional_services,
            "observations": policy.observations
        }

        compositor = InsuranceCompositor(
            template_path="Contract-de-asigurare-RCA-1.png", 
            font_path="times.ttf"
        )
        
        compositor.create_insurance(sample_data, f"insurance_{policy.number}.png")
    else:
        print("Could not find or create a user.")
