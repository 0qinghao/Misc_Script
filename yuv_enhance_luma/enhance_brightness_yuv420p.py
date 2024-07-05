import numpy as np


def enhance_brightness_yuv420p_percentage(yuv_data, width, height, percentage_increase):
    # Extract Y, U, V planes
    y_plane = yuv_data[0:width * height].reshape((height, width))
    u_plane = yuv_data[width * height:width * height + (width // 2) * (height // 2)].reshape((height // 2, width // 2))
    v_plane = yuv_data[width * height + (width // 2) * (height // 2):].reshape((height // 2, width // 2))

    # Increase Y values by percentage
    y_plane = np.clip(y_plane * (1 + percentage_increase), 0, 255).astype(np.uint8)

    # Combine planes back into a single array
    enhanced_yuv = np.concatenate((y_plane.flatten(), u_plane.flatten(), v_plane.flatten()))
    return enhanced_yuv


def main():
    # Example YUV420P video frame size
    width, height = 1920, 1088
    # Percentage increase for brightness enhancement
    percentage_increase = 0.2  # 20% increase

    # Read YUV420P data from file
    input_filename = 'D:\\src_yuv\\FH_Test\\2023-10-24\\indoor_lablight6_still_1920_1088_160.yuv'
    output_filename = 'output_enhanced.yuv'

    # Calculate the size of one frame in bytes
    frame_size = width * height * 3 // 2

    with open(input_filename, 'rb') as infile, open(output_filename, 'wb') as outfile:
        while True:
            # Read one frame of YUV420P data
            yuv_data = infile.read(frame_size)
            if len(yuv_data) < frame_size:
                break

            # Convert data to numpy array
            yuv_data = np.frombuffer(yuv_data, dtype=np.uint8)

            # Enhance brightness
            enhanced_yuv_data = enhance_brightness_yuv420p_percentage(yuv_data, width, height, percentage_increase)

            # Write enhanced data to output file
            outfile.write(enhanced_yuv_data.tobytes())

    print(f'Brightness enhancement completed. Enhanced video saved as {output_filename}')


if __name__ == "__main__":
    main()
