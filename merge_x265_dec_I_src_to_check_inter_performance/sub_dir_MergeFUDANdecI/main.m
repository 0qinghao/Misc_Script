clear
parse = parse_fun;
enc = enc_fun;

srclist = {
           "E:\src_yuv\mc_test_all\hk_floor_12M_1920x1088.yuv", ...
               "E:\src_yuv\mc_test_all\case025_1920x1088_12b_34425_car1_1000frames.yuv", ...
               "E:\src_yuv\mc_test_all\question_mosaic_0_1920x1088_1026frames.yuv", ...
               "E:\src_yuv\mc_test_all\HL_day_asphalt_road_265_16M_1920x1088_729frames.yuv", ...
               "E:\src_yuv\mc_test_all\9_indoor_day_canteen_1920x1088.yuv", ...
               "E:\src_yuv\mc_test_all\1_outdoor_day_cross_1920x1088.yuv", ...
               "E:\src_yuv\mc_test_all\BasketballDrive_1920x1088_50.yuv", ...
               "E:\src_yuv\mc_test_all\Kimono_1920x1088_24.yuv", ...
               "E:\src_yuv\mc_test_all\ParkScene_1920x1088_24.yuv", ...
               "E:\src_yuv\mc_test_all\Tennis_1920x1088_24.yuv"
           };

% src_fullname = "E:\src_yuv\mc_test_all\hk_floor_12M_1920x1088.yuv";
% qp = 37;

cnt = 0;
for i = 1:length(srclist)
    for qp = 22:5:47
        cnt = cnt + 1;

        src_fullname = srclist{i};

        % get yuv name w h etc
        file_name_cell = regexp(src_fullname, '(?<=\\).*(?=\.yuv)', 'match');
        file_name_aggressive = (strsplit(file_name_cell{1}, '\'));
        file_name = file_name_aggressive{end};
        wh_cell = regexp(src_fullname, '\d+x\d+', 'match');
        wh = str2double((strsplit(wh_cell{1}, 'x')));
        w = wh(1);
        h = wh(2);
        file_name_log{cnt} = file_name;
        qp_log(cnt) = qp;

        % FH 解码第一帧
        % cmdout_FH{cnt} = enc.FH_dec(file_name, qp);
        %         [bitrate_P_FH(cnt), psnr_P_FH(cnt)] = parse.parse_FH_out(cmdout_FH{cnt});

        % fudan 解码第一帧
        cmdout_fudan{cnt} = enc.fudan_dec(file_name, qp);

        % 拼接 FH dec I frame / src other frame
        % replace_1st_f(strcat(file_name, "_qp", num2str(qp), "_FHdec.yuv"), src_fullname);

        % 拼接 fudan dec I frame / src other frame
        replace_1st_f(strcat(file_name, "_qp", num2str(qp), "_fudandec.yuv"), src_fullname);

        % molchip 原始性能
        cmdout_molchip{cnt} = enc.molchip_enc(src_fullname, qp, 0);
        [bitrate_P_molchip(cnt), psnr_P_molchip(cnt)] = parse.parse_molchip_out(cmdout_molchip{cnt});

        % molchip 如果拥有 FH I 帧编码能力的性能
        % cmdout_molchip_FHdec1{cnt} = enc.molchip_enc(strcat(pwd, "\", file_name, "_qp", num2str(qp), "_FHdec1src2toend.yuv"), qp, 1);
        % [bitrate_P_molchip_FHdec1(cnt), psnr_P_molchip_FHdec1(cnt)] = parse.parse_molchip_out(cmdout_molchip_FHdec1{cnt});

        % molchip 如果拥有 fudan I 帧编码能力的性能
        cmdout_molchip_fudandec1{cnt} = enc.molchip_enc(strcat(pwd, "\", file_name, "_qp", num2str(qp), "_fudandec1src2toend.yuv"), qp, 1);
        [bitrate_P_molchip_fudandec1(cnt), psnr_P_molchip_fudandec1(cnt)] = parse.parse_molchip_out(cmdout_molchip_fudandec1{cnt});
    end
end

% T = table(file_name_log', qp_log', bitrate_P_molchip', psnr_P_molchip', bitrate_P_molchip_FHdec1', psnr_P_molchip_FHdec1');
% varNames = {'file_name', 'qp', 'bitrate_P_molchip', 'psnr_P_molchip', 'bitrate_P_molchip_FHdec1', 'psnr_P_molchip_FHdec1'};
T = table(file_name_log', qp_log', bitrate_P_molchip', psnr_P_molchip', bitrate_P_molchip_fudandec1', psnr_P_molchip_fudandec1');
varNames = {'file_name', 'qp', 'bitrate_P_molchip', 'psnr_P_molchip', 'bitrate_P_molchip_fudandec1', 'psnr_P_molchip_fudandec1'};
T.Properties.VariableNames = varNames;
writetable(T, 'check_molchip_inter_performance.csv', 'WriteRowNames', true);
save('check_molchip_inter_performance.mat');
