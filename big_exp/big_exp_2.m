% Big Experiment - 2/4
% 缺陷检测
% Author: Qin Hao
% Date: 2020/6/13

% (2)对于图像IMG_1526.jpg IMG_1527.jpg，布中有一条织错的线，将这条线找出来，
% 并用一条线标注出来。

% 读取图像
img = imread('IMG_1526.jpg');
%img = imread('IMG_1527.jpg');
% 转换为灰度图像
img = rgb2gray(img);
subplot(1, 2, 1), imshow(img), title('Original image');

% 边缘检测
thresh = [0.300, 0.500]; % 双阈值
ed = edge(img, 'canny', thresh); % canny 边缘提取
ed = imdilate(ed, strel('square', 2)); % 膨胀

% 霍夫变换，提取直线
[H, theta, rho] = hough(ed, 'RhoResolution', 0.5, 'ThetaResolution', 0.5); % 得到参数空间
peak = houghpeaks(H, 5); % 求极值点
lines = houghlines(ed, theta, rho, peak); % 返回原图直线信息
subplot(1, 2, 2), imshow(ed), title('Detected result'), hold on
% 绘图
for k = 1 : length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:, 1), xy(:, 2), 'LineWidth', 4);
end