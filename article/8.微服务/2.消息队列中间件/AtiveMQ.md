---
sort: 5
---
# ActiveMQ


官网：http://activemq.apache.org

解压即可启动
```text
运行bin/win64/activemq.bat即可
ActiveMQ 服务启动地址：http://127.0.0.1:8161/admin/ 
用户名/密码 admin/admin
修改密码在conf/users.properties 和 conf/group.properties
```

## 1.什么是JMS	

JMS即Java消息服务（Java Message Service）应用程序接口，是一个Java平台中关于面向消息中间件（MOM）的API，
用于在两个应用程序之间， 或分布式系统中发送消息，进行异步通信。Java消息服务是一个与具体平台无关的API，
绝大多数MOM提供商都对JMS提供支持。

## 2.JMS体系架构

JMS提供者(provider):连接面向消息中间件的，JMS接口的一个实现。
提供者可以是Java平台的JMS实现，也可以是非Java平台的面向消息中间件的适配器。

JMS客户:生产或消费基于消息的Java的应用程序或对象。

JMS生产者(producer):创建并发送消息的JMS客户。

JMS消费者(consumer):	接收消息的JMS客户。

JMS消息(message):包括可以在JMS客户之间传递的数据的对象

JMS队列(queue):一个容纳那些被发送的等待阅读的消息的区域。与队列名字所暗示的意思不同，消息的接受顺序并不一定要与消息的发送顺序相同。一旦一个消息被阅读，该消息将被从队列中移走。

JMS主题(topic):一种支持发送消息给多个订阅者的机制。

## 3.对象模型

1. 连接工厂。连接工厂（ConnectionFactory）是由管理员创建，并绑定到JNDI树中。客户端使用JNDI查找连接工厂，然后利用连接工厂创建一个JMS连接。

2. JMS连接。JMS连接（Connection）表示JMS客户端和服务器端之间的一个活动的连接，是由客户端通过调用连接工厂的方法建立的。

3. JMS会话。JMS会话（Session）表示JMS客户与JMS服务器之间的会话状态。JMS会话建立在JMS连接上，表示客户与服务器之间的一个会话线程。

4. JMS目的。JMS目的（Destination），又称为消息队列，是实际的消息源。

5. JMS生产者和消费者。生产者（Message Producer）和消费者（Message Consumer）对象由Session对象创建，用于发送和接收消息。

6. JMS消息通常有两种类型： 
- 点对点（Point-to-Point）。
	消费者只能主动去获得消息或注册监听器获得消息。在点对点的消息系统中，消息分发给一个单独的使用者。点对点消息往往与队列（javax.jms.Queue）相关联。

- 发布/订阅（Publish/Subscribe）。
	发布/订阅消息系统支持一个事件驱动模型，消息生产者和消费者都参与消息的传递。生产者发布事件，而使用者订阅感兴趣的事件，并使用事件。该类型消息一般与特定的主题（javax.jms.Topic）关联。

## 4.消息类型

JMS定义了五种不同的消息正文格式，以及调用的消息类型，允许你发送并接收以一些不同形式的数据，提供现有消息格式的一些级别的兼容性。

- StreamMessage -- Java原始值的数据流
- MapMessage--一套键值对
- TextMessage--一个字符串对象（最常用）
- ObjectMessage--一个序列化的 Java对象
- BytesMessage--一个未解释字节的数据流
	


































