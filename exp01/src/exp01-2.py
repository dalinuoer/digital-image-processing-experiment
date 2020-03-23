# 由于每张图片的大小不一致，拼图的时候不好处理，所以首先用OpenCV读取每个图片，再把它们的大小都改为100*100。一次更改，使用多次。
#coding=utf-8
import os # 和文件有关的模块
import cv2 # OpenCV

#这图片所在的文件夹
readPath="C:\\Users\\53065\\Pictures\\images"

#改变大小之后的图片
savePath="C:\\Users\\53065\\Pictures\\save"

#用一个列表保存所有的图片的文件名字
files=os.listdir(readPath)

#n变量用来看到图片的处理进度。
n=0

#遍历所有图片文件们
for file in files:
    n+=1
    imgPath=readPath+ "\\" + file#构造图片路径
    img = cv2.imread(imgPath)#读取图片到内存img变量
    img = cv2.resize(img, (100,100))#更改图片的大小
    # 更改之后写入文件，方便以后使用。否则你生成一张马赛克就要处理一次10万张图片
    cv2.imwrite(savePath + "\\"+file, img)
    print(n)

cv2.waitKey()


# 建立索引就是保存每张图片出现次数最多的像素值然后保存到文件中。格式为：文件名称：B,G,R
#建立好索引文件之后，就可以知道每个图片和他们最常见的颜色。在使用这些图片的时候，就可以读取整个索引文件，然后定位到图片文件本身。
import cv2
import os
import collections

readPath = "C:\\Users\\53065\\Pictures\\save"
files = os.listdir(readPath)
n = 0
s = ''
for file in files:
    li = []
    n += 1
    imgPath = readPath + "\\" + file
    img = cv2.imread(imgPath)
    for i in range(100):
        for j in range(100):
            b = img[i, j, 0]
            g = img[i, j, 1]
            r = img[i, j, 2]
            li.append((b, g, r))

    most = collections.Counter(li).most_common(1)
    s += file
    s += ":"
    s += str(most[0][0]).replace("(", "").replace(")", "")
    s += "\n"
    print(n)

f = open('filename.txt', 'w')
f.write(s)

# 首先是读取生成的索引文件。然后可以选择打乱它，以免一样的图片聚集出现在一个位置附近。
#假设目标图片是n*m的，那么新建一个n*100，m*100的图片（这里是100的整数倍是因为刚才把图片集中的每个图片都更改为100*100大小的了）。这是一个很大的图片。对于原图片的每个像素，都遍历索引文件，找到和BGR像素值的欧式距离（你也可以采取其他度量方式，甚至可以找最相近的图片，但这样将导致同图片的聚集，因为相邻的像素值很可能一样的）不大于一个阈值的索引文件中的值，然后根据找到的BGR定位到具体的文件，由文件再读取图片，把图片放到大图上的具体位置。
import cv2
import numpy as np

readPath = "C:\\Users\\53065\\Pictures\\save"


def readIndex():
    fs = open("filename.txt", "r")
    n = 0
    dic = []
    for line in fs.readlines():
        n += 1
        temp = line.split(":")
        file = temp[0]
        bgr = temp[1].split(",")
        b = int(bgr[0])
        g = int(bgr[1])
        r = int(bgr[2])
        dic.append((file, (b, g, r)))
    return dic


img = cv2.imread("../img/xiamu.jpg")
s = np.shape(img)
big = np.zeros((100 * s[0], 100 * s[1], 3), dtype=np.uint8)

list = readIndex()  # 读取索引文件到变量中

for i in range(s[0]):  # 遍历行和列
    for j in range(s[1]):
        print(i)
        b = img[i, j, 0]
        g = img[i, j, 1]
        r = img[i, j, 2]  # 获取图像当前位置的BGR值

        np.random.shuffle(list)  # 打乱索引文件

        for item in list:
            imgb = item[1][0]
            imgg = item[1][1]
            imgr = item[1][2]  # 获取索引文件的RGB值

            distance = (imgb - b) ** 2 + (imgg - g) ** 2 + (imgr - r) ** 2  # 欧式距离

            if distance < 100:
                filepath = readPath + "\\" + str(item[0])  # 定位到具体的图片文件
                little = cv2.imread(filepath)  # 读取整个最相近的图片
                big[i * 100:(i + 1) * 100, j * 100:(j + 1) * 100] = little  # 把图片画到大图的相应位置

cv2.imwrite("../img/new.jpg", big)  # 输出大图到文件中
