f = rgb2gray(imread('laoshan.jpg')); % 读取并转换为灰度图
figure, imshow(f); % 显示原图像
[c,s] = wavefast(f, 1, 'haar'); % 二维haar小波变换
figure; wave2gray(c, s, -6); % 小波变换系数
[nc,y] = wavecut('a', c, s); % 第四阶变换系数
figure, wave2gray(nc, s, -6);
edge = abs(waveback(nc, s, 'sym4')); % 二维逆FWT
figure, imshow(mat2gray(edge)); % 显示反变换后的图像
