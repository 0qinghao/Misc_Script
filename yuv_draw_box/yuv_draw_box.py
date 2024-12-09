import numpy as np
import os


def draw_transparent_box_outline_on_frame(frame, width, height, x, y, box_width, box_height, color=(255, 128, 128), alpha=0.5, line_thickness=1):
    """
    在一帧 YUV 图像上画半透明的外边框线，并支持控制边框线的粗细。
    """
    y_value, u_value, v_value = color  # 解包颜色值

    # 创建新的缓冲区
    new_frame = {'Y': frame['Y'].copy(), 'U': frame['U'].copy(), 'V': frame['V'].copy()}

    # 限制框的范围
    x_end = min(x + box_width, width)
    y_end = min(y + box_height, height)

    # Y 通道：绘制边框线
    for i in range(line_thickness):  # 按照粗细迭代绘制多层边框
        # 上边框
        if y + i < height:
            new_frame['Y'][y + i, x:x_end] = (alpha * y_value + (1 - alpha) * frame['Y'][y + i, x:x_end]).astype(np.uint8)
        # 下边框
        if y_end - 1 - i >= 0:
            new_frame['Y'][y_end - 1 - i, x:x_end] = (alpha * y_value + (1 - alpha) * frame['Y'][y_end - 1 - i, x:x_end]).astype(np.uint8)
        # 左边框
        if x + i < width:
            new_frame['Y'][y:y_end, x + i] = (alpha * y_value + (1 - alpha) * frame['Y'][y:y_end, x + i]).astype(np.uint8)
        # 右边框
        if x_end - 1 - i >= 0:
            new_frame['Y'][y:y_end, x_end - 1 - i] = (alpha * y_value + (1 - alpha) * frame['Y'][y:y_end, x_end - 1 - i]).astype(np.uint8)

    # UV 通道：绘制边框线
    uv_x, uv_y = x // 2, y // 2
    uv_x_end, uv_y_end = x_end // 2, y_end // 2
    uv_line_thickness = max(1, line_thickness // 2)  # UV 分辨率减半，调整线宽

    for i in range(uv_line_thickness):
        # 上边框
        if uv_y + i < height // 2:
            new_frame['U'][uv_y + i, uv_x:uv_x_end] = (alpha * u_value + (1 - alpha) * frame['U'][uv_y + i, uv_x:uv_x_end]).astype(np.uint8)
            new_frame['V'][uv_y + i, uv_x:uv_x_end] = (alpha * v_value + (1 - alpha) * frame['V'][uv_y + i, uv_x:uv_x_end]).astype(np.uint8)
        # 下边框
        if uv_y_end - 1 - i >= 0:
            new_frame['U'][uv_y_end - 1 - i, uv_x:uv_x_end] = (alpha * u_value + (1 - alpha) * frame['U'][uv_y_end - 1 - i, uv_x:uv_x_end]).astype(np.uint8)
            new_frame['V'][uv_y_end - 1 - i, uv_x:uv_x_end] = (alpha * v_value + (1 - alpha) * frame['V'][uv_y_end - 1 - i, uv_x:uv_x_end]).astype(np.uint8)
        # 左边框
        if uv_x + i < width // 2:
            new_frame['U'][uv_y:uv_y_end, uv_x + i] = (alpha * u_value + (1 - alpha) * frame['U'][uv_y:uv_y_end, uv_x + i]).astype(np.uint8)
            new_frame['V'][uv_y:uv_y_end, uv_x + i] = (alpha * v_value + (1 - alpha) * frame['V'][uv_y:uv_y_end, uv_x + i]).astype(np.uint8)
        # 右边框
        if uv_x_end - 1 - i >= 0:
            new_frame['U'][uv_y:uv_y_end, uv_x_end - 1 - i] = (alpha * u_value + (1 - alpha) * frame['U'][uv_y:uv_y_end, uv_x_end - 1 - i]).astype(np.uint8)
            new_frame['V'][uv_y:uv_y_end, uv_x_end - 1 - i] = (alpha * v_value + (1 - alpha) * frame['V'][uv_y:uv_y_end, uv_x_end - 1 - i]).astype(np.uint8)

    return new_frame


def process_yuv_sequence(input_path, output_path, width, height, frames, box_width, box_height, start_x, start_y, dx, dy, color, alpha, move_interval, line_thickness):
    """
    在 YUV 图像序列中画运动的半透明框。
    """
    y_size = width * height
    uv_size = y_size // 4

    # 当前框位置
    curr_x = start_x
    curr_y = start_y

    # 打开输入文件和输出文件
    with open(input_path, 'rb') as infile, open(output_path, 'wb') as outfile:
        for frame_idx in range(frames):
            # 读取一帧 YUV
            y = np.frombuffer(infile.read(y_size), dtype=np.uint8).reshape((height, width))
            u = np.frombuffer(infile.read(uv_size), dtype=np.uint8).reshape((height // 2, width // 2))
            v = np.frombuffer(infile.read(uv_size), dtype=np.uint8).reshape((height // 2, width // 2))

            frame = {'Y': y, 'U': u, 'V': v}

            # 更新框的位置（根据间隔控制运动）
            if frame_idx % move_interval == 0:
                curr_x = int(curr_x + dx)
                curr_y = int(curr_y + dy)

            # 在当前帧画半透明框
            new_frame = draw_transparent_box_outline_on_frame(frame, width, height, curr_x, curr_y, box_width, box_height, color, alpha, line_thickness)

            # 写入修改后的帧
            outfile.write(new_frame['Y'].tobytes())
            outfile.write(new_frame['U'].tobytes())
            outfile.write(new_frame['V'].tobytes())


if __name__ == "__main__":
    # 配置参数
    input_yuv = "D:/src_yuv/FH_Test/stress/case7_xgm_outdoor_day_avenue_1920x1088_1000frames.yuv"  # 输入 YUV 文件
    output_yuv = "D:/src_yuv/trouble_shooting/flicker/draw_box_1920x1088.yuv"  # 输出 YUV 文件
    width = 1920  # 图像宽度
    height = 1088  # 图像高度
    frames = 151  # 帧数

    box_width = 500  # 框宽度
    box_height = 400  # 框高度
    line_thickness = 2
    start_x = 1100  # 起始位置 x
    start_y = 100  # 起始位置 y
    dx = 2  # 每次水平移动量
    dy = 4  # 每次垂直移动量
    move_interval = 2  # 每隔 move_interval 帧运动一次

    # 框的颜色和透明度
    # color = (81, 90, 240)  # 红色
    # color = (210, 16, 146)  # 黄色
    color = (145, 54, 34)  # 绿色
    # color = (41, 240, 110)  # 蓝色
    alpha = 0.7  # 透明度（0.0 完全透明，1.0 完全不透明）

    # 调用处理函数
    process_yuv_sequence(input_yuv, output_yuv, width, height, frames, box_width, box_height, start_x, start_y, dx, dy, color, alpha, move_interval, line_thickness)
