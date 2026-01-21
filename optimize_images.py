import os
from PIL import Image

image_dir = r"c:\Users\nyx\Desktop\awais\Projects\New folder\images"
files = [f for f in os.listdir(image_dir) if f.lower().endswith(('.png', '.jpg', '.jpeg'))]

print(f"Found {len(files)} images to process.")

for filename in files:
    filepath = os.path.join(image_dir, filename)
    name, ext = os.path.splitext(filename)
    
    try:
        with Image.open(filepath) as img:
            # Resize if too huge (max width 1600)
            if img.width > 1600:
                ratio = 1600 / img.width
                new_height = int(img.height * ratio)
                img = img.resize((1600, new_height), Image.Resampling.LANCZOS)
                print(f"Resized {filename}")

            # Save as WebP
            webp_path = os.path.join(image_dir, f"{name}.webp")
            img.save(webp_path, "WEBP", quality=80)
            print(f"Saved {name}.webp")
            
            # Also optimize original PNG in place (lossless but better compression)
            # using optimize=True
            # img.save(filepath, optimize=True) # Optional, keeping original distinct just in case
            
            # Print savings
            original_size = os.path.getsize(filepath)
            new_size = os.path.getsize(webp_path)
            savings = (original_size - new_size) / original_size * 100
            print(f"Compressed {filename}: {original_size/1024:.1f}KB -> {new_size/1024:.1f}KB ({savings:.1f}%)")
            
    except Exception as e:
        print(f"Error processing {filename}: {e}")
