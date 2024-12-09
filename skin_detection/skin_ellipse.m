% 定义椭圆的隐函数
f = @(px, py) ((px - 113) * 0.7314 + (py - 155.6) * 0.6820).^2 / 136.89 + ...
              (-(px - 113) * 0.6820 + (py - 155.6) * 0.7314).^2 / 57.76 - 1;

% 绘制椭圆
figure;
fimplicit(f, [80 140 140 170]); % 调整范围以便看到整个椭圆

% 添加标题和标签
title('Ellipse Plot');
xlabel('px');
ylabel('py');
axis equal; % 保持比例
grid on;
