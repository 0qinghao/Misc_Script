% (1-SATD DCR) * (sum(SATD)^2)
% SATD DCR 表征 4 个 SATD 是否均匀分布，均匀分布的话趋向于保持 16x16 块；引入 sum SATD pow 2, 均匀但 4 个块都很大则还是分 8x8 做
function ret = one_min_DCR_mul_S(satd4)
    ret = (4 - ((sum(satd4)^2) / sum(satd4.^2))) * (sum(satd4)^2) / 1024;
end
