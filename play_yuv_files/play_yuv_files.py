import os
import re
import subprocess
import keyboard

# 获取当前目录下所有 .yuv 文件
yuv_files = [f for f in os.listdir('.') if f.endswith('.yuv')]
yuv_files.sort()  # 按文件名排序，便于依次播放

# 用于从文件名中提取分辨率的正则表达式
resolution_pattern = re.compile(r'_(\d+)x(\d+)\.yuv$')

def get_resolution_from_filename(filename):
    match = resolution_pattern.search(filename)
    if match:
        width, height = match.groups()
        return int(width), int(height)
    else:
        raise ValueError(f"文件名中未找到分辨率信息: {filename}")

current_index = 0

def play_yuv_file(index):
    filename = yuv_files[index]
    width, height = get_resolution_from_filename(filename)
    command = [
        'ffplay',
        '-f', 'rawvideo',
        '-pixel_format', 'nv12',
        '-video_size', f'{width}x{height}',
        filename
    ]
    # 使用 subprocess.Popen 而不是 run 以便后续关闭进程
    return subprocess.Popen(command)

# 当前播放进程
process = None

def on_key_event(event):
    global current_index, process

    if event.name == 'right':  # 按下右箭头键
        current_index = (current_index + 1) % len(yuv_files)
    elif event.name == 'left':  # 按下左箭头键
        current_index = (current_index - 1 + len(yuv_files)) % len(yuv_files)
    else:
        return

    # 如果有进程在运行，先终止它
    if process:
        process.terminate()

    # 播放新的文件
    process = play_yuv_file(current_index)

# 绑定键盘事件
keyboard.on_press(on_key_event)

# 首次播放第一个文件
process = play_yuv_file(current_index)

# 保持脚本运行
print("按右箭头键切换到下一个文件，按左箭头键切换到上一个文件，按 Esc 退出。")
keyboard.wait('esc')  # 按下 Esc 键退出

# 退出时终止 ffplay 进程
if process:
    process.terminate()
