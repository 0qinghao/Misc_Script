T = [85,171,200];
scaleT = [26214, 23302, 20560, 18396, 16384, 14564];
qbitsT = 16:27;
lut_val = zeros(6,12,3);

for d1 = 1:3
    for d2 = 1:6
        for d3 = 1:12
            add = T(d1);
            scale = scaleT(d2);
            qbits = qbitsT(d3);
            lut_val(d2,d3,d1) = round((2^(qbits)-add*2^(qbits-9))/scale);
        end
    end
end