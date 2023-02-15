SQL> host cls

SQL> create table test1
  2  (tid number,
  3   tname varchar2(20),
  4   hiredate date default sysdate);

���Ѵ�����

SQL> insert into test1(tid,tname) values(1,'Tom');

�Ѵ��� 1 �С�

SQL> select * from test1;

       TID TNAME                HIREDATE                                                                                
---------- -------------------- --------------                                                                          
         1 Tom                  20-6�� -13                                                                              

��ѡ�� 1 �С�

SQL> host cls

SQL> --�е�ַ
SQL> select rowid,empno,ename from emp;

ROWID                   EMPNO ENAME                                                                                     
------------------ ---------- ----------                                                                                
AAANIwAAEAAAAAeAAA       7369 SMITH                                                                                     
AAANIwAAEAAAAAeAAB       7499 ALLEN                                                                                     
AAANIwAAEAAAAAeAAC       7521 WARD                                                                                      
AAANIwAAEAAAAAeAAD       7566 JONES                                                                                     
AAANIwAAEAAAAAeAAE       7654 MARTIN                                                                                    
AAANIwAAEAAAAAeAAF       7698 BLAKE                                                                                     
AAANIwAAEAAAAAeAAG       7782 CLARK                                                                                     
AAANIwAAEAAAAAeAAH       7788 SCOTT                                                                                     
AAANIwAAEAAAAAeAAI       7839 KING                                                                                      
AAANIwAAEAAAAAeAAJ       7844 TURNER                                                                                    
AAANIwAAEAAAAAeAAK       7876 ADAMS                                                                                     

ROWID                   EMPNO ENAME                                                                                     
------------------ ---------- ----------                                                                                
AAANIwAAEAAAAAeAAL       7900 JAMES                                                                                     
AAANIwAAEAAAAAeAAM       7902 FORD                                                                                      
AAANIwAAEAAAAAeAAN       7934 MILLER                                                                                    

��ѡ��14�С�

SQL> --����20�Ų��ŵ�Ա��
SQL> create table emp20
  2  as
  3  select * from emp where deptno=20;

���Ѵ�����

SQL> select * from emp20;

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                   
---------- ---------- --------- ---------- -------------- ----- ---------- ----------                                   
      7369 SMITH      CLERK           7902 17-12��-80       800                    20                                   
      7566 JONES      MANAGER         7839 02-4�� -81      2975                    20                                   
      7788 SCOTT      ANALYST         7566 13-7�� -87      3000                    20                                   
      7876 ADAMS      CLERK           7788 13-7�� -87      1100                    20                                   
      7902 FORD       ANALYST         7566 03-12��-81      3000                    20                                   

��ѡ��5�С�

SQL> --������: Ա����  ���� ��н ��н ��������
SQL> create table empinfo
  2  as
  3  select e.empno,e.ename,e.sal,e.sal*12 annlsal,d.dname
  4  from emp e,dept d
  5  where e.deptno=d.deptno;

���Ѵ�����

SQL> select * from empinfo;

     EMPNO ENAME        SAL    ANNLSAL DNAME                                                                            
---------- ---------- ----- ---------- --------------                                                                   
      7369 SMITH        800       9600 RESEARCH                                                                         
      7499 ALLEN       1600      19200 SALES                                                                            
      7521 WARD        1250      15000 SALES                                                                            
      7566 JONES       2975      35700 RESEARCH                                                                         
      7654 MARTIN      1250      15000 SALES                                                                            
      7698 BLAKE       2850      34200 SALES                                                                            
      7782 CLARK       2450      29400 ACCOUNTING                                                                       
      7788 SCOTT       3000      36000 RESEARCH                                                                         
      7839 KING        5000      60000 ACCOUNTING                                                                       
      7844 TURNER      1500      18000 SALES                                                                            
      7876 ADAMS       1100      13200 RESEARCH                                                                         

     EMPNO ENAME        SAL    ANNLSAL DNAME                                                                            
---------- ---------- ----- ---------- --------------                                                                   
      7900 JAMES        950      11400 SALES                                                                            
      7902 FORD        3000      36000 RESEARCH                                                                         
      7934 MILLER      1300      15600 ACCOUNTING                                                                       

