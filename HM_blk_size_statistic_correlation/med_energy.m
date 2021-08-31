% 计算 MED 后的能量作为块的表征
function ret = med_energy(d)
    d = double(d);
    [n, ~] = size(d);
    after_med = zeros(n, n);
    after_med(1, :) = d(1, :);
    after_med(:, 1) = d(:, 1);

    for i = 2:n
        for j = 2:n
            left = d(i, j - 1);
            top = d(i - 1, j);
            lefttop = d(i - 1, j - 1);
            if (lefttop >= max(left, top))
                after_med(i, j) = min(left, top);
            elseif (lefttop <= min(left, top))
                after_med(i, j) = max(left, top);
            else
                after_med(i, j) = left + top - lefttop;
            end
        end
    end

    after_med = after_med - d;

    ret = sum(after_med(2:end, 2:end).^2);
end
