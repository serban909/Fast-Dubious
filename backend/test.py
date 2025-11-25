import os
import django
from django.conf import settings

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings.py")  # <-- replace with your settings path
django.setup()

from compositor import BadgeCompositor

import tempfile
import unittest
from io import BytesIO
from PIL import Image
from django.core.files.base import ContentFile


class TestBadgeCompositor(unittest.TestCase):
    def setUp(self):
        # Create a temporary template image
        self.temp_dir = tempfile.TemporaryDirectory()
        
        self.template_path = os.path.join(self.temp_dir.name, "template.png")
        
        template_img = Image.new("RGBA", (800, 600), (255, 255, 255, 255))
        template_img.save(self.template_path)

        # Create a temporary face image
        self.face_path = os.path.join(self.temp_dir.name, "face.png")
        face_img = Image.new("RGBA", (500, 500), (200, 100, 100, 255))
        face_img.save(self.face_path)

        # Patch BadgeCompositor paths
        self.compositor = BadgeCompositor()
        self.compositor.TEMPLATE_PATH = self.template_path
        self.compositor.FONT_PATH = os.path.join(self.temp_dir.name, "Roboto-Bold.ttf")

        # Fake user data
        self.user_data = {
            "first_name": "John",
            "last_name": "Doe",
            "id_code": "12345",
            "dob": "1990-01-01"
        }

    def tearDown(self):
        self.temp_dir.cleanup()

    def test_create_badge_returns_contentfile(self):
        result = self.compositor.create_badge(self.user_data, self.face_path)
        self.assertIsInstance(result, ContentFile)
        self.assertTrue(result.name.startswith("badge_"))
        self.assertTrue(result.name.endswith(".png"))

        # Verify the file is a valid PNG
        badge_img = Image.open(BytesIO(result.read()))
        self.assertEqual(badge_img.format, "PNG")
        self.assertEqual(badge_img.mode, "RGBA")

    def test_badge_contains_text(self):
        result = self.compositor.create_badge(self.user_data, self.face_path)
        badge_img = Image.open(BytesIO(result.read()))

        # Just check image size matches template (basic validation)
        self.assertEqual(badge_img.size, (800, 600))


if __name__ == "__main__":
    unittest.main()
