SQL> host cls

SQL> select count(*) Total,
  2         sum(decode(to_char(hiredate,'RR'),'80',1,0)) "1980",
  3         sum(decode(to_char(hiredate,'RR'),'81',1,0)) "1981",
  4         sum(decode(to_char(hiredate,'RR'),'82',1,0)) "1982",
  5         sum(decode(to_char(hiredate,'RR'),'87',1,0)) "1987"
  6  from emp;

     TOTAL       1980       1981       1982       1987                          
---------- ---------- ---------- ---------- ----------                          
        14          1         10          1          2                          

SQL> host cls

SQL> /*
SQL> SQL类型
SQL> 1. DML(Data Manipulation Lanuage 数据操作语言): select insert update delete
SQL> 2. DDL(Data Definition Language 数据定义语言): create/alter/drop/truncate table
SQL>                                                create/drop view/sequence/index/synonym
SQL> 3. DCL(Data Control Language 数据控制语言): commit rollback
SQL> */
SQL> host cls

SQL> --插入数据 insert
SQL> insert into emp(empno,ename,sal ,deptno)
  2  values(1001,'Tom',6000,20);

已创建 1 行。

SQL> --隐式/显式插入null
SQL> --地址符   &
SQL> insert into emp(empno,ename,sal,deptno)
  2  values(&empno,&ename,&sal,&deptno);
输入 empno 的值:  1002
输入 ename 的值:  'Mary'
输入 sal 的值:  5000
输入 deptno 的值:  10
原值    2: values(&empno,&ename,&sal,&deptno)
新值    2: values(1002,'Mary',5000,10)

已创建 1 行。

SQL> /
输入 empno 的值:  1003
输入 ename 的值:  'Mike'
输入 sal 的值:  6000
输入 deptno 的值:  30
原值    2: values(&empno,&ename,&sal,&deptno)
新值    2: values(1003,'Mike',6000,30)

已创建 1 行。

SQL> ed
已写入 file afiedt.buf

  1  insert into emp(empno,ename,sal,deptno)
  2* values(&empno,'&ename',&sal,&deptno)
SQL> /
输入 empno 的值:  1004
输入 ename 的值:  Jerry
输入 sal 的值:  5000
输入 deptno 的值:  10
原值    2: values(&empno,'&ename',&sal,&deptno)
新值    2: values(1004,'Jerry',5000,10)

已创建 1 行。

SQL> host ls

SQL> host cls

SQL> select empno,ename,&t
  2  from emp;
输入 t 的值:  sal
原值    1: select empno,ename,&t
新值    1: select empno,ename,sal

     EMPNO ENAME             SAL                                                
---------- ---------- ----------                                                
      1001 Tom              6000                                                
      1002 Mary             5000                                                
      1003 Mike             6000                                                
      1004 Jerry            5000                                                
      7369 SMITH             800                                                
      7499 ALLEN            1600                                                
      7521 WARD             1250                                                
      7566 JONES            2975                                                
      7654 MARTIN           1250                                                
      7698 BLAKE            2850                                                
      7782 CLARK            2450                                                

     EMPNO ENAME             SAL                                                
---------- ---------- ----------                                                
      7788 SCOTT            3000                                                
      7839 KING             5000                                                
      7844 TURNER           1500                                                
      7876 ADAMS            1100                                                
      7900 JAMES             950                                                
      7902 FORD             3000                                                
      7934 MILLER           1300                                                

已选择18行。

SQL> /
输入 t 的值:  deptno
原值    1: select empno,ename,&t
新值    1: select empno,ename,deptno

     EMPNO ENAME          DEPTNO                                                
---------- ---------- ----------                                                
      1001 Tom                20                                                
      1002 Mary               10                                                
      1003 Mike               30                                                
      1004 Jerry              10                                                
      7369 SMITH              20                                                
      7499 ALLEN              30                                                
      7521 WARD               30                                                
      7566 JONES              20                                                
      7654 MARTIN             30                                                
      7698 BLAKE              30                                                
      7782 CLARK              10                                                

     EMPNO ENAME          DEPTNO                                                
---------- ---------- ----------                                                
      7788 SCOTT              20                                                
      7839 KING               10                                                
      7844 TURNER             30                                                
      7876 ADAMS              20                                                
      7900 JAMES              30                                                
      7902 FORD               20                                                
      7934 MILLER             10                                                

