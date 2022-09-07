vid = './1_01_R_20220304201712_avi.yuv';
f_cnt = 100;

[y, u, v] = yuvRead(vid, 1920, 1080, f_cnt);
y = double(y); u = double(u); v = double(v);
y_f = y; u_f = u; v_f = v;

for f=2:f_cnt
    for w=2:1920-1
        for h=2:1080-1
            window_curr = y(h-1:h+1,w-1:w+1,f); 
%             window_curr = y(h-1:h,w-1:w,f); 
            window_diff = abs(y_f(h,w,f-1) - window_curr); 
            [M,I] = min(window_diff(:));
            y_f(h,w,f) = window_curr(I);
        end
    end
end
% for f=2:f_cnt
%     for w=2:1920/2-1
%         for h=2:1088/2-1
%             window_curr = u(h-1:h+1,w-1:w+1,f); 
% %             window_curr = u(h-1:h,w-1:w,f); 
%             window_diff = abs(u_f(h,w,f-1) - window_curr); 
%             [M,I] = min(window_diff(:));
%             u_f(h,w,f) = window_curr(I);
%             
%             window_curr = v(h-1:h+1,w-1:w+1,f); 
% %             window_curr = v(h-1:h,w-1:w,f); 
%             window_diff = abs(v_f(h,w,f-1) - window_curr); 
%             [M,I] = min(window_diff(:));
%             v_f(h,w,f) = window_curr(I);
%         end
%     end
% end

y_f = uint8(y_f);

fid = fopen('filtered.yuv', 'w');
for f=1:f_cnt
    fwrite(fid, y_f(:,:,f)');
%     fwrite(fid, u_f(:,:,f)');
%     fwrite(fid, v_f(:,:,f)');
end
fclose(fid);
