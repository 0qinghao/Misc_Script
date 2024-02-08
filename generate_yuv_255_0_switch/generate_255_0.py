import numpy as np

# 视频分辨率
width, height = 352, 288
frames = 100  # 总帧数

# 创建一个空的YUV420序列
yuv_sequence = np.zeros((frames, height * 3 // 2, width), dtype=np.uint8)

# 交替填充Y、U、V分量
for i in range(frames):
    yuv_sequence[i, 0:height, 0:width] = 255 if i % 2 == 0 else 0
    yuv_sequence[i, height:height + height // 2, 0:width] = 128#255 if i % 2 == 0 else 0
    yuv_sequence[i, height + height // 2:, 0:width] = 128#255 if i % 2 == 0 else 0

# 将YUV序列保存为二进制文件
# with open('255_0_switch_352x288_100f.yuv', 'wb') as file:
with open('black_white_switch_352x288_100f.yuv', 'wb') as file:
    for frame in yuv_sequence:
        file.write(frame.tobytes())
