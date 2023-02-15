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
SQL> SQL����
SQL> 1. DML(Data Manipulation Lanuage ���ݲ�������): select insert update delete
SQL> 2. DDL(Data Definition Language ���ݶ�������): create/alter/drop/truncate table
SQL>                                                create/drop view/sequence/index/synonym
SQL> 3. DCL(Data Control Language ���ݿ�������): commit rollback
SQL> */
SQL> host cls

SQL> --�������� insert
SQL> insert into emp(empno,ename,sal ,deptno)
  2  values(1001,'Tom',6000,20);

�Ѵ��� 1 �С�

SQL> --��ʽ/��ʽ����null
SQL> --��ַ��   &
SQL> insert into emp(empno,ename,sal,deptno)
  2  values(&empno,&ename,&sal,&deptno);
���� empno ��ֵ:  1002
���� ename ��ֵ:  'Mary'
���� sal ��ֵ:  5000
���� deptno ��ֵ:  10
ԭֵ    2: values(&empno,&ename,&sal,&deptno)
��ֵ    2: values(1002,'Mary',5000,10)

�Ѵ��� 1 �С�

SQL> /
���� empno ��ֵ:  1003
���� ename ��ֵ:  'Mike'
���� sal ��ֵ:  6000
���� deptno ��ֵ:  30
ԭֵ    2: values(&empno,&ename,&sal,&deptno)
��ֵ    2: values(1003,'Mike',6000,30)

�Ѵ��� 1 �С�

SQL> ed
��д�� file afiedt.buf

  1  insert into emp(empno,ename,sal,deptno)
  2* values(&empno,'&ename',&sal,&deptno)
SQL> /
���� empno ��ֵ:  1004
���� ename ��ֵ:  Jerry
���� sal ��ֵ:  5000
���� deptno ��ֵ:  10
ԭֵ    2: values(&empno,'&ename',&sal,&deptno)
��ֵ    2: values(1004,'Jerry',5000,10)

�Ѵ��� 1 �С�

SQL> host ls

SQL> host cls

SQL> select empno,ename,&t
  2  from emp;
���� t ��ֵ:  sal
ԭֵ    1: select empno,ename,&t
��ֵ    1: select empno,ename,sal

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

��ѡ��18�С�

SQL> /
���� t ��ֵ:  deptno
ԭֵ    1: select empno,ename,&t
��ֵ    1: select empno,ename,deptno

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

��ѡ��18�С�

SQL> select *
  2  from &t;
���� t ��ֵ:  dept
ԭֵ    2: from &t
��ֵ    2: from dept

    DEPTNO DNAME          LOC                                                   
---------- -------------- -------------                                         
        10 ACCOUNTING     NEW YORK                                              
        20 RESEARCH       DALLAS                                                
        30 SALES          CHICAGO                                               
        40 OPERATIONS     BOSTON                                                

SQL> rollback;

��������ɡ�

SQL> host cls

SQL> --������
SQL> create table emp10 as select * from emp where 1=2;

���Ѵ�����

SQL> desc emp10
 ����                                      �Ƿ�Ϊ��? ����
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

δѡ����

SQL> --һ���Դ�emp��  ������10�Ų��ŵ�Ա�����뵽emp10
SQL> insert into emp10
  2  select * from emp where deptno=10;

�Ѵ���3�С�

SQL> select * from emp10;

     EMPNO ENAME      JOB              MGR HIREDATE              SAL       COMM 
---------- ---------- --------- ---------- -------------- ---------- ---------- 
    DEPTNO                                                                      
----------                                                                      
      7782 CLARK      MANAGER         7839 09-6�� -81           2450            
        10                                                                      
                                                                                
      7839 KING       PRESIDENT            17-11��-81           5000            
        10                                                                      
                                                                                
      7934 MILLER     CLERK           7782 23-1�� -82           1300            
        10                                                                      
                                                                                

SQL> set linesize 120
SQL> col sal for 9999
SQL> host cls

SQL> --��������
SQL> --ɾ������
SQL> /*
SQL> delete ��truncate������
SQL> 1. delete����ɾ�� truncate �ȴݻٱ� ���ؽ�
SQL> 2. **** delete ��DML(���Իع�)��truncate��DDL(�����Իع�)
SQL> 3. delete�����ͷſռ� truncate��
SQL> 4. delete�������Ƭ truncate����
SQL> 5. delete�������أ�truncate������
SQL> */
SQL> set feedback off
SQL> @c:\sql.sql
SQL> select count(*) from testdelete;

  COUNT(*)                                                                                                              
----------                                                                                                              
      5000                                                                                                              
SQL> set timing on
SQL> delete from testdelete;
����ʱ��:  00: 00: 00.04
SQL> set timing off
SQL> drop table testdelete purge;
SQL> @c:\sql.sql
SQL> select count(*) from testdelete;

  COUNT(*)                                                                                                              
----------                                                                                                              
      5000                                                                                                              
SQL> set timing on
SQL> truncate table testdelete;
����ʱ��:  00: 00: 07.87
SQL> set timing off
SQL> host cls

SQL> /*
SQL> Oracle�е�����
SQL> 1. ��ʼ��־: DML���
SQL> 2. ������־: �ύ: ��ʽ�ύ commit
SQL>                    ��ʽ�ύ �����˳�exit ,DDL���
SQL>              �ع�: ��ʽ  rollback
SQL>                    ��ʽ  ����,崻����������˳�
SQL> */
SQL> --�����
SQL> create table testsavepoint
  2  (tid number,tname varchar2(20));
SQL> set feedback on
SQL> insert into testsavepoint values(1,'Tom');

�Ѵ��� 1 �С�

SQL> insert into testsavepoint values(2,'Mary');

�Ѵ��� 1 �С�

SQL> savepoint a;

������Ѵ�����

SQL> insert into testsavepoint values(3,'Moke');

�Ѵ��� 1 �С�

SQL> select * from testsavepoint;

       TID TNAME                                                                                                        
---------- --------------------                                                                                         
         1 Tom                                                                                                          
         2 Mary                                                                                                         
         3 Moke                                                                                                         

��ѡ��3�С�

SQL> rollback to savepoint a;

��������ɡ�

SQL> select * from testsavepoint;

       TID TNAME                                                                                                        
---------- --------------------                                                                                         
         1 Tom                                                                                                          
         2 Mary                                                                                                         

��ѡ��2�С�

SQL> commit;

�ύ��ɡ�

SQL> spool off
