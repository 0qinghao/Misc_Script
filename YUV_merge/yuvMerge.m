% function YUV_merged = yuvMerge(yuv_src_y, yuv_src_uv)
[src_y, src_u, src_v] = yuvRead("Z:\derek.you\2019-07-30-FullhanSrc\420\5_outdoor_day_rain_cross_1920x1088.yuv", 1920, 1088, 1);
[MOL_y, MOL_u, MOL_v] = yuvRead("Z:\rin.lin\MOL_INTER_BS\5_outdoor_day_rain_cross_1920x1088_qp37.yuv", 1920, 1088, 1);
[HM_y, HM_u, HM_v] = yuvRead("Z:\rin.lin\HM_MOLcfg_INTER_BS\5_outdoor_day_rain_cross_1920x1088_qp37.yuv", 1920, 1088, 1);

fid = fopen('YUV_merged_MOLy_srcuv.yuv', 'a');
fwrite(fid, MOL_y');
fwrite(fid, src_u');
fwrite(fid, src_v');
fclose(fid);

fid = fopen('YUV_merged_srcy_MOLuv.yuv', 'a');
fwrite(fid, src_y');
fwrite(fid, MOL_u');
fwrite(fid, MOL_v');
fclose(fid);
% end
