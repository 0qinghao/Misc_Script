hadamard(8)
% hadmard 变换后的系数频率分布，取决于每一行/列符号变化的频次
had_f_1d = [zeros(1,8);zeros(1,8)+7;zeros(1,8)+3;zeros(1,8)+4;zeros(1,8)+1;zeros(1,8)+6;zeros(1,8)+2;zeros(1,8)+5];

% 行变化率+列变化率
had_f = had_f_1d + had_f_1d';

had_f

% 排序
had_f_1d_sort = had_f_1d + 1;
had_f_sort = had_f_1d_sort + had_f_1d_sort' - 1;
had_f_sort;