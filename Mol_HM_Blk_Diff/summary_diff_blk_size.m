% 统计分块的不同

load blk_size_mat.dat

[h, w, file_cnt] = size(HM_blk_size_mat);

% checked_flag = zeros(h, w, file_cnt);
cnt_HM32_MOL4 = zeros(1, file_cnt);
cnt_HM32_MOL8 = zeros(1, file_cnt);
cnt_HM32_MOL16 = zeros(1, file_cnt);
cnt_HM32_MOL32 = zeros(1, file_cnt);
cnt_HM16_MOL4 = zeros(1, file_cnt);
cnt_HM16_MOL8 = zeros(1, file_cnt);
cnt_HM16_MOL16 = zeros(1, file_cnt);
cnt_HM16_MOL32 = zeros(1, file_cnt);
cnt_HM8_MOL4 = zeros(1, file_cnt);
cnt_HM8_MOL8 = zeros(1, file_cnt);
cnt_HM8_MOL16 = zeros(1, file_cnt);
cnt_HM8_MOL32 = zeros(1, file_cnt);
cnt_HM4_MOL4 = zeros(1, file_cnt);
cnt_HM4_MOL8 = zeros(1, file_cnt);
cnt_HM4_MOL16 = zeros(1, file_cnt);
cnt_HM4_MOL32 = zeros(1, file_cnt);

tic
for i = 1:file_cnt
    % for i = 1:2
    t_HM_blk_size_mat = HM_blk_size_mat(:, :, i);
    t_MOL_blk_size_mat = MOL_blk_size_mat(:, :, i);

    for y = 1:4:h
        for x = 1:4:w
            % if (checked_flag(y, x) == 1)
            %     continue;
            % end
            if (t_HM_blk_size_mat(y, x) == 32)
                if (t_MOL_blk_size_mat(y, x) == 32)
                    cnt_HM32_MOL32(i) = cnt_HM32_MOL32(i) + 16;
                elseif (t_MOL_blk_size_mat(y, x) == 16)
                    cnt_HM32_MOL16(i) = cnt_HM32_MOL16(i) + 16;
                elseif (t_MOL_blk_size_mat(y, x) == 8)
                    cnt_HM32_MOL8(i) = cnt_HM32_MOL8(i) + 16;
                elseif (t_MOL_blk_size_mat(y, x) == 4)
                    cnt_HM32_MOL4(i) = cnt_HM32_MOL4(i) + 16;
                else
                    error("can't parse size mat");
                end
            elseif (t_HM_blk_size_mat(y, x) == 16)
                if (t_MOL_blk_size_mat(y, x) == 32)
                    cnt_HM16_MOL32(i) = cnt_HM16_MOL32(i) + 16;
                elseif (t_MOL_blk_size_mat(y, x) == 16)
                    cnt_HM16_MOL16(i) = cnt_HM16_MOL16(i) + 16;
                elseif (t_MOL_blk_size_mat(y, x) == 8)
                    cnt_HM16_MOL8(i) = cnt_HM16_MOL8(i) + 16;
                elseif (t_MOL_blk_size_mat(y, x) == 4)
                    cnt_HM16_MOL4(i) = cnt_HM16_MOL4(i) + 16;
                else
                    error("can't parse size mat");
                end
            elseif (t_HM_blk_size_mat(y, x) == 8)
                if (t_MOL_blk_size_mat(y, x) == 32)
                    cnt_HM8_MOL32(i) = cnt_HM8_MOL32(i) + 16;
                elseif (t_MOL_blk_size_mat(y, x) == 16)
                    cnt_HM8_MOL16(i) = cnt_HM8_MOL16(i) + 16;
                elseif (t_MOL_blk_size_mat(y, x) == 8)
                    cnt_HM8_MOL8(i) = cnt_HM8_MOL8(i) + 16;
                elseif (t_MOL_blk_size_mat(y, x) == 4)
                    cnt_HM8_MOL4(i) = cnt_HM8_MOL4(i) + 16;
                else
                    error("can't parse size mat");
                end
            elseif (t_HM_blk_size_mat(y, x) == 4)
                if (t_MOL_blk_size_mat(y, x) == 32)
                    cnt_HM4_MOL32(i) = cnt_HM4_MOL32(i) + 16;
                elseif (t_MOL_blk_size_mat(y, x) == 16)
                    cnt_HM4_MOL16(i) = cnt_HM4_MOL16(i) + 16;
                elseif (t_MOL_blk_size_mat(y, x) == 8)
                    cnt_HM4_MOL8(i) = cnt_HM4_MOL8(i) + 16;
                elseif (t_MOL_blk_size_mat(y, x) == 4)
                    cnt_HM4_MOL4(i) = cnt_HM4_MOL4(i) + 16;
                else
                    error("can't parse size mat");
                end
            end
        end
    end
