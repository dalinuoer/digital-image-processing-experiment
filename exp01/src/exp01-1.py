# %%
import matplotlib.pyplot as plt
from PIL import Image
# %%
lena = Image.open("../img/lena.bmp") # 读取图片
lena.show()
# %%
lena = lena.resize((640, 480)) # 改变大小
lena.show()
# %%
lena = lena.convert('L') # 灰度化
lena.show()
# %%
# 另存为gif
images=[]
images.append(lena)
lena.save('../img/lena.gif', save_all=True, append_images=images,loop=1,duration=1)
# %%