fr = fopen('scene_halogen_3ms_7.raw16');
fw = fopen('reorder.raw', 'wb');
src_w = 4096;

output_start_w = 272;
output_start_h = 103;
fread(fr, output_start_w+src_w*output_start_h, '*ubit16');
output_w = 1920;
output_h = 1080;

cnt = 0;
while (cnt < output_h * output_w)
    val = fread(fr, 1, '*ubit16');
    val_0ABC = bitshift(val, -4);
    fwrite(fw, val_0ABC, '*ubit16');

    cnt = cnt + 1;
    if (mod(cnt, output_w) == 0)
        fread(fr, src_w - output_w, '*uint16');
    end
end

fclose(fr);
fclose(fw);