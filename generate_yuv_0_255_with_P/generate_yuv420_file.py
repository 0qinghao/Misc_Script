import random

def generate_yuv420_file(filename, width, height, num_frames):
    with open(filename, 'wb') as file:
        for _ in range(num_frames):
            # Generate a random probability for each frame
            probability = random.uniform(0, 1)
            # Generate Y data
            y_data = bytes(random.choices([0, 255], k=width * height, weights=[probability, 1 - probability]))

            # Generate a random probability for each frame
            probability = random.uniform(0, 1)
            # Generate U data
            u_data = bytes(random.choices([0, 255], k=width * height // 4, weights=[probability, 1 - probability]))

            # Generate a random probability for each frame
            probability = random.uniform(0, 1)
            # Generate V data
            v_data = bytes(random.choices([0, 255], k=width * height // 4, weights=[probability, 1 - probability]))

            # Write Y, U, and V data in sequence
            file.write(y_data)
            file.write(u_data)
            file.write(v_data)

    print(f"YUV420 file '{filename}' generated successfully.")

# 设置参数
width = 352
height = 240
num_frames = 100
filename = f"rand_p_255_0_{width}x{height}.yuv"

# 生成YUV420文件
generate_yuv420_file(filename, width, height, num_frames)
