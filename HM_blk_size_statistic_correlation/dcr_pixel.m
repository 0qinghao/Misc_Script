% DCR ���·�����ԭʼ��������ƽ��/ƽ����
function ret = dcr_pixel(d)
    t = double(d);

    ret = round((sum(sum(t))^2) / sum(sum(t.^2)));
end
