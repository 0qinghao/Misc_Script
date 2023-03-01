% function YUV_merged = yuvMerge(yuv_src_y, yuv_src_uv)
[src_y, src_u, src_v] = yuvRead("S:\derek.you\2019-07-30-FullhanSrc\420\indoor_54db_wdroff_NR45_8fps_8M_1920x1088.yuv", 1920, 1088, 1);

fid = fopen('NR45_repeat_1st_frame.yuv', 'a');
for i=1:20
    fwrite(fid, src_y');
    fwrite(fid, src_u');
    fwrite(fid, src_v');
end

fclose(fid);
% end
