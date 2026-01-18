"""
Serializers for the badges backend.
"""
from rest_framework import serializers
from backend.models import BadgeRequest, UserProfile


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ['id_code', 'first_name', 'last_name', 'date_of_birth', 'profile_photo']


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
