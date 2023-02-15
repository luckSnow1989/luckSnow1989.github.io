SQL> host cls

SQL> --等值连接
SQL> --查询员工信息： 员工号 姓名 月薪 部门名称
SQL> select e.empno,e.ename,e.sal,d.dname
  2  from emp e,dept d
  3  where e.deptno=d.deptno;

     EMPNO ENAME             SAL DNAME                                          
---------- ---------- ---------- --------------                                 
      7369 SMITH             800 RESEARCH                                       
      7499 ALLEN            1600 SALES                                          
      7521 WARD             1250 SALES                                          
      7566 JONES            2975 RESEARCH                                       
      7654 MARTIN           1250 SALES                                          
      7698 BLAKE            2850 SALES                                          
      7782 CLARK            2450 ACCOUNTING                                     
      7788 SCOTT            3000 RESEARCH                                       
      7839 KING             5000 ACCOUNTING                                     
      7844 TURNER           1500 SALES                                          
      7876 ADAMS            1100 RESEARCH                                       

     EMPNO ENAME             SAL DNAME                                          
---------- ---------- ---------- --------------                                 
      7900 JAMES             950 SALES                                          
      7902 FORD             3000 RESEARCH                                       
      7934 MILLER           1300 ACCOUNTING                                     

已选择14行。

SQL>  --不等值连接
SQL> --查询员工信息： 员工号 姓名 月薪 工资级别
SQL> select * from salgrade;

     GRADE      LOSAL      HISAL                                                
---------- ---------- ----------                                                
         1        700       1200                                                
         2       1201       1400                                                
         3       1401       2000                                                
         4       2001       3000                                                
         5       3001       9999                                                

SQL> select e.empno,e.ename,e.sal,s.grade
  2  from emp e,salgrade s
  3  where e.sal between s.losal and s.hisal;

     EMPNO ENAME             SAL      GRADE                                     
---------- ---------- ---------- ----------                                     
      7369 SMITH             800          1                                     
      7900 JAMES             950          1                                     
      7876 ADAMS            1100          1                                     
      7521 WARD             1250          2                                     
      7654 MARTIN           1250          2                                     
      7934 MILLER           1300          2                                     
      7844 TURNER           1500          3                                     
      7499 ALLEN            1600          3                                     
      7782 CLARK            2450          4                                     
      7698 BLAKE            2850          4                                     
      7566 JONES            2975          4                                     

     EMPNO ENAME             SAL      GRADE                                     
---------- ---------- ---------- ----------                                     
      7788 SCOTT            3000          4                                     
      7902 FORD             3000          4                                     
      7839 KING             5000          5                                     

已选择14行。

SQL> host cls

SQL> --外连接
SQL> --按部门统计员工人数： 部门号 部门名称 人数
SQL> select d.deptno,d.dname,count(e.empno)
  2  from emp e,dept d
  3  where e.deptno=d.deptno
  4  group by d.deptno,d.dname;

    DEPTNO DNAME          COUNT(E.EMPNO)                                        
---------- -------------- --------------                                        
        10 ACCOUNTING                  3                                        
        20 RESEARCH                    5                                        
        30 SALES                       6                                        

SQL> ed
已写入 file afiedt.buf

  1  select d.deptno 部门号,d.dname 部门名称,count(e.empno) 人数
  2  from emp e,dept d
  3  where e.deptno=d.deptno
  4* group by d.deptno,d.dname
SQL> /

    部门号 部门名称             人数                                            
---------- -------------- ----------                                            
        10 ACCOUNTING              3                                            
        20 RESEARCH                5                                            
        30 SALES                   6                                            

SQL> select count(*) from emp;

  COUNT(*)                                                                      
----------                                                                      
        14                                                                      

SQL> select * from dept;

    DEPTNO DNAME          LOC                                                   
---------- -------------- -------------                                         
        10 ACCOUNTING     NEW YORK                                              
        20 RESEARCH       DALLAS                                                
        30 SALES          CHICAGO                                               
        40 OPERATIONS     BOSTON                                                

SQL> select * from emp where deptno=40;

未选定行

