"""
Admin configuration for badges backend.
"""
from django.contrib import admin
from models import UserProfile, BadgeRequest


@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ['id_code', 'first_name', 'last_name', 'date_of_birth']
    search_fields = ['id_code', 'first_name', 'last_name']


@admin.register(BadgeRequest)
class BadgeRequestAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'status', 'created_at']
    list_filter = ['status', 'created_at']
    search_fields = ['user__id_code', 'user__first_name', 'user__last_name']
    readonly_fields = ['id', 'created_at']
