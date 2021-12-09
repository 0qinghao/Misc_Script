function out = med_smooth(in)
    in = double(in);
    out = in;
    [h, w] = size(in);

    for i = 2:h
        for j = 2:w
            if (in(i, j) < min(in(i - 1, j), in(i, j - 1)))
                out(i, j) = (max(in(i - 1, j), in(i, j - 1)) + in(i, j)) / 2;
            elseif (in(i, j) > max(in(i - 1, j), in(i, j - 1)))
                out(i, j) = (min(in(i - 1, j), in(i, j - 1)) + in(i, j)) / 2;
            else
                out(i, j) = (in(i - 1, j) + in(i, j - 1) - in(i - 1, j - 1) + in(i, j)) / 2;
            end
        end
    end

    out = uint8(out);
end
