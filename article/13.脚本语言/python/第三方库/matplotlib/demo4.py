from matplotlib import pyplot
import  matplotlib
matplotlib.use("Agg")

friends = [ 70, 65, 72, 63, 71, 64, 60, 64, 67]
minutes = [175, 170, 205, 120, 220, 130, 105, 145, 190]
labels = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i']

pyplot.scatter(friends, minutes)

for label, friend_count, minute_count in zip(labels, friends, minutes) :
    pyplot.annotate(label,
                    xy=(friend_count, minute_count),
                    xytext=(5,-5),
                    textcoords = "offset points"
        )

pyplot.title("日分钟数与朋友数")
pyplot.xlabel("朋友数")
pyplot.ylabel("花在网站上的日分钟数")
# pyplot.savefig("d://1.png")
pyplot.show()


test_1_grades = [ 99, 90, 85, 97, 80]
test_2_grades = [100, 85, 60, 90, 70]
pyplot.scatter(test_1_grades, test_2_grades)
pyplot.title("Axes Aren't Comparable")
pyplot.xlabel("测验1的分数")
pyplot.ylabel("测验2的分数")
pyplot.show()