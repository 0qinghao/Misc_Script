vid = 'D:\FH420_300f\hk_floor_12M_1920x1088.yuv';
vid = 'D:\FH420_300f\12_indoor_day_OnePeopleSitting_1920x1088.yuv';
TH = 10;

[y, u, v] = yuvRead(vid, 1920, 1088, 1);

% y_f = filter_by_pix(y, TH);
% u_f = filter_by_pix(u, TH / 2);
% v_f = filter_by_pix(v, TH / 2);

y_texture_map = get_texture_map(y, TH);
u_texture_map = get_texture_map(u, TH - 2);
v_texture_map = get_texture_map(v, TH - 2);
y_f = filter_with_texture_map(y, y_texture_map);
u_f = filter_with_texture_map(u, u_texture_map);
v_f = filter_with_texture_map(v, v_texture_map);

fid = fopen('filtered.yuv', 'w');
fwrite(fid, y_f');
fwrite(fid, u_f');
fwrite(fid, v_f');
fclose(fid);
