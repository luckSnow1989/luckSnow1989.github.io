--1.数据字典也是一张表，由数据库管理员维护，程序员不可以直接操作(原则上是这样的)
select * from tab;
--在Oracle数据库中，表的种类分为两种
       --(1)包含商业数据的表：person,students
       --(2)数据字典：dictionary，user_objects,user_tables,user_tab_column，user_view
       
--2.查看dictionary的数据结构，命令行
desc dictionary
Name       Type           Nullable Default Comments                   
---------- -------------- -------- ------- -------------------------- 
TABLE_NAME VARCHAR2(30)   Y                Name of the object         
COMMENTS   VARCHAR2(4000) Y                Text comment on the object
              
--3.查看当前用户能使用那些数据字典
select * from dictionary

--4.查看当前用户创建的表
select * from user_tables

--5.数据字典的命名规则
       前缀                 说明
---------- -------------- -------- ------- -------------------------- 
       user_              用户自己的
       all_               用户可以访问到的
       dba_               管理员视图
       v$                 性能相关的数据

--6.给表添加注释
comment on table person is '我的测试数据';       
       
--7.查看自己的权限,视图
select * from session_privs  

--8.查看序列，视图
select * from user_synonyms   
       
--9.查看触发器,视图
select * from user_triggers
       
--10.查看创建的源代码,视图
select * from user_source
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
