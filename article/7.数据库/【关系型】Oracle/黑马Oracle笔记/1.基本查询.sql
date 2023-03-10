SQL> --1.清屏
SQL> host cls

SQL> --2.当前用户
SQL> show user
USER 为 "SCOTT"
SQL> --3.当前用户下的表
SQL> select * from tab;

TNAME                          TABTYPE  CLUSTERID                               
------------------------------ ------- ----------                               
DEPT                           TABLE                                            
EMP                            TABLE                                            
BONUS                          TABLE                                            
SALGRADE                       TABLE                                            

SQL> --4.tab: 数据字典(表)
SQL> desc emp
 名称                                      是否为空? 类型
 ----------------------------------------- -------- ----------------------------
 EMPNO                                     NOT NULL NUMBER(4)
 ENAME                                              VARCHAR2(10)
 JOB                                                VARCHAR2(9)
 MGR                                                NUMBER(4)
 HIREDATE                                           DATE
 SAL                                                NUMBER(7,2)
 COMM                                               NUMBER(7,2)
 DEPTNO                                             NUMBER(2)

SQL> --5.查询员工的所有信息
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

SQL> --6.设置行宽
SQL> set linesize 120
SQL> --设置列宽
SQL> col ename for a8
SQL> col sal for 9999
SQL> /

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     

已选择14行。

SQL> --7.通过列名
SQL> select empno,ename,job,mgr,hiredate,sal,comm,deptno
  2  from emp;

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     

已选择14行。

SQL> /*
SQL> SQL优化:
SQL> 1. 尽量使用列名(Orale9i之后，*和列名是一样的 )
SQL> */
SQL> host cls

SQL> --8.查询员工信息:员工号  姓名 月薪
SQL> select empno,ename,sal
  2  from emp;

     EMPNO ENAME      SAL                                                                                               
---------- -------- -----                                                                                               
      7369 SMITH      800                                                                                               
      7499 ALLEN     1600                                                                                               
      7521 WARD      1250                                                                                               
      7566 JONES     2975                                                                                               
      7654 MARTIN    1250                                                                                               
      7698 BLAKE     2850                                                                                               
      7782 CLARK     2450                                                                                               
      7788 SCOTT     3000                                                                                               
      7839 KING      5000                                                                                               
      7844 TURNER    1500                                                                                               
      7876 ADAMS     1100                                                                                               

     EMPNO ENAME      SAL                                                                                               
---------- -------- -----                                                                                               
      7900 JAMES      950                                                                                               
      7902 FORD      3000                                                                                               
      7934 MILLER    1300                                                                                               

已选择14行。

SQL> --9.查询员工信息:员工号  姓名 月薪 年薪
SQL> select empno,ename,sal,sal*12
  2  from emp;

     EMPNO ENAME      SAL     SAL*12                                                                                    
---------- -------- ----- ----------                                                                                    
      7369 SMITH      800       9600                                                                                    
      7499 ALLEN     1600      19200                                                                                    
      7521 WARD      1250      15000                                                                                    
      7566 JONES     2975      35700                                                                                    
      7654 MARTIN    1250      15000                                                                                    
      7698 BLAKE     2850      34200                                                                                    
      7782 CLARK     2450      29400                                                                                    
      7788 SCOTT     3000      36000                                                                                    
      7839 KING      5000      60000                                                                                    
      7844 TURNER    1500      18000                                                                                    
      7876 ADAMS     1100      13200                                                                                    

     EMPNO ENAME      SAL     SAL*12                                                                                    
---------- -------- ----- ----------                                                                                    
      7900 JAMES      950      11400                                                                                    
      7902 FORD      3000      36000                                                                                    
      7934 MILLER    1300      15600                                                                                    

已选择14行。

SQL> --10.查询员工信息:员工号  姓名 月薪 年薪 奖金 年收入
SQL> select empno,ename,sal,sal*12,comm,sal*12+comm
  2  from emp;

     EMPNO ENAME      SAL     SAL*12       COMM SAL*12+COMM                                                             
