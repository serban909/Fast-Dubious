"""
Admin configuration for badges backend.
"""
from django.contrib import admin
from backend.models import UserProfile, BadgeRequest, Vehicle, InsurancePolicy, IdentityCard


@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ['id_code', 'first_name', 'last_name', 'date_of_birth']
    search_fields = ['id_code', 'first_name', 'last_name']


@admin.register(IdentityCard)
class IdentityCardAdmin(admin.ModelAdmin):
    list_display = ['series', 'number', 'user', 'cnp', 'nationality']
    search_fields = ['cnp', 'user__last_name', 'number']


@admin.register(Vehicle)
class VehicleAdmin(admin.ModelAdmin):
    list_display = ['make_model', 'registration_number', 'owner']
    search_fields = ['registration_number', 'vin', 'owner__last_name']


@admin.register(InsurancePolicy)
class InsurancePolicyAdmin(admin.ModelAdmin):
    list_display = ['series', 'number', 'user', 'vehicle', 'validity_start', 'validity_end']
    list_filter = ['insurer_name', 'issue_date']
    search_fields = ['number', 'user__last_name', 'vehicle__registration_number']


@admin.register(BadgeRequest)
class BadgeRequestAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'status', 'created_at']
    list_filter = ['status', 'created_at']
    search_fields = ['user__id_code', 'user__first_name', 'user__last_name']
    readonly_fields = ['id', 'created_at']
