#################### para part ####################
Param 
(
    $parent_f0 = "./ResultRC_2023_11_01_0000_NO_FBC", 
    $parent_f1 = "./ResultRC_2023_11_08_0444_FBC65",
    $yuv_size = "1920x1088"
)
#################### para part end ####################

function Get-Sequences {
    $seqFolders = Get-ChildItem $parent_f0 | Where-Object { $_.PSIsContainer } | Select-Object -ExpandProperty Name

    Write-Host "Available sequences:"
    for ($i = 0; $i -lt $seqFolders.Count; $i++) {
        Write-Host "$i. $($seqFolders[$i])"
    }

    $input = Read-Host "Enter the sequence number (or 'q' to quit)"

    if ($input -eq 'q') {
        exit
    }

    if ($input -ge 0 -and $input -lt $seqFolders.Count) {
        return $seqFolders[$input]
    } else {
        Write-Host "Invalid input. Please enter a valid sequence number or 'q' to quit."
        return $null
    }
}

do {
    $selectedSeq = Get-Sequences

    if ($selectedSeq -ne $null) {
        $sw = 1920 * 2
        $sh = 1080 * 2
        $speed = 25

        $label0 = "NO FBC"
        $label1 = "FBC 65 percent"
        $label2 = "Y_difference"
        $label3 = "UV_difference"

        $input0 = "-i `"$parent_f0/$selectedSeq/$selectedSeq`_cbr_2M.h265`"" 
        $input1 = "-i `"$parent_f1/$selectedSeq/$selectedSeq`_cbr_2M.h265`"" 

        $label_font_common_cfg = "fontfile=simhei.ttf:fontsize=$($sw/50):fontcolor=red"

        $cmd_ffmpeg_part = ".\ffmpeg.exe $input0 $input1 -filter_complex `"nullsrc=size=$sw`x$sh`:rate=25[base]; [0:v]scale=$($sw/2)`:$($sh/2)[0:vp]; [1:v]scale=$($sw/2)`:$($sh/2)[1:vp]; [0:v]format=yuva420p,lut=c1=0:c2=0:c3=128,negate[v0yforcmp]; [1:v]format=yuva420p,lut=c1=0:c2=0[v1yforcmp]; [v1yforcmp][v0yforcmp]overlay,scale=$($sw/2)`:$($sh/2)[2:vp]; [0:v]format=yuva420p,lut=c0=0:c3=128,negate[v0uvforcmp]; [1:v]format=yuva420p,lut=c0=0[v1uvforcmp]; [v1uvforcmp][v0uvforcmp]overlay,scale=$($sw/2)`:$($sh/2)[3:vp]; [base][0:vp]overlay=0:0[a]; [a][1:vp]overlay=$($sw/2)`:0[b]; [b][2:vp]overlay=0:$($sh/2)[c]; [c][3:vp]overlay=$($sw/2)`:$($sh/2)[d]; [d]setpts=$(25/$speed)*PTS`" -f avi -c:v rawvideo -pix_fmt yuv420p - | "

        $cmd_ffplay_part = ".\ffplay.exe -vf `"drawtext=$label_font_common_cfg`:text=%{frame_num}:x=(w-tw)/2:y=h-lh,drawtext=$label_font_common_cfg`:text=$label0`:x=0:y=0,drawtext=$label_font_common_cfg`:text=$label1`:x=$($sw/2):y=0,drawtext=$label_font_common_cfg`:text=$label2`:x=0:y=$($sh/2),drawtext=$label_font_common_cfg`:text=$label3`:x=$($sw/2):y=$($sh/2)`" -noframedrop -left 9999 -fs -"

        $cmd = $cmd_ffmpeg_part + $cmd_ffplay_part
        cmd /c $cmd
    }
} while ($true)
