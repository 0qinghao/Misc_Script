% 计算方法是 DCR 论文的逐点计算，不过对比论文，算的对象变成了 hadamard 域
function ret = dcr_hadamard(d)
    d = double(d);
    [n, ~] = size(d);
    ret = 0;
    for x = 1:8:n
        for y = 1:8:n
            t(x:x + 7, y:y + 7) = abs(hadamard(8) * d(x:x + 7, y:y + 7) * hadamard(8));
        end
    end

    ret = round(256 * (sum(sum(t))^2) / sum(sum(t.^2)));
end
