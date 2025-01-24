import numpy as np
from PIL import Image, ImageFilter
import os


def yuv_to_gray(yuv_frame, width, height):
    """
    将YUV NV12帧转换为灰度图像
    """
    # YUV分量的大小
    y_size = width * height
    uv_size = (width // 2) * (height // 2)

    # YUV分量
    y = yuv_frame[:y_size].reshape((height, width)).copy()  # 使用copy()确保是可修改的
    uv = yuv_frame[y_size:].reshape((height // 2, width // 2, 2)).copy()  # 使用copy()确保是可修改的

    # 将YUV图像变为灰度，只保留Y分量，U和V设置为128（灰色）
    uv[:, :, 0] = 128  # U通道
    uv[:, :, 1] = 128  # V通道

    # 返回变为灰度的YUV图像
    return np.concatenate([y.flatten(), uv.flatten()])


def process_icon(icon_path, target_size):
    """
    处理带透明通道的图标：将非透明区域变红，并将图标缩放到统一大小
    """
    # 打开图标并将其转换为RGBA模式
    icon = Image.open(icon_path).convert("RGBA")

    # 缩放图标到统一大小
    icon = icon.resize(target_size, Image.Resampling.LANCZOS)

    # 对图标应用高斯模糊（可调节模糊的强度）
    icon = icon.filter(ImageFilter.GaussianBlur(radius=1))  # radius可调节模糊强度

    # 获取图标的RGBA分量
    data = np.array(icon)

    # 遍历每个像素
    for i in range(data.shape[0]):
        for j in range(data.shape[1]):
            # 如果alpha值大于0（即非透明区域），变为红色
            if data[i, j, 3] > 0:  # Alpha通道
                data[i, j] = [255, 0, 0, 255]  # 红色，完全不透明

    # 转换回RGBA图像
    red_icon = Image.fromarray(data, mode="RGBA")
    return red_icon


def overlay_icon_on_yuv(yuv_frame, icons, width, height, target_size):
    """
    将多个处理过的图标叠加到YUV帧的左上角
    """
    # 获取图标的大小
    icon_height, icon_width = target_size
    num_icons = len(icons)

    # 假设YUV为NV12格式，获取YUV分量
    y_size = width * height
    uv_size = (width // 2) * (height // 2)

    y = yuv_frame[:y_size].reshape((height, width))
    uv = yuv_frame[y_size:].reshape((height // 2, width // 2, 2))

    # 计算每个图标的叠加位置
    y_offset = 0
    x_offset = 0

    for icon in icons:
        # 获取图标数据
        icon_data = np.array(icon)

        # 在YUV帧的左上角叠加图标
        for i in range(min(icon_height, height - y_offset)):
            for j in range(min(icon_width, width - x_offset)):
                # 仅在非透明区域叠加图标
                if icon_data[i, j, 3] > 0:
                    # 对应的YUV值修改，假设图标是RGB（255,0,0）
                    y[i + y_offset, j + x_offset] = 76  # Y值，近似于红色
                    uv[(i + y_offset) // 2, (j + x_offset) // 2, 0] = 128  # U值，固定
                    uv[(i + y_offset) // 2, (j + x_offset) // 2, 1] = 255  # V值，接近红色的色调

        # 更新偏移量，向下排列下一个图标
        x_offset += icon_width * 2

    # 将YUV分量拼接成一帧
    new_yuv_frame = np.concatenate([y.flatten(), uv.flatten()])
    return new_yuv_frame


def process_yuv_file(yuv_file, icons, width, height, target_size, frame_count):
    """
    逐帧处理YUV文件，并叠加多个图标
    """
    with open(yuv_file, 'rb') as f:
        # 计算每一帧的大小
        frame_size = width * height * 3 // 2  # YUV NV12一帧的大小

        # 逐帧处理YUV数据
        for frame_index in range(frame_count):
            yuv_frame = np.frombuffer(f.read(frame_size), dtype=np.uint8)

            # 转换为灰度并叠加图标
            gray_yuv = yuv_to_gray(yuv_frame, width, height)
            overlayed_yuv = overlay_icon_on_yuv(gray_yuv, icons, width, height, target_size)

            # 返回处理后的帧数据
            yield overlayed_yuv


def main(yuv_file, icon_folder, output_file, width, height, target_size=(50, 50), frame_count=100):
    """
    主函数：处理单个YUV文件，叠加多个图标并保存输出
    """
    # 读取图标文件夹中的所有图标文件
    icon_files = [f for f in os.listdir(icon_folder) if f.endswith(('.png', '.jpg', '.bmp'))]

    # 处理图标
    icons = [process_icon(os.path.join(icon_folder, icon_file), target_size) for icon_file in icon_files]

    # 处理YUV文件并叠加图标
    processed_sequence = process_yuv_file(yuv_file, icons, width, height, target_size, frame_count)

    # 保存输出到指定文件
    with open(output_file, 'wb') as f:
        for frame in processed_sequence:
            f.write(frame)

    print(f"Processed YUV file and saved to {output_file}")


if __name__ == "__main__":
    yuv_file = "D:\\src_yuv\\challenge_p_stream_to_yuv\\yingshi_cam_move_736x1280_nv12.yuv"  # 替换为YUV文件路径
    icon_folder = ".\\icon"  # 替换为图标文件夹路径
    output_file = "out.yuv"  # 替换为输出文件路径
    width = 736  # 设置YUV序列的宽度
    height = 1280  # 设置YUV序列的高度
    target_size = (50, 50)  # 设置图标缩放后的大小
    frame_count = 300  # 设置YUV文件中的帧数

    main(yuv_file, icon_folder, output_file, width, height, target_size, frame_count)
