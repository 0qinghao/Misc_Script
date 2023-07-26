
function generate_bar_hor(unit_pix, img_w, img_h, rep_f)
    sum_x = ceil(img_w / unit_pix);
    sum_y = ceil(img_h / unit_pix);
    
    img_w_up = sum_x * unit_pix;
    img_h_up = sum_y * unit_pix;
    
    Y = zeros(img_w_up,img_h_up);
    U = zeros(ceil(img_w_up/2),ceil(img_h_up/2));
    V = zeros(ceil(img_w_up/2),ceil(img_h_up/2));
    
    for i = 1:unit_pix:img_h
        for j = 1:unit_pix:img_w
%             oe_x = bitand(round(j / unit_pix), 1);
            oe_y = bitand(round(i / unit_pix), 1);
            if (oe_y == 0)
                val_y = 255;
                val_u = 128;
                val_v = 128;
            else
                val_y = 0;
                val_u = 128;
                val_v = 128;
            end
            Y(i:i+unit_pix-1,j:j+unit_pix-1) = val_y;
            U(ceil((i+1)/2):ceil((i+unit_pix-1)/2),ceil((j+1)/2):ceil((j+unit_pix-1)/2)) = val_u;
            V(ceil((i+1)/2):ceil((i+unit_pix-1)/2),ceil((j+1)/2):ceil((j+unit_pix-1)/2)) = val_v;
        end
    end
    
    Y = Y(1:img_h,1:img_w); Y=Y';
    U = U(1:img_h/2,1:img_w/2); U=U';
    V = V(1:img_h/2,1:img_w/2); V=V';
    
    YUV = [Y(:);U(:);V(:)];
    fid = fopen('bar_hor.yuv', 'w');
    for i=1:rep_f
        fwrite(fid, uint8(YUV));
    end
    fclose(fid);
end