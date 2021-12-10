vid = 'D:\FH420_300f\hk_floor_12M_1920x1088.yuv';
Tex_th = 28;

[y, u, v] = yuvRead(vid, 1920, 1088, 1);

y_f = filter_by_pix(y, 999);
u_f = filter_by_pix(u, 6);
v_f = filter_by_pix(v, 6);

% y_texture_map = get_texture_map(y, Tex_th);
% u_texture_map = get_texture_map(u, Tex_th);
% v_texture_map = get_texture_map(v, Tex_th);
% y_f = filter_with_texture_map(y, y_texture_map);
% u_f = filter_with_texture_map(u, u_texture_map);
% v_f = filter_with_texture_map(v, v_texture_map);

fid = fopen('filtered.yuv', 'w');
fwrite(fid, y_f');
fwrite(fid, u_f');
fwrite(fid, v_f');
fclose(fid);
