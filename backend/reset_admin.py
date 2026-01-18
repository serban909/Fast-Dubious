import os
import django
from pathlib import Path

# Setup Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'settings')
django.setup()

from django.conf import settings
from django.contrib.auth import get_user_model

def reset_password():
    print(f"📂 Database Path from settings: {settings.DATABASES['default']['NAME']}")
    
    User = get_user_model()
    print(f"👥 User Model: {User}")
    
    # Check if admin exists
    try:
        admin_user = User.objects.get(username='admin')
        print("✅ Found user 'admin'")
        admin_user.set_password('admin')
        admin_user.is_staff = True
        admin_user.is_superuser = True
        admin_user.is_active = True
        admin_user.save()
        print("🔓 Password reset to 'admin' (and ensure is_active=True, is_staff=True)")
    except User.DoesNotExist:
        print("❌ User 'admin' not found. Creating it now...")
        User.objects.create_superuser('admin', 'admin@example.com', 'admin')
        print("✨ Created new superuser 'admin' with password 'admin'")
    
    # Verify
    u = User.objects.get(username='admin')
    print(f"🔍 Verification - Username: {u.username}, Is Active: {u.is_active}, Is Staff: {u.is_staff}")

if __name__ == "__main__":
    reset_password()