SQL> /*
SQL> 希望： 在最后的结果中，包含某些不成立的记录
SQL> 外连接:
SQL> 左外连接: 当where e.deptno=d.deptno不成立的时候,等号左边所代表的表 任然被包含
SQL>         写法: where e.deptno=d.deptno(+)
SQL> 右外连接: 当where e.deptno=d.deptno不成立的时候,等号右边所代表的表 任然被包含
SQL>         写法:where e.deptno(+)=d.deptno
SQL> */
SQL> select d.deptno,d.dname,count(e.empno)
  2  from emp e,dept d
  3  where e.deptno(+)=d.deptno
  4  group by d.deptno,d.dname;

    DEPTNO DNAME          COUNT(E.EMPNO)                                        
---------- -------------- --------------                                        
        10 ACCOUNTING                  3                                        
        40 OPERATIONS                  0                                        
        20 RESEARCH                    5                                        
        30 SALES                       6                                        

SQL> ed
已写入 file afiedt.buf

  1  select d.deptno,d.dname,count(e.empno)
  2  from emp e,dept d
  3  where e.deptno(+)=d.deptno
  4  group by d.deptno,d.dname
  5* order by 1
SQL> /

    DEPTNO DNAME          COUNT(E.EMPNO)                                        
---------- -------------- --------------                                        
        10 ACCOUNTING                  3                                        
        20 RESEARCH                    5                                        
        30 SALES                       6                                        
        40 OPERATIONS                  0                                        

SQL> host cls

SQL> --自连接
SQL> --查询员工信息：***的老板是***
SQL> 
SQL> select * from emp;

     EMPNO ENAME      JOB              MGR HIREDATE              SAL       COMM 
---------- ---------- --------- ---------- -------------- ---------- ---------- 
    DEPTNO                                                                      
----------                                                                      
      7369 SMITH      CLERK           7902 17-12月-80            800            
        20                                                                      
                                                                                
      7499 ALLEN      SALESMAN        7698 20-2月 -81           1600        300 
        30                                                                      
                                                                                
      7521 WARD       SALESMAN        7698 22-2月 -81           1250        500 
        30                                                                      
                                                                                

     EMPNO ENAME      JOB              MGR HIREDATE              SAL       COMM 
---------- ---------- --------- ---------- -------------- ---------- ---------- 
    DEPTNO                                                                      
----------                                                                      
      7566 JONES      MANAGER         7839 02-4月 -81           2975            
        20                                                                      
                                                                                
      7654 MARTIN     SALESMAN        7698 28-9月 -81           1250       1400 
        30                                                                      
                                                                                
      7698 BLAKE      MANAGER         7839 01-5月 -81           2850            
        30                                                                      
                                                                                

     EMPNO ENAME      JOB              MGR HIREDATE              SAL       COMM 
---------- ---------- --------- ---------- -------------- ---------- ---------- 
    DEPTNO                                                                      
----------                                                                      
      7782 CLARK      MANAGER         7839 09-6月 -81           2450            
        10                                                                      
                                                                                
      7788 SCOTT      ANALYST         7566 13-7月 -87           3000            
        20                                                                      
                                                                                
      7839 KING       PRESIDENT            17-11月-81           5000            
        10                                                                      
                                                                                

     EMPNO ENAME      JOB              MGR HIREDATE              SAL       COMM 
---------- ---------- --------- ---------- -------------- ---------- ---------- 
    DEPTNO                                                                      
----------                                                                      
      7844 TURNER     SALESMAN        7698 08-9月 -81           1500          0 
        30                                                                      
                                                                                
      7876 ADAMS      CLERK           7788 13-7月 -87           1100            
        20                                                                      
                                                                                
      7900 JAMES      CLERK           7698 03-12月-81            950            
        30                                                                      
                                                                                

     EMPNO ENAME      JOB              MGR HIREDATE              SAL       COMM 
---------- ---------- --------- ---------- -------------- ---------- ---------- 
    DEPTNO                                                                      
----------                                                                      
      7902 FORD       ANALYST         7566 03-12月-81           3000            
        20                                                                      
                                                                                
      7934 MILLER     CLERK           7782 23-1月 -82           1300            
        10                                                                      
                                                                                

已选择14行。

SQL> set linesize 120
SQL> col sal for 999
SQL> col sal for 9999
SQL> host cls

