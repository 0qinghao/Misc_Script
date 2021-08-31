function ret = sad(d)
    [n, ~] = size(d);

    % if (n == 8)
    %     ret = sum(sum(abs(hadamard(8) * d * hadamard(8))));
    %     ret = bitshift((ret + 2), -2);
    % else if (n == 16)
    ret = 0;
    for x = 1:8:n
        for y = 1:8:n
            ret = sum(sum(abs(d(x:x + 7, y:y + 7))));
        end
    end
    % end
end
