from matplotlib import pyplot, font_manager
# x 轴值-年
years = [2013, 2014, 2015, 2016, 2017, 2018]
# Y轴值-房价
data1 = [10000, 12000, 18000, 28000, 40000, 55000]
# Y轴值-租房价
data2 = [1000, 1100, 1200, 1300, 1600, 2500]
# windows 下解决中文乱码的问题
font = font_manager.FontProperties(fname='C:\Windows\Fonts\simkai.ttf')
# 绘制曲线-label是图例
pyplot.plot(years, data1, label="房价", color="red", marker="o")
pyplot.plot(years, data2, label="租房", color="green", marker="o")
# 大标题
pyplot.title("北京房价与租房同比变化曲线", fontproperties=font)
# y轴说明
pyplot.ylabel("单位/kg", fontproperties=font)
# x轴说明
pyplot.xlabel("年", fontproperties=font)
# x轴说明
pyplot.legend(prop=font, title="legend")
# 保存到磁盘
pyplot.savefig('D://fit.png')
# 显示在弹框里
pyplot.show()