function out = L_edge(in)
    in = double(in);
    out = in;
    [h, w] = size(in);

    for i = 2:h-1
        for j = 2:w-1
            out(i,j) = abs(sum(in(i-1:i+1,j-1:j+1) .* [1,1,1;1,-8,1;1,1,1],[1,2]));
        end
    end

    out = uint8(out);
end
