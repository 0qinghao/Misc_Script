#!/bin/bash

# 输入视频文件名
input_video="crop_select_wechat_512x512.yuv"

# 输出视频文件名
output_video="box_crop_select_wechat_512x512.yuv"

# 视频分辨率，根据你的视频分辨率设置
width=512
height=512

# 边框宽度，根据你的需求设置
border_width=2

# 边框颜色
border_color="red"

# 指定边框的位置和大小（x, y, w, h）
x=81
y=251
w=200
h=200

# 通过FFmpeg处理指定帧
ffmpeg -s:v "${width}x${height}" -pix_fmt yuv420p -i "$input_video" -vf "drawbox=x=${x}:y=${y}:w=${w}:h=${h}:color=${border_color}:t=${border_width}" -f rawvideo -pix_fmt yuv420p "$output_video"


echo "边框已添加到每帧。"
