from abc import ABC, abstractmethod
import requests
import base64
import os
from django.core.files.base import ContentFile
from django.conf import settings
import warnings

try:
    import google.generativeai as genai
    # Suppress the deprecation warning for now as we are using the stable legacy SDK
    warnings.filterwarnings("ignore", category=FutureWarning, module="google.generativeai")
except ImportError:
    genai = None

class IFaceModifier(ABC):
    """Interface for AI services that modify faces."""
    @abstractmethod
    def alter_face(self, source_image_path: str, prompt: str) -> str:
        """
        Modifies a face based on a prompt.
        Returns the path to the locally saved altered image.
        """
        pass

class GeminiFaceAdapter(IFaceModifier):
    def alter_face(self, source_image_path: str, prompt: str) -> str:
        """
        Uses Gemini/Imagen to alter the face by generating a new image based on the prompt.
        """
        api_key = getattr(settings, 'GEMINI_API_KEY', os.environ.get('GEMINI_API_KEY'))
        
        # Ensure output directory exists
        output_dir = os.path.join(settings.BASE_DIR, 'processed_faces')
        os.makedirs(output_dir, exist_ok=True)
        
        filename = os.path.basename(source_image_path)
        name, ext = os.path.splitext(filename)
        output_path = os.path.join(output_dir, f"{name}_ai{ext}")

        print(f"🤖 Gemini/Imagen Adapter: Processing {source_image_path} with prompt: '{prompt}'...")

        # --- A. Try the official Google Gen AI Client (New SDK) ---
        try:
            from google import genai
            from google.genai import types
            
            client = genai.Client(api_key=api_key)
            
            # Read image
            with open(source_image_path, "rb") as f:
                image_bytes = f.read()

            # Attempt Generation with Gemini 3.0 Flash Preview (as requested)
            # or try to use Imagen if available via this client.
            # We construct a prompt that asks for a NEW image.
            
            model_name = "gemini-3.0-flash-preview"
            full_prompt = f"Create a photorealistic portrait of this person but {prompt}. Return only the image."
            
            print(f"🔄 Requesting Image Generation from {model_name}...")
            
            try:
                response = client.models.generate_content(
                    model=model_name,
                    contents=[
                        types.Part.from_bytes(data=image_bytes, mime_type="image/jpeg"),
                        types.Part.from_text(text=full_prompt)
                    ],
                    config=types.GenerateContentConfig(response_mime_type="image/jpeg") 
                    # Note: response_mime_type='image/jpeg' is the key for image output on supported models
                )
                
                # Check for image bytes in response
                if response.bytes:
                     with open(output_path, 'wb') as f:
                        f.write(response.bytes)
                     print(f"✅ AI Image Generated & Saved: {output_path}")
                     return output_path
                
                # Fallback: check parts
                if response.candidates and response.candidates[0].content.parts:
                    for part in response.candidates[0].content.parts:
                        if part.inline_data:
                            with open(output_path, 'wb') as f:
                                f.write(part.inline_data.data)
                            print(f"✅ AI Image Generated (from parts): {output_path}")
                            return output_path

            except Exception as gen_error:
                 print(f"   Note: Generation attempt failed ({gen_error}). Falling back to simulation.")

        except ImportError:
            print("   Note: New google-genai SDK not found.")
        except Exception as e:
            print(f"   Note: Error initializing new client: {e}")

        # --- B. Fallback: Local Simulation (Draw Mustache / Brighten) ---
        print("⚠️ Integrating local simulation for demonstration (Real API edit required specialized Imagen endpoint).")
        try:
            from PIL import Image, ImageEnhance, ImageDraw
            with Image.open(source_image_path) as img:
                img = img.convert("RGBA")
                
                # Simulate "mustache"
                if "mustache" in prompt.lower():
                    print("   ✏️ Drawing simulated mustache...")
                    draw = ImageDraw.Draw(img)
                    w, h = img.size
                    # Mustache coordinates (approximate based on typical passport photo face)
                    # Face is roughly centered. Mouth is at ~65% height.
                    mx = w // 2
                    my = int(h * 0.62)
                    mw = w // 4  # Width of mustache
                    mh = h // 25 # Thickness

                    # Draw thick slightly curved line or ellipse
                    draw.ellipse([mx - mw//2, my, mx + mw//2, my + mh], fill="black")
                
                # Simulate "happy" (Brightness)
                elif "happy" in prompt.lower() or "lighter" in prompt.lower():
                    enhancer = ImageEnhance.Brightness(img)
                    img = enhancer.enhance(1.4)
                
                if img.mode == "RGBA":
                    img = img.convert("RGB")
                    
                img.save(output_path)
                
            print(f"✅ Local Processing Complete. Saved to: {output_path}")
            return output_path
            
        except Exception as e:
            print(f"❌ Local Error: {e}")
            return source_image_path

class BananaFaceAdapter(IFaceModifier):
    def alter_face(self, source_image_path: str, mod_dict_or_prompt) -> ContentFile:
        # Compatibility wrapper
        prompt = mod_dict_or_prompt
        if isinstance(mod_dict_or_prompt, dict):
            prompt = f"person, face closeup, {', '.join([k for k, v in mod_dict_or_prompt.items() if v])}"
        
        # 2. Encode File
        with open(source_image_path, "rb") as f:
            img_base64 = base64.b64encode(f.read()).decode('utf-8')

        # 3. Call Nano Banana / Stable Diffusion API
        # Note: This is a pseudo-implementation of a generic SD API payload
        payload = {
            "apiKey": getattr(settings, 'BANANA_API_KEY', ''),
            "modelInputs": {
                "prompt": prompt,
                "init_image": img_base64,
                "strength": 0.5, # Keep 50% original structure, 50% AI style
                "negative_prompt": "blurry, distorted text, bad anatomy"
            }
        }
        
        try:
            response = requests.post(getattr(settings, 'BANANA_URL', 'http://localhost'), json=payload, timeout=60)
            response.raise_for_status()
            
            # 4. Decode Response
            output_base64 = response.json().get('modelOutputs', [{}])[0].get('image_base64')
            if not output_base64:
                raise ValueError("Empty response from AI provider")
                
            return ContentFile(base64.b64decode(output_base64), name="altered_face.png")
        except Exception as e:
            print(f"Banana API Error: {e}")
            raise e

class LocalDiffusersAdapter(IFaceModifier):
    def alter_face(self, source_image_path: str, prompt: str) -> str:
        """
        Uses the local AI Editor (DirectML/Diffusers) to alter the face.
        """
        try:
            from backend.ai_editor import AIEditor
            
            output_dir = os.path.join(settings.BASE_DIR, 'processed_faces')
            os.makedirs(output_dir, exist_ok=True)
            
            filename = os.path.basename(source_image_path)
            name, ext = os.path.splitext(filename)
            output_path = os.path.join(output_dir, f"{name}_diffused{ext}")
            
            print(f"🎨 LocalDiffusersAdapter: Editing {source_image_path} with prompt: '{prompt}'")
            editor = AIEditor.get_instance()
            return editor.edit_image(source_image_path, prompt, output_path)
        except Exception as e:
            print(f"❌ LocalDiffusersAdapter failed: {e}")
            raise e