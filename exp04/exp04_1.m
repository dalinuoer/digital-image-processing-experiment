% Exp04-1
% Author: Qin Hao
% Date: 2020/5/4

%------Test目录下有图像windmill_noise.png，用Matlab写程序，去除条纹干扰。------

%------代码参考实验材料 滤波.ppt 中的代码------

% 读取图像
img = imread('test/windmill_noise.png');
% 显示原图像
figure, subplot(2, 2, 1), imshow(img);
title("原图像");
% 显示原始图像频谱图
F = fft2(img);
fc = fftshift(F);
s = log(1 + abs(fc));
subplot(2,2,2),imshow(s, []);
title("原图像频谱");

% 无padding过程，直接在频率域产生于图像大小一致的滤波器

[M, N] = size(img); % 获取图像的行数M和列数N
[u, v] = dftuv(M, N); % 计算频域网格数组
d = sqrt(u.^2 + v.^2); % 计算每个点到原点的距离

% 1. 理想带阻滤波
% 滤波器参数
w = 5;
D0 = 15;
% 理想带阻滤波器
ba = d < (D0 - w / 2) | d > (D0 + w / 2);
% 滤波
H = double(ba);
g = real(ifft2(H .* fft2(img))); % 滤波后的图像
% 显示理想带阻滤波后的图像
subplot(2, 2, 3), imshow(g, []);
title("理想带阻滤波图像");
% 显示理想带阻滤波后的频谱
F = fft2(g);
fc = fftshift(F);
s = log(1 + abs(fc));
subplot(2, 2, 4), imshow(s, []);
title("理想带阻滤波频谱");

% 2. 巴特沃斯带阻滤波
% 滤波器参数
n = 3;
% 巴特沃斯滤波器
H = 1 ./ (1 + (w * d ./ (d.^2 - D0^2)).^(2 * n));
% 滤波
g = real(ifft2(H .* fft2(img))); % 滤波后的图像
% 显示巴特沃斯带阻滤波后的图像
figure, subplot(2, 2, 1), imshow(g, []);
title("巴特沃斯带阻滤波图像");
% 显示巴特沃斯带阻滤波后的频谱
F = fft2(g);
fc = fftshift(F);
s = log(1 + abs(fc));
subplot(2, 2, 2), imshow(s, []);
title("巴特沃斯带阻滤波频谱");

% 3. 高斯带阻滤波
% 高斯带阻滤波器
H = 1 - exp(-1 / 2 * (((d.^2) - D0^2) ./ (d * w)).^2);
% 滤波
g = real(ifft2(H .* fft2(img))); % 滤波后的图像
% % 显示高斯带阻滤波后的图像
subplot(2, 2, 3), imshow(g, []);
title("高斯带阻滤波图像");
% 显示高斯带阻滤波后的频谱
F = fft2(g);
fc = fftshift(F);
s = log(1 + abs(fc));
subplot(2, 2, 4), imshow(s, []);
title("高斯带阻滤波频谱");


% dftuv 函数实现
function [U, V] = dftuv(M, N)
% DFTUV 实现频域滤波器的网格函数

% 遍历
u = 0 : (M - 1);
v = 0 : (N - 1);
% 计算网格的索引，即将网络的原点转移到左上角，因为FFT计算时变换的原点在左上角
idx = find(u > M / 2); % 找大于M/2的数据
u(idx) = u(idx) - M; % 将大于M/2的数据减去M
idy = find(v > N / 2);
v(idy) = v(idy) - N;
% 计算网格矩阵
[V, U] = meshgrid(v, u);

end