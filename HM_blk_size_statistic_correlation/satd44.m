function ret = satd44(d)
    [n, ~] = size(d);

    ret = 0;
    for x = 1:4:n
        for y = 1:4:n
            t = sum(sum(abs(hadamard(4) * d(x:x + 3, y:y + 3) * hadamard(4))));
            t = bitshift((t + 1), -1);
            ret = ret + t;
        end
    end
end
