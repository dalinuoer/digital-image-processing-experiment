img = imread('img/100_3228.JPG');
img1 = histeq(img);

figure(1),subplot(1, 2, 1),imshow(img);
title('ԭʼͼ��');
figure(1),subplot(1, 2, 2),imshow(img1);
title('��ǿͼ��');

figure(2),subplot(1, 2, 1),imhist(img);
title('ԭʼͼ��ֱ��ͼ');
figure(2),subplot(1, 2, 2),imhist(img1);
title('��ǿͼ��ֱ��ͼ');
