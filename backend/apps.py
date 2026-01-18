"""
App configuration for badges backend.
"""
from django.apps import AppConfig


class BadgesConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'backend'
    label = 'badges'
    verbose_name = 'Badge Generation System'
