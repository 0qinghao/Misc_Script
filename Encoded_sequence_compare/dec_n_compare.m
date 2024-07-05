bs_folder1 = "D:\Run_Enc_Script\Result_2022_06_01_1145 rc0 txqp0 22-47 isp";
type1 = "使用 dbk 前数据计算 sao";
bs_folder2 = "D:\Run_Enc_Script\Result_2022_06_01_1749 dis sao when dbk bs gt 114-qp";
type2 = "使用 dbk 前数据计算 sao, dbk 强度大时禁用 sao";
bs_folder3 = "D:\Run_Enc_Script\Result_2022_06_13_1951 sao after dbk";
type3 = "dbk 后计算 sao";

yuv_w = 1920;
yuv_h = 1088;
yuv_frames = 50;
compare_size_w = 196;
compare_size_h = 128;
compare_cnt = 4;
diff_TH = 100000;
qp = 42;
ffmpeg_path = "D:\Program Files (x86)\ffmpeg\bin\ffmpeg.exe";

bs_list1 = dir(strcat(bs_folder1, "/**/*qp" + num2str(qp) + ".h265"));
bs_list2 = dir(strcat(bs_folder2, "/**/*qp" + num2str(qp) + ".h265"));
bs_list3 = dir(strcat(bs_folder3, "/**/*qp" + num2str(qp) + ".h265"));
bs_cnt = length(bs_list1);

i = 0;
sample1 = zeros(compare_size_h, compare_size_w, 3, compare_cnt); sample1 = uint8(sample1);
sample2 = zeros(compare_size_h, compare_size_w, 3, compare_cnt); sample2 = uint8(sample2);
sample3 = zeros(compare_size_h, compare_size_w, 3, compare_cnt); sample3 = uint8(sample3);
sample_name = cell(1, compare_cnt);
sample_f = zeros(1, compare_cnt);
sample_x = zeros(1, compare_cnt);
sample_y = zeros(1, compare_cnt);

ts = tight_subplot(compare_cnt,3,[.01 .01],[.1 .01],[.01 .01]);
while (i < compare_cnt)
    rand_seq = randi([1, bs_cnt]);
    rand_f = randi([0, yuv_frames-1]);
    rand_x = randi([0, yuv_w-compare_size_w-1]);
    rand_y = randi([0, yuv_h-compare_size_h-1]);
    cmd1 = """" + ffmpeg_path + """" + " -i """ + bs_list1(rand_seq).folder + "/" + bs_list1(rand_seq).name + """" + " -vf ""select=eq(n\," + num2str(rand_f) + "), crop=" + num2str(compare_size_w) + ":" + num2str(compare_size_h) + ":" + num2str(rand_x) + ":" + num2str(rand_y) + """" + " -pix_fmt yuv420p -y " + num2str(i) + "_bs1_dec" + num2str(compare_size_w) + "x" + num2str(compare_size_h) + ".yuv";
    cmd2 = """" + ffmpeg_path + """" + " -i """ + bs_list2(rand_seq).folder + "/" + bs_list2(rand_seq).name + """" + " -vf ""select=eq(n\," + num2str(rand_f) + "), crop=" + num2str(compare_size_w) + ":" + num2str(compare_size_h) + ":" + num2str(rand_x) + ":" + num2str(rand_y) + """" + " -pix_fmt yuv420p -y " + num2str(i) + "_bs2_dec" + num2str(compare_size_w) + "x" + num2str(compare_size_h) + ".yuv";
    cmd3 = """" + ffmpeg_path + """" + " -i """ + bs_list3(rand_seq).folder + "/" + bs_list3(rand_seq).name + """" + " -vf ""select=eq(n\," + num2str(rand_f) + "), crop=" + num2str(compare_size_w) + ":" + num2str(compare_size_h) + ":" + num2str(rand_x) + ":" + num2str(rand_y) + """" + " -pix_fmt yuv420p -y " + num2str(i) + "_bs3_dec" + num2str(compare_size_w) + "x" + num2str(compare_size_h) + ".yuv";
    system(cmd1); system(cmd2); system(cmd3);
    
    [y1, u1, v1] = yuvRead_2double(num2str(i) + "_bs1_dec" + num2str(compare_size_w) + "x" + num2str(compare_size_h) + ".yuv", compare_size_w, compare_size_h, 1);
    [y2, u2, v2] = yuvRead_2double(num2str(i) + "_bs2_dec" + num2str(compare_size_w) + "x" + num2str(compare_size_h) + ".yuv", compare_size_w, compare_size_h, 1);
    [y3, u3, v3] = yuvRead_2double(num2str(i) + "_bs3_dec" + num2str(compare_size_w) + "x" + num2str(compare_size_h) + ".yuv", compare_size_w, compare_size_h, 1);

%     if(max(max(abs(y1-y2)))>diff_TH)    
    if(sum(abs(y1-y2),[1,2])>diff_TH)
        i = i + 1;
        sample1(:,:,:,i) = y_u_v2rgb(y1,u1,v1);
        sample2(:,:,:,i) = y_u_v2rgb(y2,u2,v2);
        sample3(:,:,:,i) = y_u_v2rgb(y3,u3,v3);
%         sample_name(1, i) = bs_list1(rand_seq).name;
        sample_f(1,i) = rand_f;
        sample_x(1,i) = rand_x;
        sample_y(1,i) = rand_y;
        
        axes(ts((i-1)*3+1))
        imshow(sample1(:,:,:,i));
        axes(ts((i-1)*3+2))
        imshow(sample2(:,:,:,i));
        axes(ts((i-1)*3+3))
        imshow(sample3(:,:,:,i));
    end
end

