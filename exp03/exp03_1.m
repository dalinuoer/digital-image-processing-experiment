% Exp03-1
% Author: Qin Hao
% Date: 2020/4/18

%img = imread('test/2.JPG');%读取图像
img = imread('test/100_3228.JPG');

% ------查看不同图像的傅立叶变换的图像------
% fft2函数实现二维傅里叶变换；使用fftshift函数将零频分量移至频谱中心
fourierImg = fftshift(fft2(img));

% 查看不同图像的DCT（离散余弦）变换
grayImg = rgb2gray(img);% DCT变换前需要转换成灰度图像
dctImg = dct2(grayImg);% 离散余弦变换

figure, imshow(img);% 显示原始图像
figure, imshow(fourierImg);% 显示傅里叶变换的图像
figure, imshow(dctImg);% 显示离散余弦变换后的图像

%------对变换后的图像使用频率域图像增强的方法增强效果------
% 频率域图像增强常用的方法有图像平滑、图像去噪和图像锐化

% 将彩色图片RGB三通道分离为三个单通道
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
% 对三通道图像逐一进行处理
fourierImgR = GaussianHighpassFiltering(R);
fourierImgG = GaussianHighpassFiltering(G);
fourierImgB = GaussianHighpassFiltering(B);
% 合并为彩色图像
img(:, :, 1) = fourierImgR(:, :, 1);
img(:, :, 2) = fourierImgG(:, :, 1);
img(:, :, 3) = fourierImgB(:, :, 1);
% 显示滤波后的图像
figure,imshow(img);

function image = GaussianHighpassFiltering(img)
% GaussianHighPassFiltering - 高斯高通滤波函数
%
% Syntax: image = GaussianHighPassFiltering(img)
%
% 该函数输入一个灰度图像，输出经过高斯高通滤波后的图像
fourierImg = fftshift(fft2(double(img)));% 傅里叶变换，中心化

[row, col] = size(fourierImg);% 获取行数和列数
D0 = 0.2;% 阈值
% 中心点坐标
rowCenter = ceil(row / 2);
colCenter = ceil(col / 2);

H = zeros(row, col);% 高斯滤波器
for u = 1 : row
    for v = 1 : col
        D = power((power((u - rowCenter), 2) + power((v - colCenter), 2)), 0.5);% (u, v)与中心点之间的距离
        H(u, v) = 1 - exp(-power(D, 2) / (2 * power(D0, 2)));% 高斯高通滤波器
    end
end
fourierImg = fourierImg .* H;

image = ifft2(ifftshift(fourierImg));% 逆中心化，逆傅里叶变化

end