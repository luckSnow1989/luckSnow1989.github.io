import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# 1. 单一折线图
print("1. 单一折线图 #########################")
csv = pd.read_csv('line.csv')
print(csv.dtypes)# 查询下数据类型
csv['time'] = pd.to_datetime(csv['time'])# 将time列数据转为时间类型
print(csv.head())# 显示前5行
one_year_data = csv[0:12]#获取前12和数据（其实就是一年的数据）
plt.plot(one_year_data['time'], one_year_data['percent'])#指定图的x轴和y轴的值
plt.xticks(rotation=10) # x轴数据倾斜45度
plt.xlabel('1~12月')# x轴标注
plt.ylabel('百分比')# y轴标注
plt.title('2000年失业率百分比')# 大标题
# plt.ylim(0,10) # 设置y轴值的范围。
#plt.savefig("d://aa.png")#保存图到本地
plt.show()#显示图像。只能放在最后一步操作，相当于将图输出出去，并关闭资源。

# 2. 子图
print("2. 子图 #########################")
# figure创建子图。fig.add_subplot添加一个子图。
# add_subplot第一个参数行数，第二个列数，第三个是添加子图到那个位置
"""
    比如 2,3 的子图。结构如下，为一个2行3列的表格。1~6表示位置。
    1  2  3
    4  5  6
"""
fig = plt.figure(figsize = (10,3))#figsize 初始化子图画布的大小
ax1 = fig.add_subplot(2,3,1)
ax2 = fig.add_subplot(2,3,2)
ax3 = fig.add_subplot(2,3,3)
ax4 = fig.add_subplot(2,3,4)
# 子图的设置方法与plt图相似，但是有前缀set_,比如，plt.xlabel() 对应 ax1.set_xlabel()

ax1.plot(np.random.randint(1,5,5), np.arange(5))
ax2.plot(np.arange(10) * 3, np.arange(10))
plt.show()

# 3. 多个折线图
print("3. 多个折线图 #########################")
csv = pd.read_csv('line.csv')
csv['time'] = pd.to_datetime(csv['time'])# 将time列数据转为时间类型
x = csv[0:6]['time']
y1 = csv[0:6]['percent']
y2 = csv[6:12]['percent']
plt.plot(x, y1, color='red', marker='o')#第一个曲线
plt.plot(x, y2, color='blue', marker='*')#第二个曲线
plt.title('2000年失业率百分比')# 大标题
plt.show()

# 4. 条形图
print("4. 柱形图 #########################")
x = [x + 1 for x in range(12)]
y = [np.random.random() * 100 for _ in range(12)]
plt.bar(x, y)#plt.barh(x, y) #xy相反
plt.show()

# 5. 散点图
print("5. 散点图 #########################")
plt.scatter(x, y)
plt.show()

# 6. 柱形图
print("6. 柱形图 #########################")
plt.hist(y, bins=5)
plt.show()


# 7.盒图
print("7.盒图 #########################")
plt.boxplot([
    [1,2,3],[4,5,6],[8,9,10]
])
plt.show()