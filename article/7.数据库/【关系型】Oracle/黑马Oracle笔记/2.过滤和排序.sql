SQL> --查询10号部门的员工信息
SQL> select *
  2  from emp
  3  where deptno=10;

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     

SQL> --字符大小写敏感
SQL> select *
  2  from emp
  3  where ename = 'KING';

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     

SQL> ed
已写入 file afiedt.buf

  1  select *
  2  from emp
  3* where ename = 'King'
SQL> /

未选定行

SQL> --
SQL> --日期格式敏感: 查询入职日期为17-11月-81的员工
SQL> select *
  2  from emp
  3  where hiredate='17-11月-81';

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     

SQL> ed
已写入 file afiedt.buf

  1  select *
  2  from emp
  3* where hiredate='1981-11-17'
SQL> /
where hiredate='1981-11-17'
               *
第 3 行出现错误: 
ORA-01861: 文字与格式字符串不匹配 


SQL> select sysdate from dual;

SYSDATE                                                                                                                 
--------------                                                                                                          
19-6月 -13                                                                                                              

SQL> select *
  2  from v$nls_parameters;

PARAMETER                                                                                                               
----------------------------------------------------------------                                                        
VALUE                                                                                                                   
----------------------------------------------------------------                                                        
NLS_LANGUAGE                                                                                                            
SIMPLIFIED CHINESE                                                                                                      
                                                                                                                        
NLS_TERRITORY                                                                                                           
CHINA                                                                                                                   
                                                                                                                        
NLS_CURRENCY                                                                                                            
￥                                                                                                                      
                                                                                                                        

PARAMETER                                                                                                               
----------------------------------------------------------------                                                        
VALUE                                                                                                                   
----------------------------------------------------------------                                                        
NLS_ISO_CURRENCY                                                                                                        
CHINA                                                                                                                   
                                                                                                                        
NLS_NUMERIC_CHARACTERS                                                                                                  
.,                                                                                                                      
                                                                                                                        
NLS_CALENDAR                                                                                                            
GREGORIAN                                                                                                               
                                                                                                                        

PARAMETER                                                                                                               
----------------------------------------------------------------                                                        
VALUE                                                                                                                   
----------------------------------------------------------------                                                        
NLS_DATE_FORMAT                                                                                                         
DD-MON-RR                                                                                                               
                                                                                                                        
NLS_DATE_LANGUAGE                                                                                                       
SIMPLIFIED CHINESE                                                                                                      
                                                                                                                        
NLS_CHARACTERSET                                                                                                        
ZHS16GBK                                                                                                                
                                                                                                                        

PARAMETER                                                                                                               
----------------------------------------------------------------                                                        
VALUE                                                                                                                   
----------------------------------------------------------------                                                        
NLS_SORT                                                                                                                
BINARY                                                                                                                  
                                                                                                                        
NLS_TIME_FORMAT                                                                                                         
HH.MI.SSXFF AM                                                                                                          
                                                                                                                        
NLS_TIMESTAMP_FORMAT                                                                                                    
DD-MON-RR HH.MI.SSXFF AM                                                                                                
                                                                                                                        

PARAMETER                                                                                                               
----------------------------------------------------------------                                                        
VALUE                                                                                                                   
----------------------------------------------------------------                                                        
NLS_TIME_TZ_FORMAT                                                                                                      
HH.MI.SSXFF AM TZR                                                                                                      
                                                                                                                        
NLS_TIMESTAMP_TZ_FORMAT                                                                                                 
DD-MON-RR HH.MI.SSXFF AM TZR                                                                                            
                                                                                                                        
NLS_DUAL_CURRENCY                                                                                                       
￥                                                                                                                      
                                                                                                                        

PARAMETER                                                                                                               
----------------------------------------------------------------                                                        
VALUE                                                                                                                   
----------------------------------------------------------------                                                        
NLS_NCHAR_CHARACTERSET                                                                                                  
AL16UTF16                                                                                                               
                                                                                                                        
NLS_COMP                                                                                                                
BINARY                                                                                                                  
                                                                                                                        
NLS_LENGTH_SEMANTICS                                                                                                    
BYTE                                                                                                                    
                                                                                                                        

