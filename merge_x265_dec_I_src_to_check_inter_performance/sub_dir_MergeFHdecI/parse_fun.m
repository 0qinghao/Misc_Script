function parse=parse_fun
parse.parse_x265_out=@parse_x265_out;
parse.parse_molchip_out=@parse_molchip_out;
end

function [bitrateP, psnrP] = parse_x265_out(cmdout)
    bitrateP_cell = regexp(cmdout, '(?<=x265 \[info\]: frame P:.*kb/s: )[\d\.]+', 'match');
    bitrateP = str2num(bitrateP_cell{1}) * 1024;
    
    PSNR_PY_cell = regexp(cmdout, '(?<=x265 \[info\]: frame P:.*Y:)[\d\.]+', 'match');
    PSNR_PU_cell = regexp(cmdout, '(?<=x265 \[info\]: frame P:.*U:)[\d\.]+', 'match');
    PSNR_PV_cell = regexp(cmdout, '(?<=x265 \[info\]: frame P:.*V:)[\d\.]+', 'match');
    PSNR_PY = str2num(PSNR_PY_cell{1});
    PSNR_PU = str2num(PSNR_PU_cell{1});
    PSNR_PV = str2num(PSNR_PV_cell{1});
    
    psnrP = (6*PSNR_PY + PSNR_PU + PSNR_PV) / 8;
end

function [bitrateP, psnrP] = parse_molchip_out(cmdout)
    bit_cell = regexp(cmdout, '(?<=No.\d+ Frame:+.*)\d+(?=\ bits)', 'match');
    for i=1:50
       bit(i) = str2num(bit_cell{i}); 
    end
    bitrateP = sum(bit(2:50))/49*25;
    
    PSNR_Y_cell = regexp(cmdout, '(?<=psnr_y: )[\d\.]+(?=.*Dist)', 'match');
    PSNR_U_cell = regexp(cmdout, '(?<=psnr_u: )[\d\.]+(?=.*Dist)', 'match');
    PSNR_V_cell = regexp(cmdout, '(?<=psnr_v: )[\d\.]+(?=.*Dist)', 'match');    
    for i=1:50
       PSNR_Y(i) = str2num(PSNR_Y_cell{i}); 
       PSNR_U(i) = str2num(PSNR_U_cell{i}); 
       PSNR_V(i) = str2num(PSNR_V_cell{i}); 
    end
    
    psnrP = (sum(PSNR_Y(2:50))*6+sum(PSNR_U(2:50))+sum(PSNR_V(2:50)))/49/8;
end