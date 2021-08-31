% 简单地计算残差总能量
function ret = ssd(d)
    ret = sum(sum(d.^2));
end
