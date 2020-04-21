% Exp03-3
% Author: Qin Hao
% Date: 2020/4/18

% 频率域磨皮自然需要进行平滑滤波
% 频率域平滑滤波器有三种：Ideal、Butterworth and Gaussion filters
% Ideal filter 具有比较大的缺点，会产生rings
% 所以主要关注Butterworth filter 和 Gaussion filter

% 读入图像
%img = imread('test/img/1.jpg');
%img = imread('test/img/2.jpg');
%img = imread('test/img/3.jpg');
img = imread('test/img/4.jpg');

figure,imshow(img);
% 将彩色图片RGB三通道分离为三个单通道
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
% 对三通道图像逐一进行处理
% Butterworth低通滤波
%fourierImgR = ButterworthLowpassFiltering(R);
%fourierImgG = ButterworthLowpassFiltering(G);
%fourierImgB = ButterworthLowpassFiltering(B);
% Gaussion低通滤波
fourierImgR = GaussianLowpassFiltering(R);
fourierImgG = GaussianLowpassFiltering(G);
fourierImgB = GaussianLowpassFiltering(B);
% 合并为彩色图像
img(:, :, 1) = fourierImgR(:, :, 1);
img(:, :, 2) = fourierImgG(:, :, 1);
img(:, :, 3) = fourierImgB(:, :, 1);
% 显示滤波后的图像
figure, imshow(img);


function image = ButterworthLowpassFiltering(img)
% ButterworthLowpassFiltering - 巴特沃斯低通滤波器
%
% Syntax: image = ButterworthLowpassFiltering(img)
%
% 该函数输入一个灰度图像，输出经过巴特沃斯低通滤波后的图像
fourierImg = fftshift(fft2(double(img)));% 傅里叶变换，中心化

[row, col] = size(fourierImg);% 获取行数和列数
D0 = 80;% 阈值
n = 3;
% 中心点坐标
rowCenter = ceil(row / 2);
colCenter = ceil(col / 2);

H = zeros(row, col);% 巴特沃斯低通滤波器
for u = 1 : row
    for v = 1 : col
       D = power(power((u - rowCenter), 2) + power((v - colCenter), 2), 0.5);% (u, v)与中心点之间的距离
        H(u, v) = 1 / (1 + power(D / D0, 2 * n));% 巴特沃斯低通滤波器
    end
end
fourierImg = fourierImg .* H;

image = ifft2(ifftshift(fourierImg));% 逆中心化，逆傅里叶变化

end

function image = GaussianLowpassFiltering(img)
% GaussianLowpassFiltering - 高斯低通滤波器
%
% Syntax: images = GaussianLowpassFiltering(img)
%
% 该函数输入一个灰度图像，输出经过高斯低通滤波后的图像
fourierImg = fftshift(fft2(double(img)));% 傅里叶变换，中心化

[row, col] = size(fourierImg);% 获取行数和列数
D0 = 80;% 阈值
% 中心点坐标
rowCenter = ceil(row / 2);
colCenter = ceil(col / 2);

H = zeros(row, col);% 高斯滤波器
for u = 1 : row
    for v = 1 : col
        D = power(power((u - rowCenter), 2) + power((v - colCenter), 2), 0.5);% (u, v)与中心点之间的距离
        H(u, v) = exp(-power(D, 2) / (2 * power(D0, 2)));% 高斯高通滤波器
    end
end
fourierImg = fourierImg .* H;

image = ifft2(ifftshift(fourierImg));% 逆中心化，逆傅里叶变化

end