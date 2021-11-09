[y, u, v] = yuvRead('./356x288.yuv', 356, 288, 1);

[height, width] = size(y);

mode_cnt = zeros(1, 9);

for w = 1:64:width - 64
    for h = 2:height - 1
        ref = double(y(h - 1, w:w + 63, 1));
        dst = double(y(h, w:w + 63, 1));

        dist_dc = pred_dc(ref, dst);
        dist_dcinv = pred_invdc(ref, dst);
        dist_ver = pred_ver(ref, dst);
        dist_121 = pred_121(ref, dst);
        dist_l2 = pred_l2(ref, dst);
        dist_l1 = pred_l1(ref, dst);
        dist_r1 = pred_r1(ref, dst);
        dist_r2 = pred_r2(ref, dst);
        if (w == 1)
            left = 128;
        else
            left = double(y(h, w - 1, 1));
        end
        dist_MED = pred_MED(ref, dst, left);

        dist_mat = [dist_dc, dist_dcinv, dist_ver, dist_121, dist_l2, dist_l1, dist_r1, dist_r2, dist_MED];

        mode_cnt = mode_cnt + (min(dist_mat) == dist_mat);
    end
end

function dist = pred_dc(ref, dst)
    pred = bitshift((sum(ref) + 32), -6);
    dist = sum(abs(dst - pred));
end

function dist = pred_invdc(ref, dst)
    pred = 256 - bitshift((sum(ref) + 32), -6);
    dist = sum(abs(dst - pred));
end

function dist = pred_ver(ref, dst)
    pred = ref;
    dist = sum(abs(dst - pred));
end

function dist = pred_121(ref, dst)
    pred = ref;
    pred(1) = bitshift(ref(1) * 3 + ref(2) + 2, -2);
    pred(end) = bitshift(ref(end) * 3 + ref(end - 1) + 2, -2);
    pred(2:end - 1) = bitshift(ref(1:end - 2) + 2 * ref(2:end - 1) + ref(3:end) + 2, -2);
    dist = sum(abs(dst - pred));
end

function dist = pred_l2(ref, dst)
    pred = ref;
    pred(1:2) = ref(1);
    pred(3:end) = ref(1:end - 2);
    dist = sum(abs(dst - pred));
end

function dist = pred_l1(ref, dst)
    pred = ref;
    pred(1) = ref(1);
    pred(2:end) = ref(1:end - 1);
    dist = sum(abs(dst - pred));
end

function dist = pred_r1(ref, dst)
    pred = ref;
    pred(end) = ref(end);
    pred(1:end - 1) = ref(2:end);
    dist = sum(abs(dst - pred));
end

function dist = pred_r2(ref, dst)
    pred = ref;
    pred(end - 1:end) = ref(end);
    pred(1:end - 2) = ref(3:end);
    dist = sum(abs(dst - pred));
end

function dist = pred_MED(ref, dst, left)
    pred = ref;
    for i = 2:64
        top = ref(i);
        topleft = ref(i - 1);
        % left = dst(i - 1);
        if (topleft > top && topleft > left)
            pred(i) = min(top, left);
        elseif (topleft < top && topleft < left)
            pred(i) = max(top, left);
        else
            pred(i) = top + left - topleft;
        end
    end
    pred(1) = ref(1);
    dist = sum(abs(dst - pred));
end
