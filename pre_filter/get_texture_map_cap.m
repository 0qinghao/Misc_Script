function texture_map = get_texture_map_cap(in, Th_pow)
    in = double(in);
    texture_map = zeros(size(in));
    g_image = zeros(size(in));

    M_cap = [1,1,1;1,-8,1;1,1,1];

    for i = 1:size(in, 1) - 2
        for j = 1:size(in, 2) - 2          
            Gxy(i + 1, j + 1) = (sum(sum(M_cap .* in(i:i + 2, j:j + 2))));
        end
    end
    
    texture_map = abs(Gxy);
end
