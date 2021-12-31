function filtered = filter_with_texture_map(in, map)
    se = strel('square', 3);
    in = double(in);
    filtered = in;

    for i = 2:size(in, 1) - 1
        for j = 2:size(in, 2) - 1
            src_sub = in(i - 1:i + 1, j - 1:j + 1);

            if (map(i, j) == 0)
                filtered(i, j) = round(mean(src_sub, [1, 2]));

                % filtered_sub = imopen(src_sub, se);
                % filtered(i, j) = filtered_sub(2, 2);
                % else
                %     filtered_sub = med_smooth(src_sub);
                %     filtered(i:i + 3, j:j + 3) = filtered_sub(end - 3:end, end - 3:end);
            end
        end
    end

    % for i = 1:8:size(in, 1) - 8
    %     for j = 1:8:size(in, 2) - 8
    %         if (map(i, j) == 0)
    %             filtered(i:i + 7, j:j + 7) = mean(mean(in(i:i + 7, j:j + 7)));
    %         end
    %     end
    % end

    filtered = uint8(filtered);
end
