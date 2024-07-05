import numpy as np
import mediapipe as mp
import os
import random

from mediapipe.tasks import python
from mediapipe.tasks.python import vision


# Function to read YUV420 frame
def read_yuv420_frame(file, width, height, frame_num):
    frame_size = width * height * 3 // 2
    file.seek(frame_size * frame_num)
    y = np.fromfile(file, dtype=np.uint8, count=width * height).reshape((height, width))
    u = np.fromfile(file, dtype=np.uint8, count=width * height // 4).reshape((height // 2, width // 2))
    v = np.fromfile(file, dtype=np.uint8, count=width * height // 4).reshape((height // 2, width // 2))

    # Upsample U and V to the size of Y
    u = np.repeat(np.repeat(u, 2, axis=0), 2, axis=1)
    v = np.repeat(np.repeat(v, 2, axis=0), 2, axis=1)

    # Stack Y, U, V channels together
    yuv = np.stack((y, u, v), axis=-1)

    return yuv


# Convert YUV to RGB using standard coefficients
def yuv_to_rgb(yuv):
    y = yuv[:, :, 0].astype(np.float32)
    u = yuv[:, :, 1].astype(np.float32) - 128.0
    v = yuv[:, :, 2].astype(np.float32) - 128.0

    r = y + 1.402 * v
    g = y - 0.344136 * u - 0.714136 * v
    b = y + 1.772 * u

    rgb = np.stack((r, g, b), axis=-1)
    rgb = np.clip(rgb, 0, 255).astype(np.uint8)

    return rgb


# Get test YUV files from two directories
directory_paths = ['D:\\src_yuv\\FH_Test\\stress']
YUV_FILENAMES = []
for directory_path in directory_paths:
    YUV_FILENAMES.extend([os.path.join(directory_path, file) for file in os.listdir(directory_path) if file.endswith('.yuv')])

width, height = 1920, 1088  # Example dimensions, adjust to your video dimensions

# Create the options that will be used for ImageSegmenter
base_options = python.BaseOptions(model_asset_path='./selfie_multiclass_256x256.tflite')
options = vision.ImageSegmenterOptions(base_options=base_options, output_category_mask=True, output_confidence_masks=True)

# Collect all YUV values
all_skin_yuv_values = []
all_non_skin_yuv_values = []

# Create the image segmenter
with vision.ImageSegmenter.create_from_options(options) as segmenter:
    # Loop through YUV files
    for yuv_file_name in YUV_FILENAMES:
        with open(yuv_file_name, 'rb') as file:
            frame_num = 0
            while True:
                try:
                    # Read every 100th frame
                    yuv_frame = read_yuv420_frame(file, width, height, frame_num)
                    rgb_frame = yuv_to_rgb(yuv_frame)

                    # Create the MediaPipe image file that will be segmented
                    image = mp.Image(image_format=mp.ImageFormat.SRGB, data=rgb_frame)

                    # Retrieve the masks for the segmented image
                    segmentation_result = segmenter.segment(image)
                    category_mask = segmentation_result.category_mask

                    # Retrieve confidence masks
                    confidence_masks = segmentation_result.confidence_masks

                    # Generate mask for body-skin (2) and face-skin (3)
                    body_skin_confidence = confidence_masks[2].numpy_view()
                    face_skin_confidence = confidence_masks[3].numpy_view()

                    # Combine the masks
                    combined_confidence = np.maximum(body_skin_confidence, face_skin_confidence)

                    # Threshold for confidence
                    threshold = 0.8
                    skin_mask = combined_confidence > threshold

                    # Extract YUV values where mask is true
                    skin_yuv_values = yuv_frame[skin_mask]

                    # Append YUV values to the list
                    all_skin_yuv_values.append(skin_yuv_values)

                    # Generate mask for non-skin regions (inverse of skin mask)
                    non_skin_mask = ~skin_mask

                    # Randomly sample non-skin regions to avoid bias
                    non_skin_indices = np.column_stack(np.where(non_skin_mask))
                    random_indices = np.random.choice(len(non_skin_indices), size=len(skin_yuv_values), replace=False)
                    sampled_non_skin_indices = non_skin_indices[random_indices]

                    non_skin_yuv_values = yuv_frame[sampled_non_skin_indices[:, 0], sampled_non_skin_indices[:, 1]]

                    # Append non-skin YUV values to the list
                    all_non_skin_yuv_values.append(non_skin_yuv_values)

                    frame_num += 500

                except ValueError:
                    # End of file reached
                    break

# Concatenate all YUV values into a single array
all_skin_yuv_values = np.concatenate(all_skin_yuv_values, axis=0)
all_non_skin_yuv_values = np.concatenate(all_non_skin_yuv_values, axis=0)

# Export YUV values to text files
np.savetxt('skin_yuv_values.txt', all_skin_yuv_values, fmt='%d')
np.savetxt('non_skin_yuv_values.txt', all_non_skin_yuv_values, fmt='%d')
