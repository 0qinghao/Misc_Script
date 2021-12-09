[R, G1, G2, B, all_c] = bayerRGGB_extract('1_board_rggb_1920x1080_12b.raw', 1920, 1080);

I_demosaic = demosaic(bitshift(all_c,4), 'rggb');

Ycbcr_demosaic = rgb2ycbcr(I_demosaic);

Y_demosaic = Ycbcr_demosaic(:,:,1);

Y_demosaic_12bit = bitshift(Y_demosaic+8,-4);

[h,w] = size(Y_demosaic_12bit);
Y_demosaic_12bit = double(Y_demosaic_12bit);
diff_Y = 0;
for i=1:h-1
    diff_Y = diff_Y + sum(abs(Y_demosaic_12bit(i+1,:) - Y_demosaic_12bit(i,:)));
end

[h,w] = size(G1);
G1_12bit = double(G1);
G2_12bit = double(G2);
R_12bit = double(R);
B_12bit = double(B);
diff_G = 0;
for i=1:h-1
    diff_G = diff_G + sum(abs(G1_12bit(i+1,:) - G1_12bit(i,:)));
    diff_G = diff_G + sum(abs(G2_12bit(i+1,:) - G2_12bit(i,:)));
end