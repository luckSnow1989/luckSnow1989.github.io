SQL> host cls

SQL> /*
SQL> 查询部门号是10和20的员工信息
SQL> 1. select * from emp where deptno in (10,20);
SQL> 2. select * from emp where deptno=10 or deptno=20;
SQL> 3. 集合运算
SQL>    select * from emp where deptno=10
SQL>    加上
SQL>    select * from emp where deptno=20;
SQL> */
SQL> select * from emp where deptno=10
  2  union
  3  select * from emp where deptno=20;

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7369 SMITH      CLERK           7902 17-12月-80       800                    20                                   
      7566 JONES      MANAGER         7839 02-4月 -81      2975                    20                                   
      7782 CLARK      MANAGER         7839 09-6月 -81      2450                    10                                   
      7788 SCOTT      ANALYST         7566 13-7月 -87      3000                    20                                   
      7839 KING       PRESIDENT            17-11月-81      5000                    10                                   
      7876 ADAMS      CLERK           7788 13-7月 -87      1100                    20                                   
      7902 FORD       ANALYST         7566 03-12月-81      3000                    20                                   
      7934 MILLER     CLERK           7782 23-1月 -82      1300                    10                                   

已选择8行。

SQL> select deptno,job,sum(sal) from emp group by rollup(deptno,job);

    DEPTNO JOB         SUM(SAL)                                                                                         
---------- --------- ----------                                                                                         
        10 CLERK           1300                                                                                         
        10 MANAGER         2450                                                                                         
        10 PRESIDENT       5000                                                                                         
        10                 8750                                                                                         
        20 CLERK           1900                                                                                         
        20 ANALYST         6000                                                                                         
        20 MANAGER         2975                                                                                         
        20                10875                                                                                         
        30 CLERK            950                                                                                         
        30 MANAGER         2850                                                                                         
        30 SALESMAN        5600                                                                                         

    DEPTNO JOB         SUM(SAL)                                                                                         
---------- --------- ----------                                                                                         
        30                 9400                                                                                         
                          29025                                                                                         

已选择13行。

SQL> select deptno,job,sum(sal) from emp group by deptno,job
  2  union
  3  select deptno,sum(sal) from emp group by deptno
  4  union
  5  select sum(sal) from emp;
select deptno,sum(sal) from emp group by deptno
*
第 3 行出现错误: 
ORA-01789: 查询块具有不正确的结果列数 


SQL> /*
SQL> 注意的问题
SQL> 1. 参与运算的各个集合必须列数相同 且类型一致
SQL> 2. 采用第一个集合的表头作为最后的表头
SQL> 3. 如果排序，必须 在每个集合后使用相同order by
SQL> 4. 括号
SQL> */
SQL> select deptno,job,sum(sal) from emp group by deptno,job
  2  union
  3  select deptno,to_char(null),sum(sal) from emp group by deptno
  4  union
  5  select to_number(null),to_char(null),sum(sal) from emp;

    DEPTNO JOB         SUM(SAL)                                                                                         
---------- --------- ----------                                                                                         
        10 CLERK           1300                                                                                         
        10 MANAGER         2450                                                                                         
        10 PRESIDENT       5000                                                                                         
        10                 8750                                                                                         
        20 ANALYST         6000                                                                                         
        20 CLERK           1900                                                                                         
        20 MANAGER         2975                                                                                         
        20                10875                                                                                         
        30 CLERK            950                                                                                         
        30 MANAGER         2850                                                                                         
        30 SALESMAN        5600                                                                                         

    DEPTNO JOB         SUM(SAL)                                                                                         
---------- --------- ----------                                                                                         
        30                 9400                                                                                         
                          29025                                                                                         

已选择13行。

SQL> break on deptno skip 2
SQL> select deptno,job,sum(sal) from emp group by deptno,job
  2  union
  3  select deptno,to_char(null),sum(sal) from emp group by deptno
  4  union
  5  select to_number(null),to_char(null),sum(sal) from emp;

    DEPTNO JOB         SUM(SAL)                                                                                         
