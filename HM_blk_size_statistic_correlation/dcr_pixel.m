% DCR 文章方案，原始像素做和平方/平方和
function ret = dcr_pixel(d)
    t = double(d);

    ret = round((sum(sum(t))^2) / sum(sum(t.^2)));
end
