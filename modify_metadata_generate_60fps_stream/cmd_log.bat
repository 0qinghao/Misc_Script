rem 由 ffmpeg / x265 生成，可能含有一些高级编码工具 (wpp/ref=3...)，我们的编码器生成的 264/265 码流中是不包含 fps 信息的，要修改存在较大困难
rem 上述码流已提交
rem 现在发现了使用 ffmpeg 直接修改 metadata 的方案

ffmpeg -i .\9_indoor_day_canteen_1920x1088_cbr_2M.h264 -c:v copy -bsf:v h264_metadata=tick_rate=120 bsfv.h264
ffmpeg -i .\9_indoor_day_canteen_1920x1088_cbr_2M.h265 -c:v copy -bsf:v hevc_metadata=tick_rate=60 bsfv.h265