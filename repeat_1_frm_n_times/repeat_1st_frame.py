import os


def extract_and_repeat_first_frame(input_yuv, output_yuv, width, height, frames_to_repeat=350):
    # 计算Y、U、V平面的大小
    frame_size = width * height * 3 // 2

    with open(input_yuv, 'rb') as infile:
        with open(output_yuv, 'wb') as outfile:
            # 读取第一帧
            first_frame = infile.read(frame_size)

            # 重复写入第一帧
            for _ in range(frames_to_repeat):
                outfile.write(first_frame)


if __name__ == "__main__":
    input_yuv = 'D:/src_yuv/trouble_shooting/fbc_flicker_1440x960.yuv'  # 输入YUV序列文件
    output_yuv = 'output_sequence.yuv'  # 输出的YUV文件
    width = 1440  # 图像的宽度
    height = 960  # 图像的高度

    extract_and_repeat_first_frame(input_yuv, output_yuv, width, height)
