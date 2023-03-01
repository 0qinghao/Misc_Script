function [y32] = get_xy_32_y(y_full,x,y,cnt)
    y32 = zeros(32,32,cnt);
    y32 = uint8(y32);
    for f=1:cnt
       y_curr_f = y_full(:,:,f);
       y32(:,:,f) = y_curr_f(x:x+31,y:y+31);
    end
end

