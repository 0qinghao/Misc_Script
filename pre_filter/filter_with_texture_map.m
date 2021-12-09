function filtered = filter_with_texture_map(in, map)
    se = strel('square', 2);

    in = double(in);
    filtered = in;

    for i = 1:4:size(in, 1) - 4
        for j = 1:4:size(in, 2) - 4
            if (map(i, j) == 0)
                if (i == size(in, 1) - 4 || j == size(in, 2) - 4)
                    src_sub = in(i:i + 3, j:j + 3);
                else
                    src_sub = in(i:i + 4, j:j + 4);
                end

                filtered_sub = imopen(src_sub, se);
                filtered(i:i + 3, j:j + 3) = filtered_sub(1:4, 1:4);
            end
        end
    end

    filtered = uint8(filtered);
end
