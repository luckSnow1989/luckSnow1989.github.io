SQL> --�ַ�����
SQL> select lower('Hello WORLd') תСд,upper('Hello WORLd') ת��д,
  2         initcap('hello world') ����ĸ��д
  3  from dual;

תСд      ת��д      ����ĸ��д                                              
----------- ----------- -----------                                             
hello world HELLO WORLD Hello World                                             

SQL> --substr(a,b) ��a�У���bλ��ʼȡ��ȡ�ұ����е��ַ�
SQL> select substr('hello world',3) from dual;

SUBSTR('H                                                                       
---------                                                                       
llo world                                                                       

SQL> --substr(a,b,c) ��a�У���bλ��ʼȡ��ȡcλ
SQL> select substr('hello world',3,4) from dual;

SUBS                                                                            
----                                                                            
llo                                                                             

SQL> host cls

SQL> --length �ַ���  lengthb �ֽ���
SQL> select length('hello world')  �ַ���,lengthb('hello world')  �ֽ���
  2  from dual;

    �ַ���     �ֽ���                                                           
---------- ----------                                                           
        11         11                                                           

SQL> ed
��д�� file afiedt.buf

  1  select length('�й�')  �ַ���,lengthb('�й�')  �ֽ���
  2* from dual
SQL> /

    �ַ���     �ֽ���                                                           
---------- ----------                                                           
         2          4                                                           

SQL> host cls

SQL> --instr(a,b) ��a�в���b���ҵ������±꣬���򷵻�0
SQL> select instr('hello world','ll') from dual;

INSTR('HELLOWORLD','LL')                                                        
------------------------                                                        
                       3                                                        

SQL> --��ʾ:�ڶ���Ŀκ���ҵ
SQL> host cls

SQL> --lpad ����� rpad�����
SQL> select lpad('abcd',10,'*') ��,rpad('abcd',10,'*') ��
  2  from dual;

��         ��                                                                   
---------- ----------                                                           
******abcd abcd******                                                           

SQL> --trim: ȥ��ǰ��ָ�����ַ�
SQL> select trim('H' from  'Hello WorldH') from dual;

TRIM('H'FR                                                                      
----------                                                                      
ello World                                                                      

SQL> --replace �滻
SQL> select replace('hello world',
  2  'l','*') from dual;

REPLACE('HE                                                                     
-----------                                                                     
he**o wor*d                                                                     

SQL> host cls

SQL> --��������
SQL> select ROUND(45.926, 2) һ,ROUND(45.926, 1) ��,ROUND(45.926, 0) ��,
  2         ROUND(45.926, -1) ��, ROUND(45.926, -2) ��
  3  from dual;

        һ         ��         ��         ��         ��                          
---------- ---------- ---------- ---------- ----------                          
     45.93       45.9         46         50          0                          

SQL> ed
��д�� file afiedt.buf

  1  select TRUNC(45.926, 2) һ,TRUNC(45.926, 1) ��,TRUNC(45.926, 0) ��,
  2         TRUNC(45.926, -1) ��, TRUNC(45.926, -2) ��
  3* from dual
SQL> /

        һ         ��         ��         ��         ��                          
---------- ---------- ---------- ---------- ----------                          
     45.92       45.9         45         40          0                          

SQL> host cls

SQL> --���ں���
SQL> select sysdate from dual;

SYSDATE                                                                         
--------------                                                                  
19-6�� -13                                                                      

SQL> select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual;

TO_CHAR(SYSDATE,'YY                                                             
-------------------                                                             
2013-06-19 14:22:23                                                             

SQL> select to_char(systimestamp,'yyyy-mm-dd hh24:mi:ss:ff') from dual;

TO_CHAR(SYSTIMESTAMP,'YYYY-MM                                                   
-----------------------------                                                   
2013-06-19 14:23:22:000000                                                      

SQL> select to_char(systimestamp,'yyyy-mm-dd hh24:mi:ss:ff') from dual;

TO_CHAR(SYSTIMESTAMP,'YYYY-MM                                                   
-----------------------------                                                   
2013-06-19 14:23:24:843000                                                      

SQL> --���� ���� ����
SQL> select (sysdate-1) ����, sysdate ����,(sysdate+1) ����
  2  from dual;

����           ����           ����                                              
-------------- -------------- --------------                                    
18-6�� -13     19-6�� -13     20-6�� -13                                        

SQL> host cls

SQL> --����Ա���Ĺ���
SQL> select ename,hiredate,(sysdate-hiredate) ��, (sysdate-hiredate)/7 ����,
  2                        (sysdate-hiredate)/30 ��,(sysdate-hiredate)/365 ��
  3  from emp;

ENAME      HIREDATE               ��       ����         ��         ��           
---------- -------------- ---------- ---------- ---------- ----------           
SMITH      17-12��-80     11872.6018 1696.08597 395.753392 32.5276761           
ALLEN      20-2�� -81     11807.6018 1686.80025 393.586725 32.3495939           
WARD       22-2�� -81     11805.6018 1686.51454 393.520059 32.3441144           
JONES      02-4�� -81     11766.6018 1680.94311 392.220059 32.2372651           
MARTIN     28-9�� -81     11587.6018 1655.37168 386.253392 31.7468541           
BLAKE      01-5�� -81     11737.6018 1676.80025 391.253392  32.157813           
CLARK      09-6�� -81     11698.6018 1671.22882 389.953392 32.0509637           
SCOTT      13-7�� -87     703435.602   100490.8 23447.8534 1927.22083           
KING       17-11��-81     11537.6018 1648.22882 384.586725 31.6098678           
TURNER     08-9�� -81     11607.6018 1658.22882 386.920059 31.8016487           
ADAMS      13-7�� -87     703435.602   100490.8 23447.8534 1927.22083           

ENAME      HIREDATE               ��       ����         ��         ��           
---------- -------------- ---------- ---------- ---------- ----------           
JAMES      03-12��-81     11521.6018 1645.94311 384.053392 31.5660322           
FORD       03-12��-81     11521.6018 1645.94311 384.053392 31.5660322           
MILLER     23-1�� -82     11470.6018 1638.65739 382.353392 31.4263062           

��ѡ��14�С�

SQL> select sysdate+hiredate from emp;
select sysdate+hiredate from emp
              *
�� 1 �г��ִ���: 
ORA-00975: ���������� + ���� 


SQL> host cls

SQL> --last_day ���������·ݵ����һ��
SQL> select last_day(sysdate) from dual;

LAST_DAY(SYSDA                                                                  
--------------                                                                  
30-6�� -13                                                                      

SQL> --MONTHS_BETWEEN ��������������������
SQL> select ename,hiredate,(sysdate-hiredate)/30 һ,MONTHS_BETWEEN(sysdate,hiredate) ��
  2  from emp;

ENAME      HIREDATE               һ         ��                                 
---------- -------------- ---------- ----------                                 
SMITH      17-12��-80     395.753475 390.084008                                 
ALLEN      20-2�� -81     393.586809 387.987234                                 
WARD       22-2�� -81     393.520142 387.922718                                 
JONES      02-4�� -81     392.220142 386.567879                                 
MARTIN     28-9�� -81     386.253475  380.72917                                 
BLAKE      01-5�� -81     391.253475 385.600137                                 
CLARK      09-6�� -81     389.953475 384.342073                                 
SCOTT      13-7�� -87     23447.8535  23111.213                                 
KING       17-11��-81     384.586809 379.084008                                 
TURNER     08-9�� -81     386.920142 381.374331                                 
ADAMS      13-7�� -87     23447.8535  23111.213                                 

ENAME      HIREDATE               һ         ��                                 
---------- -------------- ---------- ----------                                 
JAMES      03-12��-81     384.053475 378.535621                                 
FORD       03-12��-81     384.053475 378.535621                                 
MILLER     23-1�� -82     382.353475  376.89046                                 

��ѡ��14�С�

SQL> --ADD_MONTHS: �������ɸ���
SQL> select ADD_MONTHS(sysdate,100) from dual;

ADD_MONTHS(SYS                                                                  
--------------                                                                  
19-10��-21                                                                      

SQL> host cls

SQL> --next_day
SQL> select next_day(sysdate,'������') from dual;

NEXT_DAY(SYSDA                                                                  
--------------                                                                  
26-6�� -13                                                                      

SQL> select next_day(sysdate,'������') from dual;

NEXT_DAY(SYSDA                                                                  
--------------                                                                  
20-6�� -13                                                                      

SQL> --��ʾ: next_dayӦ�ã� ÿ������һ�����ݱ���
SQL> --�����죺 �ֲ�ʽ���ݿ�
SQL> select next_day(sysdate,'�����') from dual;
select next_day(sysdate,'�����') from dual
                        *
�� 1 �г��ִ���: 
ORA-01846: ���е�����Ч 


SQL> host cls

SQL> select round(sysdate,'month'),  round(sysdate,'year') from dual;

ROUND(SYSDATE, ROUND(SYSDATE,                                                   
-------------- --------------                                                   
01-7�� -13     01-1�� -13                                                       

SQL> --��ʽת����ǰ�᣺ ��ת�������ǿ���ת����
SQL> --��ʽת��
SQL> --��ʾ��ǰʱ��: 2013-06-19 14:45:23������������
SQL> select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss"������" day') from dual;

TO_CHAR(SYSDATE,'YYYY-MM-DDHH24:MI:                                             
-----------------------------------                                             
2013-06-19 14:46:59������ ������                                                

SQL> --��ѯԱ��нˮ�� ��λС�� ���Ҵ���  ǧλ��
SQL> select to_char(sal,'L9,999.99') from emp;

TO_CHAR(SAL,'L9,999                                                             
-------------------                                                             
           ��800.00                                                             
         ��1,600.00                                                             
         ��1,250.00                                                             
         ��2,975.00                                                             
         ��1,250.00                                                             
         ��2,850.00                                                             
         ��2,450.00                                                             
         ��3,000.00                                                             
         ��5,000.00                                                             
         ��1,500.00                                                             
         ��1,100.00                                                             

TO_CHAR(SAL,'L9,999                                                             
-------------------                                                             
           ��950.00                                                             
         ��3,000.00                                                             
         ��1,300.00                                                             

��ѡ��14�С�

SQL> host cls

SQL> --ͨ�ú���
SQL> --nvl2(a,b,c) ��a=nullʱ������c�����򷵻�b
SQL> select sal*12+nvl2(comm,comm,0) from emp;

SAL*12+NVL2(COMM,COMM,0)                                                        
------------------------                                                        
                    9600                                                        
                   19500                                                        
                   15500                                                        
                   35700                                                        
                   16400                                                        
                   34200                                                        
                   29400                                                        
                   36000                                                        
                   60000                                                        
                   18000                                                        
                   13200                                                        

SAL*12+NVL2(COMM,COMM,0)                                                        
------------------------                                                        
                   11400                                                        
                   36000                                                        
                   15600                                                        

��ѡ��14�С�

SQL> host cls

SQL> --NULLIF(a,b) ��a=bʱ, ����null�����򷵻�a
SQL> select nullif('abc','abc') from dual
  2  ;

NUL                                                                             
---                                                                             
                                                                                

SQL> select nullif('abc','abcd') from dual;

NUL                                                                             
---                                                                             
abc                                                                             

SQL> --COALESCE :���������ҵ���һ����Ϊnull��ֵ
SQL> select comm,sal,COALESCE(comm,sal) from emp;

      COMM        SAL COALESCE(COMM,SAL)                                        
---------- ---------- ------------------                                        
                  800                800                                        
       300       1600                300                                        
       500       1250                500                                        
                 2975               2975                                        
      1400       1250               1400                                        
                 2850               2850                                        
                 2450               2450                                        
                 3000               3000                                        
                 5000               5000                                        
         0       1500                  0                                        
                 1100               1100                                        

      COMM        SAL COALESCE(COMM,SAL)                                        
---------- ---------- ------------------                                        
                  950                950                                        
                 3000               3000                                        
                 1300               1300                                        

��ѡ��14�С�

SQL> host cls

SQL> --�������ʽ
SQL> --�ǹ��ʣ��ܲ�1000 ����800 ����400
SQL> select ename,job,sal ��ǰнˮ,
  2         case job when 'PRESIDENT' then sal+1000
  3                  when 'MANAGER' then sal+800
  4                  else sal+400
  5          end �Ǻ�нˮ
  6  from emp;

ENAME      JOB         ��ǰнˮ   �Ǻ�нˮ                                      
---------- --------- ---------- ----------                                      
SMITH      CLERK            800       1200                                      
ALLEN      SALESMAN        1600       2000                                      
WARD       SALESMAN        1250       1650                                      
JONES      MANAGER         2975       3775                                      
MARTIN     SALESMAN        1250       1650                                      
BLAKE      MANAGER         2850       3650                                      
CLARK      MANAGER         2450       3250                                      
SCOTT      ANALYST         3000       3400                                      
KING       PRESIDENT       5000       6000                                      
TURNER     SALESMAN        1500       1900                                      
ADAMS      CLERK           1100       1500                                      

ENAME      JOB         ��ǰнˮ   �Ǻ�нˮ                                      
---------- --------- ---------- ----------                                      
JAMES      CLERK            950       1350                                      
FORD       ANALYST         3000       3400                                      
MILLER     CLERK           1300       1700                                      

��ѡ��14�С�

SQL> select ename,job,sal ��ǰнˮ,
  2         decode(job,'PRESIDENT',sal+1000,
  3                    'MANAGER',sal+800,
  4                              sal+400) �Ǻ�нˮ
  5  from emp;

ENAME      JOB         ��ǰнˮ   �Ǻ�нˮ                                      
---------- --------- ---------- ----------                                      
SMITH      CLERK            800       1200                                      
ALLEN      SALESMAN        1600       2000                                      
WARD       SALESMAN        1250       1650                                      
JONES      MANAGER         2975       3775                                      
MARTIN     SALESMAN        1250       1650                                      
BLAKE      MANAGER         2850       3650                                      
CLARK      MANAGER         2450       3250                                      
SCOTT      ANALYST         3000       3400                                      
KING       PRESIDENT       5000       6000                                      
TURNER     SALESMAN        1500       1900                                      
ADAMS      CLERK           1100       1500                                      

ENAME      JOB         ��ǰнˮ   �Ǻ�нˮ                                      
---------- --------- ---------- ----------                                      
JAMES      CLERK            950       1350                                      
FORD       ANALYST         3000       3400                                      
MILLER     CLERK           1300       1700                                      

��ѡ��14�С�

SQL> spool off
