vid = 'D:\FH420_300f\HL_indoor_44db_265_16M_1920x1088_234frames.yuv';

[y, u, v] = yuvRead(vid, 1920, 1088, 20);
[y_rec1, u_rec1, v_rec1] = yuvRead('2x2dec.yuv', 1920, 1088, 20);
[y_rec2, u_rec2, v_rec2] = yuvRead('3x3dec.yuv', 1920, 1088, 20);
[ysrc_rec, usrc_rec, vsrc_rec] = yuvRead('srcdec.yuv', 1920, 1088, 20);

psnr(y,y_rec1)
psnr(y,y_rec2)
psnr(y,ysrc_rec)