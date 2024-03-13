% V=[167 172 177 177 177 172 167 167; 159 163 167 169 172 170 169 169; 162 154 157 162 167 174 172 172; 162 159 157 159 162 167 172 172];
% V=[127 127 130 130 133 133 133 133; 127 128 130 131 133 133 133 133; 133 133 133 131 130 130 130 133; 136 137 133 131 130 130 130 130];
V=[134 134 134 136 139 136 134 134; 134 132 131 133 136 137 139 139; 134 131 129 126 134 139 144 144; 134 131 129 131 134 139 144 144];

grp0_src = V;

grp0_rec=zeros(4,8,50);

clc
for i=1:50
    grp0_src
    
%     if (mod(i,4)==0)
        t_data_for_calc_pred = grp0_src([1,3],1:2:8);
%     elseif (mod(i,4)==1)
%         t_data_for_calc_pred = grp0_src([1,3],2:2:8);
%     elseif (mod(i,4)==2)
%         t_data_for_calc_pred = grp0_src([2,4],1:2:8);
%     elseif (mod(i,4)==3)
%         t_data_for_calc_pred = grp0_src([2,4],2:2:8);
%     end
    
    grp0_pred = floor(mean(t_data_for_calc_pred(:)));

    grp0_res_t = grp0_src - grp0_pred;
    
    grp0_res_sign = double(grp0_res_t>=0);
    grp0_res_sign(grp0_res_sign==0) = -1;
    grp0_res_val = abs(grp0_res_t);
    
    if (mod(i,2))
        add = 16384/2;
    else
        add = 0;
    end

    grp0_res_q = bitshift(grp0_res_val * 8192 + add, -14, 'int32');
    grp0_res_q = grp0_res_q .* grp0_res_sign;
    
    grp0_res_dq = grp0_res_q * 2;

    grp0_rec(:,:,i) = grp0_pred + grp0_res_dq;
    
    grp0_src = grp0_rec(:,:,i);
end

grp0_src - V
sum(abs(grp0_src - V),[1,2])