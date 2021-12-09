function [R, G1, G2, B, all_c] = bayerGBRG_extract(gbrg_file_name, width, height)
    fid = fopen(gbrg_file_name);

    R = uint16(zeros(height / 2, width / 2));
    G1 = uint16(zeros(height / 2, width / 2));
    G2 = uint16(zeros(height / 2, width / 2));
    B = uint16(zeros(height / 2, width / 2));

    all_c = uint16(zeros(height, width));

    for i = 1:height
        line_val = fread(fid, width, '*ubit16');
        all_c(i, :) = line_val;
        if (bitand(i, 1))
            G1((i + 1) / 2, :) = line_val(1:2:width);
            B((i + 1) / 2, :) = line_val(2:2:width);
        else
            R(i / 2, :) = line_val(1:2:width);
            G2(i / 2, :) = line_val(2:2:width);
        end
    end

    fclose(fid);
end
