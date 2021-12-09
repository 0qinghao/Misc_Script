% 1Bayer图像的准无损压缩方法_李晓雯.pdf

[R, G1, G2, B] = bayerRGGB_extract('3_IT8_rggb_1920x1080_12b.raw', 1920, 1080);
[h, w] = size(G1);
G12 = zeros(h * 2, w);
G12(1:2:end, :) = G1;
G12(2:2:end, :) = G2;
G12_16bit = uint16(G12) * 16;
imwrite(G12_16bit, 'G12.png', 'png', 'bitdepth', 16);

H_G12 = [1, 0, 1; 0, 2, 0; 0, 0, 0] / 4;
G12_F = round(imfilter(double(G12), H_G12));
H_RB = [1, 1, 1; 0, 1, 0; 0, 0, 0] / 4;
R_F = round(imfilter(double(R), H_RB));
B_F = round(imfilter(double(B), H_RB));
G12_F_16bit = uint16(G12_F) * 16;
imwrite(G12_F_16bit, 'G12_F.png', 'png', 'bitdepth', 16);

H_rec_G1 = [-1, -1, 0; 0, 4, 0; 0, 0, 0] / 2;
temp = round(imfilter(G12_F, H_rec_G1));
G1_rec = temp(1:2:end, :);
H_rec_G2 = [0, -1, -1; 0, 4, 0; 0, 0, 0] / 2;
temp = round(imfilter(G12_F, H_rec_G2));
G2_rec = temp(1:2:end, :);
H_rec_RB = [-1, -1, -1; 0, 4, 0; 0, 0, 0];
R_rec = round(imfilter(R_F, H_rec_RB));
B_rec = round(imfilter(B_F, H_rec_RB));
G12_rec = zeros(h * 2, w);
G12_rec(1:2:end, :) = G1_rec;
G12_rec(2:2:end, :) = G2_rec;
G12_rec_16bit = uint16(G12_rec) * 16;
imwrite(G12_rec_16bit, 'G12_rec.png', 'png', 'bitdepth', 16);

RG1B_12bit = uint16(R_rec);
RG1B_12bit(:, :, 2) = uint16(G1_rec);
RG1B_12bit(:, :, 3) = uint16(B_rec);
RG1B_16bit = bitshift(RG1B_12bit, 4);
imwrite(RG1B_16bit, 'RG1B_f1.png', 'png', 'bitdepth', 16);

RG2B_12bit = uint16(R_rec);
RG2B_12bit(:, :, 2) = uint16(G2_rec);
RG2B_12bit(:, :, 3) = uint16(B_rec);
RG2B_16bit = bitshift(RG2B_12bit, 4);
imwrite(RG2B_16bit, 'RG2B_f1.png', 'png', 'bitdepth', 16);

psnr(uint8(G12_rec / 16), uint8(G12 / 16))
