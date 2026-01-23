import torch
import torch_directml
from diffusers import StableDiffusionInstructPix2PixPipeline, EulerAncestralDiscreteScheduler
from PIL import Image
import os

class AIEditor:
    _instance = None
    _pipe = None

    @classmethod
    def get_instance(cls):
        if cls._instance is None:
            cls._instance = AIEditor()
        return cls._instance

    def __init__(self):
        if AIEditor._pipe is None:
            self._initialize_pipeline()

    def _initialize_pipeline(self):
        print("Loading AI Editor Pipeline...")
        # Initialize DirectML device
        self.dml = torch_directml.device()

        # Load pipeline with float16 to save ~50% VRAM
        # Use a local cache or pre-downloaded model if possible to avoid network delays
        self.pipe = StableDiffusionInstructPix2PixPipeline.from_pretrained(
            "timbrooks/instruct-pix2pix", 
            torch_dtype=torch.float16,  # Use float16 here
            safety_checker=None        # Optional: saves a bit more memory
        ).to(self.dml)

        self.pipe.scheduler = EulerAncestralDiscreteScheduler.from_config(self.pipe.scheduler.config)

        # VRAM Optimization: This is crucial for 8GB cards
        self.pipe.enable_attention_slicing()
        print("AI Editor Pipeline Loaded.")
        AIEditor._pipe = self.pipe

    def edit_image(self, image_path, prompt, output_path):
        image = Image.open(image_path).convert("RGB")
        
        # Resize if necessary to avoid OOM
        # InstructPix2Pix works best with 512x512 or similar aspect ratios
        # We'll limit max dimension to 512 to be safe and fast
        max_dim = 512
        if image.width > max_dim or image.height > max_dim:
            image.thumbnail((max_dim, max_dim))
        
        pipeline = AIEditor._pipe
        if pipeline is None:
             self._initialize_pipeline()
             pipeline = self.pipe

        print(f"Running AI Editor with prompt: '{prompt}' on {image_path}")
        result = pipeline(
            prompt=prompt,
            image=image,
            num_inference_steps=20,
            image_guidance_scale=1.2,
            guidance_scale=7.5
        ).images[0]

        result.save(output_path)
        return output_path

if __name__ == "__main__":
    # Test block
    if os.path.exists("boss.png"):
        editor = AIEditor()
        editor.edit_image("boss.png", "add a sombrero", "editedboss_test.png")