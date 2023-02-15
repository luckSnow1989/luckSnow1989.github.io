import seaborn as sns
import numpy as np
import matplotlib.pyplot as plt


def sinplot():
    x = np.linspace(start=0, stop=np.pi * 4, num=200)# 0 ~ 10 平均分成100个点
    for i in range(10):
        plt.plot(x, np.sin(x + i * 0.3) * i)# x + i * 0.3 没什么意义，就是为了让图对比度高些
    plt.show()

def demo1():# 1. 回归分析
    # tips 是在餐厅吃饭收费和消费的统计。total_bill总消费， tip小费，sex客户性别
    tips = sns.load_dataset("tips")  # seaborn内置的加载demo数据的函数。函数自动从GitHub上下载csv文件。
    print("数据结构\r\n", tips.head())
    # 创建total_bill总消费 和 tip小费 进行回归分析。包括拟合的线性直线
    sns.regplot(x='total_bill', y='tip', data=tips)
    # sns.regplot(x=tips['total_bill'], y=tips['tip'])
    plt.show()
    # x_jitter 是x轴的值在0.5 范围内进行抖动（为了更好的对数据进行回归分析）
    sns.regplot(x='size', y='tip', data=tips, x_jitter=0.05)
    plt.show()

def demo2():#分析数据分布情况
    tips = sns.load_dataset("tips")
    # 1. 使用stripplot，形成类似于散点图的分布
    sns.stripplot(x='day', y='total_bill', data=tips, jitter=True)
    plt.show()
    # 2. 使用swarmplot，比stripplot有更好的数据排列。
    sns.swarmplot(x='day', y='total_bill', data=tips)
    plt.show()
    # 3.violinplot将分布情况绘制成色斑图
    sns.violinplot(x='day', y='total_bill', data=tips)
    plt.show()
    # 4. hue多种数据混合显示
    sns.violinplot(x='day', y='total_bill', hue='sex', data=tips)
    plt.show()

    # 5. hue多种数据混合显示(split=True,混合在一起显示)
    sns.violinplot(x='day', y='total_bill', hue='sex', data=tips, split=True)
    plt.show()

    # 6. 多种图混合使用
    sns.violinplot(x='day', y='total_bill', data=tips, inner=None)
    # alpha 透明度
    sns.swarmplot(x='day', y='total_bill', data=tips, color='w', alpha=0.5)
    plt.show()

def demo3():#
    tips = sns.load_dataset("tips")
    print(tips.head())
    g = sns.FacetGrid(tips, col='sex')# 将数据根据性别分类
    g.map(plt.scatter, 'total_bill', 'tip')# 第一个参数是图的类型，plt.scatter散点图;每一种性别下，total_bill 和 tip 进行分对比
    g.add_legend()
    plt.show()

    g = sns.FacetGrid(tips, col="sex")
    g.map(sns.distplot, "tip")# plt.distplot柱形图，添加密度函数; 只能进行一种数据的分析
    plt.show()

    # KDE等高线
    g = sns.FacetGrid(tips, col="sex")
    g.map(sns.kdeplot, 'total_bill', 'tip')
    plt.show()
if __name__ == "__main__":
    #demo1()
    #demo2()
    demo3()



