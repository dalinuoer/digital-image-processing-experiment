% Exp06
% Author: Qin Hao
% Date: 2020/5/31

% ------1. 对test 目录下的图像进行图像压缩测试，调节参数查看效果------

addpath(genpath('./dipum_toolbox_2.0.1')); % 将代码加入搜索路径

% 分别读取test 目录下的三张图片
img = imread('test/euro.jpg');
%img = imread('test/euro2016.jpg');
%img = imread('test/worldcup.jpg');

% 将图片转换为灰度图像
img = rgb2gray(img);
figure, imshow(img);

% Huffman
c1 = mat2huff(img); % 编码
img1 = uint8(huff2mat(c1)); % 解码
figure, imshow(img1); % 显示Huffman 压缩图像
ratio1 = imratio(img, c1); % 计算压缩率
fprintf('The compression ratio of huffman is %f.\n', ratio1);

% JPEG
quality = 0.10; % 质量因子
c2 = im2jpeg(img, quality); % 编码
img2 = jpeg2im(c2); % 解码
figure, imshow(img2); % 显示JPEG 压缩图像
ratio2 = imratio(img, c2); % 计算压缩率
fprintf('The compression ratio of JPEG with quality factor %.2f is %f.\n', quality, ratio2);

% JPEG2000
n = 5; % 进制
q = [8 8.5]; % 隐式量化参数
c3 = im2jpeg2k(img, n, q); % 编码
img3 = jpeg2k2im(c3); % 解码
figure, imshow(img3); % 显示JPEG2000 压缩图像
ratio3 = imratio(img, c3); % 计算压缩率
fprintf('The compression ratio of JPEG2000 with n = %d and q = [%.2f %.2f] is %f.\n', n, q(1), q(2), ratio3);