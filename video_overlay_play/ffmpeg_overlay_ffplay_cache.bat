@echo off
setlocal EnableDelayedExpansion

rem stream folder, stream suffix, label
set f1=D:\FH_PT\PTv2_FH_H265_2M
set f2=D:\FH_PT\PTv3
set f3=D:\board_demo_stream\2022_12_12_cbr2M
set f4=D:\run_enc_script\Result_2023_02_07_0119_w_exmvsi64896_8-20

set suffix1=_blk_cbr_2M_FH.h265
set suffix2=.265
set suffix3=1228.h265
set suffix4=_cbr_2M.h265

rem get seq name, cat string
set seq=%1
set stm1="%f1%/%seq%/%seq%%suffix1%"
set stm2="%f2%/%seq%/%seq%%suffix2%"
::set stm3="%f3%/%seq%/%seq%%suffix3%"
set stm3="%f3%/%seq%/%suffix3%"
set stm4="%f4%/%seq%/%seq%%suffix4%"

set label1=
set label2=
set label3=
set label4=
rem set label1=PTv2
rem set label2=PTv3
rem set label3=MC_1228
rem set label4=MC_new_SAOw8-20

rem FH(PTv2) stream need additional options, to make color range and play speed suitable
rem setpts=2*PTS
set special_cfg1=,setpts=2*PTS
set special_cfg2=
set special_cfg3=
set special_cfg4=

rem if no PTv3 stream
if not exist %stm2% (
set stm2=%stm1%
set label2=%label1%
set special_cfg2=%special_cfg1%
)

rem set play speed (=25 normal; <25 slow; >25 fast(limited by hardware))
set speed=25

rem ffmpeg / ffplay path
set ffmpeg="D:\Program Files (x86)\ffmpeg\bin\ffmpeg.exe"
set ffplay="D:\Program Files (x86)\ffmpeg\bin\ffplay.exe"

rem set screen size
set /a sw=1920*2
set /a sh=1080*2
rem if %sw%*9/16 neq %sh% (
rem     set /a sh=%sw%*9/16
rem )

rem 某些版本的 ffmpeg 在不指定字体的情况下会直接 error (大部分版本不指定字体会默认使用 times)
rem label theme
set label_font_common_cfg=fontfile=simhei.ttf:fontsize=%sw%/50:fontcolor=red

rem -f avi: select a container which support rawvideo, avi/nut/matroska...
rem -left 9999 -fs: make sure display in the second screen (the right one)
%ffmpeg% ^
-i %stm1% -i %stm2% -i %stm3% -i %stm4% ^
-filter_complex "nullsrc=size=%sw%x%sh%:rate=25[base]; [0:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2:out_range=full%special_cfg1%[0:tmp]; [1:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2:out_range=full%special_cfg2%[1:tmp]; [2:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2:out_range=full%special_cfg3%[2:tmp]; [3:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2:out_range=full%special_cfg4%[3:tmp]; [base][0:tmp]overlay=0:0[a]; [a][1:tmp]overlay=%sw%/2:0[b]; [b][2:tmp]overlay=0:%sh%/2[c]; [c][3:tmp]overlay=%sw%/2:%sh%/2[d]; [d]setpts=25/%speed%*PTS" ^
-f avi -c:v rawvideo -pix_fmt yuv420p - | %ffplay% ^
-vf "drawtext=%label_font_common_cfg%:text=%%{frame_num}:x=(w-tw)/2:y=h-lh,drawtext=%label_font_common_cfg%:text=%label1%:x=0:y=0,drawtext=%label_font_common_cfg%:text=%label2%:x=%sw%/2:y=0,drawtext=%label_font_common_cfg%:text=%label3%:x=0:y=%sh%/2,drawtext=%label_font_common_cfg%:text=%label4%:x=%sw%/2:y=%sh%/2" ^
-noframedrop -left 9999 -fs -

rem -vf "hflip,vflip"

rem -f avi -c:v libx265 -pix_fmt yuv420p -x265-params "lossless=1" overlay_lossless.hevc -y
rem -f avi -c:v rawvideo -pix_fmt yuv420p overlay_raw.avi -y