img1 = imread('img/1.jpg');
img2 = imread('img/2.jpg');
img3 = imread('img/3.jpg');
img4 = imread('img/4.jpg');

filter(img1, 1);
filter(img2, 3);
filter(img3, 5);
filter(img4, 7);

function filter(img1, n)
% 对彩色图片进行均值滤波操作
R = img1(:, :, 1);
G = img1(:, :, 2);
B = img1(:, :, 3);

R = filter2(fspecial('average',6),R) / 255;
G = filter2(fspecial('average',6),G) / 255;
B = filter2(fspecial('average',6),B) / 255;
% 对彩色图像R,G，B三个通道分别进行6×6模板的均值滤波
img2 = cat(3,R,G,B);

figure(n), subplot(1, 2, 1),imshow(img1);
title('原始图像');
figure(n), subplot(1, 2, 2),imshow(img2);
title('滤波图像');

figure(n + 1), subplot(1, 2, 1),imhist(img1);
title('原始图像直方图');
figure(n + 1), subplot(1, 2, 2),imhist(img2);
title('滤波图像直方图');
end