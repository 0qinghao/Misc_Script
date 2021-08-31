function ret = blk_sobel_ana(G)
    % TH = 20;
    % ret = sum(G > TH, 'all');
    ret = sum(G, 'all');
end
