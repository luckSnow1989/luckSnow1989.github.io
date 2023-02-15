import pandas as pd
import numpy as np

# 1. 读取csv文件(以逗号隔开)
print("1 ########################################")
csv = pd.read_csv("demo.csv")
print(type(csv))#<class 'pandas.core.frame.DataFrame'>
print(csv.dtypes)#返回每一列数据的类型

print("1. 前2行\r\n", csv.head(2))#默认读取前5行，可设置读取前n行
print("2. 最后3行\r\n", csv.tail(3))#默认读取最后5行，可设置读取最后n行
print("3. 所有的列", csv.columns)
print("4. 所有的列(列表值)", csv.columns.tolist())
print("5. 行列", csv.shape)
print("6. 读取第1行数据(不包括第一行列名)\r\n", csv.loc[0])
print("7. 读取第2行到第4行\r\n", csv.loc[1:3])
print("8. 读取第2,6,21行\r\n", csv.loc[[1, 5, 20]])
print("9. 获得一列全部的数据\r\n", csv['id'])
print("10. 获得多列全部的数据\r\n", csv[ ['id','name'] ])
print("11. 获得全部数据\r\n", csv[ csv.columns.tolist() ])
print("12. 读取第1行的age", csv.loc[0, 'age'])

# 2. 数值运算
print("2 ########################################")
print("1. 一列数据加6\r\n", csv['age'] + 6)
print("2. 多列数据乘以5\r\n", csv[ ['id', 'age'] ] * 5)
print("3. 获得最大值", csv['age'].max())
print("4. 获得最大值索引", csv['age'].idxmax())

# 3. 排序
# inplace   是否新生成一个
# ascending 是否升序
print("3 ########################################")
demo = csv.sort_values("age", ascending=False)
print("1. 排序\r\n", demo)# 这里的索引值的混乱的
print("2. 排序后重新生成索引\r\n", demo.reset_index(drop=True))

# 4. 数据预处理(数据缺失或异常)
print("4 ########################################")
age = csv['age']#获得数据列
age_is_null = pd.isnull(age)
print("1. 判断数据是否为空\r\n", age_is_null)
age_null_value = age[age_is_null]
print("2. 获得数据为空数据\r\n", age_null_value)

print("3. 求平均值", csv["age"].mean())# 自动去除None的值

# index=type        根据index指定的列进行分组， type 1=老师 2=学生
# values=age        values是分组后进行分析的数据列名
# aggfunc=np.mean   如何进行数据分析    np.mean均值（默认） np.sum 求和
print("4. 基本数据分析", csv.pivot_table(index='type', values='age', aggfunc=np.mean))
print("5. 去除有None值的那行数据", csv.dropna(axis=0, subset=['age', 'type']))


#5.自定义函数
print("5 ########################################")
def show_data(data):
    return data.loc[2]

apply = csv.apply(show_data)
print("1. 自定义函数", apply)

#6.series 操作（非常重要）
#series的操作基本上和numoy.array()函数相同。
print("6 ########################################")
films = pd.read_csv("film.csv")
film_names = films['电影名称']
print("1. 数据数据类型", type(film_names))
print("2. 获得0~2行\r\n", film_names.loc[0:2])
film_name_list = film_names.values
print("3. 获得数据的列表", film_name_list)

# 创建Series结构
print("7 ########################################")
from pandas import Series
# index=films['电影名称'].values 指定索引列
# data 指定数据列
series_data = Series(index=films['电影名称'].values, data=films['优酷'].values)
print("1. 创建Series结构\r\n", series_data)
print("2. 获得<电影A>的评分\r\n", series_data['电影A'])
print("3. 获得全部索引", series_data.index.tolist())
print("4. 按照索引排序\r\n", series_data.sort_index())
print("5. 按照数值排序\r\n", series_data.sort_values())
print("6. 使用numpy的函数", np.add(series_data, series_data))








