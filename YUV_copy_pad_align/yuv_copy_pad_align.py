import numpy as np


def read_yuv_frames(yuv_file, width, height, target_width, target_height, frame_count):
    """
    读取多帧YUV数据，并返回填充后的帧数据
    :param yuv_file: 输入的YUV文件路径
    :param width: 每帧的原始宽度
    :param height: 每帧的原始高度
    :param target_width: 目标帧宽度
    :param target_height: 目标帧高度
    :param frame_count: 要处理的帧数
    :return: 填充后的帧列表
    """
    frame_size = width * height * 3 // 2  # YUV420P格式

    yuv_data = np.fromfile(yuv_file, dtype=np.uint8)

    frames = []
    for i in range(frame_count):
        start = i * frame_size
        end = start + frame_size
        frame_data = yuv_data[start:end]

        # 解析YUV420P格式
        y = frame_data[:width * height].reshape((height, width))
        u = frame_data[width * height:width * height + (width // 2) * (height // 2)].reshape((height // 2, width // 2))
        v = frame_data[width * height + (width // 2) * (height // 2):].reshape((height // 2, width // 2))

        # 填充每一帧
        y_padded, u_padded, v_padded = pad_yuv(y, u, v, target_width, target_height)

        frames.append((y_padded, u_padded, v_padded))

    return frames


def write_yuv_frames(output_file, frames):
    """
    将填充后的多帧YUV数据写入文件
    :param output_file: 输出文件路径
    :param frames: 填充后的帧数据
    """
    with open(output_file, 'wb') as f:
        for y, u, v in frames:
            f.write(y.tobytes())
            f.write(u.tobytes())
            f.write(v.tobytes())


def pad_yuv(y, u, v, target_width, target_height):
    """
    用复制最后一个像素填充Y、U、V分量到目标尺寸
    :param y: 原始Y分量
    :param u: 原始U分量
    :param v: 原始V分量
    :param target_width: 目标宽度
    :param target_height: 目标高度
    :return: 填充后的Y、U、V分量
    """
    # 填充Y分量
    y_padded = np.copy(y)
    if target_height > y.shape[0]:
        y_padded = np.vstack([y_padded, np.tile(y[-1, :], (target_height - y.shape[0], 1))])
    if target_width > y.shape[1]:
        y_padded = np.hstack([y_padded, np.tile(y_padded[:, -1:], (1, target_width - y.shape[1]))])

    # 填充U分量
    u_padded = np.copy(u)
    if target_height // 2 > u.shape[0]:
        u_padded = np.vstack([u_padded, np.tile(u[-1, :], (target_height // 2 - u.shape[0], 1))])
    if target_width // 2 > u.shape[1]:
        u_padded = np.hstack([u_padded, np.tile(u_padded[:, -1:], (1, target_width // 2 - u.shape[1]))])

    # 填充V分量
    v_padded = np.copy(v)
    if target_height // 2 > v.shape[0]:
        v_padded = np.vstack([v_padded, np.tile(v[-1, :], (target_height // 2 - v.shape[0], 1))])
    if target_width // 2 > v.shape[1]:
        v_padded = np.hstack([v_padded, np.tile(v_padded[:, -1:], (1, target_width // 2 - v.shape[1]))])

    return y_padded, u_padded, v_padded


def main():
    input_file = 'T:\Derek.You\YUV_Sequence\others\mobile_144_144.yuv'  # 输入文件
    output_file = 'output.yuv'  # 输出文件
    width, height = 144, 144  # 输入帧的宽高
    target_width, target_height = 160, 160  # 目标帧的宽高
    frame_count = 10  # 假设要处理的帧数

    # 读取并填充多帧YUV数据
    frames = read_yuv_frames(input_file, width, height, target_width, target_height, frame_count)

    # 写入填充后的YUV数据
    write_yuv_frames(output_file, frames)

    print(f"YUV数据已经填充并保存到 {output_file}")


if __name__ == "__main__":
    main()
