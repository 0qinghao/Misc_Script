vid="\\public\tpr\Derek.You\YUV_Sequence\420\hk_floor_12M_1920x1088.yuv";
[y, u, v] = yuvRead(vid, 1920, 1088, 1);
in = double(y);
out = in;
[hh, ww] = size(in);

% 处理 space 权重和 tonal 权重
L=9; scale=256;
xs=linspace(0,3,1e5);ys = normpdf(xs,0,0.4*1.1^(min(9,L)-4));
xt=linspace(0,20,1e5);yt = normpdf(xt,0,15+6*(max(9,L)-9));
[~,I(1)]=min(abs(xs-0));[~,I(2)]=min(abs(xs-1));[~,I(3)]=min(abs(xs-sqrt(2))); Ws = round(ys(I(1:3))*scale);
clear I
for i=0:31
    [~,I(i+1)]=min(abs(xt-i));
end
Wt = round(yt(I(:))*scale);

Ws_3x3 = [Ws(3),Ws(2),Ws(3);
          Ws(2),Ws(1),Ws(2);
          Ws(3),Ws(2),Ws(3)
];
% 
% for h = 1:32:hh
%     for w = 1:32:ww
%         mat32 = in(h:h+31,w:w+31);
%         mat32_out = mat32;
%         for i = 2:31
%             for j = 2:31
%                 diff = abs(mat32(i-1:i+1,j-1:j+1) - mat32(i,j));
%                 diff(diff>15)=15;
%                 Wt_3x3 = Wt(diff+1);
%                 
%                 Wst = Wt_3x3 .* Ws_3x3;
%                 Wst_s = sum(Wst,[1,2]);
%                 
%                 mat32_out(i,j) = round(sum(Wst .* mat32(i-1:i+1,j-1:j+1), [1,2]) / Wst_s);
%             end
%         end
%         out(h:h+31,w:w+31) = mat32_out;
%     end
% end
% 
% out = uint8(out);
% fid = fopen('filtered.yuv', 'w');
% fwrite(fid, out');
% fclose(fid);