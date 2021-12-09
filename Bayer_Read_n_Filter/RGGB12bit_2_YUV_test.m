RG1B_12bit = R;
RG1B_12bit(:, :, 2) = G1;
RG1B_12bit(:, :, 3) = B;
RG1B_16bit = bitshift(RG1B_12bit, 4);
imwrite(RG1B_16bit, 'RG1B.ppm');

RG2B_12bit = R;
RG2B_12bit(:, :, 2) = G2;
RG2B_12bit(:, :, 3) = B;
RG2B_16bit = bitshift(RG2B_12bit, 4);
imwrite(RG2B_16bit, 'RG2B.ppm');
