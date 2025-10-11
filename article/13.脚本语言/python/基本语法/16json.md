一、json

	JSON (JavaScript Object Notation) 是一种轻量级的数据交换格式。它基于ECMAScript的一个子集。
	
	Python3 中可以使用 json 模块来对 JSON 数据进行编解码，它包含了两个函数：
		json.dumps(): 对数据进行编码。
		json.loads(): 对数据进行解码。
	
二、Python 编码为 JSON 类型转换对应表
	
	Python			    JSON
	dict				object
	list, tuple		    array
	str				    string
	number			    number
	True				true
	False				false
	None				null


三、操作基本数据类型

	import json
	data = {
	    'no' : 1,
	    'name' : 'Runoob',
	    'url' : 'http://www.runoob.com'
	}
	
	# Python字典类型转换为 JSON 对象
	json_str = json.dumps(data)
	print ("Python 原始数据：", repr(data))
	print ("JSON 对象：", json_str)
	
	# 将 JSON 对象转换为 Python 字典
	data2 = json.loads(json_str)
	print ("data2['name']: ", data2['name'])
	print ("data2['url']: ", data2['url'])

四、操作自定义类

    import json

    class Student(object):
        def __init__(self, name, age, score):
            self.name = name
            self.age = age
            self.score = score

    s = Student('Bob', 20, 88)
    print(s)

默认情况下，dumps()不知道如何将Student实例变为一个JSON的{}对象

    try:
        print(json.dumps(s))
    except:
        print("无法序列化")

使用__dict__,因为通常class的实例都有一个__dict__属性，它就是一个dict，用来存储实例变量

    str = json.dumps(s, default= lambda obj : s.__dict__)
    print(str)

如果我们要把一个json反序列化成一个实例，首先loads会转换出一个dict对象，然后，我们传入objcet_hook函数，将dict转换成实例

    def dict2student(d):
        return Student(d['name'], d['age'], d['score'])
    print(json.loads(str, object_hook=dict2student))
