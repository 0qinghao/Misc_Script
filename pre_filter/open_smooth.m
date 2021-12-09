function out = open_smooth(in)
    se = strel('square', 2);
    %     erode = imerode(in, se);
    out = imopen(in, se);
end
