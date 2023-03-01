import os

# jpg文件夹路径
jpg_path = r'D:\Misc_Script\generate_all_size_yuv_pic\jpg'
# yuv文件夹路径
yuv_path = r'D:\Misc_Script\generate_all_size_yuv_pic\yuv'

# 生成的bat文件路径
batfile_path = r'D:\Misc_Script\generate_all_size_yuv_pic\cmd_list2.bat'

# cmd语句集合
cmd_str = ""

if not os.path.exists(yuv_path):
    print("jpg文件不存在！")
    exit(0)
if not os.path.exists(jpg_path):
    os.mkdir(jpg_path)

# 读取文件夹下全部文件名，文件名格式：序号_宽x高.yuv
yuv_list = os.listdir(yuv_path)
# change directory到指定目录下
os.chdir(yuv_path)
for yuv_name in yuv_list:
    x = yuv_name.split('.')  # (序号_宽x高,扩展名)
    y = x[0].split('_')  # (序号,宽x高)
    # 例ffmpeg -s 500x375 -i D:\image\yuv/000006_500x375.yuv \
    # D:\image\jpg2/000006_500x375.jpg -y
    cmd_str += \
        "ffmpeg -s "+y[1]+" -pixel_format nv12 -i " + yuv_path + "/" + yuv_name + " " \
        + " -q:v 2 " + jpg_path + "/" + x[0] + ".jpg -y\n"
cmd_str += "pause"

# 生成bat文件
outf = open(batfile_path, 'w')
outf.write(cmd_str)
outf.close()
