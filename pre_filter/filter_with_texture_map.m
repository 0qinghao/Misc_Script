function filtered = filter_with_texture_map(in, map)
    filtered_map = map;
    in = double(in);
    filtered = in;

    for i = 1:4:size(in, 1) - 4
        for j = 1:4:size(in, 2) - 4
            if (filtered_map(i, j) == 0)
                ii = i;
                jj = j;
                while (all(all(filtered_map(i:ii + 4, j:jj + 4) == 0)))
                    ii = ii + 4;
                    jj = jj + 4;
                    if (ii > size(in, 1) - 4 || jj > size(in, 2) - 4)
                        break;
                    end
                end

                if (i ~= ii)
                    filtered_map(i:ii + 3, j:jj + 3) = 1;
                    filtered(i:ii + 3, j:jj + 3) = mean(mean(in(i:ii + 3, j:jj + 3)));
                end
            end
        end
    end

    filtered = uint8(filtered);
end