��ѡ��14�С�

SQL> host cls

SQL> --�޸ı� ׷������ �޸��� ɾ���� ������
SQL> desc test1
 ����                                                              �Ƿ�Ϊ��? ����
 ----------------------------------------------------------------- -------- --------------------------------------------
 TID                                                                        NUMBER
 TNAME                                                                      VARCHAR2(20)
 HIREDATE                                                                   DATE

SQL> alter table test1 add image blob;

���Ѹ��ġ�

SQL> desc test1
 ����                                                              �Ƿ�Ϊ��? ����
 ----------------------------------------------------------------- -------- --------------------------------------------
 TID                                                                        NUMBER
 TNAME                                                                      VARCHAR2(20)
 HIREDATE                                                                   DATE
 IMAGE                                                                      BLOB

SQL> alter table test1 modify tname varchar2(40);

���Ѹ��ġ�

SQL> desc test1
 ����                                                              �Ƿ�Ϊ��? ����
 ----------------------------------------------------------------- -------- --------------------------------------------
 TID                                                                        NUMBER
 TNAME                                                                      VARCHAR2(40)
 HIREDATE                                                                   DATE
 IMAGE                                                                      BLOB

SQL> alter table drop column image;
alter table drop column image
            *
�� 1 �г��ִ���: 
ORA-00903: ������Ч 


SQL> alter table test1 drop column image;

���Ѹ��ġ�

SQL> desc test1
 ����                                                              �Ƿ�Ϊ��? ����
 ----------------------------------------------------------------- -------- --------------------------------------------
 TID                                                                        NUMBER
 TNAME                                                                      VARCHAR2(40)
 HIREDATE                                                                   DATE

SQL> alter table test1 rename tname to username;
alter table test1 rename tname to username
                         *
�� 1 �г��ִ���: 
ORA-14155: ȱʧ PARTITION �� SUBPARTITION �ؼ��� 


SQL> alter table test1 rename column tname to username;

���Ѹ��ġ�

SQL> desc test1
 ����                                                              �Ƿ�Ϊ��? ����
 ----------------------------------------------------------------- -------- --------------------------------------------
 TID                                                                        NUMBER
 USERNAME                                                                   VARCHAR2(40)
 HIREDATE                                                                   DATE

SQL> host cls

SQL> -- ɾ����
SQL> select * from tab;

TNAME                          TABTYPE  CLUSTERID                                                                       
------------------------------ ------- ----------                                                                       
DEPT                           TABLE                                                                                    
TESTSAVEPOINT                  TABLE                                                                                    
EMP                            TABLE                                                                                    
BONUS                          TABLE                                                                                    
SALGRADE                       TABLE                                                                                    
EMP10                          TABLE                                                                                    
TESTDELETE                     TABLE                                                                                    
TEST1                          TABLE                                                                                    
EMP20                          TABLE                                                                                    
EMPINFO                        TABLE                                                                                    

��ѡ��10�С�

SQL> drop table test1;

����ɾ����

SQL> select * from tab;

TNAME                          TABTYPE  CLUSTERID                                                                       
------------------------------ ------- ----------                                                                       
BIN$UKc1E0vyQ0C1ZcDR8cUI4w==$0 TABLE                                                                                    
DEPT                           TABLE                                                                                    
TESTSAVEPOINT                  TABLE                                                                                    
EMP                            TABLE                                                                                    
BONUS                          TABLE                                                                                    
SALGRADE                       TABLE                                                                                    
EMP10                          TABLE                                                                                    
TESTDELETE                     TABLE                                                                                    
EMP20                          TABLE                                                                                    
EMPINFO                        TABLE                                                                                    

��ѡ��10�С�

SQL> --Oracle�Ļ���վ
SQL> show recyclebin
ORIGINAL NAME    RECYCLEBIN NAME                OBJECT TYPE  DROP TIME                                                  
---------------- ------------------------------ ------------ -------------------                                        
TEST1            BIN$UKc1E0vyQ0C1ZcDR8cUI4w==$0 TABLE        2013-06-20:15:23:20                                        
SQL> purge recyclebin;

