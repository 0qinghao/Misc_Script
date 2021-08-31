% ���㷽���� DCR ���ĵ������㣬�����Ա����ģ���Ķ������� hadamard ��
function ret = dcr_hadamard(d)
    d = double(d);
    [n, ~] = size(d);
    ret = 0;
    for x = 1:8:n
        for y = 1:8:n
            t(x:x + 7, y:y + 7) = abs(hadamard(8) * d(x:x + 7, y:y + 7) * hadamard(8));
        end
    end

    ret = round(256 * (sum(sum(t))^2) / sum(sum(t.^2)));
end
