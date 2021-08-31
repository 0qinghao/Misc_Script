% 4 个 SATD 相差的程度  主要是为与 DCR simple 联合使用做测试
function ret = satd_diff(satd4)
    ret = max(satd4) - min(satd4);
end
