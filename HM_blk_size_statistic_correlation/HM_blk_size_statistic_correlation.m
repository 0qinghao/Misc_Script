% 分析某种统计量与 HM 分块结果的相关性
load '../Mol_HM_Blk_Diff/blk_size_mat_HM_all.mat'
% HM_res_yuv_dir_str = "\\pub\staff\rin.lin\HM_MOLcfg_INTRA_BS\";
% HM_res_yuv_file = dir(strcat(HM_res_yuv_dir_str, '*residual.yuv'));
% FH_yuv_dir_str = "\\pub\staff\derek.you\2019-07-30-FullhanSrc\420\";
% FH_yuv_file = dir(strcat(FH_yuv_dir_str, '*.yuv'));
load 'HM_res_yuv_file.mat'
file_cnt = length(HM_res_yuv_file);
y_res = zeros(1088, 1920, file_cnt);

% stat_str = "SATD max";
% stat_log_8 = [0]; stat_log_16 = [0];
% % for i = 1:file_cnt
% for i = 1:4:file_cnt
%     res_str = strcat(HM_res_yuv_file(i).folder, '\', HM_res_yuv_file(i).name);
%     disp(res_str);
%     y_res_temp = yuvRead(res_str, 1920, 1088, 1);
%     y_res(:, :, i) = reshape(typecast(y_res_temp(:), "int8"), 1088, 1920);
%     t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
%     for y = 1:16:1088
%         for x = 1:16:1920
%             if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
%                 stat_log_8(end + 1) = max([satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))]);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             elseif (t_HM_blk_size_mat(y, x) == 16)
%                 stat_log_16(end + 1) = max([satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))]);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             end
%         end
%     end
% end

