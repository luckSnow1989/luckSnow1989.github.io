# tomcat

## 1.介绍
Tomcat服务器由Apache提供，开源免费。由于Sun和其他公司参与到了Tomcat的开发中，所以最新的JSP/Servlet规范总是能在Tomcat中体现出来。

当前最新版本是Tomcat8，我们课程中使用Tomcat7。Tomcat7支持Servlet3.0，而Tomcat6只支持Servlet2.5！

## 2.Tomcat类加载
图解Tomcat类加载机制：https://www.cnblogs.com/aspirant/p/8991830.html

Tomcat的类加载机制是什么样的？是否违反双亲委派机制？
- https://mp.weixin.qq.com/s/4Kv58XUzbZyzvZCM1qx2eA
- https://mp.weixin.qq.com/s/YsW3MxozoxSrOeSCJOhuBQ

为什么要违反：1.为了保证多个webAPP之间的隔离性；2.提高公共类库的性能，不用重复加载。3.提高灵活性，热加载使用的是卸载响应的classloader。不影响别人。

当Tomcat启动时，会创建几种类加载器：
1. Bootstrap 引导类加载器 
加载JVM启动所需的类，以及标准扩展类（位于jre/lib/ext下）

2. System 系统类加载器 
加载Tomcat启动的类，比如bootstrap.jar，通常在catalina.bat或者catalina.sh中指定。位于CATALINA_HOME/bin下


3. Common 通用类加载器 
加载Tomcat使用以及应用通用的一些类，位于CATALINA_HOME/lib下，比如servlet-api.jar

4. webapp 应用类加载器
每个应用在部署后，都会创建一个唯一的类加载器。该类加载器会加载位于 WEB-INF/lib下的jar文件中的class 和 WEB-INF/classes下的class文件

当应用需要到某个类时，则会按照下面的顺序进行类加载：
1、使用bootstrap引导类加载器加载
2、使用system系统类加载器加载
3、使用应用类加载器在WEB-INF/classes中加载
4、使用应用类加载器在WEB-INF/lib中加载
5、使用common类加载器在CATALINA_HOME/lib中加载 


## 3.学习资源

### 3.1.Tomcat教程

<a target="_blank" href="./tomcat/tomcat">tomcat教程.txt</a>

<div name="wordShowDiv" word-url="./tomcat/Tomcat教程.docx"></div>

### 3.2.虚拟主机的目录层次

<div name="wordShowDiv" word-url="./tomcat/虚拟主机的目录层次.docx"></div>

### 3.3.Tomcat安装.docx

<div name="wordShowDiv" word-url="./tomcat/Tomcat安装.docx"></div>

### 3.4.Session共享

<div name="wordShowDiv" word-url="./tomcat/Session共享.docx"></div>

### 3.5.远程调试

[eclipse远程调试Tomcat方法](./tomcat/eclipse远程调试Tomcat方法.pdf)

### 3.6.Tomcat常用配置

<a target="_blank" href="./tomcat/Tomcat常用配置.sh">Tomcat常用配置</a>

### 3.7.tomcat7和tomcat8编码问题.txt

<a target="_blank" href="./tomcat/tomcat7和tomcat8编码问题.txt">tomcat7和tomcat8编码问题</a>
