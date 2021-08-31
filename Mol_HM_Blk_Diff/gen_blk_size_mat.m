function blk_size_mat = gen_blk_size_mat(blk_info_file_str)
    % 注：Elecard HEVC Analyzer 导出的 blk_info 文件的编码是 utf16，matlab/octave 并不支持，需要手动转 utf8
    fid = fopen(blk_info_file_str, "r");

    blk_size_mat = zeros(1088, 1920);
    while ~feof(fid)
        tline = fgetl(fid);
        ctu_location_cell = regexp(tline, '(?<=^ctu location;)\d+x\d+', 'match');
        if ~isempty(ctu_location_cell)
            ctu_location = str2double((strsplit(ctu_location_cell{1}, 'x')));
            ctu_location_x = ctu_location(1);
            ctu_location_y = ctu_location(2);
            continue;
        end

        tu_info_cell = regexp(tline, '(?<=^tu rect/qp;)(\d+,){3}', 'match');
        if ~isempty(tu_info_cell)
            tu_info = str2double((strsplit(tu_info_cell{1}, ',')));
            tu_x = tu_info(1);
            tu_y = tu_info(2);
            tu_size = tu_info(3);

            blk_size_mat(ctu_location_y + tu_y + 1:ctu_location_y + tu_y + tu_size, ctu_location_x + tu_x + 1:ctu_location_x + tu_x + tu_size) = tu_size;
        end
    end

    fclose(fid);
end
