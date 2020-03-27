img = imread('img/IMG_2546.JPG');
figure(1),imhist(img); % 查看直方图

% 取反
invert(:, :, 1) = 255 - img(:, :, 1);
invert(:, :, 2) = 255 - img(:, :, 2);
invert(:, :, 3) = 255 - img(:, :, 3);
figure(2),subplot(1, 2, 1),imshow(img);
title('原始图像');
figure(2),subplot(1, 2, 2),imshow(invert);
title('取反图像');

figure(3),imhist(invert); % 显示取反后图像的直方图

img2 = histeq(img); % 直方图均衡化
figure(4),imhist(img2);

img3 = imrotate(img, -9); % 旋转图像，使图中文字水平
figure(5),imshow(img3);

img4 = imcrop(img3, [680, 690, 320, 70]); % 切割图象，保留文字
figure(6),imshow(img4);