% x265 src: lambda2 = 0.038 * exp(0.234 * QP)

qp = 0:51;

lambda2_src = 0.038 .* exp(0.234 .* qp);
lambda2_src = round(lambda2_src * 256);

% lambda2_t3 = 0.038 .* exp(0.225 .* qp);
% lambda2_t3 = round(lambda2_t3 * 256);

lambda2_tn = 0.076 .* exp(0.234 .* qp);
lambda2_tn = round(lambda2_tn * 256);

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