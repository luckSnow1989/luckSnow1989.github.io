---
sort: 1
---
# jmeter

Apache JMeter是一款纯java编写负载功能测试和性能测试开源工具软件。

相比Loadrunner而言，JMeter小巧轻便且免费，逐渐成为了主流的性能测试工具，是每个测试人员都必须要掌握的工具之一。

本文为JMeter性能测试完整入门篇，从Jmeter下载安装到编写一个完整性能测试脚本、最终执行性能测试并分析性能测试结果。

运行环境为Windows 10系统，JDK版本为1.8，JMeter版本为3.3。

## 1.Jmeter安装

### 1.1.JDK安装

由于Jmeter是基于java开发，首先需要下载安装JDK （目前JMeter只支持到Java 8，尚不支持 Java 9）\ 
1.
官网下载地址：http://www.oracle.com/technetwork/java/javase/downloads/index.html\
2. 选择Java SE 8u151/ 8u152，点击JDK下载\
![image](img/jmeter/media/image1.png)
\
3. 安装下载的JDK\
4. 配置系统环境变量

### 1.2.JMeter安装

- 官网下载地址：http://jmeter.apache.org/download_jmeter.cgi

- 下载最新JMeter 3.3版本：apache-jmeter-3.3.zip\
    ![image](img/jmeter/media/image2.png)
    


- 下载完成后解压zip包


- 启动JMeter\
    双击JMeter解压路径（apache-jmeter-3.3\\bin）bin下面的jmeter.bat即可\
    ![image](img/jmeter/media/image3.png)
    

## 2.测试实例

我们选取最常见的百度搜索接口：

### 2.1.接口地址

http://www.baidu.com/s?ie=utf-8&wd=jmeter性能测试

### 2.2.请求参数

ie：编码方式，默认为utf-8\
wd: 搜索词

### 2.3.返回结果

搜索结果，我们可以通过校验结果中是否含有搜索词wd来判断本次请求成功或失败。

## 3.JMeter脚本编写

### 3.1.添加线程组

右键点击“测试计划” -> “添加” -> “Threads(Users)” -> “线程组”\
![image](img/jmeter/media/image4.png)
\
这里可以配置线程组名称，线程数，准备时长（Ramp-Up Period(in
seconds)）循环次数，调度器等参数：\
![image](img/jmeter/media/image5.png)
\
线程组参数详解：\
1.
线程数：虚拟用户数。一个虚拟用户占用一个进程或线程。设置多少虚拟用户数在这里也就是设置多少个线程数。\
2. Ramp-Up Period(in
seconds)准备时长：设置的虚拟用户数需要多长时间全部启动。如果线程数为10，准备时长为2，那么需要2秒钟启动10个线程，也就是每秒钟启动5个线程。\
3.
循环次数：每个线程发送请求的次数。如果线程数为10，循环次数为100，那么每个线程发送100次请求。总请求数为10*100=1000
。如果勾选了“永远”，那么所有线程会一直发送请求，一到选择停止运行脚本。\
4. Delay Thread creation until needed：直到需要时延迟线程的创建。\
5.
调度器：设置线程组启动的开始时间和结束时间(配置调度器时，需要勾选循环次数为永远)\
持续时间（秒）：测试持续时间，会覆盖结束时间\
启动延迟（秒）：测试延迟启动时间，会覆盖启动时间\
启动时间：测试启动时间，启动延迟会覆盖它。当启动时间已过，手动只需测试时当前时间也会覆盖它。\
结束时间：测试结束时间，持续时间会覆盖它。

因为接口调试需要，我们暂时均使用默认设置，待后面真正执行性能测试时再回来配置。

### 3.2.添加HTTP请求

右键点击“线程组” -> “添加” -> “Sampler” -> “HTTP请求”\
![image](img/jmeter/media/image6.png)
\
对于我们的接口http://www.baidu.com/s?ie=utf-8&wd=jmeter性能测试，可以参考下图填写：\
![image](img/jmeter/media/image7.png)
\
Http请求主要参数详解：

Web服务器\
协议：向目标服务器发送HTTP请求协议，可以是HTTP或HTTPS，默认为HTTP\
服务器名称或IP ：HTTP请求发送的目标服务器名称或IP\
端口号：目标服务器的端口号，默认值为80\
2.Http请求\
方法：发送HTTP请求的方法，可用方法包括GET、POST、HEAD、PUT、OPTIONS、TRACE、DELETE等。\
路径：目标URL路径（URL中去掉服务器地址、端口及参数后剩余部分）\
Content encoding ：编码方式，默认为ISO-8859-1编码，这里配置为utf-8

同请求一起发送参数\
在请求中发送的URL参数，用户可以将URL中所有参数设置在本表中，表中每行为一个参数（对应URL中的
name=value），注意参数传入中文时需要勾选“编码”

### 3.3.添加察看结果树