SQL> select * from emp;

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7369 SMITH      CLERK           7902 17-12月-80       800                    20                                   
      7499 ALLEN      SALESMAN        7698 20-2月 -81      1600        300         30                                   
      7521 WARD       SALESMAN        7698 22-2月 -81      1250        500         30                                   
      7566 JONES      MANAGER         7839 02-4月 -81      2975                    20                                   
      7654 MARTIN     SALESMAN        7698 28-9月 -81      1250       1400         30                                   
      7698 BLAKE      MANAGER         7839 01-5月 -81      2850                    30                                   
      7782 CLARK      MANAGER         7839 09-6月 -81      2450                    10                                   
      7788 SCOTT      ANALYST         7566 13-7月 -87      3000                    20                                   
      7839 KING       PRESIDENT            17-11月-81      5000                    10                                   
      7844 TURNER     SALESMAN        7698 08-9月 -81      1500          0         30                                   
      7876 ADAMS      CLERK           7788 13-7月 -87      1100                    20                                   

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7900 JAMES      CLERK           7698 03-12月-81       950                    30                                   
      7902 FORD       ANALYST         7566 03-12月-81      3000                    20                                   
      7934 MILLER     CLERK           7782 23-1月 -82      1300                    10                                   

已选择14行。

SQL> --自连接：通过表的别名，将同一张表视为多张表
SQL> select e.ename||'的老板是'||b.ename
  2  from emp e,emp b
  3  where e.mgr=b.empno;

E.ENAME||'的老板是'||B.ENAME                                                                                            
----------------------------                                                                                            
FORD的老板是JONES                                                                                                       
SCOTT的老板是JONES                                                                                                      
JAMES的老板是BLAKE                                                                                                      
TURNER的老板是BLAKE                                                                                                     
MARTIN的老板是BLAKE                                                                                                     
WARD的老板是BLAKE                                                                                                       
ALLEN的老板是BLAKE                                                                                                      
MILLER的老板是CLARK                                                                                                     
ADAMS的老板是SCOTT                                                                                                      
CLARK的老板是KING                                                                                                       
BLAKE的老板是KING                                                                                                       

E.ENAME||'的老板是'||B.ENAME                                                                                            
----------------------------                                                                                            
JONES的老板是KING                                                                                                       
SMITH的老板是FORD                                                                                                       

已选择13行。

SQL> select count(*)
  2  from emp e,emp b;

  COUNT(*)                                                                                                              
----------                                                                                                              
       196                                                                                                              

SQL> --层次查询
SQL> desc emp
 名称                                                              是否为空? 类型
 ----------------------------------------------------------------- -------- --------------------------------------------
 EMPNO                                                             NOT NULL NUMBER(4)
 ENAME                                                                      VARCHAR2(10)
 JOB                                                                        VARCHAR2(9)
 MGR                                                                        NUMBER(4)
 HIREDATE                                                                   DATE
 SAL                                                                        NUMBER(7,2)
 COMM                                                                       NUMBER(7,2)
 DEPTNO                                                                     NUMBER(2)

SQL> select level,empno,ename,sal,mgr
  2  from emp
  3  connect by prior empno=mgr
  4  start with mgr is null
  5  order by 1;

     LEVEL      EMPNO ENAME        SAL        MGR                                                                       
---------- ---------- ---------- ----- ----------                                                                       
         1       7839 KING        5000                                                                                  
         2       7566 JONES       2975       7839                                                                       
         2       7698 BLAKE       2850       7839                                                                       
         2       7782 CLARK       2450       7839                                                                       
         3       7902 FORD        3000       7566                                                                       
         3       7521 WARD        1250       7698                                                                       
         3       7900 JAMES        950       7698                                                                       
         3       7934 MILLER      1300       7782                                                                       
         3       7499 ALLEN       1600       7698                                                                       
         3       7788 SCOTT       3000       7566                                                                       
         3       7654 MARTIN      1250       7698                                                                       

     LEVEL      EMPNO ENAME        SAL        MGR                                                                       
---------- ---------- ---------- ----- ----------                                                                       
         3       7844 TURNER      1500       7698                                                                       
         4       7876 ADAMS       1100       7788                                                                       
         4       7369 SMITH        800       7902                                                                       

已选择14行。

SQL> /*
SQL> 执行的过程:
SQL> 1. KING: start with mgr is null ---> empno=7839
SQL> 2. where mgr = 7839; ---> 7566 7698 7782
SQL> 3. where mgr in (7566 7698 7782)*/
SQL> spool off
