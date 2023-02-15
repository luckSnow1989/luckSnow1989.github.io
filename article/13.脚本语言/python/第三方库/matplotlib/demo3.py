# 条形图
# 几部电影所获得的奥斯卡金像奖的数目

# Linux无界面调用时必须将这两行放在最前面
# import  matplotlib
# matplotlib.use("Agg")

from matplotlib import pyplot
movies = ["Annie Hall", "Ben-Hur", "Casablanca", "Gandhi", "West Side Story"]
num_oscars = [5, 11, 3, 8, 10]

pyplot.bar(movies, num_oscars)

pyplot.title("中文")

pyplot.ylabel("y")

pyplot.savefig("/usr/local/demo/1.png")

# pyplot.show()