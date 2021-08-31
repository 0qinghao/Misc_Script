% c 模型原始方案，先算出 4 个 satd，然后套用 dcr 概念，取反测试
function ret = satd_dcr_inv(satd4)
    % ret = 64 * (sum(satd4)^2) / sum(satd4.^2);
    ret = 256 * sum(satd4.^2) / (sum(satd4)^2);
end
