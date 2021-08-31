% c 模型原始方案，但是观察到 8x8 的 dcr_simple 也有可能很大，再加一个 double check 条件
function ret = dcr_simple(satd4)
    ret = 64 * (sum(satd4)^2) / sum(satd4.^2);
    satd_std = std(satd4);
    ret = ret + 512 / (satd_std + 1);
end
