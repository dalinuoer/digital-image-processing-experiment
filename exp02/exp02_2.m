img = imread('img/100_3228.JPG');
img1 = histeq(img);

figure(1),subplot(1, 2, 1),imshow(img);
title('原始图像');
figure(1),subplot(1, 2, 2),imshow(img1);
title('增强图像');

figure(2),subplot(1, 2, 1),imhist(img);
title('原始图像直方图');
figure(2),subplot(1, 2, 2),imhist(img1);
title('增强图像直方图');
