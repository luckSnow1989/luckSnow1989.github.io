SQL> host cls

SQL> --查询工资比SCOTT高的员工信息
SQL> --1. SCOTT的工资
SQL> select sal from emp where ename='SCOTT';

       SAL                                                                      
----------                                                                      
      3000                                                                      

SQL> --2.比3000高的
SQL> set linesize 120
SQL> col sal for 9999
SQL> select * from emp where sal > 3000;

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7839 KING       PRESIDENT            17-11月-81      5000                    10                                   

SQL> --解决的问题：不能一步求解
SQL> select *
  2  from emp
  3  where sal > (select sal
  4               from emp
  5               where ename='SCOTT');

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7839 KING       PRESIDENT            17-11月-81      5000                    10                                   

SQL> /*
SQL> 注意的问题
SQL> 1. 括号
SQL> 2. 合理的书写风格
SQL> 3. 可以主查询的where select from having后面放置子查询
SQL> 4. 不可以在主查询的group by后面放置子查询
SQL> 5. 强调from后面的子查询
SQL> 6. 主查询和子查询可以不是同一张表，只要子查询返回的结果 主查询可以使用即可
SQL> 7. 一般不在子查询使用order by，但在Top-N分析问题中 必须使用order by
SQL> 8. 一般先执行子查询，再执行主查询；但相关子查询除外
SQL> 9. 单行子查询只能使用单行操作符 多行子查询只能使用多行操作符
SQL> 10. 子查询中null
SQL> */
SQL> -- 3. 可以主查询的where select from having后面放置子查询
SQL> select ename,sal,(select job from emp where empno=7839) 一列
  2  from emp;

ENAME        SAL 一列                                                                                                   
---------- ----- ---------                                                                                              
SMITH        800 PRESIDENT                                                                                              
ALLEN       1600 PRESIDENT                                                                                              
WARD        1250 PRESIDENT                                                                                              
JONES       2975 PRESIDENT                                                                                              
MARTIN      1250 PRESIDENT                                                                                              
BLAKE       2850 PRESIDENT                                                                                              
CLARK       2450 PRESIDENT                                                                                              
SCOTT       3000 PRESIDENT                                                                                              
KING        5000 PRESIDENT                                                                                              
TURNER      1500 PRESIDENT                                                                                              
ADAMS       1100 PRESIDENT                                                                                              

ENAME        SAL 一列                                                                                                   
---------- ----- ---------                                                                                              
JAMES        950 PRESIDENT                                                                                              
FORD        3000 PRESIDENT                                                                                              
MILLER      1300 PRESIDENT                                                                                              

已选择14行。

SQL> --5. 强调from后面的子查询
SQL> --查询员工的姓名和薪水
SQL> select *
  2  from (select ename,sal from emp);

ENAME        SAL                                                                                                        
---------- -----                                                                                                        
SMITH        800                                                                                                        
ALLEN       1600                                                                                                        
WARD        1250                                                                                                        
JONES       2975                                                                                                        
MARTIN      1250                                                                                                        
BLAKE       2850                                                                                                        
CLARK       2450                                                                                                        
SCOTT       3000                                                                                                        
KING        5000                                                                                                        
TURNER      1500                                                                                                        
ADAMS       1100                                                                                                        

ENAME        SAL                                                                                                        
---------- -----                                                                                                        
JAMES        950                                                                                                        
FORD        3000                                                                                                        
MILLER      1300                                                                                                        

已选择14行。

SQL> --查询员工的姓名 薪水 年薪
SQL> ed
已写入 file afiedt.buf

  1  select *
  2* from (select ename,sal,sal*12 annlsal from emp)
SQL> /

ENAME        SAL    ANNLSAL                                                                                             
---------- ----- ----------                                                                                             
SMITH        800       9600                                                                                             
ALLEN       1600      19200                                                                                             
WARD        1250      15000                                                                                             
JONES       2975      35700                                                                                             
MARTIN      1250      15000                                                                                             
BLAKE       2850      34200                                                                                             
CLARK       2450      29400                                                                                             
SCOTT       3000      36000                                                                                             
KING        5000      60000                                                                                             
TURNER      1500      18000                                                                                             
ADAMS       1100      13200                                                                                             

