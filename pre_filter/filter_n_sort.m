% vid="D:\global_mv_seq\5f_clip\BasketballDrive_1920x1088_50_5f.yuv";
vid="D:\FH420_300f\case025_1920x1088_12b_34425_car1_1000frames.yuv";
[y, u, v] = yuvRead(vid, 1920, 1088, 1);
in = double(y);
out = in;
[h, w] = size(in);

edge_strength = double(L_edge_blk(y));
fid = fopen('edge_strength.yuv', 'w');
fwrite(fid, edge_strength');
fclose(fid);

TH1 = 48; TH2 = 96; TH3 = 128;

for i = 5:4:h-4
    for j = 5:4:w-4
        t_strength = edge_strength(i:i+3,j:j+3);
        t_src = in(i:i+3,j:j+3);
        
        s_avg = mean(t_strength,[1,2]);
        s_max = max(max(t_strength));
        
        if (s_avg < TH1)%% && s_max < TH2)
            out(i:i+3,j:j+3) = round(mean(t_src,[1,2]));
%             for x = i:i+3
%                 for y = j:j+3
%                     out(x,y) = sum(sum(in(x-1:x+1,y-1:y+1) .* [1,1,1;1,1,1;1,1,1]))/9;
%                 end
%             end
        elseif (s_avg < TH2)%%1 && s_max > TH2)
            for x = i:i+3
                for y = j:j+3
                    out(x,y) = round(sum(sum(in(x-1:x+1,y-1:y+1) .* [1,2,1;2,4,2;1,2,1]))/16);
                end
            end
        elseif (s_avg < TH3)%% > TH1 && s_max < TH3)
            ;
        else
%             for x = i:i+3
%                 for y = j:j+3
%                     out(x,y) = round(sum(sum(in(x-1:x+1,y-1:y+1) .* [0,-1,0;-1,5,-1;0,-1,0])));
%                 end
%             end
        end
    end
end

out = uint8(out);
fid = fopen('filtered.yuv', 'w');
fwrite(fid, out');
fclose(fid);