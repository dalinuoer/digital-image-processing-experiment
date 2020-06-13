% Big Experiment - 2/4
% 缺陷检测
% Author: Qin Hao
% Date: 2020/6/13

% (2)对于图像IMG_1526.jpg IMG_1527.jpg，布中有一条织错的线，将这条线找出来，
% 并用一条线标注出来。

% 读取图像
img = imread('IMG_1526.jpg');
% 转换为灰度图像
img = rgb2gray(img);
figure, imshow(img);