已选择18行。

SQL> select *
  2  from &t;
输入 t 的值:  dept
原值    2: from &t
新值    2: from dept

    DEPTNO DNAME          LOC                                                   
---------- -------------- -------------                                         
        10 ACCOUNTING     NEW YORK                                              
        20 RESEARCH       DALLAS                                                
        30 SALES          CHICAGO                                               
        40 OPERATIONS     BOSTON                                                

SQL> rollback;

回退已完成。

SQL> host cls

SQL> --批处理
SQL> create table emp10 as select * from emp where 1=2;

表已创建。

SQL> desc emp10
 名称                                      是否为空? 类型
 ----------------------------------------- -------- ----------------------------
 EMPNO                                              NUMBER(4)
 ENAME                                              VARCHAR2(10)
 JOB                                                VARCHAR2(9)
 MGR                                                NUMBER(4)
 HIREDATE                                           DATE
 SAL                                                NUMBER(7,2)
 COMM                                               NUMBER(7,2)
 DEPTNO                                             NUMBER(2)

SQL> select * from emp10;

未选定行

SQL> --一次性从emp中  将所有10号部门的员工插入到emp10
SQL> insert into emp10
  2  select * from emp where deptno=10;

已创建3行。

SQL> select * from emp10;

     EMPNO ENAME      JOB              MGR HIREDATE              SAL       COMM 
---------- ---------- --------- ---------- -------------- ---------- ---------- 
    DEPTNO                                                                      
----------                                                                      
      7782 CLARK      MANAGER         7839 09-6月 -81           2450            
        10                                                                      
                                                                                
      7839 KING       PRESIDENT            17-11月-81           5000            
        10                                                                      
                                                                                
      7934 MILLER     CLERK           7782 23-1月 -82           1300            
        10                                                                      
                                                                                

SQL> set linesize 120
SQL> col sal for 9999
SQL> host cls

SQL> --更新数据
SQL> --删除数据
SQL> /*
SQL> delete 和truncate的区别
SQL> 1. delete逐条删除 truncate 先摧毁表 再重建
SQL> 2. **** delete 是DML(可以回滚)，truncate是DDL(不可以回滚)
SQL> 3. delete不会释放空间 truncate会
SQL> 4. delete会产生碎片 truncate不会
SQL> 5. delete可以闪回，truncate不可以
SQL> */
SQL> set feedback off
SQL> @c:\sql.sql
SQL> select count(*) from testdelete;

  COUNT(*)                                                                                                              
----------                                                                                                              
      5000                                                                                                              
SQL> set timing on
SQL> delete from testdelete;
已用时间:  00: 00: 00.04
SQL> set timing off
SQL> drop table testdelete purge;
SQL> @c:\sql.sql
SQL> select count(*) from testdelete;

  COUNT(*)                                                                                                              
----------                                                                                                              
      5000                                                                                                              
SQL> set timing on
SQL> truncate table testdelete;
已用时间:  00: 00: 07.87
SQL> set timing off
SQL> host cls

SQL> /*
SQL> Oracle中的事务
SQL> 1. 起始标志: DML语句
SQL> 2. 结束标志: 提交: 显式提交 commit
SQL>                    隐式提交 正常退出exit ,DDL语句
SQL>              回滚: 显式  rollback
SQL>                    隐式  掉电,宕机，非正常退出
SQL> */
SQL> --保存点
SQL> create table testsavepoint
  2  (tid number,tname varchar2(20));
SQL> set feedback on
SQL> insert into testsavepoint values(1,'Tom');

已创建 1 行。

SQL> insert into testsavepoint values(2,'Mary');

已创建 1 行。

SQL> savepoint a;

保存点已创建。

SQL> insert into testsavepoint values(3,'Moke');

已创建 1 行。

SQL> select * from testsavepoint;

       TID TNAME                                                                                                        
---------- --------------------                                                                                         
         1 Tom                                                                                                          
         2 Mary                                                                                                         
         3 Moke                                                                                                         

已选择3行。

SQL> rollback to savepoint a;

回退已完成。

SQL> select * from testsavepoint;

       TID TNAME                                                                                                        
---------- --------------------                                                                                         
         1 Tom                                                                                                          
         2 Mary                                                                                                         

已选择2行。

SQL> commit;

提交完成。

SQL> spool off