PARAMETER                                                                                                               
----------------------------------------------------------------                                                        
VALUE                                                                                                                   
----------------------------------------------------------------                                                        
NLS_NCHAR_CONV_EXCP                                                                                                     
FALSE                                                                                                                   
                                                                                                                        

已选择19行。

SQL> col PARAMETER for a30
SQL> /

PARAMETER                      VALUE                                                                                    
------------------------------ ----------------------------------------------------------------                         
NLS_LANGUAGE                   SIMPLIFIED CHINESE                                                                       
NLS_TERRITORY                  CHINA                                                                                    
NLS_CURRENCY                   ￥                                                                                       
NLS_ISO_CURRENCY               CHINA                                                                                    
NLS_NUMERIC_CHARACTERS         .,                                                                                       
NLS_CALENDAR                   GREGORIAN                                                                                
NLS_DATE_FORMAT                DD-MON-RR                                                                                
NLS_DATE_LANGUAGE              SIMPLIFIED CHINESE                                                                       
NLS_CHARACTERSET               ZHS16GBK                                                                                 
NLS_SORT                       BINARY                                                                                   
NLS_TIME_FORMAT                HH.MI.SSXFF AM                                                                           

PARAMETER                      VALUE                                                                                    
------------------------------ ----------------------------------------------------------------                         
NLS_TIMESTAMP_FORMAT           DD-MON-RR HH.MI.SSXFF AM                                                                 
NLS_TIME_TZ_FORMAT             HH.MI.SSXFF AM TZR                                                                       
NLS_TIMESTAMP_TZ_FORMAT        DD-MON-RR HH.MI.SSXFF AM TZR                                                             
NLS_DUAL_CURRENCY              ￥                                                                                       
NLS_NCHAR_CHARACTERSET         AL16UTF16                                                                                
NLS_COMP                       BINARY                                                                                   
NLS_LENGTH_SEMANTICS           BYTE                                                                                     
NLS_NCHAR_CONV_EXCP            FALSE                                                                                    

已选择19行。

SQL> host cls

SQL> select *
  2  from v$nls_parameters;

PARAMETER                      VALUE                                                                                    
------------------------------ ----------------------------------------------------------------                         
NLS_LANGUAGE                   SIMPLIFIED CHINESE                                                                       
NLS_TERRITORY                  CHINA                                                                                    
NLS_CURRENCY                   ￥                                                                                       
NLS_ISO_CURRENCY               CHINA                                                                                    
NLS_NUMERIC_CHARACTERS         .,                                                                                       
NLS_CALENDAR                   GREGORIAN                                                                                
NLS_DATE_FORMAT                DD-MON-RR                                                                                
NLS_DATE_LANGUAGE              SIMPLIFIED CHINESE                                                                       
NLS_CHARACTERSET               ZHS16GBK                                                                                 
NLS_SORT                       BINARY                                                                                   
NLS_TIME_FORMAT                HH.MI.SSXFF AM                                                                           

PARAMETER                      VALUE                                                                                    
------------------------------ ----------------------------------------------------------------                         
NLS_TIMESTAMP_FORMAT           DD-MON-RR HH.MI.SSXFF AM                                                                 
NLS_TIME_TZ_FORMAT             HH.MI.SSXFF AM TZR                                                                       
NLS_TIMESTAMP_TZ_FORMAT        DD-MON-RR HH.MI.SSXFF AM TZR                                                             
NLS_DUAL_CURRENCY              ￥                                                                                       
NLS_NCHAR_CHARACTERSET         AL16UTF16                                                                                
NLS_COMP                       BINARY                                                                                   
NLS_LENGTH_SEMANTICS           BYTE                                                                                     
NLS_NCHAR_CONV_EXCP            FALSE                                                                                    

已选择19行。

SQL> alter session set NLS_DATE_FORMAT='yyyy-mm-dd';

会话已更改。

SQL> select * from emp where hiredate='1981-11-17';

     EMPNO ENAME    JOB              MGR HIREDATE     SAL       COMM     DEPTNO                                         
---------- -------- --------- ---------- ---------- ----- ---------- ----------                                         
      7839 KING     PRESIDENT            1981-11-17  5000                    10                                         

