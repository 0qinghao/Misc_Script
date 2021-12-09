function filtered = filter_with_texture_map(in, map)
    se = strel('square', 2);

    in = double(in);
    filtered = in;

    for i = 1:4:size(in, 1) - 4
        for j = 1:4:size(in, 2) - 4

            if (i == 1 || j == 1)
                src_sub = in(i:i + 3, j:j + 3);
            else
                src_sub = in(i - 1:i + 3, j - 1:j + 3);
            end

            if (map(i, j) == 0)
                filtered_sub = imopen(src_sub, se);
                filtered(i:i + 3, j:j + 3) = filtered_sub(end - 3:end, end - 3:end);
            else
                filtered_sub = med_smooth(src_sub);
                filtered(i:i + 3, j:j + 3) = filtered_sub(end - 3:end, end - 3:end);
            end
        end
    end

    filtered = uint8(filtered);
end
