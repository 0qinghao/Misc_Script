% 分析重建的参考像素失真分布与预测模式的关系
HM_res_yuv_dir_str = "\\pub\staff\rin.lin\HM_MOLcfg_INTRA_BS\";
% HM_res_yuv_file = dir(strcat(HM_res_yuv_dir_str, '*residual.yuv'));
% FH_yuv_dir_str = "\\pub\staff\derek.you\2019-07-30-FullhanSrc\420\";
% FH_yuv_file = dir(strcat(FH_yuv_dir_str, '*.yuv'));
HM_unf_yuv_file = dir(strcat(HM_res_yuv_dir_str, '*unfiltered.yuv'));
load '../Mol_HM_Blk_Diff/blk_size_mat_HM_all.mat'
load 'blk_intra_mode_mat_HM_all.mat'
load 'yuv_file.mat'
file_cnt = length(HM_res_yuv_file);
y_unf = zeros(1088, 1920, file_cnt);

log_cnt = 0;
for i = 1:1
    % for i = 1:4:file_cnt
    unf_str = strcat(HM_unf_yuv_file(i).folder, '\', HM_unf_yuv_file(i).name);
    src_str = strcat(FH_yuv_file(ceil(i / 4)).folder, '\', FH_yuv_file(ceil(i / 4)).name);
    disp(unf_str);
    disp(src_str);
    y_unf(:, :, i) = yuvRead(unf_str, 1920, 1088, 1);
    y_src(:, :, ceil(i / 4)) = yuvRead(src_str, 1920, 1088, 1);
    t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
    t_HM_blk_intra_mode_mat = HM_blk_intra_mode_mat(:, :, i);
    for y = 1:8:1088
        for x = 1:8:1920
            if (t_HM_blk_size_mat(y, x) == 8)
                log_cnt = log_cnt + 1;
                t_mode = t_HM_blk_intra_mode_mat(y, x);
                distortion = double(y_unf(y:y + 7, x:x + 7)) - double(y_src(y:y + 7, x:x + 7));
                stat_log_8(log_cnt).mode = t_mode;
                stat_log_8(log_cnt).dist = distortion;
            end
        end
    end
end

% stat
sum_dist = zeros(8, 8);
cnt = 0;
for i = 1:log_cnt
    if (stat_log_8(i).mode == 2)
        sum_dist = sum_dist + abs(stat_log_8(i).dist);
        cnt = cnt + 1;
    end
end
avg_dist = sum_dist / cnt;

% % scatter
% subplot(1, 3, 1)
% x_8 = linspace(0, 100, length(stat_log_8)); x_16 = linspace(0, 100, length(stat_log_16));
% plot(x_8, stat_log_8, '.', x_16, stat_log_16, '.')
% set(gca, 'xtick', [], 'xticklabel', [], 'fontsize', 15);
% ylabel(stat_str, 'fontsize', 15)
% title(strcat(stat_str, " scatter"), 'fontsize', 15)
% legend("8x8", "16x16", 'fontsize', 11)
% % histogram
% subplot(1, 3, 2:3)
% h8 = histogram(stat_log_8, 'numbins', 100, 'normalization', 'probability', 'BinWidth', max([stat_log_8, stat_log_16]) / 100); hold; h16 = histogram(stat_log_16, 'numbins', 100, 'normalization', 'probability', 'BinWidth', max([stat_log_8, stat_log_16]) / 100);
% xlabel(stat_str, 'fontsize', 15)
% ylabel("P", 'fontsize', 15)
% title(strcat(stat_str, " histogram"), 'fontsize', 15)
% legend("8x8", "16x16", 'fontsize', 11)
