% satd  pow2
function ret = satd_pow2(d)
    [n, ~] = size(d);

    % if (n == 8)
    %     ret = sum(sum(abs(hadamard(8) * d * hadamard(8))));
    %     ret = bitshift((ret + 2), -2);
    % else if (n == 16)
    ret = 0;
    for x = 1:8:n
        for y = 1:8:n
            t = sum(sum(abs(hadamard(8) * d(x:x + 7, y:y + 7) * hadamard(8))));
            t = bitshift((t + 2), -2);
            ret = ret + t;
        end
    end
    ret = ret^2;
    % end
end
