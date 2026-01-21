import os
from PIL import Image

image_dir = r"c:\Users\nyx\Desktop\awais\Projects\New folder\images"
files = [f for f in os.listdir(image_dir) if f.lower().endswith('.webp')]

for filename in files:
    filepath = os.path.join(image_dir, filename)
    with Image.open(filepath) as img:
        print(f"{filename}: width={img.width} height={img.height}")