---------- -------- ----- ---------- ---------- -----------                                                             
      7369 SMITH      800       9600                                                                                    
      7499 ALLEN     1600      19200        300       19500                                                             
      7521 WARD      1250      15000        500       15500                                                             
      7566 JONES     2975      35700                                                                                    
      7654 MARTIN    1250      15000       1400       16400                                                             
      7698 BLAKE     2850      34200                                                                                    
      7782 CLARK     2450      29400                                                                                    
      7788 SCOTT     3000      36000                                                                                    
      7839 KING      5000      60000                                                                                    
      7844 TURNER    1500      18000          0       18000                                                             
      7876 ADAMS     1100      13200                                                                                    

     EMPNO ENAME      SAL     SAL*12       COMM SAL*12+COMM                                                             
---------- -------- ----- ---------- ---------- -----------                                                             
      7900 JAMES      950      11400                                                                                    
      7902 FORD      3000      36000                                                                                    
      7934 MILLER    1300      15600                                                                                    

已选择14行。

SQL> /*
SQL> SQL语句中的null值
SQL> 1. 包含null的表达式都为null
SQL> 2. null!=null
SQL> */
SQL> select empno,ename,sal,sal*12,comm,sal*12+nvl(comm,0)
  2  from emp;

     EMPNO ENAME      SAL     SAL*12       COMM SAL*12+NVL(COMM,0)                                                      
---------- -------- ----- ---------- ---------- ------------------                                                      
      7369 SMITH      800       9600                          9600                                                      
      7499 ALLEN     1600      19200        300              19500                                                      
      7521 WARD      1250      15000        500              15500                                                      
      7566 JONES     2975      35700                         35700                                                      
      7654 MARTIN    1250      15000       1400              16400                                                      
      7698 BLAKE     2850      34200                         34200                                                      
      7782 CLARK     2450      29400                         29400                                                      
      7788 SCOTT     3000      36000                         36000                                                      
      7839 KING      5000      60000                         60000                                                      
      7844 TURNER    1500      18000          0              18000                                                      
      7876 ADAMS     1100      13200                         13200                                                      

     EMPNO ENAME      SAL     SAL*12       COMM SAL*12+NVL(COMM,0)                                                      
---------- -------- ----- ---------- ---------- ------------------                                                      
      7900 JAMES      950      11400                         11400                                                      
      7902 FORD      3000      36000                         36000                                                      
      7934 MILLER    1300      15600                         15600                                                      

已选择14行。

SQL> --11.查询奖金为null的员工
SQL> select *
  2  from emp
  3  where comm=null;

未选定行

SQL> select *
  2  from emp
  3  where comm is null;

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     

已选择10行。

SQL> host cls

SQL> select *
  2  form emp;
form emp
*
第 2 行出现错误: 
ORA-00923: 未找到要求的 FROM 关键字 


SQL> --c 命令
SQL> 2
  2* form emp
SQL> c /form/from
  2* from emp
SQL> /

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     

已选择14行。

SQL> select empno,ename,sal,job
  2  form emp;
form emp
     *
第 2 行出现错误: 
ORA-00923: 未找到要求的 FROM 关键字 


SQL> ed
已写入 file afiedt.buf

  1  select empno,ename,sal,job
  2* from emp
SQL> /

     EMPNO ENAME      SAL JOB                                                                                           
---------- -------- ----- ---------                                                                                     
      7369 SMITH      800 CLERK                                                                                         
      7499 ALLEN     1600 SALESMAN                                                                                      
      7521 WARD      1250 SALESMAN                                                                                      
      7566 JONES     2975 MANAGER                                                                                       
      7654 MARTIN    1250 SALESMAN                                                                                      
      7698 BLAKE     2850 MANAGER                                                                                       
      7782 CLARK     2450 MANAGER                                                                                       
      7788 SCOTT     3000 ANALYST                                                                                       
      7839 KING      5000 PRESIDENT                                                                                     
      7844 TURNER    1500 SALESMAN                                                                                      
      7876 ADAMS     1100 CLERK                                                                                         

     EMPNO ENAME      SAL JOB                                                                                           
