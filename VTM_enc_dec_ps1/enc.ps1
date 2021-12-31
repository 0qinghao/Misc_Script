../bin/EncoderApp.exe -c ../cfg/encoder_lowdelay_vtm.cfg --InputFile=\\pub\staff\derek.you\2019-07-30-FullhanSrc\420\1_outdoor_day_cross_1920x1088.yuv --FrameRate=25 --SourceWidth=1920 --SourceHeight=1088 --FramesToBeEncoded=15 --BitstreamFile=1_outdoor_day_cross_1920x1088.bin --ReconFile=1_outdoor_day_cross_1920x1088_rec.yuv --OutputBitDepth=8 | tee ./log/1_outdoor_day_cross_1920x1088_enc.log
Pause

# ## 批量处理脚本
# $yuv_dir = "\\pub\staff\derek.you\2019-07-30-FullhanSrc\420\"

# $para_comm = " --FrameRate=25"
# $para_comm = $para_comm + " --SourceWidth=1920 --SourceHeight=1088"
# $para_comm = $para_comm + " --FramesToBeEncoded=15"
# $para_comm = $para_comm + " --OutputBitDepth=8"
# ## default QP has been set in *.cfg file, uncomment it to override
# # $para_comm = $para_comm + " --QP==42"

# $yuv_file_list = ls -Path $yuv_dir -Filter "*.yuv"
# $yuv_name_list = $yuv_file_list.Name -replace ".yuv", ""
# foreach ($yuv_name in $yuv_name_list) {
#     $para = $para_comm + " --InputFile=$yuv_dir\$yuv_name`.yuv"
#     $para = $para + " --BitstreamFile=$yuv_name`.bin"
#     $para = $para + " --ReconFile=$yuv_name`_rec.yuv"
#     $cmd = "../bin/EncoderApp.exe -c ../cfg/encoder_lowdelay_vtm.cfg $para | tee ./log/$yuv_name`_enc.log"
#     Invoke-Expression $cmd
# }
# Pause