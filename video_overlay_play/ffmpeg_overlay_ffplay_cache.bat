:: stream folder, stream suffix, label
set f1=D:\run_enc_script\Result_2022_12_15_1833 1214 cbr
set f2=D:\run_enc_script\Result_2023_01_12_2023 0110dev dirty_ch_sao_dist_12x
set f3=D:\FH_PT\PTv3
set f4=D:\run_enc_script\Result_tmp_test_2

set suffix1=_cbr_2M.h265
set suffix2=_cbr_2M.h265
set suffix3=.265
set suffix4=_cbr_2M.h265

set label1=Src 0110
set label2=Chroma SAO 12x
set label3=PTv3
set label4=tmp2

:: set screen size
set /a sw=1920*2
set /a sh=1080*2

:: set play speed (=25 normal; <25 slow; >25 fast(limited by network and hardware))
set speed=10

:: ffmpeg / ffplay
set ffmpeg="D:\Program Files (x86)\ffmpeg\bin\ffmpeg.exe"
set ffplay="D:\Program Files (x86)\ffmpeg\bin\ffplay.exe"

:: label theme
set label_font_common_cfg=fontfile=msyh.ttc:fontsize=%sw%/25:fontcolor=red

:: get seq name, cat string
set seq=%1
set stm1="%f1%/%seq%/%seq%%suffix1%"
set stm2="%f2%/%seq%/%seq%%suffix2%"
set stm3="%f3%/%seq%/%seq%%suffix3%"
set stm4="%f4%/%seq%/%seq%%suffix4%"

if %sw%/16*9 neq %sh% (
    set /a sh=%sw%/16*9
)

%ffmpeg% ^
-i %stm1% -i %stm2% -i %stm3% -i %stm4% ^
-filter_complex "nullsrc=size=%sw%x%sh%:rate=25[base]; [0:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2[0:cs]; [1:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2[1:cs]; [2:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2[2:cs]; [3:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2[3:cs]; [base][0:cs]overlay=0:0[a]; [a][1:cs]overlay=%sw%/2:0[b]; [b][2:cs]overlay=0:%sh%/2[c]; [c][3:cs]overlay=%sw%/2:%sh%/2[d]; [d]drawtext=%label_font_common_cfg%:text=%label1%:x=0:y=0,drawtext=%label_font_common_cfg%:text=%label2%:x=%sw%/2:y=0,drawtext=%label_font_common_cfg%:text=%label3%:x=0:y=%sh%/2,drawtext=%label_font_common_cfg%:text=%label4%:x=%sw%/2:y=%sh%/2[labeled]; [labeled]setpts=25/%speed%*PTS" ^
-f nut -c:v rawvideo - | %ffplay% -left 0 -top 0 -

:: -f nut -c:v libx265 -x265-params "lossless=1" overlay.hevc
:: -f nut -c:v rawvideo overlay.yuv

:: FH stream need additional options, to make color range and play speed suitable
:: like this [2:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2:out_range=full,setpts=2*PTS[2:cs];