end
toc

sum_HM32_MOL4 = 0;
sum_HM32_MOL8 = 0;
sum_HM32_MOL16 = 0;
sum_HM32_MOL32 = 0;
sum_HM16_MOL4 = 0;
sum_HM16_MOL8 = 0;
sum_HM16_MOL16 = 0;
sum_HM16_MOL32 = 0;
sum_HM8_MOL4 = 0;
sum_HM8_MOL8 = 0;
sum_HM8_MOL16 = 0;
sum_HM8_MOL32 = 0;
sum_HM4_MOL4 = 0;
sum_HM4_MOL8 = 0;
sum_HM4_MOL16 = 0;
sum_HM4_MOL32 = 0;
sum_HM32_MOL32 = 0;

for i = 1:file_cnt
    % for i = 4:4:file_cnt
    % for i = 1:2
    sum_HM32_MOL4 = sum_HM32_MOL4 + cnt_HM32_MOL4(i);
    sum_HM32_MOL8 = sum_HM32_MOL8 + cnt_HM32_MOL8(i);
    sum_HM32_MOL16 = sum_HM32_MOL16 + cnt_HM32_MOL16(i);
    sum_HM32_MOL32 = sum_HM32_MOL32 + cnt_HM32_MOL32(i);
    sum_HM16_MOL4 = sum_HM16_MOL4 + cnt_HM16_MOL4(i);
    sum_HM16_MOL8 = sum_HM16_MOL8 + cnt_HM16_MOL8(i);
    sum_HM16_MOL16 = sum_HM16_MOL16 + cnt_HM16_MOL16(i);
    sum_HM16_MOL32 = sum_HM16_MOL32 + cnt_HM16_MOL32(i);
    sum_HM8_MOL4 = sum_HM8_MOL4 + cnt_HM8_MOL4(i);
    sum_HM8_MOL8 = sum_HM8_MOL8 + cnt_HM8_MOL8(i);
    sum_HM8_MOL16 = sum_HM8_MOL16 + cnt_HM8_MOL16(i);
    sum_HM8_MOL32 = sum_HM8_MOL32 + cnt_HM8_MOL32(i);
    sum_HM4_MOL4 = sum_HM4_MOL4 + cnt_HM4_MOL4(i);
    sum_HM4_MOL8 = sum_HM4_MOL8 + cnt_HM4_MOL8(i);
    sum_HM4_MOL16 = sum_HM4_MOL16 + cnt_HM4_MOL16(i);
    sum_HM4_MOL32 = sum_HM4_MOL32 + cnt_HM4_MOL32(i);
end
sum_arr = [sum_HM4_MOL4, sum_HM4_MOL8, sum_HM4_MOL16, sum_HM4_MOL32, sum_HM8_MOL4, sum_HM8_MOL8, sum_HM8_MOL16, sum_HM8_MOL32, sum_HM16_MOL4, sum_HM16_MOL8, sum_HM16_MOL16, sum_HM16_MOL32, sum_HM32_MOL4, sum_HM32_MOL8, sum_HM32_MOL16, sum_HM32_MOL32];

% if (sum(sum_arr) != file_cnt * 1920 * 1088)
%     error('cnt error')
% end

disp('HM MOL same:')
disp(sum([sum_HM4_MOL4, sum_HM8_MOL8, sum_HM16_MOL16, sum_HM32_MOL32]) / sum(sum_arr))
disp('HM small blk, MOL big blk:')
disp(sum([sum_HM4_MOL8, sum_HM4_MOL16, sum_HM4_MOL32, sum_HM8_MOL16, sum_HM8_MOL32, sum_HM16_MOL32]) / sum(sum_arr))
disp('HM big blk, MOL small blk:')
disp(sum([sum_HM8_MOL4, sum_HM16_MOL4, sum_HM16_MOL8, sum_HM32_MOL4, sum_HM32_MOL8, sum_HM32_MOL16]) / sum(sum_arr))

% cnt_HM32_MOL32(1) + cnt_HM32_MOL16(1) + cnt_HM32_MOL8(1) + cnt_HM32_MOL4(1) + ...
%     cnt_HM16_MOL32(1) + cnt_HM16_MOL16(1) + cnt_HM16_MOL8(1) + cnt_HM16_MOL4(1) + ...
%     cnt_HM8_MOL32(1) + cnt_HM8_MOL16(1) + cnt_HM8_MOL8(1) + cnt_HM8_MOL4(1) + ...
%     cnt_HM4_MOL32(1) + cnt_HM4_MOL16(1) + cnt_HM4_MOL8(1) + cnt_HM4_MOL4(1)
