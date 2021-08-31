% 分析某种统计量与 HM 分块结果的相关性
load '../Mol_HM_Blk_Diff/blk_size_mat_HM_all.mat'
% HM_res_yuv_dir_str = "\\pub\staff\rin.lin\HM_MOLcfg_INTRA_BS\";
% HM_res_yuv_file = dir(strcat(HM_res_yuv_dir_str, '*residual.yuv'));
% FH_yuv_dir_str = "\\pub\staff\derek.you\2019-07-30-FullhanSrc\420\";
% FH_yuv_file = dir(strcat(FH_yuv_dir_str, '*.yuv'));
load 'HM_res_yuv_file.mat'
file_cnt = length(HM_res_yuv_file);
y_res = zeros(1088, 1920, file_cnt);

stat_str = "net";
stat_log_8 = [0]; stat_log_16 = [0];
% for i = 1:file_cnt
for i = 1:4:file_cnt
    res_str = strcat(HM_res_yuv_file(i).folder, '\', HM_res_yuv_file(i).name);
    disp(res_str);
    y_res_temp = yuvRead(res_str, 1920, 1088, 1);
    y_res(:, :, i) = reshape(typecast(y_res_temp(:), "int8"), 1088, 1920);
    t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
    for y = 1:16:1088
        for x = 1:16:1920
            if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
                data_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
                stat_log_tmp = dcr_simple(data_4_blk);
                if (stat_log_tmp >= 200)
                    % data_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
                    data_4_blk = [sad(y_res(y:y + 7, x:x + 7, i)), sad(y_res(y:y + 7, x + 8:x + 15, i)), sad(y_res(y + 8:y + 15, x:x + 7, i)), sad(y_res(y + 8:y + 15, x + 8:x + 15, i))];
                    % data_4_blk = [ssd(y_res(y:y + 7, x:x + 7, i)), ssd(y_res(y:y + 7, x + 8:x + 15, i)), ssd(y_res(y + 8:y + 15, x:x + 7, i)), ssd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
                    % data_4_blk = [blk_entropy(y_res(y:y + 7, x:x + 7, i)), blk_entropy(y_res(y:y + 7, x + 8:x + 15, i)), blk_entropy(y_res(y + 8:y + 15, x:x + 7, i)), blk_entropy(y_res(y + 8:y + 15, x + 8:x + 15, i))];
                    % stat_log_8(end + 1) = sum(data_4_blk);
                    stat_log_8(end + 1) = dcr_simple(data_4_blk);
                end
                t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
            elseif (t_HM_blk_size_mat(y, x) == 16)
                data_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
                stat_log_tmp = dcr_simple(data_4_blk);
                if (stat_log_tmp >= 200)
                    % data_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
                    data_4_blk = [sad(y_res(y:y + 7, x:x + 7, i)), sad(y_res(y:y + 7, x + 8:x + 15, i)), sad(y_res(y + 8:y + 15, x:x + 7, i)), sad(y_res(y + 8:y + 15, x + 8:x + 15, i))];
                    % data_4_blk = [ssd(y_res(y:y + 7, x:x + 7, i)), ssd(y_res(y:y + 7, x + 8:x + 15, i)), ssd(y_res(y + 8:y + 15, x:x + 7, i)), ssd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
                    % data_4_blk = [blk_entropy(y_res(y:y + 7, x:x + 7, i)), blk_entropy(y_res(y:y + 7, x + 8:x + 15, i)), blk_entropy(y_res(y + 8:y + 15, x:x + 7, i)), blk_entropy(y_res(y + 8:y + 15, x + 8:x + 15, i))];
                    % stat_log_16(end + 1) = sum(data_4_blk);
                    stat_log_16(end + 1) = dcr_simple(data_4_blk);
                end
                t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
            end
        end
    end
end

% Test TH
stat_log_8 = stat_log_8(2:end);
stat_log_16 = stat_log_16(2:end);
right_p_8 = [0]; right_p_16 = [0]; right_p = [0];
right_TH = min([stat_log_8, stat_log_16]):max([stat_log_8, stat_log_16]);
for i = right_TH
    right_8_cnt = sum(stat_log_8 < i); right_16_cnt = sum(stat_log_16 >= i);
    % right_8_cnt = sum(stat_log_8 > i); right_16_cnt = sum(stat_log_16 <= i);
    right_p_8(end + 1) = right_8_cnt / length(stat_log_8); right_p_16(end + 1) = right_16_cnt / length(stat_log_16);
    right_p(end + 1) = right_p_8(end) + right_p_16(end);
end
right_p = right_p(2:end); right_p_8 = right_p_8(2:end); right_p_16 = right_p_16(2:end);
[p_max, p_max_index] = max(right_p);
p_max_TH = right_TH(p_max_index)
right_p_8(p_max_index)
right_p_16(p_max_index)
% % Test TH
% stat_log_8 = stat_log_8(2:end);
% stat_log_16 = stat_log_16(2:end);
% right_p = [0];
% right_TH = min([stat_log_8, stat_log_16]):max([stat_log_8, stat_log_16]);
% for i = right_TH
%     right_8_cnt = sum(stat_log_8 < i); right_16_cnt = sum(stat_log_16 >= i);
%     right_p(end + 1) = (right_8_cnt + right_16_cnt) / (length(stat_log_8) + length(stat_log_16));
% end
% right_p = right_p(2:end);
% [p_max, p_max_index] = max(right_p);
% p_max_TH = right_TH(p_max_index)
% p_max
% scatter
subplot(1, 3, 1)
x_8 = linspace(0, 100, length(stat_log_8)); x_16 = linspace(0, 100, length(stat_log_16));
plot(x_8, stat_log_8, '.', x_16, stat_log_16, '.')
set(gca, 'xtick', [], 'xticklabel', [], 'fontsize', 15);
ylabel(stat_str, 'fontsize', 15)
title(strcat(stat_str, " scatter"), 'fontsize', 15)
legend("8x8", "16x16", 'fontsize', 11)
% histogram
subplot(1, 3, 2:3)
h8 = histogram(stat_log_8, 'numbins', 100, 'normalization', 'probability', 'BinWidth', max([stat_log_8, stat_log_16]) / 100); hold; h16 = histogram(stat_log_16, 'numbins', 100, 'normalization', 'probability', 'BinWidth', max([stat_log_8, stat_log_16]) / 100);
xlabel(stat_str, 'fontsize', 15)
ylabel("P", 'fontsize', 15)
title(strcat(stat_str, " histogram"), 'fontsize', 15)
legend("8x8", "16x16", 'fontsize', 11)
