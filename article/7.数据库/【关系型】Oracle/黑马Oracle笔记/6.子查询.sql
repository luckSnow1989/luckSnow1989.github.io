SQL> host cls

SQL> --��ѯ���ʱ�SCOTT�ߵ�Ա����Ϣ
SQL> --1. SCOTT�Ĺ���
SQL> select sal from emp where ename='SCOTT';

       SAL                                                                      
----------                                                                      
      3000                                                                      

SQL> --2.��3000�ߵ�
SQL> set linesize 120
SQL> col sal for 9999
SQL> select * from emp where sal > 3000;

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7839 KING       PRESIDENT            17-11��-81      5000                    10                                   

SQL> --��������⣺����һ�����
SQL> select *
  2  from emp
  3  where sal > (select sal
  4               from emp
  5               where ename='SCOTT');

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7839 KING       PRESIDENT            17-11��-81      5000                    10                                   

SQL> /*
SQL> ע�������
SQL> 1. ����
SQL> 2. �������д���
SQL> 3. ��������ѯ��where select from having��������Ӳ�ѯ
SQL> 4. ������������ѯ��group by��������Ӳ�ѯ
SQL> 5. ǿ��from������Ӳ�ѯ
SQL> 6. ����ѯ���Ӳ�ѯ���Բ���ͬһ�ű�ֻҪ�Ӳ�ѯ���صĽ�� ����ѯ����ʹ�ü���
SQL> 7. һ�㲻���Ӳ�ѯʹ��order by������Top-N���������� ����ʹ��order by
SQL> 8. һ����ִ���Ӳ�ѯ����ִ������ѯ��������Ӳ�ѯ����
SQL> 9. �����Ӳ�ѯֻ��ʹ�õ��в����� �����Ӳ�ѯֻ��ʹ�ö��в�����
SQL> 10. �Ӳ�ѯ��null
SQL> */
SQL> -- 3. ��������ѯ��where select from having��������Ӳ�ѯ
SQL> select ename,sal,(select job from emp where empno=7839) һ��
  2  from emp;

ENAME        SAL һ��                                                                                                   
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

ENAME        SAL һ��                                                                                                   
---------- ----- ---------                                                                                              
JAMES        950 PRESIDENT                                                                                              
FORD        3000 PRESIDENT                                                                                              
MILLER      1300 PRESIDENT                                                                                              

��ѡ��14�С�

SQL> --5. ǿ��from������Ӳ�ѯ
SQL> --��ѯԱ����������нˮ
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

��ѡ��14�С�

SQL> --��ѯԱ�������� нˮ ��н
SQL> ed
��д�� file afiedt.buf

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

��ѡ��14�С�

SQL> --6. ����ѯ���Ӳ�ѯ���Բ���ͬһ�ű�ֻҪ�Ӳ�ѯ���صĽ�� ����ѯ����ʹ�ü���
SQL> --��ѯ��������ΪSALES��Ա����Ϣ
SQL> select *
  2  from emp
  3  where deptno=(select deptno
  4                from dept
  5                where dname='SALES');

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7499 ALLEN      SALESMAN        7698 20-2�� -81      1600        300         30                                   
      7521 WARD       SALESMAN        7698 22-2�� -81      1250        500         30                                   
      7654 MARTIN     SALESMAN        7698 28-9�� -81      1250       1400         30                                   
      7698 BLAKE      MANAGER         7839 01-5�� -81      2850                    30                                   
      7844 TURNER     SALESMAN        7698 08-9�� -81      1500          0         30                                   
      7900 JAMES      CLERK           7698 03-12��-81       950                    30                                   

��ѡ��6�С�

SQL> select e.*
  2  from emp e,dept d
  3  where e.deptno=d.deptno and d.dname='SALES';

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7499 ALLEN      SALESMAN        7698 20-2�� -81      1600        300         30                                   
      7521 WARD       SALESMAN        7698 22-2�� -81      1250        500         30                                   
      7654 MARTIN     SALESMAN        7698 28-9�� -81      1250       1400         30                                   
      7698 BLAKE      MANAGER         7839 01-5�� -81      2850                    30                                   
      7844 TURNER     SALESMAN        7698 08-9�� -81      1500          0         30                                   
      7900 JAMES      CLERK           7698 03-12��-81       950                    30                                   

��ѡ��6�С�

SQL> --�Ż�5:�����ϣ�����ʹ�ö���ѯ
SQL> host cls

