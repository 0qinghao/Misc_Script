fw = fopen('random.raw', 'wb');

output_w = 1920;
output_h = 1080;

cnt = 0;
while (cnt < output_h * output_w)
    val = uint16(rand()*2^12-1);
    fwrite(fw, val, '*ubit16');
    cnt = cnt+1;
end

fclose(fw);