SQL> alter session set NLS_DATE_FORMAT='DD-MON-RR';

会话已更改。

SQL> host cls

SQL> --between and 在...之间
SQL> --查询薪水1000~2000之间的员工
SQL> select *
  2  from emp
  3  where sal between 1000 and 2000;

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     

已选择6行。

SQL> ed
已写入 file afiedt.buf

  1  select *
  2  from emp
  3* where sal between 2000 and 1000
SQL> /

未选定行

SQL> --2. 小值在前 大值在后
SQL> host cls

SQL> --in 在集合中
SQL> --查询部门号是10和20的员工
SQL> select *
  2  from emp
  3  where deptno in (10,20);

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     

已选择8行。

SQL> ed
已写入 file afiedt.buf

  1  select *
  2  from emp
  3* where deptno not in (10,20)
SQL> /

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     

已选择6行。

SQL> --思考题:
SQL> --结论:空值3. 如果集合中含有null，不能使用not in,但可以使用in
SQL> ed
已写入 file afiedt.buf

  1  select *
  2  from emp
  3* where deptno not in (10,20,null)
SQL> /

未选定行

SQL> ed
已写入 file afiedt.buf

  1  select *
  2  from emp
  3* where deptno in (10,20,null)
SQL> /

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     

已选择8行。

SQL> host cls

SQL> --like 模糊查询 % _
SQL> --查询名字以S打头的员工
SQL> select *
  2  from emp
  3  where ename like 'S%';

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     

SQL> --查询名字是4个字的员工
SQL> select *
  2  from emp
  3  where ename like '____';

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     

SQL> insert into emp(empno,ename,sal,deptno)
  2  values(1001,'Tom_ABCD',5000,10);

已创建 1 行。

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
      1001 Tom_ABCD                                      5000                    10                                     

已选择15行。

SQL> --查询名字中含有下划线的员工
SQL> select *
  2  from emp
  3  where ename like '%_%';

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
      1001 Tom_ABCD                                      5000                    10                                     

已选择15行。

SQL> ed
已写入 file afiedt.buf

  1  select *
  2  from emp
  3* where ename like '%\_%' escape '\'
SQL> /

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      1001 Tom_ABCD                                      5000                    10                                     

SQL> rollback;

回退已完成。

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

SQL> host cls

SQL> --优化2: where 从右-->左
SQL> host cls

SQL> --排序
SQL> select *
  2  from emp
  3  order by sal;

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     

已选择14行。

SQL> --a命令  append
SQL> a  desc
  3* order by sal desc
SQL> /

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     

已选择14行。

SQL> --order by后面+列名  表达式  别名 序号
SQL> --查询员工信息 按照年薪排序
SQL> select ename,sal,sal*12
  2  from emp
  3  order by sal*12;

ENAME      SAL     SAL*12                                                                                               
-------- ----- ----------                                                                                               
SMITH      800       9600                                                                                               
JAMES      950      11400                                                                                               
ADAMS     1100      13200                                                                                               
WARD      1250      15000                                                                                               
MARTIN    1250      15000                                                                                               
MILLER    1300      15600                                                                                               
TURNER    1500      18000                                                                                               
ALLEN     1600      19200                                                                                               
CLARK     2450      29400                                                                                               
BLAKE     2850      34200                                                                                               
JONES     2975      35700                                                                                               

ENAME      SAL     SAL*12                                                                                               
-------- ----- ----------                                                                                               
SCOTT     3000      36000                                                                                               
FORD      3000      36000                                                                                               
KING      5000      60000                                                                                               

已选择14行。

SQL> ed
已写入 file afiedt.buf

  1  select ename,sal,sal*12 年薪
  2  from emp
  3* order by 年薪
SQL> /

ENAME      SAL       年薪                                                                                               
-------- ----- ----------                                                                                               
SMITH      800       9600                                                                                               
JAMES      950      11400                                                                                               
ADAMS     1100      13200                                                                                               
WARD      1250      15000                                                                                               
MARTIN    1250      15000                                                                                               
MILLER    1300      15600                                                                                               
TURNER    1500      18000                                                                                               
ALLEN     1600      19200                                                                                               
CLARK     2450      29400                                                                                               
BLAKE     2850      34200                                                                                               
JONES     2975      35700                                                                                               