SQL> --in �ڼ�����
SQL> --��ѯ����������SALES��ACCOUNTING��Ա��
SQL> select *
  2  from emp
  3  where deptno in (select deptno from dept where dname='SALES' or dname='ACCOUNTING');

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7499 ALLEN      SALESMAN        7698 20-2�� -81      1600        300         30                                   
      7521 WARD       SALESMAN        7698 22-2�� -81      1250        500         30                                   
      7654 MARTIN     SALESMAN        7698 28-9�� -81      1250       1400         30                                   
      7698 BLAKE      MANAGER         7839 01-5�� -81      2850                    30                                   
      7782 CLARK      MANAGER         7839 09-6�� -81      2450                    10                                   
      7839 KING       PRESIDENT            17-11��-81      5000                    10                                   
      7844 TURNER     SALESMAN        7698 08-9�� -81      1500          0         30                                   
      7900 JAMES      CLERK           7698 03-12��-81       950                    30                                   
      7934 MILLER     CLERK           7782 23-1�� -82      1300                    10                                   

��ѡ��9�С�

SQL> select e.*
  2  from emp e,dept d
  3  where e.deptno=d.deptno and (d.dname='SALES' or d.dname='ACCOUNTING');

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7499 ALLEN      SALESMAN        7698 20-2�� -81      1600        300         30                                   
      7521 WARD       SALESMAN        7698 22-2�� -81      1250        500         30                                   
      7654 MARTIN     SALESMAN        7698 28-9�� -81      1250       1400         30                                   
      7698 BLAKE      MANAGER         7839 01-5�� -81      2850                    30                                   
      7782 CLARK      MANAGER         7839 09-6�� -81      2450                    10                                   
      7839 KING       PRESIDENT            17-11��-81      5000                    10                                   
      7844 TURNER     SALESMAN        7698 08-9�� -81      1500          0         30                                   
      7900 JAMES      CLERK           7698 03-12��-81       950                    30                                   
      7934 MILLER     CLERK           7782 23-1�� -82      1300                    10                                   

��ѡ��9�С�

SQL> --any: �ͼ����� ����һ��ֵ�Ƚ�
SQL> --��ѯ���ʱ�30�Ų�������һ��Ա���ߵ�Ա����Ϣ
SQL> select *\
  2  ;
select *\
        *
�� 1 �г��ִ���: 
ORA-00911: ��Ч�ַ� 


SQL> select *
  2  from emp
  3  where sal > any (select sal from emp where deptno=30);

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7839 KING       PRESIDENT            17-11��-81      5000                    10                                   
      7902 FORD       ANALYST         7566 03-12��-81      3000                    20                                   
      7788 SCOTT      ANALYST         7566 13-7�� -87      3000                    20                                   
      7566 JONES      MANAGER         7839 02-4�� -81      2975                    20                                   
      7698 BLAKE      MANAGER         7839 01-5�� -81      2850                    30                                   
      7782 CLARK      MANAGER         7839 09-6�� -81      2450                    10                                   
      7499 ALLEN      SALESMAN        7698 20-2�� -81      1600        300         30                                   
      7844 TURNER     SALESMAN        7698 08-9�� -81      1500          0         30                                   
      7934 MILLER     CLERK           7782 23-1�� -82      1300                    10                                   
      7521 WARD       SALESMAN        7698 22-2�� -81      1250        500         30                                   
      7654 MARTIN     SALESMAN        7698 28-9�� -81      1250       1400         30                                   

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7876 ADAMS      CLERK           7788 13-7�� -87      1100                    20                                   

��ѡ��12�С�

SQL> ed
��д�� file afiedt.buf

  1  select *
  2  from emp
  3* where sal > (select min(sal) from emp where deptno=30)
SQL> /

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7499 ALLEN      SALESMAN        7698 20-2�� -81      1600        300         30                                   
      7521 WARD       SALESMAN        7698 22-2�� -81      1250        500         30                                   
      7566 JONES      MANAGER         7839 02-4�� -81      2975                    20                                   
      7654 MARTIN     SALESMAN        7698 28-9�� -81      1250       1400         30                                   
      7698 BLAKE      MANAGER         7839 01-5�� -81      2850                    30                                   
      7782 CLARK      MANAGER         7839 09-6�� -81      2450                    10                                   
      7788 SCOTT      ANALYST         7566 13-7�� -87      3000                    20                                   
      7839 KING       PRESIDENT            17-11��-81      5000                    10                                   
      7844 TURNER     SALESMAN        7698 08-9�� -81      1500          0         30                                   
      7876 ADAMS      CLERK           7788 13-7�� -87      1100                    20                                   
      7902 FORD       ANALYST         7566 03-12��-81      3000                    20                                   

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7934 MILLER     CLERK           7782 23-1�� -82      1300                    10                                   

