% cat yuv1 1st frame and yuv2 2~50 frame

function replace_1st_f(yuv1, yuv2)
    file_name_cell = regexp(yuv1, '.*qp\d+(?=.*\.yuv)', 'match');
    file_name = file_name_cell{1};

    wh_cell = regexp(yuv1, '\d+x\d+', 'match');
    wh = str2double((strsplit(wh_cell{1}, 'x')));
    w = wh(1);
    h = wh(2);

    % [FH_1st_YUV] = yuvRead_3ch(yuv1, w, h, 1);
    [fudan_1st_YUV] = yuvRead_3ch(yuv1, w, h, 1);
    [src_1_50_YUV] = yuvRead_3ch(yuv2, w, h, 50);
    % yuv_FHdec1_src49 = [FH_1st_YUV; src_1_50_YUV(w * h * 1.5 + 1:end)];
    yuv_fudandec1_src49 = [fudan_1st_YUV; src_1_50_YUV(w * h * 1.5 + 1:end)];
    % fid = fopen(strcat(file_name,"_FHdec1src2toend.yuv"),'w');
    fid = fopen(strcat(file_name, "_fudandec1src2toend.yuv"), 'w');
    % fwrite(fid, yuv_FHdec1_src49);
    fwrite(fid, yuv_fudandec1_src49);
    fclose(fid);
end
