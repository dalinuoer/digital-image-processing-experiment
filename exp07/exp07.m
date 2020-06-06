% Exp07
% Author: Qin Hao
% Date: 2020/6/5

% ------2. 对图像1.png，2.jpg，3.jpg使用形态学方法去除干扰，保留干净的字母。------

% 处理 1.png
% 先闭操作，再进行腐蚀
img1 = imread('1.png');
thresh1 = graythresh(img1); % 自动确定阈值
img1 = im2bw(img1, thresh1); % 二值化
figure, imshow(img1);

SE1 = strel('square', 3); % 创建3*3正方形结构元素
img1 = imclose(img1, SE1); % 闭操作

SE2 = strel('square', 5); % 创建5*5正方形结构元素
img1 = imerode(img1, SE2); % 腐蚀
img1 = imdilate(img1, SE2); % 膨胀

img1 = imopen(img1, SE1); % 开操作

figure, imshow(img1);

% 处理 2.jpg
img2 = imread('2.jpg');
thresh2 = graythresh(img2); % 自动确定阈值
img2 = im2bw(img2, thresh2); % 二值化
figure, imshow(img2);

img2 = imerode(img2, SE1); % 腐蚀
img2 = imdilate(img2, SE1); % 膨胀

figure, imshow(img2);

% 处理 3.jpg
img3 = imread('3.jpg');
thresh3 = graythresh(img3); % 自动确定阈值
img3 = im2bw(img3, thresh3); % 二值化
figure, imshow(img3);

img3 = imerode(img3, SE1); % 腐蚀
img3 = imdilate(img3, SE1); % 膨胀

figure, imshow(img3);