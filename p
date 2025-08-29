import os
from PIL import Image

folder = "."
valid_exts = (".jpg", ".jpeg", ".png", ".webp")

# Get all image files
files = [f for f in os.listdir(folder) if f.lower().endswith(valid_exts)]
if not files:
    print("No image files found!")
    exit()

files.sort()
print(f"Found {len(files)} images")

# Step 1: Rename all to temporary names first to avoid conflicts
temp_files = []
for i, filename in enumerate(files):
    old_path = os.path.join(folder, filename)
    temp_name = f"temp_{i}_{filename}"
    temp_path = os.path.join(folder, temp_name)
    os.rename(old_path, temp_path)
    temp_files.append(temp_name)
    print(f"Temporarily renamed: {filename} -> {temp_name}")

# Step 2: Now convert and number them properly
start_num = 100
numbered = []

for i, temp_name in enumerate(temp_files, start=start_num):
    temp_path = os.path.join(folder, temp_name)
    img = Image.open(temp_path).convert("RGBA")
    new_name = f"{i}.png"
    img.save(new_name, "PNG")
    numbered.append(i)
    os.remove(temp_path)  # Remove temp file
    print(f"Created: {new_name}")

print(f"\nConverted {len(numbered)} files")

# Output JS array
print("\nconst imageArray = [")
for n in numbered:
    print(f'    "{n}.png",')
print("];")