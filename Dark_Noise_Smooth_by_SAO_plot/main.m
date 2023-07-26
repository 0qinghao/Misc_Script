% src = "D:\FH420_300f\indoor_54db_wdroff_NR45_8fps_8M_1920x1088.yuv";
% enc = "D:\se01_run_enc_script\Result_2022_11_25_2010 1123 Dark0 SAO1\indoor_54db_wdroff_NR45_8fps_8M_1920x1088\indoor_54db_wdroff_NR45_8fps_8M_1920x1088_cbr_2M.yuv";
src = "D:\Misc_Script\repeat_1_frm_n_times\NR45_repeat_1st_frame.yuv";
enc = "D:\Misc_Script\repeat_1_frm_n_times\NR45_dec.yuv";
nframe = 20;

[src_y_full,~,~] = yuvRead(src,1920,1088,nframe);
[enc_y_full,~,~] = yuvRead(enc,1920,1088,nframe);

src_y32 = get_xy_32_y(src_y_full,64+1,128+1,nframe);
enc_y32 = get_xy_32_y(enc_y_full,64+1,128+1,nframe);

[xm,ym]=meshgrid(0:31);
x1=xm(:);
y1=ym(:);

h=figure;
annotation(h,'textbox',...
    [0.8 0.8 0.1 0.1],...
    'String',['散点：source Y',sprintf('\n'),'曲面：encoded Y'],...
    'FitBoxToText','on');
pause

for i=1:nframe
    z=src_y32(:,:,i);
    z1=z(:);
    c=z1;
    scatter3(x1,y1,z1,50,c,'.');
%     title(strcat("NR45 序列某高暗噪 CTU 连续 skip 并经 SAO 调整后变平滑示意 Frame",num2str(i)),"fontsize",15);
    sad = sum(sum(abs(double(src_y32(:,:,i))-double(enc_y32(:,:,i)))^2));
    title(strcat("Frame",num2str(i)," SSD=",num2str(sad)),"fontsize",15);
    xlabel("row");
    ylabel("col");
    zlabel("Y value");
    xlim([0,31]);ylim([0,31]);zlim([10,250]);grid on;
    view([-32,21]);
    hold on;
    mesh(xm,ym,enc_y32(:,:,i));
    hold off;
    pause
    saveas(gcf,strcat(num2str(i),".png"))
end