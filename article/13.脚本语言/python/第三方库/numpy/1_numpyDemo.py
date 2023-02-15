import numpy as np

# 1. 使用numpy 读取文件
print("1########################################")
txt = np.genfromtxt('./vc.txt',dtype=str, delimiter=',', encoding='UTF-8')
print(type(txt))    # <class 'numpy.ndarray'>
print(txt)
# print(help(np.genfromtxt)) #查看文档

# 2. 创建数组
print("2########################################")
arr = np.array([1,2,3,4,5])
print('数组', arr)
print('数组属性', arr.shape)# (5,)
print('数组中元素的类型', arr.dtype)

# 3. 创建矩阵
print("3########################################")
vc = np.array([[1,2,3], [4,5,6]])
print('矩阵', vc)
print('矩阵属性', vc.shape)#  (2, 3) ,表示2行3列矩阵

# 4. 读取
print("4########################################")
print('第一行', vc[0])
print('第一行,第二、三列', vc[0][1:3])
print('第二列', vc[:, 1])
print('第二列,第一、二行', vc[:, 1:2])

# 5. 对array进行基本运算和条件控制
print("5########################################")
vector = np.array([2, 2, 3, 5])
print(vector + 1) #所有元素都+1
print(vector * 2)#所有元素都*1
print(vector == 2)#所有元素都和2比较 [ True  True False False]
print((vector == 2) | (vector == 3))# [ True  True  True False]

# 6. 获得array中符合条件的元素
print("6########################################")
equal_two = vector == 2 # [ True  True False False],bool布尔类型作为索引，会将TRUE位置的值提取出来
print(vector[equal_two])# [2 2]

# 7. 数值类型转换
print("7########################################")
vector = np.array(['1', '2', '3', '5'])
vector = vector.astype(int)
print('数值类型转换', vector, vector.dtype)

# 8. 求极值和求和
print("8########################################")
vector = np.array(
    [[1, 5, 3],
     [4, 2, 6]]
)
print('矩阵中最大值',vector.max())
print('矩阵中每一列最大值',vector.max(axis=0))
print('矩阵中每一列最大值的索引',vector.argmax(axis=0))
print('矩阵中每一行最大值',vector.max(axis=1))
print('矩阵中每一行最大值的索引',vector.argmax(axis=1))
print('矩阵中最小值',vector.min())
print('求矩阵总和',vector.sum())
print('求矩阵每一列的和',vector.sum(axis=0))

# 9. 生产一个长度是15的数组
print("9########################################")
print("随机生产数组", np.arange(15))
print("随机生产起始值10~20, 步子是2的数组", np.arange(start=10, stop=20, step=2))

# 10.将array转换为3行5列的矩阵。 3 * 5 必须等于array的长度
print("10########################################")
vector = np.arange(15)
vector = vector.reshape(3, 5)
print("换为3行5列的矩阵", vector)
# 直接设置shape属性也可实现转换
vector = np.arange(15)
vector.shape = (3, 5)
print("换为3行5列的矩阵", vector)

# 11. 基本属性
print("11########################################")
vector = np.array(
    [[1, 5, 3],
     [4, 2, 6]]
)
print("行列", vector.shape)
print("维度", vector.ndim)
print("元素数据类型", vector.dtype)
print("元素数量", vector.size)
#dtype可指定数据类型
print("创建一个初始值为0的矩阵", np.zeros((2, 3), dtype=np.int32))
print("创建一个初始值为1的矩阵", np.ones((2, 3), dtype=np.int64))
temp = vector.view() # 浅复制 比如当vector值发生变化的时候， temp也变化了。不推荐使用
vector[0][0] = 1
print("浅复制, temp=", temp,
      ", temp is vector = " ,  temp is vector,
      "id(temp)=", id(temp),
      "id(vector)=", id(vector)
      )

temp = vector.copy() # 深复制,推荐使用
vector[0][0] = 2
print("深复制, temp=", temp,
      ", temp is vector = " ,  temp is vector,
      "id(temp)=", id(temp),
      "id(vector)=", id(vector)
      )

print("行复制扩展到2倍，列扩展到3倍", np.tile(vector, (2, 3)))

# 12. 随机
print("12########################################")
vector = np.random.random((2, 3))
print("随机矩阵", vector)
vector = np.linspace(start= 10 , stop = 20, num=50)
print("在10~20之间平均生产50个元素", vector)

# 13. 数学计算
print("13########################################")
vector = np.arange(3)
print("sin(pi / 2)", np.sin(np.pi / 2))
print("自然常数e的指数", np.exp(vector)) #(元素的e次幂)
print("计算开方", np.sqrt(vector))# 计算开方值

vector = np.random.random((2, 3)) * 10
vector = np.floor(vector)
print("向下取整", vector)
print("将矩阵转为array", vector.ravel())# 与reshape相反
vector = np.arange(15).reshape((3, 5))
print("转置(行列反转)", vector.T)

# 14. 矩阵的运算
print("14########################################")
a = np.array([
    [1, 1], [0, 1]
])
b = np.array([
    [2, 1], [3, 4]
])
print("矩阵内积", a * b) # 矩阵内部对应元素相乘
print("矩阵相乘", a.dot(b)) # 行乘列
print("矩阵相乘", np.dot(a, b))

# 15.矩阵堆积,类似于将一个集合全部追加到另一个集合后面
print("15########################################")
a = np.array([
    [1, 1], [0, 1]
])
b = np.array([
    [2, 1], [3, 4]
])
print("矩阵堆积",np.vstack((a, b)))

# 16. 矩阵切分（平均分成几份，除不尽的话会抛出异常）
print("16########################################")
vector = np.arange(36).reshape((4, 9))# 4行9列
print("按列平均切分3个", np.hsplit(vector, 3))
print("按行平均切分2个", np.vsplit(vector, 2))
print("在第3 和 5列切分", np.hsplit(vector, (3,5)))

# 17. 排序
print("16########################################")
vector = np.array([
    [2, 1], [3, 4]
])
print("按列排序", np.sort(vector, axis=0))
print("按行排序", np.sort(vector, axis=1))

