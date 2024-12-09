import os
import random
import subprocess

# 配置参数
input_folder = "D:/src_yuv/challenge_p/tmp"  # 替换为实际的文件夹路径
num_files = 2  # 需要随机选择的文件数量
width = 2560  # YUV 的单个视频宽度
height = 1440  # YUV 的单个视频高度
yuv_format = "yuv420p"  # 输入的 YUV 格式
output_file = "output_preview.mp4"  # 输出的拼接视频文件名
rows = 2  # 矩阵的行数
cols = 1  # 矩阵的列数
scale_factor = 0.15  # 缩小比例，例如 0.5 表示缩小到 50%

# 从文件夹中随机选择 YUV 文件
all_files = [os.path.join(input_folder, f) for f in os.listdir(input_folder) if f.endswith(".yuv")]
input_files = random.sample(all_files, min(num_files, len(all_files)))

# 原始拼接视频的尺寸
output_width = width * cols
output_height = height * rows

# 缩放后的输出尺寸
scaled_width = int(output_width * scale_factor)
scaled_height = int(output_height * scale_factor)

# 生成 ffmpeg 命令
inputs = " ".join([f"-f rawvideo -pix_fmt {yuv_format} -s:v {width}x{height} -i {file}" for file in input_files])
filter_complex = f"xstack=inputs={len(input_files)}:layout=" + "|".join([f"{j * width}_{i * height}" for i in range(rows) for j in range(cols)])

# 缩放并生成输出
command = f"ffmpeg {inputs} -filter_complex \"{filter_complex},scale={scaled_width}:{scaled_height}\" -c:v libx264 -crf 23 -t 5 {output_file} -y"

# 执行 ffmpeg 命令
subprocess.run(command, shell=True)

print("拼接完成，输出文件为:", output_file)
print("输出视频尺寸为:", scaled_width, "x", scaled_height)
