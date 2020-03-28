img1 = imread('img/1.jpg');
img2 = imread('img/2.jpg');
img3 = imread('img/3.jpg');
img4 = imread('img/4.jpg');

filter(img1, 1);
filter(img2, 3);
filter(img3, 5);
filter(img4, 7);

function filter(img1, n)
% �Բ�ɫͼƬ���о�ֵ�˲�����
R = img1(:, :, 1);
G = img1(:, :, 2);
B = img1(:, :, 3);

R = filter2(fspecial('average',6),R) / 255;
G = filter2(fspecial('average',6),G) / 255;
B = filter2(fspecial('average',6),B) / 255;
% �Բ�ɫͼ��R,G��B����ͨ���ֱ����6��6ģ��ľ�ֵ�˲�
img2 = cat(3,R,G,B);

figure(n), subplot(1, 2, 1),imshow(img1);
title('ԭʼͼ��');
figure(n), subplot(1, 2, 2),imshow(img2);
title('�˲�ͼ��');

figure(n + 1), subplot(1, 2, 1),imhist(img1);
title('ԭʼͼ��ֱ��ͼ');
figure(n + 1), subplot(1, 2, 2),imhist(img2);
title('�˲�ͼ��ֱ��ͼ');
end