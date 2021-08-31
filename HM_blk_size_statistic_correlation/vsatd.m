% 类似 c 模型原始方案的论文 vsatd
function ret = vsatd(satd4)
    ms = mean(satd4);
    ret = sum((satd4 / ms - 1).^2) / 4 * 256;
    % ret = (sum(satd4.^2) - 4 * ms^2) / (4 * ms^2) * 256;
end
