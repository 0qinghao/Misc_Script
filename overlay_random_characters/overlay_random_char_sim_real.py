import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont
import random

def add_gaussian_noise(image, mean=0, sigma=25):
    row, col, ch = image.shape
    gauss = np.random.normal(mean, sigma, (row, col, ch))
    noisy = np.clip(image + gauss, 0, 255)
    return noisy.astype(np.uint8)

def apply_blur(image, kernel_size=5):
    return cv2.GaussianBlur(image, (kernel_size, kernel_size), 0)

def adjust_brightness_contrast(image, alpha=1.0, beta=0):
    return cv2.convertScaleAbs(image, alpha=alpha, beta=beta)

def apply_perspective_transform(image):
    rows, cols, _ = image.shape
    pts1 = np.float32([[0, 0], [cols - 1, 0], [0, rows - 1], [cols - 1, rows - 1]])
    pts2 = np.float32([[0, 0], [cols - 1, 0], [int(0.2 * cols), rows - 1], [int(0.8 * cols), rows - 1]])
    matrix = cv2.getPerspectiveTransform(pts1, pts2)
    result = cv2.warpPerspective(image, matrix, (cols, rows))
    return result

def apply_color_variation(image):
    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    hue_shift = random.randint(-10, 10)
    hsv[:, :, 0] = (hsv[:, :, 0] + hue_shift) % 180
    return cv2.cvtColor(hsv, cv2.COLOR_HSV2BGR)

def generate_random_text(length=5):
    chinese_characters = [chr(random.randint(0x4e00, 0x9fff)) for _ in range(length)]
    return ''.join(chinese_characters)

def place_text_on_image(image, text, height, width):
    pil_image = Image.fromarray(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
    draw = ImageDraw.Draw(pil_image)

    font_path = "C:\Windows\Fonts\simhei.ttf"
    font_size = 20
    font = ImageFont.truetype(font_path, font_size)

    text_position = (random.randint(0, width - font_size), random.randint(0, height - font_size))
    draw.text(text_position, text, font=font, fill=(255, 255, 255))

    return cv2.cvtColor(np.array(pil_image), cv2.COLOR_RGB2BGR)

def generate_random_text_image(source_image_path, output_path, num_images=20):
    source_image = cv2.imread(source_image_path)
    height, width, _ = source_image.shape

    for i in range(num_images):
        image = source_image.copy()

        text = generate_random_text()
        image = place_text_on_image(image, text, height, width)

        image = add_gaussian_noise(image)
        image = apply_blur(image)
        image = adjust_brightness_contrast(image)
        image = apply_perspective_transform(image)
        image = apply_color_variation(image)

        output_image_path = f"{output_path}/image_{i + 1}.png"
        cv2.imwrite(output_image_path, image)

# Example usage
source_image_path = "test.jpg"
output_path = "./"
generate_random_text_image(source_image_path, output_path)
