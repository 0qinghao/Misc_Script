# stream folder, stream suffix, label
# 2x2 raster
$f0 = "D:\board_demo_stream\2023_09_22_XC00_cbr\"
$f1 = "D:\board_demo_stream\2023_09_22_XC00_cbr\"
$f2 = "D:\board_demo_stream\2023_09_22_XC00_cbr\"
$f3 = "D:\board_demo_stream\2023_09_22_XC00_cbr\"

$suffix0 = "PTV3.h265"
$suffix1 = "XC01.h265"
$suffix2 = "FY11.h265"
$suffix3 = "XC01.h265"

### 如果要求调整画面位置, 只修改这部分 start ###
# Get seq name, cat string
$seq = $args[0]
$stm0 = "$f0\$seq\$suffix0"
$stm1 = "$f1\$seq\$suffix1"
$stm2 = "$f2\$seq\$suffix2"
$stm3 = "$f3\$seq\$suffix3"

# Set labels
$label0 = "PTv3"
$label1 = "XC01"
$label2 = "FY11"
$label3 = "XC01"

# Special configurations
$special_cfg0 = ""
$special_cfg1 = ""
$special_cfg2 = ""
$special_cfg3 = ""

# Check if PTv3 stream exists
if (-not (Test-Path -Path $stm0 -PathType Leaf)) {
    $stm0 = $stm0 -replace "PTv3", "PTv2"
    $label0 = $label0 -replace "PTv3", "PTv2"
    $special_cfg0 = "$special_cfg0,setpts=2*PTS"
}
### 如果要求调整画面位置, 只修改这部分 end ###

# Set play speed (=25 normal; <25 slow; >25 fast(limited by hardware))
$speed = 25

# ffmpeg / ffplay paths
$ffmpeg = "D:\Program Files (x86)\ffmpeg\bin\ffmpeg.exe"
$ffplay = "D:\Program Files (x86)\ffmpeg\bin\ffplay.exe"

# Set screen size
$sw = 1920 * 2
$sh = 1080 * 2

# Font configuration
$label_font_common_cfg = "fontfile=simhei.ttf:fontsize=$($sw/50):fontcolor=red"

# ffmpeg command
$ffmpegCommand = @"
"$ffmpeg" -i "$stm0" -i "$stm1" -i "$stm2" -i "$stm3" -filter_complex "nullsrc=size=$sw`x$sh`:rate=25[base]; [0:v]crop=1920:1080:0:0,scale=$($sw/2):$($sh/2):$special_cfg0[0:tmp]; [1:v]crop=1920:1080:0:0,scale=$($sw/2):$($sh/2):$special_cfg1[1:tmp]; [2:v]crop=1920:1080:0:0,scale=$($sw/2):$($sh/2):$special_cfg2[2:tmp]; [3:v]crop=1920:1080:0:0,scale=$($sw/2):$($sh/2):$special_cfg3[3:tmp]; [base][0:tmp]overlay=0:0[a]; [a][1:tmp]overlay=$($sw/2):0[b]; [b][2:tmp]overlay=0:$($sh/2)[c]; [c][3:tmp]overlay=$($sw/2):$($sh/2)[d]; [d]setpts=25/$speed*PTS" -f avi -c:v rawvideo -pix_fmt yuv420p -
"@

# ffplay command
$ffplayCommand = @"
"$ffplay" -vf "drawtext=$label_font_common_cfg`:text=%{frame_num}:x=(w-tw)/2:y=h-lh,drawtext=$label_font_common_cfg`:text=$label0`:x=0:y=0,drawtext=$label_font_common_cfg`:text=$label1`:x=$($sw/2):y=0,drawtext=$label_font_common_cfg`:text=$label2`:x=0:y=$($sh/2),drawtext=$label_font_common_cfg`:text=$label3`:x=$($sw/2):y=$($sh/2)" -noframedrop -left 9999 -fs -
"@

# powershell 的管道操作很难处理, 交给 cmd 去运行
$cmdCommand = "$ffmpegCommand | $ffplayCommand"
cmd /c $cmdCommand
