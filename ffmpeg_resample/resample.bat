ffmpeg -video_size 352x288 -pix_fmt yuv420p -i .\bus_cif_352x288.yuv -vf "select='not(mod(n\,100))',setpts=N/FRAME_RATE/TB" -pix_fmt yuv420p -frames:v 1000 output.yuv