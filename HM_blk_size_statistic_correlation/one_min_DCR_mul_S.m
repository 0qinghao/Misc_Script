% (1-SATD DCR) * (sum(SATD)^2)
% SATD DCR ���� 4 �� SATD �Ƿ���ȷֲ������ȷֲ��Ļ������ڱ��� 16x16 �飻���� sum SATD pow 2, ���ȵ� 4 ���鶼�ܴ����Ƿ� 8x8 ��
function ret = one_min_DCR_mul_S(satd4)
    ret = (4 - ((sum(satd4)^2) / sum(satd4.^2))) * (sum(satd4)^2) / 1024;
end
