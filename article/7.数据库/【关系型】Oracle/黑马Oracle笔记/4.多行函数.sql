SQL> --�����ܶ�
SQL> select sum(sal) from emp;

  SUM(SAL)                                                                      
----------                                                                      
     29025                                                                      

SQL> --����
SQL> select count(*) from emp;

  COUNT(*)                                                                      
----------                                                                      
        14                                                                      

SQL> --ƽ������
SQL> select sum(sal)/count(*) һ,avg(sal) �� from emp;

        һ         ��                                                           
---------- ----------                                                           
2073.21429 2073.21429                                                           

SQL> --ƽ������: ��ֵ
SQL> select sum(comm)/count(*) һ, sum(comm)/count(comm) ��, avg(comm) ��
  2  from emp;

        һ         ��         ��                                                
---------- ---------- ----------                                                
157.142857        550        550                                                

SQL> --��ֵ 5: �麯���Զ��˿�
SQL> select count(*), count(comm)  from emp;

  COUNT(*) COUNT(COMM)                                                          
---------- -----------                                                          
        14           4                                                          

SQL> select count(*), count(nvl(comm,0))  from emp;

  COUNT(*) COUNT(NVL(COMM,0))                                                   
---------- ------------------                                                   
        14                 14                                                   

SQL> host cls

SQL> --��������
SQL> --��ÿ�����ŵ�ƽ������
SQL> select deptno,avg(sal)
  2  from emp
  3  group by deptno;

    DEPTNO   AVG(SAL)                                                           
---------- ----------                                                           
        30 1566.66667                                                           
        20       2175                                                           
        10 2916.66667                                                           

SQL> select detpno,job,sum(sal)
  2  from emp
  3  group by deptno,job;
select detpno,job,sum(sal)
       *
�� 1 �г��ִ���: 
ORA-00904: "DETPNO": ��ʶ����Ч 


SQL> ed
��д�� file afiedt.buf

  1  select deptno,job,sum(sal)
  2  from emp
  3* group by deptno,job
SQL> /

    DEPTNO JOB         SUM(SAL)                                                 
---------- --------- ----------                                                 
        20 CLERK           1900                                                 
        30 SALESMAN        5600                                                 
        20 MANAGER         2975                                                 
        30 CLERK            950                                                 
        10 PRESIDENT       5000                                                 
        30 MANAGER         2850                                                 
        10 CLERK           1300                                                 
        10 MANAGER         2450                                                 
        20 ANALYST         6000                                                 

��ѡ��9�С�

SQL> ed
��д�� file afiedt.buf

  1  select deptno,job,sum(sal)
  2  from emp
  3  group by deptno,job
  4* order by 1
SQL> /

    DEPTNO JOB         SUM(SAL)                                                 
---------- --------- ----------                                                 
        10 CLERK           1300                                                 
        10 MANAGER         2450                                                 
        10 PRESIDENT       5000                                                 
        20 ANALYST         6000                                                 
        20 CLERK           1900                                                 
        20 MANAGER         2975                                                 
        30 CLERK            950                                                 
        30 MANAGER         2850                                                 
        30 SALESMAN        5600                                                 

��ѡ��9�С�

SQL> select deptno,avg(sal)
  2  from emp
  3  group by deptno
  4  having avg(sal)>2000;

    DEPTNO   AVG(SAL)                                                           
---------- ----------                                                           
        20       2175                                                           
        10 2916.66667                                                           

SQL> --��10�Ų��ŵ�ƽ������
SQL> select deptno,avg(sal)
  2  from emp
  3  group by deptno
  4  having deptno=10;

    DEPTNO   AVG(SAL)                                                           
---------- ----------                                                           
        10 2916.66667                                                           

SQL> ed
��д�� file afiedt.buf

  1  select deptno,avg(sal)
  2  from emp
  3  where deptno=10
  4* group by deptno
  5  /

    DEPTNO   AVG(SAL)                                                           
---------- ----------                                                           
        10 2916.66667                                                           

SQL> --�Ż�4: ����ʹ��where
SQL> host cls

SQL> /*
SQL> group by����ǿ
SQL> group by deptno,job
SQL> +
SQL> group by deptno
SQL> +
SQL> group by null
SQL> =
SQL> group by rollup(deptno,job)
SQL> 
SQL> group by rollup(a,b)
SQL> =
SQL> group by a,b
SQL> +
SQL> group by a
SQL> +
SQL> group by null
SQL> */
SQL> select deptno,job,sum(sal)
  2  from emp
  3  group by rollup(deptno,job);

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

��ѡ��13�С�

SQL> break on deptno skip 2
SQL> select deptno,job,sum(sal)
  2  from emp
  3  group by rollup(deptno,job);

    DEPTNO JOB         SUM(SAL)                                                 
---------- --------- ----------                                                 
        10 CLERK           1300                                                 
           MANAGER         2450                                                 
           PRESIDENT       5000                                                 
                           8750                                                 
                                                                                
                                                                                
        20 CLERK           1900                                                 
           ANALYST         6000                                                 
           MANAGER         2975                                                 
                          10875                                                 
                                                                                

    DEPTNO JOB         SUM(SAL)                                                 
---------- --------- ----------                                                 
                                                                                
        30 CLERK            950                                                 
           MANAGER         2850                                                 
           SALESMAN        5600                                                 
                           9400                                                 
                                                                                
                                                                                
                          29025                                                 
                                                                                
                                                                                

��ѡ��13�С�

SQL> break on null
SQL> /

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

��ѡ��13�С�

SQL> spool off
