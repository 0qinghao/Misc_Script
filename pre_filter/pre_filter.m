vid = 'D:\FH420_300f\hk_floor_12M_1920x1088.yuv';
TH = 10;

[y, u, v] = yuvRead(vid, 1920, 1088, 1);

h = fspecial('average', [5 5]);
% h = fspecial('disk', 3);
% h = fspecial('gaussian',8,4);
% h = fspecial('motion', 20, 45);

y_f = imfilter(y, h);
u_f = imfilter(u, h);
v_f = imfilter(v, h);
y_f = imfilter(y_f, h);
u_f = imfilter(u_f, h);
v_f = imfilter(v_f, h);

% y_texture_map = get_texture_map(y, TH);
% u_texture_map = get_texture_map(u, TH);
% v_texture_map = get_texture_map(v, TH);
% y_f = filter_with_texture_map(y, y_texture_map);
% u_f = filter_with_texture_map(u, u_texture_map);
% v_f = filter_with_texture_map(v, v_texture_map);

% y_f = imgaussfilt(y, 2);
% u_f = imgaussfilt(u, 2);
% v_f = imgaussfilt(v, 2);

fid = fopen('filtered.yuv', 'w');
fwrite(fid, y_f');
fwrite(fid, u_f');
fwrite(fid, v_f');
fclose(fid);
