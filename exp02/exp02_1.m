img = imread('img/IMG_2546.JPG');
figure(1),imhist(img); % �鿴ֱ��ͼ

% ȡ��
invert(:, :, 1) = 255 - img(:, :, 1);
invert(:, :, 2) = 255 - img(:, :, 2);
invert(:, :, 3) = 255 - img(:, :, 3);
figure(2),subplot(1, 2, 1),imshow(img);
title('ԭʼͼ��');
figure(2),subplot(1, 2, 2),imshow(invert);
title('ȡ��ͼ��');

figure(3),imhist(invert); % ��ʾȡ����ͼ���ֱ��ͼ

img2 = histeq(img); % ֱ��ͼ���⻯
figure(4),imhist(img2);

img3 = imrotate(img, -9); % ��תͼ��ʹͼ������ˮƽ
figure(5),imshow(img3);

img4 = imcrop(img3, [680, 690, 320, 70]); % �и�ͼ�󣬱�������
figure(6),imshow(img4);