import os
import django

# Setup Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'settings')
django.setup()

from backend.models import UserProfile, BadgeRequest
from django.contrib.auth import get_user_model

def verify():
    print("="*50)
    print("🕵️  VERIFYING BACKEND DATA")
    print("="*50)

    # 1. Check Users
    User = get_user_model()
    users = User.objects.all()
    print(f"\n🟢 Users ({users.count()}):")
    for u in users:
        print(f"   - ID: {u.id} | Username: {u.username} | Email: {u.email} | Superuser: {u.is_superuser}")

    # 2. Check User Profiles
    profiles = UserProfile.objects.all()
    print(f"\n🟢 User Profiles ({profiles.count()}):")
    for p in profiles:
        print(f"   - User ID: {p.user_id} | Name: {p.first_name} {p.last_name} | ID Code: {p.id_code}")
        if p.profile_photo:
            print(f"     📸 Photo: {p.profile_photo.name}")

    # 3. Check Badge Requests
    badges = BadgeRequest.objects.all()
    print(f"\n🟢 Badge Requests ({badges.count()}):")
    for b in badges:
        print(f"   - Req ID: {b.id} | User: {b.user} | Status: {b.status}")
        print(f"     📝 Prompts: {b.ai_prompt_modifiers}")

    print("\n" + "="*50)

if __name__ == '__main__':
    verify()
