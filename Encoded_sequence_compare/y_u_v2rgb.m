function rgb = y_u_v2rgb(y,u,v)
    [w,h] = size(y);
    
    y = uint8(y);
    u_ex = zeros(w,h);
    u_ex(1:2:w,1:2:h) = uint8(u);
    u_ex(1:2:w,2:2:h) = uint8(u);
    u_ex(2:2:w,1:2:h) = uint8(u);
    u_ex(2:2:w,2:2:h) = uint8(u);
    v_ex = zeros(w,h);
    v_ex(1:2:w,1:2:h) = uint8(v);
    v_ex(1:2:w,2:2:h) = uint8(v);
    v_ex(2:2:w,1:2:h) = uint8(v);
    v_ex(2:2:w,2:2:h) = uint8(v);
    
    yuv_ex(:,:,1) = y;
    yuv_ex(:,:,2) = u_ex;
    yuv_ex(:,:,3) = v_ex;
    
    rgb = ycbcr2rgb(yuv_ex);
end