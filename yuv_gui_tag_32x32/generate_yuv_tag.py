import cv2
import numpy as np

# 文件名和块大小
yuv_file = 'skin_detection_test_1920x1088.yuv'
width = 1920  # 图像宽度
height = 1088  # 图像高度
block_size = 32
frame_size = width * height * 3 // 2  # YUV 4:2:0格式


# 读取 YUV 图像帧
def read_yuv_frames(file, width, height):
    with open(file, 'rb') as f:
        yuv = f.read()
    num_frames = len(yuv) // frame_size
    frames = []
    for i in range(num_frames):
        frame_y = yuv[i * frame_size:i * frame_size + width * height]
        frame_y = np.frombuffer(frame_y, dtype=np.uint8).reshape((height, width))
        frames.append(frame_y)
    return frames


# 画网格
def draw_grid(image, block_size):
    for x in range(0, image.shape[1], block_size):
        cv2.line(image, (x, 0), (x, image.shape[0]), (255, 255, 255), 1)
    for y in range(0, image.shape[0], block_size):
        cv2.line(image, (0, y), (image.shape[1], y), (255, 255, 255), 1)


# 点击事件回调函数
clicked_blocks = set()
current_frame = 0


def on_mouse(event, x, y, flags, param):
    global current_frame
    if event == cv2.EVENT_LBUTTONDOWN:
        block_x = (x // block_size) * block_size
        block_y = (y // block_size) * block_size
        block_coord = (block_x, block_y, current_frame)
        if block_coord not in clicked_blocks:
            print(f"Clicked at block: ({block_x}, {block_y}) on frame {current_frame}")
            clicked_blocks.add(block_coord)
            with open('coordinates.txt', 'a') as file:
                file.write(f"{current_frame};{block_x};{block_y}\n")


# 切换帧
def display_frame(frame):
    y_channel_bgr = cv2.cvtColor(frame, cv2.COLOR_GRAY2BGR)  # 转换为 BGR 以便绘制彩色网格
    draw_grid(y_channel_bgr, block_size)
    cv2.imshow('Y Channel', y_channel_bgr)


# 读取所有帧
frames = read_yuv_frames(yuv_file, width, height)

# 显示第一帧
display_frame(frames[current_frame])

# 设置鼠标回调函数
cv2.setMouseCallback('Y Channel', on_mouse)

# 等待用户按键退出
while True:
    key = cv2.waitKey(0)
    if key == ord('q'):
        break
    elif key == ord('n'):
        current_frame = (current_frame + 1) % len(frames)
        display_frame(frames[current_frame])
    elif key == ord('p'):
        current_frame = (current_frame - 1) % len(frames)
        display_frame(frames[current_frame])

cv2.destroyAllWindows()
