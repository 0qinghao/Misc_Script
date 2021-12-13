function out = filter_by_pix(in, TH)
    in = double(in);
    out = in;
    [h, w] = size(in);

    G_mat_1 = [0, 0, 0; 1, -2, 1; 0, 0, 0];
    G_mat_2 = [0, 1, 0; 0, -2, 0; 0, 1, 0];
    G_mat_3 = [1, 0, 0; 0, -2, 0; 0, 0, 1];
    G_mat_4 = [0, 0, 1; 0, -2, 0; 1, 0, 0];

    % Lap_mat = [
    %         0, 1, 0;
    %         1, -4, 1;
    %         0, 1, 0;
    %         ];

    for j = 2:h - 1
        for k = 2:w - 1
            src_sub = in(j - 1:j + 1, k - 1:k + 1);

            G1 = abs(sum(src_sub .* G_mat_1, [1, 2]));
            G2 = abs(sum(src_sub .* G_mat_2, [1, 2]));
            G3 = abs(sum(src_sub .* G_mat_3, [1, 2]));
            G4 = abs(sum(src_sub .* G_mat_4, [1, 2]));

            isNoise = min([G1, G2, G3, G4]) > TH;

            if (isNoise)
                out(j, k) = round((sum(src_sub, [1, 2]) - in(j, k))/8);
            else
                ;
            end
        end
    end

    out = uint8(out);
end
