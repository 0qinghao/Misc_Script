@echo off
setlocal EnableDelayedExpansion

@REM stream folder, stream suffix, label
set f1=D:\run_enc\fudan_4k_yuv_test\v0328
set f2=D:\run_enc\fudan_4k_yuv_test\MC_no_aggressive
set f3=D:\run_enc\fudan_4k_yuv_test\FH
set f4=D:\run_enc\fudan_4k_yuv_test\fudan_xkcdc0510\dump

set suffix1=test_enc.h265
set suffix2=_cbr_6M.h265
set suffix3=_blk_cbr_6M_FH.h265
set suffix4=xkcdc_ffmpeg_level2.1_to_6.0.h265

@REM get seq name, cat string
set seq=%1
set stm1="%f1%\%suffix1%"
set stm2="%f2%\%seq%%suffix2%"
set stm3="%f3%\%seq%%suffix3%"
::set stm3="%f3%\%seq%\%suffix3%"
set stm4="%f4%\%suffix4%"

@REM set label1=
@REM set label2=
@REM set label3=
@REM set label4=
set label1=MC_0328
set label2=MC_NO_SAO_AGGRESSIVE
set label3=FH_PTv2
set label4=FUDAN_0510

@REM FH(PTv2) stream contain VUI info, which assign frame rate (vui_timing_info_present_flag==1), need additional options to make color range and play speed suitable
@REM ,setpts=2*PTS
set special_cfg1=
set special_cfg2=
set special_cfg3=,setpts=2*PTS
set special_cfg4=

@REM @REM if no PTv3 stream
@REM if not exist %stm2% (
@REM set stm2=%stm1%
@REM set label2=%label1%
@REM set special_cfg2=%special_cfg1%
@REM )

@REM set play speed (=25 normal; <25 slow; >25 fast(limited by hardware))
set speed=25

@REM ffmpeg / ffplay path
set ffmpeg="D:\Program Files (x86)\ffmpeg\bin\ffmpeg.exe"
set ffplay="D:\Program Files (x86)\ffmpeg\bin\ffplay.exe"

@REM set screen size
set /a sw=3840*1
set /a sh=2160*1
@REM if %sw%*9/16 neq %sh% (
@REM     set /a sh=%sw%*9/16
@REM )

@REM 某些版本的 ffmpeg 在不指定字体的情况下会直接 error (大部分版本不指定字体会默认使用 times)
@REM label theme
set label_font_common_cfg=fontfile=simhei.ttf:fontsize=%sw%/50:fontcolor=red

@REM -f avi: select a container which support rawvideo, avi/nut/matroska...
@REM -left 9999 -fs: make sure display in the second screen (the right one)
%ffmpeg% ^
-i %stm1% -i %stm2% -i %stm3% -i %stm4% ^
-filter_complex "nullsrc=size=%sw%x%sh%:rate=25[base]; [0:v]scale=%sw%/2:%sh%/2:out_range=full%special_cfg1%[0:tmp]; [1:v]scale=%sw%/2:%sh%/2:out_range=full%special_cfg2%[1:tmp]; [2:v]scale=%sw%/2:%sh%/2:out_range=full%special_cfg3%[2:tmp]; [3:v]scale=%sw%/2:%sh%/2:out_range=full%special_cfg4%[3:tmp]; [base][0:tmp]overlay=0:0[a]; [a][1:tmp]overlay=%sw%/2:0[b]; [b][2:tmp]overlay=0:%sh%/2[c]; [c][3:tmp]overlay=%sw%/2:%sh%/2[d]; [d]setpts=25/%speed%*PTS" ^
-f avi -c:v rawvideo -pix_fmt yuv420p - | %ffplay% ^
-vf "drawtext=%label_font_common_cfg%:text=%%{frame_num}:x=(w-tw)/2:y=h-lh,drawtext=%label_font_common_cfg%:text=%label1%:x=0:y=0,drawtext=%label_font_common_cfg%:text=%label2%:x=%sw%/2:y=0,drawtext=%label_font_common_cfg%:text=%label3%:x=0:y=%sh%/2,drawtext=%label_font_common_cfg%:text=%label4%:x=%sw%/2:y=%sh%/2" ^
-noframedrop -left 9999 -fs -

@REM -vf "hflip,vflip"

@REM -f avi -c:v libx265 -pix_fmt yuv420p -x265-params "lossless=1" overlay_lossless.hevc -y
@REM -f avi -c:v rawvideo -pix_fmt yuv420p overlay_raw.avi -y