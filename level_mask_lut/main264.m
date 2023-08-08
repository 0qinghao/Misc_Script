q_div6 = 0:8;
q = 0:63;

num = 2.^(15+q_div6)-(bitshift(2796202,-(8-q_div6)));
num_use_tab = bitshift(5592406,-8+floor(q/6));

num_inter = 2.^(15+q_div6)-(bitshift(2796202,-1-(8-q_div6)));
num_use_tab_inter = bitshift(6990507,-8+floor(q/6));

den_tab = [	13107, 8066, 13107, 8066, 8066, 5243, 8066, 5243, 13107, 8066, 13107, 8066, 8066, 5243, 8066, 5243;
            11916, 7490, 11916, 7490, 7490, 4660, 7490, 4660, 11916, 7490, 11916, 7490, 7490, 4660, 7490, 4660;
            10082, 6554, 10082, 6554, 6554, 4194, 6554, 4194, 10082, 6554, 10082, 6554, 6554, 4194, 6554, 4194;
            9362,  5825, 9362, 5825, 5825, 3647, 5825, 3647, 9362, 5825, 9362, 5825, 5825, 3647, 5825, 3647	 ;
            8192,  5243, 8192, 5243, 5243, 3355, 5243, 3355, 8192, 5243, 8192, 5243, 5243, 3355, 5243, 3355	 ;
            7282,  4559, 7282, 4559, 4559, 2893, 4559, 2893, 7282, 4559, 7282, 4559, 4559, 2893, 4559, 2893	 ];
TH_tab = zeros(64,16);

for qp=0:53
    q_per = floor(qp/6);
    q_rem = mod(qp,6);
    i_num_intra = bitshift(5592406,-8+q_per);
    i_num_inter = bitshift(6990507,-8+q_per);
    for i=1:16
        i_den = den_tab(q_rem+1,i);
        TH_tab_intra(qp+1,i) = floor(i_num_intra/i_den);
        TH_tab_inter(qp+1,i) = floor(i_num_inter/i_den);
    end
end

TH_tab_mini_intra = TH_tab_intra(49:54,[1,2,6]);
TH_tab_mini_inter = TH_tab_inter(49:54,[1,2,6]);

% T = [85,171,200];
% scaleT = [26214, 23302, 20560, 18396, 16384, 14564];
% qbitsT = 16:27;
% lut_val = zeros(6,12,3);
% 
% for d1 = 1:3
%     for d2 = 1:6
%         for d3 = 1:12
%             add = T(d1);
%             scale = scaleT(d2);
%             qbits = qbitsT(d3);
%             lut_val(d2,d3,d1) = round((2^(qbits)-add*2^(qbits-9))/scale);
%         end
%     end
% end