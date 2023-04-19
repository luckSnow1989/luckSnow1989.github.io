# Oracle

## 学习笔记
- [1oracle基本介绍.txt](学习笔记/1oracle基本介绍.txt)
- [2oracle基础.txt](学习笔记/2oracle基础.txt)
- [3单行函数.txt](学习笔记/3单行函数.txt)
- [4子查询、视图、约束.txt](学习笔记/4子查询、视图、约束.txt)
- [5oracle对象、集合运算、分级取回.txt](学习笔记/5oracle对象、集合运算、分级取回.txt)
- [6--1PLSQL语法、游标与存储过程.txt](学习笔记/6--1PLSQL语法、游标与存储过程.txt)
- [6--2触发器.txt](学习笔记/6--2触发器.txt)
- [6plsql编程.txt](学习笔记/6plsql编程.txt)
- [7【第三方工具】关于plsqldeveloper.txt](学习笔记/7【第三方工具】关于plsqldeveloper.txt)
- [8oracle用户和权限.txt](学习笔记/8oracle用户和权限.txt)
  
## 问题
- [oracle与MySQL字段创建时注意.txt](学习笔记/oracle与MySQL字段创建时注意.txt)
- [oracle基本命令.txt](学习笔记/oracle基本命令.txt)
- [oracle时间函数.txt](学习笔记/oracle时间函数.txt)
- [plsql编程练习题.docx](学习笔记/plsql编程练习题.docx)

## 高可用方案

Oracle提供了多种高可用性解决方案，包括 Oracle RAC、Data Guard等。
高可用性体系结构要求数据库和数据库客户端具有快速故障切换功能。所以提供了Oracle数据库驱动层面上的客户端故障切换功能，主要的功能包括重试连接、自动故障检测和故障转移等。
Oracle数据库提供了将数据库故障切换与故障切换过程集成的功能，故障切换过程在数据库故障切换后几秒钟内自动将客户端重定向到新的主数据库。


故障转移的工作流程如下：
1. 客户端连接时的故障转移，服务器端和客户端无需任何配置，缺省情况下即被开启，即failover=yes
2. 客户端的连接请求会逐个尝试列出的VIP，直到连接成功为止，如果所有不可连接，返回错误
3. 客户端已经建立后，服务器端实例或节点故障，都将导致客户端必须重新发起新的连接请求

### Oracle RAC


### Oracle Data Guard
- [Oracle Data Guard简介](http://blog.itpub.net/29785807/viewspace-2854651/)
  

### Oracle GoldenGate(OGG)
数据传输工具，本质就是一种日志级别的ETL工具。
- [Oracle GoldenGate(OGG)详细概述](https://blog.csdn.net/qq_42629988/article/details/121923847)
- [Oracle GoldenGate(OGG)基础知识整理](http://www.360doc.com/content/22/1207/09/1720440_1059278889.shtml)