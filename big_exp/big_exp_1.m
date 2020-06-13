% Big Experiment - 1/4
% 缺陷检测
% Author: Qin Hao
% Date: 2020/6/11

% (1)对于图像hh3.bmp hh6.bmp，在对棉花质量进行检测时，会发现有些棉花中存有杂质
% （如图中的红色线条），将棉花中的杂质部分标识出来。

% 读取图像
img = imread('hh3.bmp');
%img = imread('hh6.bmp');
figure, imshow(img);

img = double(img);

% 分离图片RGB通道
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);

% delta 为差值矩阵，result 为结果矩阵
delta = B;
result = B;

% 图像大小
[m, n, p] = size(img);
% 获取各个像素在通道之间的最大差值
for i = 1 : m
    for j = 1 : n
        result(i, j) = 255;
        % 各像素在三个通道之间的最大差值
        delta(i, j) = max([R(i, j), G(i, j), B(i, j)]) - ...
                    min([R(i, j), G(i, j), B(i, j)]);
    end
end

% 选定阈值，判断杂质是否存在，若不存在则输出空图
if max(max(delta)) > 60
    % 线性增强，增大对比度
    delta = delta * (255 / (max(max(delta))));
    % 去掉背景信息
    delta = delta - B;
    % 反色
    result = 255 - delta;
    % 中值滤波，去除噪声
    result = medfilt2(result);
    result = medfilt2(result);
    % 二值化
    for i = 1 : m
        for j = 1 : n
            if result(i,j) > 254
                result(i,j) = 255;
            else
                result(i,j) = 0;
            end
        end
    end
end

% 显示杂质二值图像
figure, imshow(uint8(result));