% c ģ��ԭʼ����������� 4 �� satd��Ȼ������ dcr ���ȡ������
function ret = satd_dcr_inv(satd4)
    % ret = 64 * (sum(satd4)^2) / sum(satd4.^2);
    ret = 256 * sum(satd4.^2) / (sum(satd4)^2);
end
