import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont
import random

def generate_random_text_image(source_image_path, output_path, num_images=20):
    # Load the source image
    source_image = cv2.imread(source_image_path)
    height, width, _ = source_image.shape

    for i in range(num_images):
        # Clone the source image to work on
        image = source_image.copy()

        # Randomly generate text
        text = generate_random_text()

        # Randomly place text on the image
        image = place_text_on_image(image, text, height, width)

        # Apply affine transformations
        image = apply_affine_transform(image)

        # Save the generated image
        output_image_path = output_path + f'/image_{i + 1}.png'
        cv2.imwrite(output_image_path, image)

def generate_random_text(length=5):
    # You can customize this function to generate text based on your requirements
    characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    return ''.join(random.choice(characters) for _ in range(length))

def place_text_on_image(image, text, height, width):
    # Use PIL to draw text on the image
    pil_image = Image.fromarray(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
    draw = ImageDraw.Draw(pil_image)

    # You may need to adjust the font path based on your system
    font_path = "C:\Windows\Fonts\simhei.ttf"
    font_size = 70
    font = ImageFont.truetype(font_path, font_size)

    # Randomly position the text on the image
    text_position = (random.randint(0, width - font_size), random.randint(0, height - font_size))
    draw.text(text_position, text, font=font, fill=(20, 20, 20))

    return cv2.cvtColor(np.array(pil_image), cv2.COLOR_RGB2BGR)

def apply_affine_transform(image):
    # Apply random affine transformations (e.g., rotation, scaling, translation)
    rows, cols, _ = image.shape

    # Define random transformation parameters
    angle = random.uniform(-100, 100)
    scale = random.uniform(0.6, 1.4)
    tx = random.randint(-50, 50)
    ty = random.randint(-50, 50)

    # Define the transformation matrix
    matrix = cv2.getRotationMatrix2D((cols / 2, rows / 2), angle, scale)
    matrix[:, 2] += (tx, ty)

    # Apply the transformation
    transformed_image = cv2.warpAffine(image, matrix, (cols, rows))

    return transformed_image

# Example usage
source_image_path = "test.jpg"
output_path = "./"
generate_random_text_image(source_image_path, output_path)
