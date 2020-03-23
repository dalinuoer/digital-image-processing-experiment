#include <iostream>
#include <opencv2/opencv.hpp>

using std::cout;
using std::endl;
using namespace cv;

int main(int, char**)
{
    Mat lena = imread("../img/lena.bmp"); // 读取图像
    if (lena.empty()) // 未正确读取图像
    {
        cout << "Reading image error!" << endl;
        return -1;
    }
    imshow("lena", lena);
    waitKey();

    Mat resizeLena;
    resize(lena, resizeLena, Size(640, 480)); // 改变大小
    imshow("resizeLena", resizeLena);
    waitKey();

    Mat grayLena;
    cvtColor(resizeLena, grayLena, COLOR_RGB2GRAY); // 灰度化
    imshow("grayLena", grayLena);
    waitKey();

    imwrite("../img/grayLena.jpg", grayLena); // 保存灰度化后的图像

    return 0;
}