右键点击“线程组” -> “添加” -> “监听器” -> “察看结果树”\
![image](img/jmeter/media/image8.png)
\
这时，我们运行Http请求，修改响应数据格式为“HTML Source
Formatted”，可以看到本次搜索返回结果页面标题为”jmeter性能测试_百度搜索“。\
![image](img/jmeter/media/image9.png)


### 3.4.添加用户自定义变量

我们可以添加用户自定义变量用以Http请求参数化，右键点击“线程组” ->
“添加” -> “配置元件” -> “用户定义的变量”：\
![image](img/jmeter/media/image10.png)
\
新增一个参数wd，存放搜索词：\
![image](img/jmeter/media/image11.png)
\
并在Http请求中使用该参数，格式为：${wd}\
![image](img/jmeter/media/image12.png)


### 3.5.添加断言

右键点击“HTTP请求” -> “添加”-> “断言” -> “响应断言”\
![image](img/jmeter/media/image13.png)
\
我们校验返回的文本中是否包含搜索词，添加参数${wd}到要测试的模式中：\
![image](img/jmeter/media/image14.png)


### 3.6.添加断言结果

右键点击“HTTP请求” -> “添加”-> “监听器” -> “断言结果”\
![image](img/jmeter/media/image15.png)


这时，我们再运行一次就可以看到断言结果成功或失败了\
![image](img/jmeter/media/image16.png)


### 3.7.添加聚合报告

右键点击“线程组” -> “添加” -> “监听器” ->
“聚合报告”，用以存放性能测试报告\
![image](img/jmeter/media/image17.png)
\
这样，我们就完成了一个完整Http接口的JMeter性能测试脚本编写。

## 4.执行性能测试

### 4.1.配置线程组

点击线程组，配置本次性能测试相关参数：线程数，循环次数，持续时间等，这里我们配置并发用户数为10，持续时间为60s\
![image](img/jmeter/media/image18.png)


### 4.2.执行测试

点击绿色小箭头按钮即可启动测试，测试之前需要点击小扫把按钮清除之前的调试结果。\
![image](img/jmeter/media/image19.png)


## 5.分析测试报告

待性能测试执行完成后，打开聚合报告可以看到：\
![image](img/jmeter/media/image20.png)


聚合报告参数详解：\
1. Label：每个 JMeter 的 element（例如 HTTP Request）都有一个 Name
属性，这里显示的就是 Name 属性的值\
2.
#Samples：请求数——表示这次测试中一共发出了多少个请求，如果模拟10个用户，每个用户迭代10次，那么这里显示100\
3. Average：平均响应时间——默认情况下是单个 Request
的平均响应时间，当使用了 Transaction Controller 时，以Transaction
为单位显示平均响应时间\
4. Median：中位数，也就是 50％ 用户的响应时间\
5. 90% Line：90％ 用户的响应时间\
6. Min：最小响应时间\
7. Max：最大响应时间\
8. Error%：错误率——错误请求数/请求总数\
9. Throughput：吞吐量——默认情况下表示每秒完成的请求数（Request per
Second），当使用了 Transaction Controller 时，也可以表示类似 LoadRunner
的 Transaction per Second 数\
10.
KB/Sec：每秒从服务器端接收到的数据量，相当于LoadRunner中的Throughput/Sec

一般而言，性能测试中我们需要重点关注的数据有： #Samples 请求数，Average
平均响应时间，Min 最小响应时间，Max 最大响应时间，Error%
错误率及Throughput 吞吐量。



## 6.Linux运行

我们通常是在服务器上运行jmeter进行压测的，jmeter也提供了命令行的执行方式。

PS:前提，我们已经使用界面的方式编辑好了测试计划。

### 6.1.使用说明
```text
--? 打印命令行选项并退出
-h、 --帮助   打印使用信息和退出
-v、 --版本 打印版本信息并退出
-p、 --propfile<argument> 要使用的jmeter属性文件
-q、 --addprop<argument>	其他JMeter属性文件
-t、 --测试文件<argument>	要运行的jmeter测试（.jmx）文件。“-t LAST“将最后加载用过的文件
	表示要运行的jmx文件
-l、 --日志文件<argument>	要将样本记录到的文件
-i、 --jmeterlogconf<argument>	jmeter日志记录配置文件（log4j2.xml）
-j、 --jmeterlogfile<argument>	jmeter运行日志文件（jmeter.log）
-n、 --非GUI	在非gui模式下运行JMeter
-s、 --服务器	运行JMeter服务器
-E、 --proxyScheme<argument>	设置用于代理服务器的代理方案
-H、 --proxyHost<argument>	设置JMeter使用的代理服务器
-P、 --proxyPort<argument>	设置JMeter要使用的代理服务器端口
-N、 --非代理主机<argument>	设置非代理主机列表（例如：*.apache.org | localhost）
-u、 --用户名<argument>	设置JMeter要使用的代理服务器的用户名
-a、 --密码<argument>	为JMeter要使用的代理服务器设置密码
-J、 --jmeterproperty<argument>=<value>	定义其他JMeter属性
******使用命令的方式，修改jmx中的配置

-G、 --全局属性<argument>=<value>	定义全局属性（发送到服务器）例如：-Gport=123或-Gglobal.properties
-D、 --系统属性<argument>=<value>	定义其他系统属性
-S、 --系统属性文件<argument>	其他系统属性文件
-f、 --强制删除结果文件	强制删除现有结果文件和Web报表文件夹开始测试前在场
-L、 --loglevel<argument>=<value>	[category=]level 例如：jorphan=INFO, jmeter.util=DEBUG or com.example.foo=WARN
-r、 --运行远程	启动远程服务器（在远程主机中定义）	指远程将所有agent启动
-R、 --远程启动<argument>	启动这些远程服务器（覆盖远程主机）
-d、 --homedir<argument>	要使用的jmeter主目录
-X、 --远程退出	在测试结束时退出远程服务器（非GUI）
-g、 --reportonly<argument>	仅从测试结果文件生成报表仪表板
	specifies the existing result file 指定已存在的结果文件
-e、 --报告的ndofloadtests	负载测试后生成报表仪表板
-o、 --reportoutputfolder<argument>	保存html报告的路径, 此文件夹必须为空或者不存在
```

