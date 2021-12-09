vid = 'D:\FH420_300f\hk_floor_12M_1920x1088.yuv';

[y, u, v] = yuvRead(vid, 1920, 1088, 1);
[y_rec, u_rec, v_rec] = yuvRead('smooth_rec.yuv', 1920, 1088, 1);
[ysrc_rec, usrc_rec, vsrc_rec] = yuvRead('src_rec.yuv', 1920, 1088, 1);

psnr(y,y_rec)
psnr(y,ysrc_rec)