ENAME        SAL    ANNLSAL                                                                                             
---------- ----- ----------                                                                                             
JAMES        950      11400                                                                                             
FORD        3000      36000                                                                                             
MILLER      1300      15600                                                                                             

已选择14行。

SQL> --6. 主查询和子查询可以不是同一张表，只要子查询返回的结果 主查询可以使用即可
SQL> --查询部门名称为SALES的员工信息
SQL> select *
  2  from emp
  3  where deptno=(select deptno
  4                from dept
  5                where dname='SALES');

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7499 ALLEN      SALESMAN        7698 20-2月 -81      1600        300         30                                   
      7521 WARD       SALESMAN        7698 22-2月 -81      1250        500         30                                   
      7654 MARTIN     SALESMAN        7698 28-9月 -81      1250       1400         30                                   
      7698 BLAKE      MANAGER         7839 01-5月 -81      2850                    30                                   
      7844 TURNER     SALESMAN        7698 08-9月 -81      1500          0         30                                   
      7900 JAMES      CLERK           7698 03-12月-81       950                    30                                   

已选择6行。

SQL> select e.*
  2  from emp e,dept d
  3  where e.deptno=d.deptno and d.dname='SALES';

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7499 ALLEN      SALESMAN        7698 20-2月 -81      1600        300         30                                   
      7521 WARD       SALESMAN        7698 22-2月 -81      1250        500         30                                   
      7654 MARTIN     SALESMAN        7698 28-9月 -81      1250       1400         30                                   
      7698 BLAKE      MANAGER         7839 01-5月 -81      2850                    30                                   
      7844 TURNER     SALESMAN        7698 08-9月 -81      1500          0         30                                   
      7900 JAMES      CLERK           7698 03-12月-81       950                    30                                   

已选择6行。

SQL> --优化5:理论上，尽量使用多表查询
SQL> host cls

SQL> --in 在集合中
SQL> --查询部门名称是SALES和ACCOUNTING的员工
SQL> select *
  2  from emp
  3  where deptno in (select deptno from dept where dname='SALES' or dname='ACCOUNTING');

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7499 ALLEN      SALESMAN        7698 20-2月 -81      1600        300         30                                   
      7521 WARD       SALESMAN        7698 22-2月 -81      1250        500         30                                   
      7654 MARTIN     SALESMAN        7698 28-9月 -81      1250       1400         30                                   
      7698 BLAKE      MANAGER         7839 01-5月 -81      2850                    30                                   
      7782 CLARK      MANAGER         7839 09-6月 -81      2450                    10                                   
      7839 KING       PRESIDENT            17-11月-81      5000                    10                                   
      7844 TURNER     SALESMAN        7698 08-9月 -81      1500          0         30                                   
      7900 JAMES      CLERK           7698 03-12月-81       950                    30                                   
      7934 MILLER     CLERK           7782 23-1月 -82      1300                    10                                   

已选择9行。

SQL> select e.*
  2  from emp e,dept d
  3  where e.deptno=d.deptno and (d.dname='SALES' or d.dname='ACCOUNTING');

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7499 ALLEN      SALESMAN        7698 20-2月 -81      1600        300         30                                   
      7521 WARD       SALESMAN        7698 22-2月 -81      1250        500         30                                   
      7654 MARTIN     SALESMAN        7698 28-9月 -81      1250       1400         30                                   
      7698 BLAKE      MANAGER         7839 01-5月 -81      2850                    30                                   
      7782 CLARK      MANAGER         7839 09-6月 -81      2450                    10                                   
      7839 KING       PRESIDENT            17-11月-81      5000                    10                                   
      7844 TURNER     SALESMAN        7698 08-9月 -81      1500          0         30                                   
      7900 JAMES      CLERK           7698 03-12月-81       950                    30                                   
      7934 MILLER     CLERK           7782 23-1月 -82      1300                    10                                   

已选择9行。

SQL> --any: 和集合中 任意一个值比较
SQL> --查询工资比30号部门任意一个员工高的员工信息
SQL> select *\
  2  ;
select *\
        *
第 1 行出现错误: 
ORA-00911: 无效字符 