��ѡ��12�С�

SQL> --all:�ͼ��ϵ�����ֵ�Ƚ�
SQL>  --��ѯ���ʱ�30�Ų�������Ա���ߵ�Ա����Ϣ
SQL> select *
  2  from emp
  3  where sal > all (select sal from emp where deptno=30);

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7566 JONES      MANAGER         7839 02-4�� -81      2975                    20                                   
      7788 SCOTT      ANALYST         7566 13-7�� -87      3000                    20                                   
      7839 KING       PRESIDENT            17-11��-81      5000                    10                                   
      7902 FORD       ANALYST         7566 03-12��-81      3000                    20                                   

SQL> ed
��д�� file afiedt.buf

  1  select *
  2  from emp
  3* where sal > (select max(sal) from emp where deptno=30)
SQL> /

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7566 JONES      MANAGER         7839 02-4�� -81      2975                    20                                   
      7788 SCOTT      ANALYST         7566 13-7�� -87      3000                    20                                   
      7839 KING       PRESIDENT            17-11��-81      5000                    10                                   
      7902 FORD       ANALYST         7566 03-12��-81      3000                    20                                   

SQL> host cls

SQL> --�����Ӳ�ѯ��null
SQL> --��ѯ�����ϰ��Ա����Ϣ
SQL> select * from emp;

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7369 SMITH      CLERK           7902 17-12��-80       800                    20                                   
      7499 ALLEN      SALESMAN        7698 20-2�� -81      1600        300         30                                   
      7521 WARD       SALESMAN        7698 22-2�� -81      1250        500         30                                   
      7566 JONES      MANAGER         7839 02-4�� -81      2975                    20                                   
      7654 MARTIN     SALESMAN        7698 28-9�� -81      1250       1400         30                                   
      7698 BLAKE      MANAGER         7839 01-5�� -81      2850                    30                                   
      7782 CLARK      MANAGER         7839 09-6�� -81      2450                    10                                   
      7788 SCOTT      ANALYST         7566 13-7�� -87      3000                    20                                   
      7839 KING       PRESIDENT            17-11��-81      5000                    10                                   
      7844 TURNER     SALESMAN        7698 08-9�� -81      1500          0         30                                   
      7876 ADAMS      CLERK           7788 13-7�� -87      1100                    20                                   

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7900 JAMES      CLERK           7698 03-12��-81       950                    30                                   
      7902 FORD       ANALYST         7566 03-12��-81      3000                    20                                   
      7934 MILLER     CLERK           7782 23-1�� -82      1300                    10                                   

��ѡ��14�С�

SQL> --���ϰ��Ա��
SQL> select *
  2  from emp
  3  where empno in (select mgr from emp);

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7902 FORD       ANALYST         7566 03-12��-81      3000                    20                                   
      7698 BLAKE      MANAGER         7839 01-5�� -81      2850                    30                                   
      7839 KING       PRESIDENT            17-11��-81      5000                    10                                   
      7566 JONES      MANAGER         7839 02-4�� -81      2975                    20                                   
      7788 SCOTT      ANALYST         7566 13-7�� -87      3000                    20                                   
      7782 CLARK      MANAGER         7839 09-6�� -81      2450                    10                                   

��ѡ��6�С�

SQL> ed
��д�� file afiedt.buf

  1  select *
  2  from emp
  3* where empno not in (select mgr from emp)
SQL> /

δѡ����

SQL> ed
��д�� file afiedt.buf

  1  select *
  2  from emp
  3* where empno not in (select mgr from emp where mgr is not null)
SQL> /

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7844 TURNER     SALESMAN        7698 08-9�� -81      1500          0         30                                   
      7521 WARD       SALESMAN        7698 22-2�� -81      1250        500         30                                   
      7654 MARTIN     SALESMAN        7698 28-9�� -81      1250       1400         30                                   
      7499 ALLEN      SALESMAN        7698 20-2�� -81      1600        300         30                                   
      7934 MILLER     CLERK           7782 23-1�� -82      1300                    10                                   
      7369 SMITH      CLERK           7902 17-12��-80       800                    20                                   
      7876 ADAMS      CLERK           7788 13-7�� -87      1100                    20                                   
      7900 JAMES      CLERK           7698 03-12��-81       950                    30                                   

��ѡ��8�С�

SQL> spool off
