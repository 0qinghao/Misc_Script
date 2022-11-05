Q = 36;

r = round((rand(16)*20-10));

r_T16_Q = round(dct(r) / Q);

r_T8_Q(1:8,1:8) = round(dct(r(1:8,1:8)) / Q);
r_T8_Q(1:8,9:16) = round(dct(r(1:8,9:16)) / Q);
r_T8_Q(9:16,1:8) = round(dct(r(9:16,1:8)) / Q);
r_T8_Q(9:16,9:16) = round(dct(r(9:16,9:16)) / Q);

r
r_T16_Q
r_T8_Q_stack = r_T8_Q