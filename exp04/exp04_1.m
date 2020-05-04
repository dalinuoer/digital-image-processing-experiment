% Exp04-1
% Author: Qin Hao
% Date: 2020/5/4

%------TestĿ¼����ͼ��windmill_noise.png����Matlabд����ȥ�����Ƹ��š�------

%------����ο�ʵ����� �˲�.ppt �еĴ���------

% ��ȡͼ��
img = imread('test/windmill_noise.png');
% ��ʾԭͼ��
figure, subplot(2, 2, 1), imshow(img);
title("ԭͼ��");
% ��ʾԭʼͼ��Ƶ��ͼ
F = fft2(img);
fc = fftshift(F);
s = log(1 + abs(fc));
subplot(2,2,2),imshow(s, []);
title("ԭͼ��Ƶ��");

% ��padding���̣�ֱ����Ƶ���������ͼ���Сһ�µ��˲���

[M, N] = size(img); % ��ȡͼ�������M������N
[u, v] = dftuv(M, N); % ����Ƶ����������
d = sqrt(u.^2 + v.^2); % ����ÿ���㵽ԭ��ľ���

% 1. ��������˲�
% �˲�������
w = 5;
D0 = 15;
% ��������˲���
ba = d < (D0 - w / 2) | d > (D0 + w / 2);
% �˲�
H = double(ba);
g = real(ifft2(H .* fft2(img))); % �˲����ͼ��
% ��ʾ��������˲����ͼ��
subplot(2, 2, 3), imshow(g, []);
title("��������˲�ͼ��");
% ��ʾ��������˲����Ƶ��
F = fft2(g);
fc = fftshift(F);
s = log(1 + abs(fc));
subplot(2, 2, 4), imshow(s, []);
title("��������˲�Ƶ��");

% 2. ������˹�����˲�
% �˲�������
n = 3;
% ������˹�˲���
H = 1 ./ (1 + (w * d ./ (d.^2 - D0^2)).^(2 * n));
% �˲�
g = real(ifft2(H .* fft2(img))); % �˲����ͼ��
% ��ʾ������˹�����˲����ͼ��
figure, subplot(2, 2, 1), imshow(g, []);
title("������˹�����˲�ͼ��");
% ��ʾ������˹�����˲����Ƶ��
F = fft2(g);
fc = fftshift(F);
s = log(1 + abs(fc));
subplot(2, 2, 2), imshow(s, []);
title("������˹�����˲�Ƶ��");

% 3. ��˹�����˲�
% ��˹�����˲���
H = 1 - exp(-1 / 2 * (((d.^2) - D0^2) ./ (d * w)).^2);
% �˲�
g = real(ifft2(H .* fft2(img))); % �˲����ͼ��
% % ��ʾ��˹�����˲����ͼ��
subplot(2, 2, 3), imshow(g, []);
title("��˹�����˲�ͼ��");
% ��ʾ��˹�����˲����Ƶ��
F = fft2(g);
fc = fftshift(F);
s = log(1 + abs(fc));
subplot(2, 2, 4), imshow(s, []);
title("��˹�����˲�Ƶ��");


% dftuv ����ʵ��
function [U, V] = dftuv(M, N)
% DFTUV ʵ��Ƶ���˲�����������

% ����
u = 0 : (M - 1);
v = 0 : (N - 1);
% ������������������������ԭ��ת�Ƶ����Ͻǣ���ΪFFT����ʱ�任��ԭ�������Ͻ�
idx = find(u > M / 2); % �Ҵ���M/2������
u(idx) = u(idx) - M; % ������M/2�����ݼ�ȥM
idy = find(v > N / 2);
v(idy) = v(idy) - N;
% �����������
[V, U] = meshgrid(v, u);

end