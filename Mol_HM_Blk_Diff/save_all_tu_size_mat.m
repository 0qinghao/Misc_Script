% ´æ´¢·Ö¿éÇé¿ö
HM_blk_info_dir_str = "\\pub\staff\rin.lin\HM_MOLcfg_INTRA_BS\";
% MOL_blk_info_dir_str = "\\\\pub\\staff\\rin.lin\\MOL_INTRA_BS\\";
HM_blk_info_file = dir(strcat(HM_blk_info_dir_str, '*_block_info_*.csv'));
% MOL_blk_info_file = dir([MOL_blk_info_dir_str, '*_block_info_*.csv']);

% file_cnt = min(length(HM_blk_info_file), length(MOL_blk_info_file));
file_cnt = (length(HM_blk_info_file));
HM_blk_size_mat = zeros(1088, 1920, file_cnt);
% MOL_blk_size_mat = zeros(1088, 1920, file_cnt);

% for i = 1:4
parfor i = 1:file_cnt
    HM_file_str = strcat(HM_blk_info_file(i).folder, '\', HM_blk_info_file(i).name);
    % MOL_file_str = strcat(MOL_blk_info_file(i).folder, '\', MOL_blk_info_file(i).name);

    disp(HM_file_str)
    HM_blk_size_mat(:, :, i) = gen_blk_size_mat(HM_file_str);
    % disp(MOL_file_str)
    % MOL_blk_size_mat(:, :, i) = gen_blk_size_mat(MOL_file_str);
end

% save -binary blk_size_mat.dat * _blk_size_mat
save('blk_size_mat_HM_all.dat', 'HM_blk_size_mat')
