function filtered = filter_with_texture_map(in, map)
    in = double(in);
    filtered = in;

    [conn_map, conn_num] = bwlabel(~map, 8);

    for n = 1:conn_num
        ind = conn_map == n;
        if (sum(ind, [1, 2]) >= 16 * 4)
            val = mean(in(ind));
            filtered(ind) = val;
        end
    end

    filtered = uint8(filtered);
end
