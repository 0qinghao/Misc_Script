@echo off
setlocal EnableDelayedExpansion

pushd "%~dp0"

@REM @FOR /F %%G in ('dir *1280x720*.yuv /b') DO (
@REM     @REM ffmpeg.exe -y -s:v 1280x720 -i %%G -vf scale=1280x736 -c:v rawvideo -pix_fmt yuv420p -vframes 100000 %%~nG_10frames.yuv
@REM     set yuv_file=%%G
@REM     set filename=!yuv_file:~9,-5!
@REM     echo !filename!
@REM )

set yuv_f[0]="..\\..\\yuv\\x32\\1280x736_parkrun_ter_10frames.yuv"
set suffix[0]="blk_rot90"

set yuv_file=!yuv_f[0]!
set filename=!yuv_file:~19,-5!_!suffix[0]!

echo !filename!

popd
PAUSE

@REM cls