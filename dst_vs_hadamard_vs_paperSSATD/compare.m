test_n = 1000;

T_dst = zeros(4, 4, test_n);
s_dst = zeros(1, test_n);
T_hadamard = zeros(4, 4, test_n);
s_hadamard = zeros(1, test_n);
T_paperSSATD = zeros(4, 4, test_n);
s_paperSSATD = zeros(1, test_n);

paperH = [
    0, 1, 1, 1;
    1, 1, 0, -1;
    1, 0, -1, 1;
    1, -1, 1, 0
    ];
% paperH = [
%     1, 1, 1, 1;
%     1, 1, -1, -1;
%     1, -1, -1, 1;
%     1, -1, 1, -1
%     ];
% paperH=[1,1,2,2;
%     2,2,0,-2;
%     2,-1,-2,1;
%     1,-2,2,-1];

[y_res, ~, ~] = yuvRead('D:\FH_HM_MOL_BS\HM_MOLcfg_INTRA_BS\1_outdoor_day_cross_1920x1088_qp37.h265_1920x1088_0_residual.yuv', 1920, 1088, 1);

i = 1;
for x = 1:4:1920 - 3
    for y = 1:4:1088 - 3
        y_sub = y_res(y:y + 3, x:x + 3);
        res = reshape(typecast(y_sub(:), 'int8'), [4, 4]);
        res = double(res);

        T_dst(:, :, i) = dst(res);
%         T_dct(:, :, i) = dct(res);
        T_hadamard(:, :, i) = hadamard(4) * res * hadamard(4)';
        T_paperSSATD(:, :, i) = paperH * res * paperH';
        s_dst(i) = sum(abs(T_dst(:, :, i)), [1, 2]);
%         s_dct(i) = sum(abs(T_dct(:, :, i)), [1, 2]);
        s_hadamard(i) = sum(abs(T_hadamard(:, :, i)), [1, 2]);
        s_paperSSATD(i) = sum(abs(T_paperSSATD(:, :, i)), [1, 2]);

        i = i + 1;
    end
end

modelFun=@(p,x) p(1) .* x;
startingVals=[1];
nlModel1 = fitnlm(s_dst, s_hadamard, modelFun, startingVals)
nlModel2 = fitnlm(s_dst, s_paperSSATD, modelFun, startingVals)
% nlModel1 = fitnlm(s_dct, s_hadamard, modelFun, startingVals)
% nlModel2 = fitnlm(s_dct, s_paperSSATD, modelFun, startingVals)
xgrid = linspace(0,5000,10000)';

subplot(1, 2, 1)
plot(s_dst, s_hadamard, '.');
% plot(s_dct, s_hadamard, '.');
line(xgrid, predict(nlModel1,xgrid), 'Color', 'r');
xlim([0, 3500]);
ylim([0, 7000]);
subplot(1, 2, 2)
plot(s_dst, s_paperSSATD, '.');
% plot(s_dct, s_paperSSATD, '.');
line(xgrid, predict(nlModel2,xgrid), 'Color', 'g');
xlim([0, 3500]);
ylim([0, 7000]);
