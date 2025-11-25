import uuid
from django.db import models

class UserProfile(models.Model):
    """
    Represents the user data stored in MySQL.
    """
    id_code = models.CharField(max_length=20, unique=True) # Unique Employee/User ID
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    date_of_birth = models.DateField()
    # The base photo stored in the system
    profile_photo = models.ImageField(upload_to='users/photos/')

    class Meta:
        app_label = 'badges'

    def __str__(self):
        return f"{self.first_name} {self.last_name}"

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