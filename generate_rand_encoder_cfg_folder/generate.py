import sys
import os
import random

# 创建文件夹和配置文件
def create_config_files(folder_name,yuv_name):
    os.makedirs(folder_name, exist_ok=True)
    
    # 生成hevc_encoder.cfg
    with open(os.path.join(folder_name, 'hevc_encoder.cfg'), 'w') as hevc_file:
        hevc_file.write(f'{yuv_name}\n')
        hevc_file.write(f'test_enc.h265\n')
        hevc_file.write(f'test_rec.yuv\n')
        hevc_file.write(f'{random.randint(1,12)*128}\n')
        hevc_file.write(f'{random.randint(1,12)*128}\n')
        hevc_file.write(f'{random.randint(1,100)}\n')
        hevc_file.write(f'{random.randint(0,51)}\n')
        hevc_file.write(f'{random.randint(0,51)}\n')
        hevc_file.write(f'{random.randint(0,1)}\n')
        hevc_file.write(f'{random.randint(100,10000)}\n')
        hevc_file.write(f'1\n')
        hevc_file.write(f'25\n')
        hevc_file.write(f'{random.randint(1,30)}\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'0x00\n')
        hevc_file.write(f'1\n')
        hevc_file.write(f'2\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'8\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'{random.choice([0, 3, 4, 7])}\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'0\n')
        hevc_file.write(f'2\n')
        hevc_file.write(f'x.ttv\n')

    
    # 生成h264_encoder.cfg
    with open(os.path.join(folder_name, 'h264_encoder.cfg'), 'w') as h264_file:
        h264_file.write(f'{yuv_name}\n')
        h264_file.write(f'test_enc.h264\n')
        h264_file.write(f'test_rec.yuv\n')
        h264_file.write(f'{random.randint(1,12)*128}\n')
        h264_file.write(f'{random.randint(1,12)*128}\n')
        h264_file.write(f'{random.randint(1,100)}\n')
        h264_file.write(f'{random.randint(0,51)}\n')
        h264_file.write(f'{random.randint(0,51)}\n')
        h264_file.write(f'{random.randint(0,1)}\n')
        h264_file.write(f'{random.randint(100,10000)}\n')
        h264_file.write(f'1\n')
        h264_file.write(f'25\n')
        h264_file.write(f'{random.randint(1,30)}\n')
        h264_file.write(f'0\n')
        h264_file.write(f'0\n')
        h264_file.write(f'0x00\n')
        h264_file.write(f'1\n')
        h264_file.write(f'2\n')
        h264_file.write(f'1\n')
        h264_file.write(f'0\n')
        h264_file.write(f'0\n')
        h264_file.write(f'0\n')
        h264_file.write(f'0\n')
        h264_file.write(f'8\n')
        h264_file.write(f'0\n')
        h264_file.write(f'0\n')
        h264_file.write(f'{random.choice([0, 3, 4, 7])}\n')
        h264_file.write(f'0\n')
        h264_file.write(f'0\n')
        h264_file.write(f'0\n')
        h264_file.write(f'0\n')
        h264_file.write(f'0\n')
        h264_file.write(f'2\n')
        h264_file.write(f'x.ttv\n')
    
    # 生成rate_control.cfg
    with open(os.path.join(folder_name, 'rate_control.cfg'), 'w') as rate_file:
        rate_file.write(f'{random.randint(1,2)}\n')
        tmp1 = random.randint(0,51)
        tmp2 = random.randint(0,51)
        rate_file.write(f'{min(tmp1,tmp2)}\n')
        rate_file.write(f'{max(tmp1,tmp2)}\n')
        tmp1 = random.randint(0,51)
        tmp2 = random.randint(0,51)
        rate_file.write(f'{min(tmp1,tmp2)}\n')
        rate_file.write(f'{max(tmp1,tmp2)}\n')
        rate_file.write(f'{random.randint(0,1)}\n')
        rate_file.write(f'1\n')
        rate_file.write(f'0\n')
        rate_file.write(f'40\n')
        rate_file.write(f'0\n')

if __name__ == "__main__":
    yuv_name = "nv12_rand_offset_in_blk64_uint_with_frame_P_128x128_10000f.yuv"#sys.argv[1]
    # 生成多组配置文件
    for i in range(1000, 1002):  # 示例生成1000到1004的文件夹
        folder_name = f'case_rand_{i}'
        create_config_files(folder_name, yuv_name)