SQL> select *
  2  from emp
  3  where sal > any (select sal from emp where deptno=30);

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7839 KING       PRESIDENT            17-11月-81      5000                    10                                   
      7902 FORD       ANALYST         7566 03-12月-81      3000                    20                                   
      7788 SCOTT      ANALYST         7566 13-7月 -87      3000                    20                                   
      7566 JONES      MANAGER         7839 02-4月 -81      2975                    20                                   
      7698 BLAKE      MANAGER         7839 01-5月 -81      2850                    30                                   
      7782 CLARK      MANAGER         7839 09-6月 -81      2450                    10                                   
      7499 ALLEN      SALESMAN        7698 20-2月 -81      1600        300         30                                   
      7844 TURNER     SALESMAN        7698 08-9月 -81      1500          0         30                                   
      7934 MILLER     CLERK           7782 23-1月 -82      1300                    10                                   
      7521 WARD       SALESMAN        7698 22-2月 -81      1250        500         30                                   
      7654 MARTIN     SALESMAN        7698 28-9月 -81      1250       1400         30                                   

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7876 ADAMS      CLERK           7788 13-7月 -87      1100                    20                                   

已选择12行。

SQL> ed
已写入 file afiedt.buf

  1  select *
  2  from emp
  3* where sal > (select min(sal) from emp where deptno=30)
SQL> /

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
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
      7902 FORD       ANALYST         7566 03-12月-81      3000                    20                                   

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7934 MILLER     CLERK           7782 23-1月 -82      1300                    10                                   

已选择12行。

SQL> --all:和集合的所有值比较
SQL>  --查询工资比30号部门所有员工高的员工信息
SQL> select *
  2  from emp
  3  where sal > all (select sal from emp where deptno=30);

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7566 JONES      MANAGER         7839 02-4月 -81      2975                    20                                   
      7788 SCOTT      ANALYST         7566 13-7月 -87      3000                    20                                   
      7839 KING       PRESIDENT            17-11月-81      5000                    10                                   
      7902 FORD       ANALYST         7566 03-12月-81      3000                    20                                   

SQL> ed
已写入 file afiedt.buf

  1  select *
  2  from emp
  3* where sal > (select max(sal) from emp where deptno=30)
SQL> /

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7566 JONES      MANAGER         7839 02-4月 -81      2975                    20                                   
      7788 SCOTT      ANALYST         7566 13-7月 -87      3000                    20                                   
      7839 KING       PRESIDENT            17-11月-81      5000                    10                                   
      7902 FORD       ANALYST         7566 03-12月-81      3000                    20                                   

SQL> host cls

SQL> --多行子查询中null
SQL> --查询不是老板的员工信息
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

SQL> --是老板的员工
SQL> select *
  2  from emp
  3  where empno in (select mgr from emp);

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7902 FORD       ANALYST         7566 03-12月-81      3000                    20                                   
      7698 BLAKE      MANAGER         7839 01-5月 -81      2850                    30                                   
      7839 KING       PRESIDENT            17-11月-81      5000                    10                                   
      7566 JONES      MANAGER         7839 02-4月 -81      2975                    20                                   
      7788 SCOTT      ANALYST         7566 13-7月 -87      3000                    20                                   
      7782 CLARK      MANAGER         7839 09-6月 -81      2450                    10                                   

已选择6行。

SQL> ed
已写入 file afiedt.buf

  1  select *
  2  from emp
  3* where empno not in (select mgr from emp)
SQL> /

未选定行

SQL> ed
已写入 file afiedt.buf

  1  select *
  2  from emp
  3* where empno not in (select mgr from emp where mgr is not null)
SQL> /

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7844 TURNER     SALESMAN        7698 08-9月 -81      1500          0         30                                   
      7521 WARD       SALESMAN        7698 22-2月 -81      1250        500         30                                   
      7654 MARTIN     SALESMAN        7698 28-9月 -81      1250       1400         30                                   
      7499 ALLEN      SALESMAN        7698 20-2月 -81      1600        300         30                                   
      7934 MILLER     CLERK           7782 23-1月 -82      1300                    10                                   
      7369 SMITH      CLERK           7902 17-12月-80       800                    20                                   
      7876 ADAMS      CLERK           7788 13-7月 -87      1100                    20                                   
      7900 JAMES      CLERK           7698 03-12月-81       950                    30                                   

已选择8行。

SQL> spool off
