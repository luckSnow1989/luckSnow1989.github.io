一、CGI
	
	CGI是一种旧的web应用开发模式，现在不推荐使用，学习下就好
	CGI(Common Gateway Interface),通用网关接口,它是一段程序,运行在服务器上如：HTTP服务器，提供同客户端HTML页面的接口。

二、网页浏览

	为了更好的了解CGI是如何工作的，我们可以从在网页上点击一个链接或URL的流程：
	1、使用你的浏览器访问URL并连接到HTTP web 服务器。
	2、Web服务器接收到请求信息后会解析URL，并查找访问的文件在服务器上是否存在，如果存在返回文件的内容，否则返回错误信息。
	3、浏览器从服务器上接收信息，并显示接收的文件或者错误信息。
	CGI程序可以是Python脚本，PERL脚本，SHELL脚本，C或者C++程序等。

三、搭建CGI服务器

	参考：http://blog.csdn.net/a1083595345/article/details/52371677

四、访问URL

	1.get请求
		(1)hello_get.py,放在Apache服务器上的cgi-bin目录下
			#!C:\Program Files\Python35\python.exe
			# coding=utf-8
			'''
			Created on 2017年5月2日
			@author: zhangx
			'''
			# CGI处理模块
			import cgi, cgitb 
			
			# 创建 FieldStorage 的实例化
			form = cgi.FieldStorage() 
			
			# 获取数据
			site_name = form.getvalue('name')
			site_url  = form.getvalue('url')
			
			print("Content-type:text/html")
			print()
			print("<html>")
			print("<head>")
			print("<meta charset=gbk>")
			print("<title>菜鸟教程CGI测试实例</title>")
			print("</head>")
			print("<body>")
			print("<h2>%s官网：%s</h2>" % (site_name, site_url))
			print("</body>")
			print("</html>")
		
		(2)页面
			<!DOCTYPE html>
			<html>
			<head>
			<meta charset="utf-8">
			<title>菜鸟教程(runoob.com)</title>
			</head>
			<body>
			<form action="/cgi-bin/hello_get.py" method="get">
			站点名称: <input type="text" name="name"><br />
			站点 URL: <input type="text" name="url" />
			<input type="submit" value="提交" />
			</form>
			</body>
			</html>

	2.post方法,放在htdocs目录下
		将页面method="get"-->method="post"

五、上传文件
	
	1.py文件
		#!C:\Program Files\Python35\python.exe
		# -*- coding: utf-8 -*-  
		'''
		Created on 2017年5月2日
		@author: zhangx
		'''
		import cgi, os
		import cgitb; cgitb.enable()
		
		form = cgi.FieldStorage()
		
		# 获取文件名
		fileitem = form['filename']
		
		# 检测文件是否上传
		if fileitem.filename:
		    # 设置文件路径 
		    fn = os.path.basename(fileitem.filename)
		    open(fn, 'wb').write(fileitem.file.read())
		
		    message = '文件 "' + fn + '" 上传成功'
		   
		else:
		    message = '文件没有上传'
		   
		print ("""\
		Content-Type: text/html\n
		<html>
		<head>
		<meta charset=gbk>
		<title>菜鸟教程(runoob.com)</title>
		</head>
		<body>
		   <p>%s</p>
		</body>
		</html>
		""" % (message,))
	
	
	2.页面
		<!DOCTYPE html>
		<html>
		<head>
		<meta charset="utf-8">
		<title>菜鸟教程(runoob.com)</title>
		</head>
		<body>
		 <form enctype="multipart/form-data"  action="/cgi-bin/save_file.py" method="post">
		   <p>选中文件: <input type="file" name="filename" /></p>
		   <p><input type="submit" value="上传" /></p>
		   </form>
		</body>
		</html>
