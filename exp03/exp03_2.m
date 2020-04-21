% Exp03-2
% Author: Qin Hao
% Date: 2020/4/18

% 读取图像
img1 = imread('test/5.bmp');
img2 = imread('test/10.bmp');

img3 = imread('test/6.bmp');
img4 = imread('test/9.bmp');

img5 = imread('test/10.bmp');
img6 = imread('test/11.bmp');
img7 = imread('test/12.bmp');
% 显示图像和频谱图
displayImgAndSpectrum(img1, img2);
displayImgAndSpectrum(img3, img4);
displayImgAndSpectrum(img5, img6, img7);


function displayImgAndSpectrum(img1, img2, img3)
% displayImgAndSpectrum - 显示图像和频谱图
%
% Syntax: displayImgAndSpectrum(img)
%
if nargin == 2
    % 傅里叶变换，中心化
    fourierImg1 = fftshift(fft2(img1));
    fourierImg2 = fftshift(fft2(img2));
    % 显示原图像和傅里叶变化图像
    figure;
    subplot(1, 2, 1), imshow(img1);
    subplot(1, 2, 2), imshow(img2);
    figure;
    subplot(1, 2, 1), imshow(fourierImg1);
    subplot(1, 2, 2), imshow(fourierImg2);
elseif nargin == 3
    % 傅里叶变换，中心化
    fourierImg1 = fftshift(fft2(img1));
    fourierImg2 = fftshift(fft2(img2));
    fourierImg3 = fftshift(fft2(img3));
    % 显示原图像和傅里叶变化图像
    figure;
    subplot(1, 3, 1), imshow(img1);
    subplot(1, 3, 2), imshow(img2);
    subplot(1, 3, 3), imshow(img3);
    figure;
    subplot(1, 3, 1), imshow(fourierImg1);
    subplot(1, 3, 2), imshow(fourierImg2);
    subplot(1, 3, 3), imshow(fourierImg3);
end

end