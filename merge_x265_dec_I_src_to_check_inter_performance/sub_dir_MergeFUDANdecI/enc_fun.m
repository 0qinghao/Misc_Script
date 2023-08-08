function enc = enc_fun
    enc.x265_enc = @x265_enc;
    enc.molchip_enc = @molchip_enc;
    enc.FH_dec = @FH_dec;
    enc.fudan_dec = @fudan_dec;
end

function cmdout = FH_dec(file_name, qp)
    wh_cell = regexp(file_name, '\d+x\d+', 'match');
    wh = str2double((strsplit(wh_cell{1}, 'x')));
    w = wh(1);
    h = wh(2);
    full_name = strcat("T:\Derek.You\ThirdPartyRef\FIXQP\H265_Fix_2022_09_15\", file_name, "\", file_name, "_blk_qp", num2str(qp), "_FH.h265");

    cmd_str = strcat("ffmpeg ", " -i ", full_name, " -vframes 1 ", strcat(file_name, "_qp", num2str(qp), "_FHdec.yuv -y"));
    cmd_str
    [~, cmdout] = system(cmd_str);
end

function cmdout = fudan_dec(file_name, qp)
    wh_cell = regexp(file_name, '\d+x\d+', 'match');
    wh = str2double((strsplit(wh_cell{1}, 'x')));
    w = wh(1);
    h = wh(2);
    full_name = strcat("D:\FUDAN_sessionTest0510\dump_all_22-47_300f\", file_name, "_", num2str(qp), "_ENC.h265");

    cmd_str = strcat("ffmpeg ", " -i ", full_name, " -vframes 1 ", strcat(file_name, "_qp", num2str(qp), "_fudandec.yuv -y"));
    cmd_str
    [~, cmdout] = system(cmd_str);
end

function cmdout = x265_enc(full_name, qp)
    file_name_cell = regexp(full_name, '(?<=\\).*(?=\.yuv)', 'match');
    file_name_aggressive = (strsplit(file_name_cell{1}, '\'));
    file_name = file_name_aggressive{end};

    wh_cell = regexp(full_name, '\d+x\d+', 'match');
    wh = str2double((strsplit(wh_cell{1}, 'x')));
    w = wh(1);
    h = wh(2);

    cmd_str = strcat("x265.exe ", " --qp ", num2str(qp), " --ipratio 1 --aq-mode 0 --rdoq-level 0 --frame-threads 1 --preset veryfast --input ", full_name, " --fps 25 --keyint 50 --input-res ", num2str(w), "x", num2str(h), " --seek 0 -f 50 --rd 1 --ctu 32 --no-wpp --bframes 0 --ref 1 --profile main --slices 1 --no-scenecut --tune psnr --psnr --no-progress -o ", file_name, "_qp", num2str(qp), "_x265.h265 ", " --recon ", file_name, "_qp", num2str(qp), "_x265rec.yuv");
    cmd_str
    [~, cmdout] = system(cmd_str);
end

function cmdout = molchip_enc(full_name, qp, b_is_enc_merged_yuv)
    file_name_cell = regexp(full_name, '(?<=\\).*(?=\.yuv)', 'match');
    file_name_aggressive = (strsplit(file_name_cell{1}, '\'));
    file_name = file_name_aggressive{end};

    wh_cell = regexp(full_name, '\d+x\d+', 'match');
    wh = str2double((strsplit(wh_cell{1}, 'x')));
    w = wh(1);
    h = wh(2);

    if (b_is_enc_merged_yuv)
        cmd_str = strcat("HEVC_encoder_I0qp.exe ", " -qp ", num2str(qp), " -rc 0 -tx 0 -i ", full_name, " -w ", num2str(w), " -h ", num2str(h), " -f 50 -gop 50");
        bs_name = strcat(file_name, "_qp", num2str(qp), "_molchipI0qp.h265");
        yuv_name = strcat(file_name, "_qp", num2str(qp), "_molchiprecI0qp.yuv");
    else
        cmd_str = strcat("HEVC_encoder.exe ", " -qp ", num2str(qp), " -rc 0 -tx 0 -i ", full_name, " -w ", num2str(w), " -h ", num2str(h), " -f 50 -gop 50");
        bs_name = strcat(file_name, "_qp", num2str(qp), "_molchip.h265");
        yuv_name = strcat(file_name, "_qp", num2str(qp), "_molchiprec.yuv");
    end
    cmd_str

    [~, cmdout] = system(cmd_str);
    movefile("test_enc.h265", bs_name);
    % movefile("test_rec.yuv", yuv_name);
    delete test_rec.yuv
    delete stats_out.*
end