����վ����ա�

SQL> show recyclebin
SQL> --drop table test1 purge; --> ����������վֱ��ɾ��
SQL> select * from TESTSAVEPOINT;

       TID TNAME                                                                                                        
---------- --------------------                                                                                         
         1 Tom                                                                                                          
         2 Mary                                                                                                         

��ѡ��2�С�

SQL> host cls

SQL> drop table TESTSAVEPOINT;

����ɾ����

SQL> show recyclebin
ORIGINAL NAME    RECYCLEBIN NAME                OBJECT TYPE  DROP TIME                                                  
---------------- ------------------------------ ------------ -------------------                                        
TESTSAVEPOINT    BIN$b9zRUzdaQfuXXqNhykffVA==$0 TABLE        2013-06-20:15:26:10                                        
SQL> select * from TESTSAVEPOINT;
select * from TESTSAVEPOINT
              *
�� 1 �г��ִ���: 
ORA-00942: �����ͼ������ 


SQL> select * from tab;

TNAME                          TABTYPE  CLUSTERID                                                                       
------------------------------ ------- ----------                                                                       
BIN$b9zRUzdaQfuXXqNhykffVA==$0 TABLE                                                                                    
DEPT                           TABLE                                                                                    
EMP                            TABLE                                                                                    
BONUS                          TABLE                                                                                    
SALGRADE                       TABLE                                                                                    
EMP10                          TABLE                                                                                    
TESTDELETE                     TABLE                                                                                    
EMP20                          TABLE                                                                                    
EMPINFO                        TABLE                                                                                    

��ѡ��9�С�

SQL> select * from BIN$b9zRUzdaQfuXXqNhykffVA==$0;
select * from BIN$b9zRUzdaQfuXXqNhykffVA==$0
                                        *
�� 1 �г��ִ���: 
ORA-00933: SQL ����δ��ȷ���� 


SQL> select * from "BIN$b9zRUzdaQfuXXqNhykffVA==$0";

       TID TNAME                                                                                                        
---------- --------------------                                                                                         
         1 Tom                                                                                                          
         2 Mary                                                                                                         

��ѡ��2�С�

SQL> --ע�⣺ ����Աû�л���վ
SQL> host cls

SQL> --�����Լ��
SQL> create table test2
  2  (tid number,
  3   tname varchar2(20),
  4   gender varchar2(4) check (gender in ('��','Ů')),
  5   sal number check (sal > 0)
  6  );

���Ѵ�����

SQL> insert into test2 values(1,'Tom', '��', 5000);

�Ѵ��� 1 �С�

SQL> insert into test2 values(2,'Tom', '��', 5000);
insert into test2 values(2,'Tom', '��', 5000)
*
�� 1 �г��ִ���: 
ORA-02290: Υ�����Լ������ (SCOTT.SYS_C005636) 


SQL> update test2 set gender='��' where tid=1;
update test2 set gender='��' where tid=1
*
�� 1 �г��ִ���: 
ORA-02290: Υ�����Լ������ (SCOTT.SYS_C005636) 


SQL> host cls

SQL> create table myperson
  2  (pid varchar2(18) constraint myperson_PK primary key,
  3   pname varchar2(40) constraint myperson_Name_notnull not null,
  4   gender varchar2(4) constraint myperson_Gender check (gender in ('��','Ů')),
  5   email varchar2(40) constraint myperson_Email_unique unique
  6                      constraint myperson_Email_notnull not null,
  7   deptno number constraint myperson_FK references dept(deptno) ON DELETE CASCADE
  8  );

���Ѵ�����

SQL> insert into myperson values('p001','Tom','��','tom@126.com',10);

�Ѵ��� 1 �С�

SQL> insert into myperson values('p002','Tom','��','tom@126.com',10);
insert into myperson values('p002','Tom','��','tom@126.com',10)
*
�� 1 �г��ִ���: 
ORA-00001: Υ��ΨһԼ������ (SCOTT.MYPERSON_EMAIL_UNIQUE) 


SQL> 
SQL> spool off
