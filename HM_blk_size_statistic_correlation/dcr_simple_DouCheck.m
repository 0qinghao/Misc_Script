% c ģ��ԭʼ���������ǹ۲쵽 8x8 �� dcr_simple Ҳ�п��ܴܺ��ټ�һ�� double check ����
function ret = dcr_simple(satd4)
    ret = 64 * (sum(satd4)^2) / sum(satd4.^2);
    satd_std = std(satd4);
    ret = ret + 512 / (satd_std + 1);
end
