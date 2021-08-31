% c 模型原始方案，先算出 4 个 satd，然后套用 dcr 概念 pow3
function ret = satd_dcr_pow3(satd4)
    ret = 64 * (sum(satd4)^3) / sum(satd4.^3);
end
