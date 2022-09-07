:: set screen size
set /a sw=1920*2
set /a sh=1080*2

:: set play speed (=25 normal; <25 slow; >25 fast(limited by network and hardware))
set speed=25

if %sw%/16*9 neq %sh% (
	set /a sh=%sw%/16*9
)

ffmpeg.exe ^
-i \\public\tpr\Derek.You\CBR_Compare\H265_2M\1_outdoor_day_cross_1920x1088\HM1625.h265 ^
-i \\public\tpr\Derek.You\CBR_Compare\H265_2M\1_outdoor_day_cross_1920x1088\x265.h265 ^
-i \\public\tpr\Derek.You\CBR_Compare\H265_2M\1_outdoor_day_cross_1920x1088\FH.h265 ^
-i \\public\tpr\Derek.You\CBR_Compare\H265_2M\1_outdoor_day_cross_1920x1088\Mol.h265 ^
-filter_complex "nullsrc=size=%sw%x%sh%:rate=25[base]; [0:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2[0:cs]; [1:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2[1:cs]; [2:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2:out_range=full,setpts=2*PTS[2:cs]; [3:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2[3:cs]; [base][0:cs]overlay=0:0[a]; [a][1:cs]overlay=%sw%/2:0[b]; [b][2:cs]overlay=0:%sh%/2[c]; [c][3:cs]overlay=%sw%/2:%sh%/2[d]; [d]setpts=25/%speed%*PTS" ^
-f nut -c:v rawvideo - | ffplay -

:: -f nut -c:v libx265 -x265-params "lossless=1" overlay.hevc
:: -f nut -c:v rawvideo overlay.yuv

:: FH stream need additional options, to make color range and play speed suitable