% 先转 hadamard 域，然后计算部分频率之和
function partF = satd_partF(d)
    d = double(d);
    [n, ~] = size(d);
    partF = 0;
    ff = 65535;
    for x = 1:8:n
        for y = 1:8:n
            t(x:x + 7, y:y + 7) = abs(hadamard(8) * d(x:x + 7, y:y + 7) * hadamard(8));
            % partF = partF + t(x, y)^2;
            % mask = [
            %     0, 0, 0, 0, 0, 0, 0, 0;
            %     0, ff, ff, ff, 0, ff, ff, ff;
            %     0, ff, 0, 0, 0, ff, 0, 0;
            %     0, ff, 0, 0, 0, ff, 0, 0;
            %     0, 0, 0, 0, 0, 0, 0, 0;
            %     0, ff, ff, ff, 0, ff, ff, ff;
            %     0, ff, 0, 0, 0, ff, 0, 0;
            %     0, ff, 0, 0, 0, ff, 0, 0;
            %     ];
            % mask = [
            %     ff, ff, ff, ff, ff, ff, ff, ff;
            %     ff, 00, 00, 00, ff, 00, 00, 00;
            %     ff, 00, ff, ff, ff, 00, ff, ff;
            %     ff, 00, ff, ff, ff, 00, ff, ff;
            %     ff, ff, ff, ff, ff, ff, ff, ff;
            %     ff, 00, 00, 00, ff, 00, 00, 00;
            %     ff, 00, ff, ff, ff, 00, ff, ff;
            %     ff, 00, ff, ff, ff, 00, ff, ff;
            %     ];
            % mask = [
            %     ff, ff, ff, ff, ff, ff, ff, ff;
            %     ff, 0, 0, 0, 0, 0, 0, 0;
            %     ff, 0, 0, 0, 0, 0, 0, 0;
            %     ff, 0, 0, 0, 0, 0, 0, 0;
            %     ff, 0, 0, 0, 0, 0, 0, 0;
            %     ff, 0, 0, 0, 0, 0, 0, 0;
            %     ff, 0, 0, 0, 0, 0, 0, 0;
            %     ff, 0, 0, 0, 0, 0, 0, 0;
            %     ];
            mask = [
                ff, ff, ff, ff, ff, ff, ff, ff;
                ff, ff, ff, ff, ff, ff, ff, 00;
                ff, ff, ff, ff, ff, ff, 00, 00;
                ff, ff, ff, ff, ff, 00, 00, 00;
                ff, ff, ff, ff, 00, 00, 00, 00;
                ff, ff, ff, 00, 00, 00, 00, 00;
                ff, ff, 00, 00, 00, 00, 00, 00;
                ff, 00, 00, 00, 00, 00, 00, 00;
                ];
            partF = partF + sum(sum(bitand(mask, t(x:x + 7, y:y + 7))));
        end
    end
end
