from abc import ABC, abstractmethod
import requests
import base64
from django.core.files.base import ContentFile
from django.conf import settings

class IFaceModifier(ABC):
    """Interface for AI services that modify faces."""
    @abstractmethod
    def alter_face(self, source_image_path: str, modifiers: dict) -> ContentFile:
        pass

class BananaFaceAdapter(IFaceModifier):
    def alter_face(self, source_image_path: str, modifiers: dict) -> ContentFile:
        # 1. Prepare Prompt
        prompt = f"person, face closeup, {', '.join([k for k, v in modifiers.items() if v])}"
        
        # 2. Encode File
        with open(source_image_path, "rb") as f:
            img_base64 = base64.b64encode(f.read()).decode('utf-8')

        # 3. Call Nano Banana / Stable Diffusion API
        # Note: This is a pseudo-implementation of a generic SD API payload
        payload = {
            "apiKey": settings.BANANA_API_KEY,
            "modelInputs": {
                "prompt": prompt,
                "init_image": img_base64,
                "strength": 0.5, # Keep 50% original structure, 50% AI style
                "negative_prompt": "blurry, distorted text, bad anatomy"
            }
        }
        
        response = requests.post(settings.BANANA_URL, json=payload, timeout=60)
        response.raise_for_status()
        
        # 4. Decode Response
        output_base64 = response.json().get('modelOutputs', [{}])[0].get('image_base64')
        if not output_base64:
            raise ValueError("Empty response from AI provider")
            
        return ContentFile(base64.b64decode(output_base64), name="altered_face.png")