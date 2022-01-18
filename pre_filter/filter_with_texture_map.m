function filtered = filter_with_texture_map(in, map)
    % se = strel('square', 3);
    set_same_TH = 20;
    in = double(in);
    filtered = in;

    upside_CTU_is_smooth = zeros(1, size(in, 2) / 32) + 1;
    upside_CTU_mean_val = zeros(1, size(in, 2) / 32);
    leftside_CTU_is_smooth = 1;
    leftside_CTU_mean_val = 0;
    neighbor_CTU_mean_val = 0;

    for i = 1:32:size(in, 1)
        for j = 1:32:size(in, 2)
            src_sub = in(i:i + 31, j:j + 31);

            if (map(i, j) == 0 && upside_CTU_is_smooth((j + 31) / 32) && leftside_CTU_is_smooth && (abs(round(mean(src_sub, [1, 2])) - neighbor_CTU_mean_val) <= set_same_TH))
                % if (abs(round(mean(src_sub, [1, 2])) - leftside_CTU_mean_val) <= set_same_TH)
                filtered(i:i + 31, j:j + 31) = neighbor_CTU_mean_val;
                upside_CTU_mean_val((j + 31) / 32) = neighbor_CTU_mean_val;
                leftside_CTU_mean_val = neighbor_CTU_mean_val;
                % end
            else
                leftside_CTU_mean_val = round(mean(src_sub, [1, 2]));
                neighbor_CTU_mean_val = round((leftside_CTU_mean_val + upside_CTU_mean_val((j + 31) / 32)) / 2);
                upside_CTU_mean_val((j + 31) / 32) = round(mean(src_sub, [1, 2]));
            end

            upside_CTU_is_smooth((j + 31) / 32) = (map(i, j) == 0);
            leftside_CTU_is_smooth = (map(i, j) == 0);
        end
    end

    filtered = uint8(filtered);
end
