function out = filter_by_pix(in, TH)
    in = double(in);
    out = in;
    [h, w] = size(in);

    Lap_mat = [
            0, 1, 0;
            1, -4, 1;
            0, 1, 0;
            ];

    for j = 2:h - 1
        for k = 2:w - 1
            src_sub = in(j - 1:j + 1, k - 1:k + 1);
            tex_level = sum(sum(src_sub .* Lap_mat));

            if (abs(tex_level) > TH)
                out(j, k) = in(j, k) - tex_level;
            else
                ;
            end
        end
    end

    out = uint8(out);
end
