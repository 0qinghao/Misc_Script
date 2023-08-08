@echo off
setlocal EnableDelayedExpansion

:: 编码配置 ::
set encoder=264
:: input_yuv should be yuv420p format
set input_yuv=out_1920x1088
set width=1920
set height=1088
set enc_frames=4051

:: 默认配置 ::
set gop=50
set qp=22

:: enc ::
cd %~dp0\encoder\%encoder%\exe
%~dp0\encoder\%encoder%\exe\%encoder%_encoder.exe -i %~dp0\src_yuv\%input_yuv%.yuv -rc 0 -w %width% -h %height% -f %enc_frames% -gop %gop% -qp %qp%
move %~dp0\encoder\%encoder%\exe\test_enc.h%encoder% %~dp0\bitstream\%input_yuv%.h%encoder%

pause