../bin/DecoderApp.exe -b ./1_outdoor_day_cross_1920x1088.bin -o ./1_outdoor_day_cross_1920x1088_dec.yuv | tee ./log/1_outdoor_day_cross_1920x1088_dec.log
Pause

# ## 批量处理脚本
# $bin_dir = "./"

# $bin_file_list = ls -Path $bin_dir -Filter "*.bin"
# $bin_name_list = $bin_file_list.Name -replace ".bin", ""
# foreach ($bin_name in $bin_name_list) {
#     if ((Get-Item ./$bin_name`.bin).Length -gt 0kb) {
#         $cmd = "../bin/DecoderApp.exe -b ./$bin_name`.bin -o ./$bin_name`_dec.yuv --OutputBitDepth=8 | tee ./log/$bin_name`_dec.log"
#         Invoke-Expression $cmd
#     }
# }
# Pause