% stat_str = "export";
% stat_log_8 = [0]; stat_log_16 = [0];
% % fid = fopen("satd_blksize.csv", "w");
% % fid = fopen("sad_blksize.csv", "w");
% fid = fopen("ssd_blksize.csv", "w");
% % for i = 1:file_cnt
% for i = 1:4:file_cnt
% res_str = strcat(HM_res_yuv_file(i).folder, '\', HM_res_yuv_file(i).name);
% disp(res_str);
% y_res_temp = yuvRead(res_str, 1920, 1088, 1);
% y_res(:, :, i) = reshape(typecast(y_res_temp(:), "int8"), 1088, 1920);
% t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
%     for y = 1:16:1088
%         for x = 1:16:1920
%             if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
%                 % satd_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 % fprintf(fid, "8 %d %d %d %d\n", satd_4_blk);
%                 % sad_4_blk = [sad(y_res(y:y + 7, x:x + 7, i)), sad(y_res(y:y + 7, x + 8:x + 15, i)), sad(y_res(y + 8:y + 15, x:x + 7, i)), sad(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 % fprintf(fid, "8 %d %d %d %d\n", sad_4_blk);
%                 ssd_4_blk = [ssd(y_res(y:y + 7, x:x + 7, i)), ssd(y_res(y:y + 7, x + 8:x + 15, i)), ssd(y_res(y + 8:y + 15, x:x + 7, i)), ssd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 fprintf(fid, "8 %d %d %d %d\n", ssd_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             elseif (t_HM_blk_size_mat(y, x) == 16)
%                 % satd_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 % fprintf(fid, "16 %d %d %d %d\n", satd_4_blk);
%                 ssd_4_blk = [ssd(y_res(y:y + 7, x:x + 7, i)), ssd(y_res(y:y + 7, x + 8:x + 15, i)), ssd(y_res(y + 8:y + 15, x:x + 7, i)), ssd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 fprintf(fid, "16 %d %d %d %d\n", ssd_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             end
%         end
%     end
% end
% fclose(fid);

% stat_str = "4x4 SATD DC Ratio";
% stat_log_8 = [0]; stat_log_16 = [0];
% % for i = 1:file_cnt
% for i = 1:4:file_cnt
%     res_str = strcat(HM_res_yuv_file(i).folder, '\', HM_res_yuv_file(i).name);
%     disp(res_str);
%     y_res_temp = yuvRead(res_str, 1920, 1088, 1);
%     y_res(:, :, i) = reshape(typecast(y_res_temp(:), "int8"), 1088, 1920);
%     t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
%     for y = 1:16:1088
%         for x = 1:16:1920
%             if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
%                 satd_blk = [satd44(y_res(y:y + 3, x:x + 3, i)), satd44(y_res(y:y + 3, x + 4:x + 7)), satd44(y_res(y:y + 3, x + 8:x + 11)), satd44(y_res(y:y + 3, x + 12:x + 15)),
%                         satd44(y_res(y + 4:y + 7, x:x + 3, i)), satd44(y_res(y + 4:y + 7, x + 4:x + 7)), satd44(y_res(y + 4:y + 7, x + 8:x + 11)), satd44(y_res(y + 4:y + 7, x + 12:x + 15)),
%                         satd44(y_res(y + 8:y + 11, x:x + 3, i)), satd44(y_res(y + 8:y + 11, x + 4:x + 7)), satd44(y_res(y + 8:y + 11, x + 8:x + 11)), satd44(y_res(y + 8:y + 11, x + 12:x + 15)),
%                         satd44(y_res(y + 12:y + 15, x:x + 3, i)), satd44(y_res(y + 12:y + 15, x + 4:x + 7)), satd44(y_res(y + 12:y + 15, x + 8:x + 11)), satd44(y_res(y + 12:y + 15, x + 12:x + 15))
%                         ];
%                 stat_log_8(end + 1) = dcr_simple(satd_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             elseif (t_HM_blk_size_mat(y, x) == 16)
%                 satd_blk = [satd44(y_res(y:y + 3, x:x + 3, i)), satd44(y_res(y:y + 3, x + 4:x + 7)), satd44(y_res(y:y + 3, x + 8:x + 11)), satd44(y_res(y:y + 3, x + 12:x + 15)),
%                         satd44(y_res(y + 4:y + 7, x:x + 3, i)), satd44(y_res(y + 4:y + 7, x + 4:x + 7)), satd44(y_res(y + 4:y + 7, x + 8:x + 11)), satd44(y_res(y + 4:y + 7, x + 12:x + 15)),
%                         satd44(y_res(y + 8:y + 11, x:x + 3, i)), satd44(y_res(y + 8:y + 11, x + 4:x + 7)), satd44(y_res(y + 8:y + 11, x + 8:x + 11)), satd44(y_res(y + 8:y + 11, x + 12:x + 15)),
%                         satd44(y_res(y + 12:y + 15, x:x + 3, i)), satd44(y_res(y + 12:y + 15, x + 4:x + 7)), satd44(y_res(y + 12:y + 15, x + 8:x + 11)), satd44(y_res(y + 12:y + 15, x + 12:x + 15))
%                         ];
%                 stat_log_16(end + 1) = dcr_simple(satd_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             end
%         end
%     end
% end

% stat_str = "DC Ratio C Model";
% stat_log_8 = [0]; stat_log_16 = [0];
% % for i = 1:file_cnt
% for i = 1:4:file_cnt
%     res_str = strcat(HM_res_yuv_file(i).folder, '\', HM_res_yuv_file(i).name);
%     disp(res_str);
%     y_res_temp = yuvRead(res_str, 1920, 1088, 1);
%     y_res(:, :, i) = reshape(typecast(y_res_temp(:), "int8"), 1088, 1920);
%     t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
%     for y = 1:16:1088
%         for x = 1:16:1920
%             if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
%                 satd_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_8(end + 1) = dcr_simple(satd_4_blk);
%                 % if (stat_log_8(end) > 238)
%                 %     disp("下述为8误判的 satd std")
%                 % end
%                 % disp(satd_4_blk)
%                 % disp(std(satd_4_blk))
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             elseif (t_HM_blk_size_mat(y, x) == 16)
%                 satd_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_16(end + 1) = dcr_simple(satd_4_blk);
%                 % disp("下述为 16 的 satd std")
%                 % disp(satd_4_blk)
%                 % disp(std(satd_4_blk))
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             end
%         end
%     end
% end

stat_str = "VSATD";
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
                satd_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
                stat_log_8(end + 1) = vsatd(satd_4_blk);
                t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
            elseif (t_HM_blk_size_mat(y, x) == 16)
                satd_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
                stat_log_16(end + 1) = vsatd(satd_4_blk);
                t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
            end
        end
    end
end

% stat_str = "res energy DC Ratio";
% stat_log_8 = [0]; stat_log_16 = [0];
% % for i = 1:file_cnt
% for i = 1:4:file_cnt
%     res_str = strcat(HM_res_yuv_file(i).folder, '\', HM_res_yuv_file(i).name);
%     disp(res_str);
%     y_res_temp = yuvRead(res_str, 1920, 1088, 1);
%     y_res(:, :, i) = reshape(typecast(y_res_temp(:), "int8"), 1088, 1920);
%     t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
%     for y = 1:16:1088
%         for x = 1:16:1920
%             if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
%                 res_4_blk = [res_energy(y_res(y:y + 7, x:x + 7, i)), res_energy(y_res(y:y + 7, x + 8:x + 15, i)), res_energy(y_res(y + 8:y + 15, x:x + 7, i)), res_energy(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_8(end + 1) = dcr_simple(res_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             elseif (t_HM_blk_size_mat(y, x) == 16)
%                 res_4_blk = [res_energy(y_res(y:y + 7, x:x + 7, i)), res_energy(y_res(y:y + 7, x + 8:x + 15, i)), res_energy(y_res(y + 8:y + 15, x:x + 7, i)), res_energy(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_16(end + 1) = dcr_simple(res_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             end
%         end
%     end
% end

% stat_str = "SSD DCR";
% stat_log_8 = [0]; stat_log_16 = [0];
% % for i = 1:file_cnt
% for i = 1:4:file_cnt
%     res_str = strcat(HM_res_yuv_file(i).folder, '\', HM_res_yuv_file(i).name);
%     disp(res_str);
%     y_res_temp = yuvRead(res_str, 1920, 1088, 1);
%     y_res(:, :, i) = reshape(typecast(y_res_temp(:), "int8"), 1088, 1920);
%     t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
%     for y = 1:16:1088
%         for x = 1:16:1920
%             if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
%                 res_4_blk = [res_energy(y_res(y:y + 7, x:x + 7, i)), res_energy(y_res(y:y + 7, x + 8:x + 15, i)), res_energy(y_res(y + 8:y + 15, x:x + 7, i)), res_energy(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_8(end + 1) = dcr_simple(res_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             elseif (t_HM_blk_size_mat(y, x) == 16)
%                 res_4_blk = [res_energy(y_res(y:y + 7, x:x + 7, i)), res_energy(y_res(y:y + 7, x + 8:x + 15, i)), res_energy(y_res(y + 8:y + 15, x:x + 7, i)), res_energy(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_16(end + 1) = dcr_simple(res_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             end
%         end
%     end
% end

% stat_str = "(1-SATD DCR) * sum(SATD)^2";
% stat_log_8 = [0]; stat_log_16 = [0];
% % for i = 1:file_cnt
% for i = 1:4:file_cnt
%     res_str = strcat(HM_res_yuv_file(i).folder, '\', HM_res_yuv_file(i).name);
%     disp(res_str);
%     y_res_temp = yuvRead(res_str, 1920, 1088, 1);
%     y_res(:, :, i) = reshape(typecast(y_res_temp(:), "int8"), 1088, 1920);
%     t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
%     for y = 1:16:1088
%         for x = 1:16:1920
%             if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
%                 data_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_8(end + 1) = one_min_DCR_mul_S(data_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             elseif (t_HM_blk_size_mat(y, x) == 16)
%                 data_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_16(end + 1) = one_min_DCR_mul_S(data_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             end
%         end
%     end
% end

% stat_str = "DC Ratio C Model double check";
% stat_log_8 = [0]; stat_log_16 = [0];
% % for i = 1:file_cnt
% for i = 1:4:file_cnt
%     res_str = strcat(HM_res_yuv_file(i).folder, '\', HM_res_yuv_file(i).name);
%     disp(res_str);
%     y_res_temp = yuvRead(res_str, 1920, 1088, 1);
%     y_res(:, :, i) = reshape(typecast(y_res_temp(:), "int8"), 1088, 1920);
%     t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
%     for y = 1:16:1088
%         for x = 1:16:1920
%             if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
%                 satd_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_8(end + 1) = dcr_simple_DouCheck(satd_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             elseif (t_HM_blk_size_mat(y, x) == 16)
%                 satd_4_blk = [satd(y_res(y:y + 7, x:x + 7, i)), satd(y_res(y:y + 7, x + 8:x + 15, i)), satd(y_res(y + 8:y + 15, x:x + 7, i)), satd(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_16(end + 1) = dcr_simple_DouCheck(satd_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             end
%         end
%     end
% end

% stat_str = "DC Ratio of SA(DCT)D";
% stat_log_8 = [0]; stat_log_16 = [0];
% for i = 1:file_cnt
%     % for i = 1:4:file_cnt
%     res_str = strcat(HM_res_yuv_file(i).folder, '\', HM_res_yuv_file(i).name);
%     disp(res_str);
%     y_res_temp = yuvRead(res_str, 1920, 1088, 1);
%     y_res(:, :, i) = reshape(typecast(y_res_temp(:), "int8"), 1088, 1920);
%     t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
%     for y = 1:16:1088
%         for x = 1:16:1920
%             if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
%                 satd_4_blk = [satd_dct(y_res(y:y + 7, x:x + 7, i)), satd_dct(y_res(y:y + 7, x + 8:x + 15, i)), satd_dct(y_res(y + 8:y + 15, x:x + 7, i)), satd_dct(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_8(end + 1) = dcr_simple(satd_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             elseif (t_HM_blk_size_mat(y, x) == 16)
%                 satd_4_blk = [satd_dct(y_res(y:y + 7, x:x + 7, i)), satd_dct(y_res(y:y + 7, x + 8:x + 15, i)), satd_dct(y_res(y + 8:y + 15, x:x + 7, i)), satd_dct(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_16(end + 1) = dcr_simple(satd_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             end
%         end
%     end
% end

% stat_str = "SATD(part F) DC Ratio";
% stat_log_8 = [0]; stat_log_16 = [0];
% % for i = 1:file_cnt
% for i = 1:4:file_cnt
%     res_str = strcat(HM_res_yuv_file(i).folder, '\', HM_res_yuv_file(i).name);
%     disp(res_str);
%     y_res_temp = yuvRead(res_str, 1920, 1088, 1);
%     y_res(:, :, i) = reshape(typecast(y_res_temp(:), "int8"), 1088, 1920);
%     t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
%     for y = 1:16:1088
%         for x = 1:16:1920
%             if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
%                 satd_4_blk = [satd_partF(y_res(y:y + 7, x:x + 7, i)), satd_partF(y_res(y:y + 7, x + 8:x + 15, i)), satd_partF(y_res(y + 8:y + 15, x:x + 7, i)), satd_partF(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_8(end + 1) = dcr_simple(satd_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             elseif (t_HM_blk_size_mat(y, x) == 16)
%                 satd_4_blk = [satd_partF(y_res(y:y + 7, x:x + 7, i)), satd_partF(y_res(y:y + 7, x + 8:x + 15, i)), satd_partF(y_res(y + 8:y + 15, x:x + 7, i)), satd_partF(y_res(y + 8:y + 15, x + 8:x + 15, i))];
%                 stat_log_16(end + 1) = dcr_simple(satd_4_blk);
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             end
%         end
%     end
% end

% stat_str = "res sobel";
% stat_log_8 = [0]; stat_log_16 = [0];
% % for i = 1:file_cnt
% for i = 1:4:file_cnt
%     res_str = strcat(HM_res_yuv_file(i).folder, '\', HM_res_yuv_file(i).name);
%     disp(res_str);
%     y_res_temp = yuvRead(res_str, 1920, 1088, 1);
%     y_res(:, :, i) = reshape(typecast(y_res_temp(:), "int8"), 1088, 1920);
%     sobel_res = sobel(y_res(:, :, i));
%     t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
%     for y = 1:16:1088
%         for x = 1:16:1920
%             if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
%                 stat_log_8(end + 1) = blk_sobel_ana(sobel_res(y:y + 15, x:x + 15));
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             elseif (t_HM_blk_size_mat(y, x) == 16)
%                 stat_log_16(end + 1) = blk_sobel_ana(sobel_res(y:y + 15, x:x + 15));
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             end
%         end
%     end
% end

% stat_str = "src var";
% stat_log_8 = [0]; stat_log_16 = [0];
% % for i = 1:file_cnt
% for i = 1:1:1
%     src_str = strcat(FH_yuv_file(1).folder, '\', FH_yuv_file(1).name);
%     disp(src_str);
%     y_src_temp = yuvRead(src_str, 1920, 1088, 1);
%     y_src(:, :, i) = reshape(y_src_temp, 1088, 1920);
%     t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
%     for y = 1:16:1088
%         for x = 1:16:1920
%             if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
%                 stat_log_8(end + 1) = blk_var(y_src(y:y + 15, x:x + 15, i));
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             elseif (t_HM_blk_size_mat(y, x) == 16)
%                 stat_log_16(end + 1) = blk_var(y_src(y:y + 15, x:x + 15, i));
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             end
%         end
%     end
% end

% stat_str = "src sobel";
% stat_log_8 = [0]; stat_log_16 = [0];
% for i = 1:4:file_cnt
%     % for i = 1:1:1
%     src_str = strcat(FH_yuv_file(ceil(i / 4)).folder, '\', FH_yuv_file(ceil(i / 4)).name);
%     disp(src_str);
%     y_src_temp = yuvRead(src_str, 1920, 1088, 1);
%     sobel_src = sobel(y_src_temp);
%     t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
%     for y = 1:16:1088
%         for x = 1:16:1920
%             if ((t_HM_blk_size_mat(y, x) == 8) && (t_HM_blk_size_mat(y, x + 8) == 8) && (t_HM_blk_size_mat(y + 8, x) == 8) && (t_HM_blk_size_mat(y + 8, x + 8) == 8))
%                 stat_log_8(end + 1) = blk_sobel_ana(sobel_src(y:y + 15, x:x + 15));
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             elseif (t_HM_blk_size_mat(y, x) == 16)
%                 stat_log_16(end + 1) = blk_sobel_ana(sobel_src(y:y + 15, x:x + 15));
%                 t_HM_blk_size_mat(y:y + 15, x:x + 15) = 0;
%             end
%         end
%     end
% end

% Test TH
stat_log_8 = stat_log_8(2:end);
stat_log_16 = stat_log_16(2:end);
right_p_8 = [0]; right_p_16 = [0]; right_p = [0];
right_TH = min([stat_log_8, stat_log_16]):max([stat_log_8, stat_log_16]);
for i = right_TH
%     right_8_cnt = sum(stat_log_8 < i); right_16_cnt = sum(stat_log_16 >= i);
    right_8_cnt = sum(stat_log_8 > i); right_16_cnt = sum(stat_log_16 <= i);
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
