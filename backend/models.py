import uuid
from django.db import models
from django.conf import settings

class UserProfile(models.Model):
    """
    Represents the user data stored in MySQL.
    """
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, null=True, blank=True, related_name='profiles')
    id_code = models.CharField(max_length=50, unique=True) # Unique Employee/User ID
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    date_of_birth = models.DateField()
    address = models.CharField(max_length=255, blank=True, null=True)
    # The base photo stored in the system
    profile_photo = models.ImageField(upload_to='users/photos/', blank=True, null=True)

    class Meta:
        app_label = 'badges'

    def __str__(self):
        return f"{self.first_name} {self.last_name}"

class IdentityCard(models.Model):
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE, related_name='id_cards')
    series = models.CharField(max_length=5, default="XR")
    number = models.CharField(max_length=10)
    cnp = models.CharField(max_length=13, unique=True, null=True, blank=True)
    
    nationality = models.CharField(max_length=100, default="Romana")
    sex = models.CharField(max_length=1, choices=[('M', 'Male'), ('F', 'Female')], default='M')
    place_of_birth = models.CharField(max_length=100, help_text="Place of birth (Location)")
    address = models.CharField(max_length=255)
    
    issued_by = models.CharField(max_length=100, default="SPCLEP")
    validity_start = models.DateField()
    validity_end = models.DateField()
    
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        app_label = 'badges'

    def __str__(self):
        return f"ID {self.series} {self.number}"

class BadgeRequest(models.Model):
    """
    Represents a specific transaction to generate a badge.
    """
    class Status(models.TextChoices):
        PROCESSING = 'PROCESSING', 'Processing'
        COMPLETED = 'COMPLETED', 'Completed'
        FAILED = 'FAILED', 'Failed'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE)
    
    # Optional: Source image for this specific request (overrides user profile photo)
    source_image = models.ImageField(upload_to='badges/temp/', null=True, blank=True)

    # AI Configuration
    ai_prompt_modifiers = models.JSONField(default=dict) # e.g. {"mustache": true}
    
    # Pipeline Artifacts (Audit Trail)
    # 1. The face returned by Nano Banana
    ai_altered_face = models.ImageField(upload_to='badges/temp_faces/', null=True, blank=True)
    # 2. The final composite using Pillow
    final_badge = models.ImageField(upload_to='badges/final/', null=True, blank=True)
    
    status = models.CharField(max_length=20, choices=Status.choices, default=Status.PROCESSING)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        app_label = 'badges'

    def __str__(self):
        return f"Request {self.id} for {self.user.id_code}"

class Vehicle(models.Model):
    owner = models.ForeignKey(UserProfile, on_delete=models.CASCADE, related_name='vehicles')
    make_model = models.CharField(max_length=200, help_text="e.g. Autoturism / DACIA / LOGAN")
    registration_number = models.CharField(max_length=20)
    vin = models.CharField(max_length=50)
    engine_power = models.CharField(max_length=100, help_text="e.g. 1390 cm3 / 55 kW")
    seats_mass = models.CharField(max_length=100, help_text="e.g. 5 locuri / 1500 kg")

    class Meta:
        app_label = 'badges'

    def __str__(self):
        return f"{self.make_model} - {self.registration_number}"

class InsurancePolicy(models.Model):
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE, related_name='policies')
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE)
    
    # Header / Insurer
    insurer_name = models.CharField(max_length=100, default="INSURANCE CO. S.A.")
    insurer_cui = models.CharField(max_length=20, default="RO12345678")
    insurer_tel_fax = models.CharField(max_length=50, default="021.123.45.67")
    
    # Contract
    series = models.CharField(max_length=10, default="RO/01")
    number = models.CharField(max_length=20)
    header_nr = models.CharField(max_length=20)
    
    # Broker
    branch_agency = models.CharField(max_length=100, default="Bucharest Agency 1")
    broker_name = models.CharField(max_length=100, default="Best Broker SRL")
    broker_code = models.CharField(max_length=20, default="BRK-001")
    
    # Validity
    validity_start = models.DateField()
    validity_end = models.DateField()
    issue_date = models.DateTimeField(auto_now_add=True)
    
    # Financial
    premium_amount = models.DecimalField(max_digits=10, decimal_places=2)
    direct_settlement_premium = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    total_premium = models.DecimalField(max_digits=10, decimal_places=2)
    
    installments_count = models.CharField(max_length=50, default="Integral")
    valoare_rate = models.CharField(max_length=50, default="-")
    due_dates = models.CharField(max_length=100, default="-")
    
    incasata_cu = models.CharField(max_length=50, default="OP")
    in_data_de = models.DateField(null=True, blank=True)
    
    bonus_malus = models.CharField(max_length=10, default="B0")
    
    # Limits
    limit_bodily_injury = models.CharField(max_length=50, default="6.070.000 EURO")
    limit_property_damage = models.CharField(max_length=50, default="1.220.000 EURO")
    
    additional_services = models.TextField(default="Asistenta Rutiera (Basic)", blank=True)
    observations = models.TextField(default="Polita emisa electronic.", blank=True)
    
    # Generated Document
    policy_document = models.ImageField(upload_to='insurance_policies/', blank=True, null=True)

    class Meta:
        app_label = 'badges'

    def __str__(self):
        return f"Policy {self.series} {self.number}"
