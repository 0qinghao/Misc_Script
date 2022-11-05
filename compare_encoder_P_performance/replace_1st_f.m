% cat yuv1 1st frame and yuv2 2~50 frame

function replace_1st_f(yuv1, yuv2, w, h, merge_file_name)
    [bs_1st_YUV] = yuvRead_3ch(yuv1,w,h,1);
    [src_1_50_YUV] = yuvRead_3ch(yuv2,w,h,50);
    yuv_bsdec1_src49 = [bs_1st_YUV;src_1_50_YUV(w*h*1.5+1:end)];
    fid = fopen(merge_file_name,'w');
    fwrite(fid,yuv_bsdec1_src49);
    fclose(fid);
end