---------- -------- ----- ---------                                                                                     
      7900 JAMES      950 CLERK                                                                                         
      7902 FORD      3000 ANALYST                                                                                       
      7934 MILLER    1300 CLERK                                                                                         

已选择14行。

SQL> ed
已写入 file afiedt.buf

  1  select empno as "员工号",ename "姓名",sal 月薪,job 职位
  2* from emp
SQL> /

    员工号 姓名             月薪 职位                                                                                   
---------- ---------- ---------- ---------                                                                              
      7369 SMITH             800 CLERK                                                                                  
      7499 ALLEN            1600 SALESMAN                                                                               
      7521 WARD             1250 SALESMAN                                                                               
      7566 JONES            2975 MANAGER                                                                                
      7654 MARTIN           1250 SALESMAN                                                                               
      7698 BLAKE            2850 MANAGER                                                                                
      7782 CLARK            2450 MANAGER                                                                                
      7788 SCOTT            3000 ANALYST                                                                                
      7839 KING             5000 PRESIDENT                                                                              
      7844 TURNER           1500 SALESMAN                                                                               
      7876 ADAMS            1100 CLERK                                                                                  

    员工号 姓名             月薪 职位                                                                                   
---------- ---------- ---------- ---------                                                                              
      7900 JAMES             950 CLERK                                                                                  
      7902 FORD             3000 ANALYST                                                                                
      7934 MILLER           1300 CLERK                                                                                  

已选择14行。

SQL> ed
已写入 file afiedt.buf

  1  select empno as "员工号",ename "姓名",sal 月    薪,job 职位
  2* from emp
SQL> /
select empno as "员工号",ename "姓名",sal 月    薪,job 职位
                                                *
第 1 行出现错误: 
ORA-00923: 未找到要求的 FROM 关键字 


SQL> ed
已写入 file afiedt.buf

  1  select empno as "员工号",ename "姓名",sal "月    薪",job 职位
  2* from emp
SQL> /

    员工号 姓名         月    薪 职位                                                                                   
---------- ---------- ---------- ---------                                                                              
      7369 SMITH             800 CLERK                                                                                  
      7499 ALLEN            1600 SALESMAN                                                                               
      7521 WARD             1250 SALESMAN                                                                               
      7566 JONES            2975 MANAGER                                                                                
      7654 MARTIN           1250 SALESMAN                                                                               
      7698 BLAKE            2850 MANAGER                                                                                
      7782 CLARK            2450 MANAGER                                                                                
      7788 SCOTT            3000 ANALYST                                                                                
      7839 KING             5000 PRESIDENT                                                                              
      7844 TURNER           1500 SALESMAN                                                                               
      7876 ADAMS            1100 CLERK                                                                                  

    员工号 姓名         月    薪 职位                                                                                   
---------- ---------- ---------- ---------                                                                              
      7900 JAMES             950 CLERK                                                                                  
      7902 FORD             3000 ANALYST                                                                                
      7934 MILLER           1300 CLERK                                                                                  

已选择14行。

SQL> host cls

SQL> --DISTINCT 去掉重复记录
SQL> select deptno from emp;

    DEPTNO                                                                                                              
----------                                                                                                              
        20                                                                                                              
        30                                                                                                              
        30                                                                                                              
        20                                                                                                              
        30                                                                                                              
        30                                                                                                              
        10                                                                                                              
        20                                                                                                              
        10                                                                                                              
        30                                                                                                              
        20                                                                                                              

    DEPTNO                                                                                                              
----------                                                                                                              
        30                                                                                                              
        20                                                                                                              
        10                                                                                                              

已选择14行。

SQL> select DISTINCT deptno from emp;

    DEPTNO                                                                                                              
