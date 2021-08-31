function blk_size_mat = gen_blk_intra_mode_mat(blk_info_file_str)
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

        pu_loc_cell = regexp(tline, '(?<=^pu rect;)(\d+,){3}', 'match');
        if ~isempty(pu_loc_cell)
            pu_loc = str2double((strsplit(pu_loc_cell{1}, ',')));
            pu_x = pu_loc(1);
            pu_y = pu_loc(2);
            pu_size = pu_loc(3);
        end

        pu_mode_cell = regexp(tline, '(?<=^pu type luma/chroma;)\d+', 'match');
        if ~isempty(pu_mode_cell)
            pu_mode = str2double(pu_mode_cell{1});
            blk_size_mat(ctu_location_y + pu_y + 1:ctu_location_y + pu_y + pu_size, ctu_location_x + pu_x + 1:ctu_location_x + pu_x + pu_size) = pu_mode;
        end
    end

    fclose(fid);
end
