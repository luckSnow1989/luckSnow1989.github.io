---
sort: 3
---

# hibernate

## 1.介绍
hibernate: 持久层框架，也称为ORM框架
- Object         对象
- Relational     关系型数据库 
- Mapping        映射

JDBC依赖于SQL，属于结构化语言，是一种不完全的面向对象的方式而hibernate能做到完全面向对象的方式操作数据库

实现了JavaEE的规范JPA

jdbc与hibernate的对比

优点
1. 比较简单;
2. 数据缓存：一级缓存    二级缓存   查询缓存;
3. 移植性比较好。

缺点
1. 因为sql语句是hibernate内部生成的，所以程序员干预不了，不可控;(如对sql语句的优化等级非常高，不适合hibernate)
2. 如果数据库特别大，不适合用hibernate;

## 2.教程

基础教程：[https://www.w3cschool.cn/hibernate/](https://www.w3cschool.cn/hibernate/)

进阶教程：[https://www.w3cschool.cn/hibernate_articles/](https://www.w3cschool.cn/hibernate_articles/)