----------                                                                                                              
        30                                                                                                              
        20                                                                                                              
        10                                                                                                              

SQL> select job from emp;

JOB                                                                                                                     
---------                                                                                                               
CLERK                                                                                                                   
SALESMAN                                                                                                                
SALESMAN                                                                                                                
MANAGER                                                                                                                 
SALESMAN                                                                                                                
MANAGER                                                                                                                 
MANAGER                                                                                                                 
ANALYST                                                                                                                 
PRESIDENT                                                                                                               
SALESMAN                                                                                                                
CLERK                                                                                                                   

JOB                                                                                                                     
---------                                                                                                               
CLERK                                                                                                                   
ANALYST                                                                                                                 
CLERK                                                                                                                   

已选择14行。

SQL> select DISTINCT job from emp;

JOB                                                                                                                     
---------                                                                                                               
CLERK                                                                                                                   
SALESMAN                                                                                                                
PRESIDENT                                                                                                               
MANAGER                                                                                                                 
ANALYST                                                                                                                 

SQL> select DISTINCT deptno,job from emp;

    DEPTNO JOB                                                                                                          
---------- ---------                                                                                                    
        20 CLERK                                                                                                        
        30 SALESMAN                                                                                                     
        20 MANAGER                                                                                                      
        30 CLERK                                                                                                        
        10 PRESIDENT                                                                                                    
        30 MANAGER                                                                                                      
        10 CLERK                                                                                                        
        10 MANAGER                                                                                                      
        20 ANALYST                                                                                                      

已选择9行。

SQL> --DISTINCT作用于后面所有的列
SQL> host cls

SQL> --连接符
SQL> select concat('Hello','  World') from emp;

CONCAT('HELL                                                                                                            
------------                                                                                                            
Hello  World                                                                                                            
Hello  World                                                                                                            
Hello  World                                                                                                            
Hello  World                                                                                                            
Hello  World                                                                                                            
Hello  World                                                                                                            
Hello  World                                                                                                            
Hello  World                                                                                                            
Hello  World                                                                                                            
Hello  World                                                                                                            
Hello  World                                                                                                            

CONCAT('HELL                                                                                                            
------------                                                                                                            
Hello  World                                                                                                            
Hello  World                                                                                                            
Hello  World                                                                                                            

已选择14行。

SQL> select concat('Hello','  World') from dual;

CONCAT('HELL                                                                                                            
------------                                                                                                            
Hello  World                                                                                                            

SQL> --dual:伪表
SQL> select 3+2 from dual;

       3+2                                                                                                              
----------                                                                                                              
         5                                                                                                              

SQL> select 'Hello'||'  World' 一列 from dual;

一列                                                                                                                    
------------                                                                                                            
Hello  World                                                                                                            

SQL> --查询员工信息：***的薪水是****
SQL> select ename||'的薪水是'||sal 一列
  2  from emp;

一列                                                                                                                    
----------------------------------------------------------                                                              
SMITH的薪水是800                                                                                                        
ALLEN的薪水是1600                                                                                                       
WARD的薪水是1250                                                                                                        
JONES的薪水是2975                                                                                                       
MARTIN的薪水是1250                                                                                                      
BLAKE的薪水是2850                                                                                                       
CLARK的薪水是2450                                                                                                       
SCOTT的薪水是3000                                                                                                       
KING的薪水是5000                                                                                                        
TURNER的薪水是1500                                                                                                      
ADAMS的薪水是1100                                                                                                       

一列                                                                                                                    
----------------------------------------------------------                                                              
JAMES的薪水是950                                                                                                        
FORD的薪水是3000                                                                                                        
MILLER的薪水是1300                                                                                                      

已选择14行。

SQL> host cls

SQL> select * from emp;

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     

已选择14行。

SQL> save c:\a.sql
已创建 file c:\a.sql
SQL> @c:\a.sql

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     

已选择14行。

SQL> spool off
