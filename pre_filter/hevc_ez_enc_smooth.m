function out = hevc_ez_enc_smooth(in)
    in = double(in);
    out = in;
    [h, w] = size(in);

    for i = 33:32:h-32
        for j = 33:32:w
            ref = [in(i-1,j:j+31),in(i:i+31,j-1)'];
            
            pred_dc = round(mean(ref));
            sad = sum(abs(pred_dc-in(i:i+31,j:j+31)),[1,2]);
            if (sad <= 32*32*6)
                out(i:i+31,j:j+31) = round((pred_dc+in(i:i+31,j:j+31))/2);
            end
%             if (in(i, j) < min(in(i - 1, j), in(i, j - 1)))
%                 out(i, j) = (max(in(i - 1, j), in(i, j - 1)));
%             elseif (in(i, j) > max(in(i - 1, j), in(i, j - 1)))
%                 out(i, j) = (min(in(i - 1, j), in(i, j - 1)));
%             else
%                 out(i, j) = (in(i - 1, j) + in(i, j - 1) - in(i - 1, j - 1));
%             end
        end
    end

    out = uint8(out);
end