ENAME      SAL       年薪                                                                                               
-------- ----- ----------                                                                                               
SCOTT     3000      36000                                                                                               
FORD      3000      36000                                                                                               
KING      5000      60000                                                                                               

已选择14行。

SQL> ed
已写入 file afiedt.buf

  1  select ename,sal,sal*12 年薪
  2  from emp
  3* order by 3
SQL> /

ENAME      SAL       年薪                                                                                               
-------- ----- ----------                                                                                               
SMITH      800       9600                                                                                               
JAMES      950      11400                                                                                               
ADAMS     1100      13200                                                                                               
WARD      1250      15000                                                                                               
MARTIN    1250      15000                                                                                               
MILLER    1300      15600                                                                                               
TURNER    1500      18000                                                                                               
ALLEN     1600      19200                                                                                               
CLARK     2450      29400                                                                                               
BLAKE     2850      34200                                                                                               
JONES     2975      35700                                                                                               

ENAME      SAL       年薪                                                                                               
-------- ----- ----------                                                                                               
SCOTT     3000      36000                                                                                               
FORD      3000      36000                                                                                               
KING      5000      60000                                                                                               

已选择14行。

SQL> ed
已写入 file afiedt.buf

  1  select ename,sal,sal*12 年薪
  2  from emp
  3* order by 4
SQL> /
order by 4
         *
第 3 行出现错误: 
ORA-01785: ORDER BY 项必须是 SELECT-list 表达式的数目 


SQL> host cls

SQL> --order by 后面+多列
SQL> select *
  2  from emp
  3  order by deptno,sal;

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     

已选择14行。

SQL> --含义： 先按照第一列排序，如果相同，再按照第二列排序，以此类推
SQL> --order by作用于后面所有的列
SQL> ed
已写入 file afiedt.buf

  1  select *
  2  from emp
  3* order by deptno,sal desc
SQL> /

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     

已选择14行。

SQL> --desc只作用于离他最近的一列
SQL> ed
已写入 file afiedt.buf

  1  select *
  2  from emp
  3* order by deptno desc,sal desc
SQL> /

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     

已选择14行。

SQL> host cls

SQL> --查询员工信息，按照奖金排序
SQL> --空值4
SQL> select * from emp order by comm;

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     

已选择14行。

SQL> set pagesize 20
SQL>  select * from emp order by comm;

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     

已选择14行。

SQL> select * from emp order by comm desc;

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     

已选择14行。

SQL> ed
已写入 file afiedt.buf

  1  select * 
  2  from emp 
  3  order by comm desc
  4* nulls last
SQL> /

     EMPNO ENAME    JOB              MGR HIREDATE         SAL       COMM     DEPTNO                                     
---------- -------- --------- ---------- -------------- ----- ---------- ----------                                     
      7654 MARTIN   SALESMAN        7698 28-9月 -81      1250       1400         30                                     
      7521 WARD     SALESMAN        7698 22-2月 -81      1250        500         30                                     
      7499 ALLEN    SALESMAN        7698 20-2月 -81      1600        300         30                                     
      7844 TURNER   SALESMAN        7698 08-9月 -81      1500          0         30                                     
      7788 SCOTT    ANALYST         7566 13-7月 -87      3000                    20                                     
      7839 KING     PRESIDENT            17-11月-81      5000                    10                                     
      7876 ADAMS    CLERK           7788 13-7月 -87      1100                    20                                     
      7900 JAMES    CLERK           7698 03-12月-81       950                    30                                     
      7902 FORD     ANALYST         7566 03-12月-81      3000                    20                                     
      7934 MILLER   CLERK           7782 23-1月 -82      1300                    10                                     
      7698 BLAKE    MANAGER         7839 01-5月 -81      2850                    30                                     
      7566 JONES    MANAGER         7839 02-4月 -81      2975                    20                                     
      7369 SMITH    CLERK           7902 17-12月-80       800                    20                                     
      7782 CLARK    MANAGER         7839 09-6月 -81      2450                    10                                     

已选择14行。

SQL> spool off
