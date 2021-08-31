% c 模型原始方案
function ret = dcr_simple(satd4)
    satd4 = satd4(:);
    ret = 64 * (sum(satd4)^2) / sum(satd4.^2);
end
