% 生成高频图像 tv1
tv1 = zeros(8);tv1(2:2:8,2:2:8)=ones(4);tv1(1:2:8,1:2:8)=ones(4);
tv1 = tv1 * 255

% DCT 测试 tv1 确实为高频信号
round(dct2(tv1))

% hadmard 变换测试 tv1，发现代表高频的系数出现在 (1,1) 处
hadamard(8)*tv1*hadamard(8)'

