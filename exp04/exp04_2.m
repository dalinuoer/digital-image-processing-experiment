% Exp04-2
% Author: Qin Hao
% Date: 2020/5/4

%------Test目录下有图像boardWithNoise.jpg，用Matlab写程序，采用自适应中值滤波器去除噪声干扰。------

% 自适应中值滤波器会根据一定的设定条件改变滤窗的大小,即当噪声面积较大时,通过增加滤窗的大小将噪声予以去除,
% 同时当判断滤窗中心的像素不是噪声时,不改变其当前像素值,即不用中值代替。

% 这样,自适应中值滤波器可以处理噪声概率更大的脉冲噪声,
% 同时在平滑非脉冲噪声图像时能够更好地保持图像细节,这是传统中值滤波器做不到的

% 读入原始图像
img = imread('test/boardWithNoise.jpg');
% 转换为灰度图片
g = rgb2gray(img);
f = g;
f(:) = 0;
been = false(size(g)); % 已经处理过的地方
Smax = 325; % Sxy 所允许的最大值, boardWithNoise.jpg 大小为 325 * 325
for i = 3 : 2 : Smax
    Zmin = ordfilt2(g, 1, ones(i, i), 'symmetric'); % Zmin 是在Sxy滤窗内灰度的最小值
    Zmax = ordfilt2(g, i * i, ones(i, i), 'symmetric'); % Zmax 是在Sxy滤窗内灰度的最大值
    Zmed = medfilt2(g, [i i], 'symmetric'); % Zmed 是在Sxy滤窗内灰度的中值

    prolevelB = (Zmed > Zmin) & (Zmax > Zmed) & ~been; % 需要转到B步骤的像素
    zb = (g > Zmin) & (Zmax > g);

    outZxy = prolevelB & zb; % 满足步骤A，B的输出原值
    outZmed = prolevelB & ~zb; % 满足A,不满足B的输出中值

    f(outZxy) = g(outZxy);
    f(outZmed) = Zmed(outZmed);

    been = been | prolevelB;
    if all(been(:))
        break;
    end
end
f(~been) = g(~been); % 超过窗口大小没被处理的像素位置输出原值

% 显示原始图像
figure, subplot(1, 2, 1), imshow(img);
title("原始图像");
% 显示自适应中值滤波图像
subplot(1, 2, 2), imshow(f);
title("自适应中值滤波图像");