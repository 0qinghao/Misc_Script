% x265 src: lambda2 = 0.038 * exp(0.234 * QP)
% hm src: lambda = Factor(0.5左右) * pow(2,(qp-12)/3) (P帧还会再扩(qp-12)/6倍,clip到2~4)

qp = 0:51;

lambda2_src = 0.038 .* exp(0.234 .* qp);
lambda2_src = round(lambda2_src * 256);
 
% lambda2_tn = 0.01 .* exp(0.2 .* qp);
% lambda2_tn = round(lambda2_tn * 256);

lambda2_tn = 0.74 * 0.5 * 2 .^ (max(0,(qp-12))/3) .* min(max((qp+4)/8,2),4);
lambda2_tn = round(lambda2_tn*256);

fprintf('{\n')
for i=1:52
    fprintf('%10d', lambda2_tn(i));
    if(i~=52)
        fprintf(',');
    end
    if(mod(i,5)==0 || i==52)
        fprintf('\n');
    end
end
fprintf('}\n');

plot(qp,lambda2_src,'g',qp,lambda2_tn,'r')