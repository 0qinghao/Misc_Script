function G = sobel(img)
    img = double(img);
    Bx = [-1, 0, 1; -2, 0, 2; -1, 0, 1]; % Sobel Gx kernel
    By = Bx'; % gradient Gy
    Yx = filter2(Bx, img); % convolve in 2d
    Yy = filter2(By, img);

    G = sqrt(Yy.^2 + Yx.^2);
end
