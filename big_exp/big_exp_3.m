% Big Experiment - 3/4
% 缺陷检测
% Author: Qin Hao
% Date: 2020/6/7

% (3)对于图像IMG_1532.jpg，根据所给图，找出图中洞的区域，并将其边缘用连续的线描出来。
% 并且测出洞的面积，即输出洞内包含的象素点的个数。

% 读取图像
img = imread('IMG_1532.jpg');
% 转换为灰度图
img = rgb2gray(img);
% 显示灰度图
figure, imshow(img);

% 均值滤波，去除花纹干扰
img = filter2(fspecial('average', 5), img);
% 边缘提取
ed = edge(img, 'canny', 0.60);

% 使边缘连续
SE1 = strel('square', 3);
ed = imdilate(ed, SE1); % 膨胀
SE2 = strel('square', 4);
ed = imclose(ed, SE2); % 闭操作

% 破洞边缘
figure, imshow(ed);

% 计算洞内包含的像素点的个数
total = 0; % 总数
count = 0; % 每一行像素数

begin = 0;

[m, n] = size(ed);
for i = 1 : m
    for j = 1 : n
        if ed(i, j) == 255 && begin == 0
            begin = 1;
        end
        if begin == 1 && ed(i, j) == 0
            count = count + 1;
        end
        if begin == 1 && ed(i, j) == 255
            break;
        end
    end
    total = total + count;

    begin = 0;
    count = 0;
end

% 输出总的像素个数
fprintf('The total number of pixel is %d.\n', total);