### 6.2.案例
案例
```shell
# t 执行本地脚本, l 记录详细日志, e 生成html格式的报告,-o指定报告的目录
jmeter -n -t 测试计划.jmx -l test.jtl -e -o ./report

#1、本地运行脚本并生成测试报告，其中测试报告的后缀名为jtl
jmeter -n -t 脚本路径 -l 测试报告路径

#2、远程运行脚本并生成测试报告，其中测试报告的后缀名为jtl
jmeter -n -t 脚本路径 -r -l 测试报告路径

#3、远程运行脚本并生成测试报告，其中测试报告的后缀名为jtl
jmeter -n -t 脚本路径 -R 负载机IP -l 测试报告路径

#4、本地运行并生成网页版测试报告，其中测试结果路径为空目录
jmeter -n -t 脚本路径 -l 测试报告路径 -e -o 测试结果路径

#5、把jtl格式的测试结果文件转换为html格式
jmeter -g 测试结果路径 -o html报告路径

#6、本地运行脚本并生成测试报告，把线程数和循环次数在命令行配置
jmeter -n -t 脚本路径 -l 测试结果路径 -JthreadNum=50 -JloopNum=10
```

### 6.3.用户自定义变量
借助 -J参数，利用函数助手对话框的 P 函数设置获取命令行属性

![](img/087556b3.png)

```shell
jmeter -n -t 脚本路径 -l 测试结果路径 -JURL=www.baidu.com?abc=1
```

### 6.4.分布式测试
很多时候，需要多台服务器通知进行压测。并汇总结果

1.首先需要压测的服务器必须都有jmeter,以及相同的测试计划文件。

2.修改配置文件，jmeter.properties。下面三台服务器是运行测试计划的，就是slave。
我们执行启动命令的服务器是master，由于master机器作为调度机本身会有一定的性能消耗所以我们配置远程执行机的时候并没有把master机器配置进去，
只配置了3台执行机。【当然也是可以把master配置进去一起参与测试】


```properties
# 我们配置 remote_hosts 在调度服务器
remote_hosts=192.168.1.10:7899,192.168.1.11:7899,192.168.1.12:7899

# 各自服务的端口
server_port=7899
```

3.上面配置的3台服务器执行命令，进入等待接收命令的状态。
```shell
./jmeter-server
```

4.确认3台slave执行机都启动正确完成后，在启动master机器，执行如下命令开启分布式测试

其中-r会自动找remote_hosts中配置的服务器，当然我们也可以使用参数传入进去

```shell
./jmeter -n -t baidu_requests_results.jmx -r -l baidu_requests_results.jtl
```

## 7.最佳实践

Jmeter压测减少资源使用的一些建议，即压测结果会更准确

1、使用非GUI模式（也就是CLI，Command Line Interface，命令行界面）：jmeter -n -t test.jmx -l result.jtl

2、少使用Listener， 如果使用-l参数，它们都可以被删除或禁用

3、在加载测试期间不要使用“查看结果树”或“用表格查看结果”监听器，只能在脚本阶段使用它们来调试脚本

4、包含控制器在这里没有帮助，因为它将文件中的所有测试元素添加到测试计划中

5、不要使用功能模式

6、使用CSV输出而不是XML

7、只保存你需要的数据

8、尽可能少地使用断言

9、如果测试需要大量数据，尤其是需要将其随机化，可以提前准备好测试数据放到数据文件中，从CSV数据集中读取， 这样可以避免在运行时浪费资源

10、设置内存。修改jmeter.sh 在文件头部增加即可。

```shell
JVM_ARGS="-Xms1G -Xmx5G -XX:MaxPermSize=512m"
```