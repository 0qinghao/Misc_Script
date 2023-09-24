@echo off
setlocal EnableDelayedExpansion

@REM stream folder, stream suffix, label
@REM 2x2 raster
set f0=D:\board_demo_stream\2023_09_22_XC00_cbr\
set f1=D:\board_demo_stream\2023_09_22_XC00_cbr\
set f2=D:\board_demo_stream\2023_09_22_XC00_cbr\
set f3=D:\board_demo_stream\2023_09_22_XC00_cbr\

set suffix0=PTV3.h265
set suffix1=XC01.h265
set suffix2=FY11.h265
set suffix3=XC01.h265

@REM get seq name, cat string
set seq=%1
set stm0="%f0%/%seq%/%suffix0%"
set stm1="%f1%/%seq%/%suffix1%"
@REM set stm2="%f2%/%seq%/%seq%%suffix2%"
set stm2="%f2%/%seq%/%suffix2%"
set stm3="%f3%/%seq%/%suffix3%"

@REM set label0=
@REM set label1=
@REM set label2=
@REM set label3=
set label0=PTv3
set label1=XC01
set label2=FY11
set label3=XC01

@REM FH(PTv2) stream contain VUI info, which assign frame rate (vui_timing_info_present_flag=1), need additional options to make and play speed suitable
@REM setpts=2*PTS
set special_cfg0=
set special_cfg1=
set special_cfg2=
set special_cfg3=
@REM set special_cfg0=out_range=full
@REM set special_cfg1=out_range=full
@REM set special_cfg2=out_range=full
@REM set special_cfg3=out_range=full

@REM if no PTv3 stream
if not exist %stm0% (
set "stm0=%stm0:PTv3=PTv2%"
set "label0=%label0:PTv3=PTv2%"
set special_cfg0="%special_cfg0%,setpts=2*PTS"
)

@REM set play speed (=25 normal; <25 slow; >25 fast(limited by hardware))
set speed=1

@REM ffmpeg / ffplay path
set ffmpeg="D:\Program Files (x86)\ffmpeg\bin\ffmpeg.exe"
set ffplay="D:\Program Files (x86)\ffmpeg\bin\ffplay.exe"

@REM set screen size
set /a sw=1920*2
set /a sh=1080*2
@REM if %sw%*9/16 neq %sh% (
@REM     set /a sh=%sw%*9/16
@REM )

@REM 某些版本的 ffmpeg 在不指定字体的情况下会直接 error (大部分版本不指定字体会默认使用 times)
@REM label theme
set label_font_common_cfg=fontfile=simhei.ttf:fontsize=%sw%/50:fontcolor=red

@REM -f avi: select a container which support rawvideo, avi/nut/matroska...
@REM -left 9999 -fs: make sure display in the second screen (the right one)
%ffmpeg% ^
-i %stm0% -i %stm1% -i %stm2% -i %stm3% ^
-filter_complex "nullsrc=size=%sw%x%sh%:rate=25[base]; [0:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2:%special_cfg0%[0:tmp]; [1:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2:%special_cfg1%[1:tmp]; [2:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2:%special_cfg2%[2:tmp]; [3:v]crop=1920:1080:0:0,scale=%sw%/2:%sh%/2:%special_cfg3%[3:tmp]; [base][0:tmp]overlay=0:0[a]; [a][1:tmp]overlay=%sw%/2:0[b]; [b][2:tmp]overlay=0:%sh%/2[c]; [c][3:tmp]overlay=%sw%/2:%sh%/2[d]; [d]setpts=25/%speed%*PTS" ^
-f avi -c:v rawvideo -pix_fmt yuv420p - | %ffplay% ^
-vf "drawtext=%label_font_common_cfg%:text=%%{frame_num}:x=(w-tw)/2:y=h-lh,drawtext=%label_font_common_cfg%:text=%label0%:x=0:y=0,drawtext=%label_font_common_cfg%:text=%label1%:x=%sw%/2:y=0,drawtext=%label_font_common_cfg%:text=%label2%:x=0:y=%sh%/2,drawtext=%label_font_common_cfg%:text=%label3%:x=%sw%/2:y=%sh%/2" ^
-noframedrop -left 9999 -fs -

@REM -vf "hflip,vflip"

@REM -f avi -c:v libx265 -pix_fmt yuv420p -x265-params "lossless=1" overlay_lossless.hevc -y
@REM -f avi -c:v rawvideo -pix_fmt yuv420p overlay_raw.avi -y