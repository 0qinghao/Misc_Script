$sw = 2560 * 2  # 叠加后图像尺寸
$sh = 1080 * 2
$speed = 50     # play speed

$label0 = "normal_decoder"
$label1 = "half_DPB_lossy_reference"
$label2 = "Y_difference"
$label3 = "UV_difference"

$label_font_common_cfg = "fontfile=simhei.ttf:fontsize=$($sw/50):fontcolor=red"

$cmd_ffmpeg_part = "ffmpeg -i crf40.avi -i crf45.avi -filter_complex `"nullsrc=size=$sw`x$sh`:rate=25[base]; [0:v]crop=1920:1080:0:0,scale=$($sw/2)`:$($sh/2)[0:vp]; [1:v]crop=1920:1080:0:0,scale=$($sw/2)`:$($sh/2)[1:vp]; [0:v]format=yuva420p,lut=c1=0:c2=0:c3=128,negate[v0yforcmp]; [1:v]format=yuva420p,lut=c1=0:c2=0[v1yforcmp]; [v1yforcmp][v0yforcmp]overlay,scale=$($sw/2)`:$($sh/2)[2:vp]; [0:v]format=yuva420p,lut=c0=0:c3=128,negate[v0uvforcmp]; [1:v]format=yuva420p,lut=c0=0[v1uvforcmp]; [v1uvforcmp][v0uvforcmp]overlay,scale=$($sw/2)`:$($sh/2)[3:vp]; [base][0:vp]overlay=0:0[a]; [a][1:vp]overlay=$($sw/2)`:0[b]; [b][2:vp]overlay=0:$($sh/2)[c]; [c][3:vp]overlay=$($sw/2)`:$($sh/2)[d]; [d]setpts=$(25/$speed)*PTS`" -f avi -c:v rawvideo -pix_fmt yuv420p - | "

$cmd_ffplay_part = "ffplay -vf `"drawtext=$label_font_common_cfg`:text=%{frame_num}:x=(w-tw)/2:y=h-lh,drawtext=$label_font_common_cfg`:text=$label0`:x=0:y=0,drawtext=$label_font_common_cfg`:text=$label1`:x=$($sw/2):y=0,drawtext=$label_font_common_cfg`:text=$label2`:x=0:y=$($sh/2),drawtext=$label_font_common_cfg`:text=$label3`:x=$($sw/2):y=$($sh/2)`" -noframedrop -left 9999 -fs -"

$cmd = $cmd_ffmpeg_part + $cmd_ffplay_part

# powershell 的管道操作很难处理, 交给 cmd 去运行
cmd /c $cmd
