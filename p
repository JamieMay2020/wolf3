import os

folder = "."
files = [f for f in os.listdir(folder) if f.lower().endswith(".png")]

# keep only files that are just numbers like 1.png, 2.png, etc.
numbered = []
for f in files:
    name, ext = os.path.splitext(f)
    if name.isdigit():
        numbered.append(int(name))

numbered.sort()

# generate JS array
print("const imageArray = [")
for n in numbered:
    print(f'    "{n}.png",')
print("];")
