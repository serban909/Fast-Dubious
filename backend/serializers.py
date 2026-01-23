"""
Serializers for the badges backend.
"""
from rest_framework import serializers
from backend.models import BadgeRequest, UserProfile, Vehicle, InsurancePolicy

class InsurancePolicySerializer(serializers.ModelSerializer):
    class Meta:
        model = InsurancePolicy
        fields = '__all__'

class VehicleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vehicle
        fields = '__all__'
        extra_kwargs = {
            'owner': {'required': False}  # We'll attach the owner in the view
        }

class UserProfileSerializer(serializers.ModelSerializer):
    generated_badge = serializers.SerializerMethodField()

    class Meta:
        model = UserProfile
        fields = ['id', 'id_code', 'first_name', 'last_name', 'date_of_birth', 'profile_photo', 'generated_badge', 'address']

    def get_generated_badge(self, obj):
        badge_req = obj.badgerequest_set.filter(status='COMPLETED').order_by('-created_at').first()
        if badge_req and badge_req.final_badge:
            return badge_req.final_badge.url
        return None


class BadgeRequestSerializer(serializers.ModelSerializer):
    user = UserProfileSerializer(read_only=True)
    
    class Meta:
        model = BadgeRequest
        fields = [
            'id', 
            'user', 
            'ai_prompt_modifiers', 
            'ai_altered_face', 
            'final_badge', 
            'status', 
            'created_at'
        ]
        read_only_fields = ['id', 'ai_altered_face', 'final_badge', 'status', 'created_at']
