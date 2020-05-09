f=rgb2gray(imread('laoshan.jpg')); % 读取图像并转换为灰度图
figure,imshow(f); % 显示原图像
[c,s]=wavefast(f,1,'haar'); % 二维haar小波变换
figure; wave2gray(c,s,-6); % 显示小波分解系数
[nc,y]=wavecut('a',c,s); % 小波分解结构零系数
figure, wave2gray(nc,s,-6);
edge=abs(waveback(nc,s,'sym4')); % 多层次的二维逆FWT
figure,imshow(mat2gray(edge));
