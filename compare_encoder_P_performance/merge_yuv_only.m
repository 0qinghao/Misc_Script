srcyuv = "T:\Derek.You\YUV_Sequence\ClassB\1088\BasketballDrive_1920x1088_50.yuv";
h265file = "D:\Run_Enc_Script\Result_2022_10_18_1933 master 22.8.29\BasketballDrive_1920x1088_50\BasketballDrive_1920x1088_50_qp37.h265";
merge_file_name = "BasketballDrive_1920x1088_50_1stMXqp37_2toendsrc.yuv";

wh_cell = regexp(srcyuv, '\d+x\d+', 'match');
wh = str2double((strsplit(wh_cell{1}, 'x')));
w = wh(1);
h = wh(2);

% 解码第一帧
cmd_str = strcat("ffmpeg ", " -i """, h265file, """ -vframes 1 ", " h265_dec_1st_frame.yuv -y");
cmd_str
[~,cmdout] = system(cmd_str);

% 拼接 dec I frame / src other frame
replace_1st_f("h265_dec_1st_frame.yuv",srcyuv,w,h,merge_file_name);

delete h265_dec_1st_frame.yuv
