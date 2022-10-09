function cu_size = parse_elecard_cu_size(blk_info_file_str,outf)
    % 注：Elecard HEVC Analyzer 导出的 blk_info 文件的编码是 utf16，matlab/octave 并不支持，需要手动转 utf8
    fid = fopen(blk_info_file_str, "r");
    i = 1;

    while ~feof(fid)
        tline = fgetl(fid);
        
        cu_info_cell = regexp(tline, '(?<=^cu rect;)(\d+,){3}', 'match');
        if ~isempty(cu_info_cell)
            cu_info = str2double((strsplit(cu_info_cell{1}, ',')));
            cu_x = cu_info(1);
            cu_y = cu_info(2);
            cu_width = cu_info(3);
        end
        
        cu_size_cell = regexp(tline, '(?<=^cu size total/pred/trans;)[\d/]+', 'match');
        if ~isempty(cu_size_cell)
            size_info = str2double((strsplit(cu_size_cell{1}, '/')));
            size_total = size_info(1);
            size_pred = size_info(2);
            size_trans = size_info(3);
            
            % x, y, width, pred, trans, total
            cu_size(i,1) = cu_x;
            cu_size(i,2) = cu_y;
            cu_size(i,3) = cu_width;
            cu_size(i,4) = size_pred;
            cu_size(i,5) = size_trans;
            cu_size(i,6) = size_total;
            i = i + 1;
        end
    end

    fclose(fid);
    
    csvwrite(outf,cu_size);
end
