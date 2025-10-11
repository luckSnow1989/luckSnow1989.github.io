SQL> --字符函数
SQL> select lower('Hello WORLd') 转小写,upper('Hello WORLd') 转大写,
  2         initcap('hello world') 首字母大写
  3  from dual;

转小写      转大写      首字母大写                                              
----------- ----------- -----------                                             
hello world HELLO WORLD Hello World                                             

SQL> --substr(a,b) 从a中，第b位开始取，取右边所有的字符
SQL> select substr('hello world',3) from dual;

SUBSTR('H                                                                       
---------                                                                       
llo world                                                                       

SQL> --substr(a,b,c) 从a中，第b位开始取，取c位
SQL> select substr('hello world',3,4) from dual;

SUBS                                                                            
----                                                                            
llo                                                                             

SQL> host cls

SQL> --length 字符数  lengthb 字节数
SQL> select length('hello world')  字符数,lengthb('hello world')  字节数
  2  from dual;

    字符数     字节数                                                           
---------- ----------                                                           
        11         11                                                           

SQL> ed
已写入 file afiedt.buf

  1  select length('中国')  字符数,lengthb('中国')  字节数
  2* from dual
SQL> /

    字符数     字节数                                                           
---------- ----------                                                           
         2          4                                                           

SQL> host cls

SQL> --instr(a,b) 从a中查找b，找到返回下标，否则返回0
SQL> select instr('hello world','ll') from dual;

INSTR('HELLOWORLD','LL')                                                        
------------------------                                                        
                       3                                                        

SQL> --提示:第二天的课后作业
SQL> host cls

SQL> --lpad 左填充 rpad右填充
SQL> select lpad('abcd',10,'*') 左,rpad('abcd',10,'*') 右
  2  from dual;

左         右                                                                   
---------- ----------                                                           
******abcd abcd******                                                           

SQL> --trim: 去掉前后指定的字符
SQL> select trim('H' from  'Hello WorldH') from dual;

TRIM('H'FR                                                                      
----------                                                                      
ello World                                                                      

SQL> --replace 替换
SQL> select replace('hello world',
  2  'l','*') from dual;

REPLACE('HE                                                                     
-----------                                                                     
he**o wor*d                                                                     

SQL> host cls

SQL> --四舍五入
SQL> select ROUND(45.926, 2) 一,ROUND(45.926, 1) 二,ROUND(45.926, 0) 三,
  2         ROUND(45.926, -1) 四, ROUND(45.926, -2) 五
  3  from dual;

        一         二         三         四         五                          
---------- ---------- ---------- ---------- ----------                          
     45.93       45.9         46         50          0                          

SQL> ed
已写入 file afiedt.buf

  1  select TRUNC(45.926, 2) 一,TRUNC(45.926, 1) 二,TRUNC(45.926, 0) 三,
  2         TRUNC(45.926, -1) 四, TRUNC(45.926, -2) 五
  3* from dual
SQL> /

        一         二         三         四         五                          
---------- ---------- ---------- ---------- ----------                          
     45.92       45.9         45         40          0                          

SQL> host cls

SQL> --日期函数
SQL> select sysdate from dual;

SYSDATE                                                                         
--------------                                                                  
19-6月 -13                                                                      

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

SQL> --昨天 今天 明天
SQL> select (sysdate-1) 昨天, sysdate 今天,(sysdate+1) 明天
  2  from dual;

昨天           今天           明天                                              
-------------- -------------- --------------                                    
18-6月 -13     19-6月 -13     20-6月 -13                                        

SQL> host cls

SQL> --计算员工的工龄
SQL> select ename,hiredate,(sysdate-hiredate) 天, (sysdate-hiredate)/7 星期,
  2                        (sysdate-hiredate)/30 月,(sysdate-hiredate)/365 年
  3  from emp;

ENAME      HIREDATE               天       星期         月         年           
---------- -------------- ---------- ---------- ---------- ----------           
SMITH      17-12月-80     11872.6018 1696.08597 395.753392 32.5276761           
ALLEN      20-2月 -81     11807.6018 1686.80025 393.586725 32.3495939           
WARD       22-2月 -81     11805.6018 1686.51454 393.520059 32.3441144           
JONES      02-4月 -81     11766.6018 1680.94311 392.220059 32.2372651           
MARTIN     28-9月 -81     11587.6018 1655.37168 386.253392 31.7468541           
BLAKE      01-5月 -81     11737.6018 1676.80025 391.253392  32.157813           
CLARK      09-6月 -81     11698.6018 1671.22882 389.953392 32.0509637           
SCOTT      13-7月 -87     703435.602   100490.8 23447.8534 1927.22083           
KING       17-11月-81     11537.6018 1648.22882 384.586725 31.6098678           
TURNER     08-9月 -81     11607.6018 1658.22882 386.920059 31.8016487           
ADAMS      13-7月 -87     703435.602   100490.8 23447.8534 1927.22083           

ENAME      HIREDATE               天       星期         月         年           
---------- -------------- ---------- ---------- ---------- ----------           
JAMES      03-12月-81     11521.6018 1645.94311 384.053392 31.5660322           
FORD       03-12月-81     11521.6018 1645.94311 384.053392 31.5660322           
MILLER     23-1月 -82     11470.6018 1638.65739 382.353392 31.4263062           

已选择14行。

SQL> select sysdate+hiredate from emp;
select sysdate+hiredate from emp
              *
第 1 行出现错误: 
ORA-00975: 不允许日期 + 日期 


SQL> host cls

SQL> --last_day 日期所在月份的最后一天
SQL> select last_day(sysdate) from dual;

LAST_DAY(SYSDA                                                                  
--------------                                                                  
30-6月 -13                                                                      

SQL> --MONTHS_BETWEEN 返回两个日期相差的月数
SQL> select ename,hiredate,(sysdate-hiredate)/30 一,MONTHS_BETWEEN(sysdate,hiredate) 二
  2  from emp;

ENAME      HIREDATE               一         二                                 
---------- -------------- ---------- ----------                                 
SMITH      17-12月-80     395.753475 390.084008                                 
ALLEN      20-2月 -81     393.586809 387.987234                                 
WARD       22-2月 -81     393.520142 387.922718                                 
JONES      02-4月 -81     392.220142 386.567879                                 
MARTIN     28-9月 -81     386.253475  380.72917                                 
BLAKE      01-5月 -81     391.253475 385.600137                                 
CLARK      09-6月 -81     389.953475 384.342073                                 
SCOTT      13-7月 -87     23447.8535  23111.213                                 
KING       17-11月-81     384.586809 379.084008                                 
TURNER     08-9月 -81     386.920142 381.374331                                 
ADAMS      13-7月 -87     23447.8535  23111.213                                 

ENAME      HIREDATE               一         二                                 
---------- -------------- ---------- ----------                                 
JAMES      03-12月-81     384.053475 378.535621                                 
FORD       03-12月-81     384.053475 378.535621                                 
MILLER     23-1月 -82     382.353475  376.89046                                 

已选择14行。

SQL> --ADD_MONTHS: 加上若干个月
SQL> select ADD_MONTHS(sysdate,100) from dual;

ADD_MONTHS(SYS                                                                  
--------------                                                                  
19-10月-21                                                                      

SQL> host cls

SQL> --next_day
SQL> select next_day(sysdate,'星期三') from dual;

NEXT_DAY(SYSDA                                                                  
--------------                                                                  
26-6月 -13                                                                      

SQL> select next_day(sysdate,'星期四') from dual;

NEXT_DAY(SYSDA                                                                  
--------------                                                                  
20-6月 -13                                                                      

SQL> --提示: next_day应用： 每个星期一做数据备份
SQL> --第四天： 分布式数据库
SQL> select next_day(sysdate,'礼拜四') from dual;
select next_day(sysdate,'礼拜四') from dual
                        *
第 1 行出现错误: 
ORA-01846: 周中的日无效 


SQL> host cls

SQL> select round(sysdate,'month'),  round(sysdate,'year') from dual;

ROUND(SYSDATE, ROUND(SYSDATE,                                                   
-------------- --------------                                                   
01-7月 -13     01-1月 -13                                                       

SQL> --隐式转换的前提： 被转换对象是可以转换的
SQL> --显式转换
SQL> --显示当前时间: 2013-06-19 14:45:23今天是星期三
SQL> select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss"今天是" day') from dual;

TO_CHAR(SYSDATE,'YYYY-MM-DDHH24:MI:                                             
-----------------------------------                                             
2013-06-19 14:46:59今天是 星期三                                                

SQL> --查询员工薪水： 两位小数 货币代码  千位符
SQL> select to_char(sal,'L9,999.99') from emp;

TO_CHAR(SAL,'L9,999                                                             
-------------------                                                             
           ￥800.00                                                             
         ￥1,600.00                                                             
         ￥1,250.00                                                             
         ￥2,975.00                                                             
         ￥1,250.00                                                             
         ￥2,850.00                                                             
         ￥2,450.00                                                             
         ￥3,000.00                                                             
         ￥5,000.00                                                             
         ￥1,500.00                                                             
         ￥1,100.00                                                             

TO_CHAR(SAL,'L9,999                                                             
-------------------                                                             
           ￥950.00                                                             
         ￥3,000.00                                                             
         ￥1,300.00                                                             

已选择14行。

SQL> host cls

SQL> --通用函数
SQL> --nvl2(a,b,c) 当a=null时，返回c，否则返回b
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

已选择14行。

SQL> host cls

SQL> --NULLIF(a,b) 当a=b时, 返回null，否则返回a
SQL> select nullif('abc','abc') from dual
  2  ;

NUL                                                                             
---                                                                             
                                                                                

SQL> select nullif('abc','abcd') from dual;

NUL                                                                             
---                                                                             
abc                                                                             

SQL> --COALESCE :从左往右找到第一个不为null的值
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

已选择14行。

SQL> host cls

SQL> --条件表达式
SQL> --涨工资，总裁1000 经理800 其他400
SQL> select ename,job,sal 涨前薪水,
  2         case job when 'PRESIDENT' then sal+1000
  3                  when 'MANAGER' then sal+800
  4                  else sal+400
  5          end 涨后薪水
  6  from emp;

ENAME      JOB         涨前薪水   涨后薪水                                      
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

ENAME      JOB         涨前薪水   涨后薪水                                      
---------- --------- ---------- ----------                                      
JAMES      CLERK            950       1350                                      
FORD       ANALYST         3000       3400                                      
MILLER     CLERK           1300       1700                                      

已选择14行。

SQL> select ename,job,sal 涨前薪水,
  2         decode(job,'PRESIDENT',sal+1000,
  3                    'MANAGER',sal+800,
  4                              sal+400) 涨后薪水
  5  from emp;

ENAME      JOB         涨前薪水   涨后薪水                                      
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

ENAME      JOB         涨前薪水   涨后薪水                                      
---------- --------- ---------- ----------                                      
JAMES      CLERK            950       1350                                      
FORD       ANALYST         3000       3400                                      
MILLER     CLERK           1300       1700                                      

已选择14行。

SQL> spool off
