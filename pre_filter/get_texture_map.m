% Th 越小越容易归类为纹理块
function texture_map = get_texture_map(in, Th_pow)
    in = double(in);
    % Pre-allocate the filtered_image matrix with zeros
    texture_map = zeros(size(in));
    gx_image = zeros(size(in));
    gy_image = zeros(size(in));

    % Sobel Operator Mask
    Mx = [-1 0 1; -2 0 2; -1 0 1];
    My = [-1 -2 -1; 0 0 0; 1 2 1];

    % Edge Detection Process
    % When i = 1 and j = 1, then filtered_image pixel
    % position will be filtered_image(2, 2)
    % The mask is of 3x3, so we need to traverse
    % to filtered_image(size(input_image, 1) - 2
    %, size(input_image, 2) - 2)
    % Thus we are not considering the borders.
    for i = 1:size(in, 1) - 2
        for j = 1:size(in, 2) - 2

            % Gradient approximations
            Gx = sum(sum(Mx .* in(i:i + 2, j:j + 2)));
            Gy = sum(sum(My .* in(i:i + 2, j:j + 2)));

            % Calculate magnitude of vector
            gx_image(i + 1, j + 1) = abs(Gx);
            gy_image(i + 1, j + 1) = abs(Gy);
        end
    end

    % imshow(uint8(gy_image))
    Th = 2^Th_pow;
    for i = 1:4:size(in, 1)
        for j = 1:4:size(in, 2)
            J11 = sum(sum(gx_image(i:i + 3, j:j + 3).^2));
            J22 = sum(sum(gy_image(i:i + 3, j:j + 3).^2));
            J12 = sum(sum(gx_image(i:i + 3, j:j + 3) .* gy_image(i:i + 3, j:j + 3)));
            J21 = J12;
            MA = J11 + J22 + (J11 - J22)^2 + 4 * J12 * J21;

            texture_map(i:i + 3, j:j + 3) = (MA >= Th);
        end
    end

    texture_map = uint8(texture_map * 128);
end