---------- --------- ----------                                                                                         
        10 CLERK           1300                                                                                         
           MANAGER         2450                                                                                         
           PRESIDENT       5000                                                                                         
                           8750                                                                                         
                                                                                                                        
                                                                                                                        
        20 ANALYST         6000                                                                                         
           CLERK           1900                                                                                         
           MANAGER         2975                                                                                         
                          10875                                                                                         
                                                                                                                        

    DEPTNO JOB         SUM(SAL)                                                                                         
---------- --------- ----------                                                                                         
                                                                                                                        
        30 CLERK            950                                                                                         
           MANAGER         2850                                                                                         
           SALESMAN        5600                                                                                         
                           9400                                                                                         
                                                                                                                        
                                                                                                                        
                          29025                                                                                         
                                                                                                                        
                                                                                                                        

已选择13行。

SQL> break on null
SQL> host cls

SQL> select deptno,job,sum(sal) from emp group by rollup(deptno,job);

    DEPTNO JOB         SUM(SAL)                                                                                         
---------- --------- ----------                                                                                         
        10 CLERK           1300                                                                                         
        10 MANAGER         2450                                                                                         
        10 PRESIDENT       5000                                                                                         
        10                 8750                                                                                         
        20 CLERK           1900                                                                                         
        20 ANALYST         6000                                                                                         
        20 MANAGER         2975                                                                                         
        20                10875                                                                                         
        30 CLERK            950                                                                                         
        30 MANAGER         2850                                                                                         
        30 SALESMAN        5600                                                                                         

    DEPTNO JOB         SUM(SAL)                                                                                         
---------- --------- ----------                                                                                         
        30                 9400                                                                                         
                          29025                                                                                         

已选择13行。

SQL> set timing on
SQL> select deptno,job,sum(sal) from emp group by rollup(deptno,job);

    DEPTNO JOB         SUM(SAL)                                                                                         
---------- --------- ----------                                                                                         
        10 CLERK           1300                                                                                         
        10 MANAGER         2450                                                                                         
        10 PRESIDENT       5000                                                                                         
        10                 8750                                                                                         
        20 CLERK           1900                                                                                         
        20 ANALYST         6000                                                                                         
        20 MANAGER         2975                                                                                         
        20                10875                                                                                         
        30 CLERK            950                                                                                         
        30 MANAGER         2850                                                                                         
        30 SALESMAN        5600                                                                                         

    DEPTNO JOB         SUM(SAL)                                                                                         
---------- --------- ----------                                                                                         
        30                 9400                                                                                         
                          29025                                                                                         

已选择13行。

已用时间:  00: 00: 00.00
SQL> select deptno,job,sum(sal) from emp group by deptno,job
  2  union
  3  select deptno,to_char(null),sum(sal) from emp group by deptno
  4  union
  5  select to_number(null),to_char(null),sum(sal) from emp;

    DEPTNO JOB         SUM(SAL)                                                                                         
---------- --------- ----------                                                                                         
        10 CLERK           1300                                                                                         
        10 MANAGER         2450                                                                                         
        10 PRESIDENT       5000                                                                                         
        10                 8750                                                                                         
        20 ANALYST         6000                                                                                         
        20 CLERK           1900                                                                                         
        20 MANAGER         2975                                                                                         
        20                10875                                                                                         
        30 CLERK            950                                                                                         
        30 MANAGER         2850                                                                                         
        30 SALESMAN        5600                                                                                         

    DEPTNO JOB         SUM(SAL)                                                                                         
---------- --------- ----------                                                                                         
        30                 9400                                                                                         
                          29025                                                                                         

已选择13行。

已用时间:  00: 00: 00.01
SQL> --优化6: 尽量不要使用集合运算
SQL> set timing off
SQL> host cls

SQL> --交集
SQL> select ename,sal from emp
  2  where sal between 700 and 1300
  3  INTERSECT
  4  select ename,sal from emp
  5  where sal between 1201 and 1400;

ENAME        SAL                                                                                                        
---------- -----                                                                                                        
MARTIN      1250                                                                                                        
MILLER      1300                                                                                                        
WARD        1250                                                                                                        

SQL> select ename,sal from emp
  2  where sal between 700 and 1300
  3  minus
  4  select ename,sal from emp
  5  where sal between 1201 and 1400;

ENAME        SAL                                                                                                        
---------- -----                                                                                                        
ADAMS       1100                                                                                                        
JAMES        950                                                                                                        
SMITH        800                                                                                                        

SQL> spool off
