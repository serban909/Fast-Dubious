"""
Test script to demonstrate all available name languages.
"""
import os
import sys
from comptest import get_random_name_by_language, BadgeCompositor

print("=" * 60)
print("Testing Random Names from Different Languages")
print("=" * 60)

languages = ["english", "romanian", "hungarian", "chinese"]

for lang in languages:
    name = get_random_name_by_language(lang)
    print(f"\n{lang.upper()}: {name['first_name']} {name['last_name']}")

print("\n" + "=" * 60)
print("Creating badges with different languages...")
print("=" * 60)

# Create a badge for each language
for lang in languages:
    random_name = get_random_name_by_language(lang)
    
    print(f"\n🎲 {lang.capitalize()}: {random_name['first_name']} {random_name['last_name']}")
    
    user_info = {
        "first_name": random_name['first_name'],
        "last_name": random_name['last_name'],
        "nationality": f"{lang.capitalize()}",
        "id_code": "0212059536198",
        "lob": "Beius, Bihor"
    }

    compositor = BadgeCompositor(
        template_path="CIROU_temp2.png",
        font_path="times.ttf"
    )

    result_path = compositor.create_badge(user_info, "djtb.jpeg", f"badge_{lang}.png")
    print(f"✅ Badge created: {result_path}")

print("\n" + "=" * 60)
print("All badges created successfully!")
print("=" * 60)
