function out = L_edge_blk(in)
    in = double(in);
    out = in;
    [h, w] = size(in);

    for i = 2:h-1
        for j = 2:w-1
            out(i,j) = abs(sum(in(i-1:i+1,j-1:j+1) .* [1,1,1;1,-8,1;1,1,1],[1,2]));
        end
    end
    
    for i = 9:8:h-8
        for j = 9:8:w-8
            out(i:i+7,j:j+7) = mean(out(i:i+7,j:j+7),[1,2]);
        end
    end

    out = uint8(out);
end
