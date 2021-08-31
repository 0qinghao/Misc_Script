function ret = satd_dct(d)
    [n, ~] = size(d);

    % if (n == 8)
    %     ret = sum(sum(abs(hadamard(8) * d * hadamard(8))));
    %     ret = bitshift((ret + 2), -2);
    % else if (n == 16)
    ret = 0;
    for x = 1:8:n
        for y = 1:8:n
            t = sum(sum(abs(round(dct2(d(x:x + 7, y:y + 7))))));
            % t = bitshift((t + 2), -2);
            ret = ret + t;
        end
    end
    % end
end
