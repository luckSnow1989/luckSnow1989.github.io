/*
create [or replace] PROCEDURE 过程名(参数列表)  
AS 
        PLSQL子程序体；

打印Hello World

调用存储过程
1. exec sayHelloWorld();
2. begin
      sayHelloWorld();
      sayHelloWorld();
   end;
   /
*/

create or replace procedure sayHelloWorld
as
  --说明部分
begin
  dbms_output.put_line('Hello World');

end;
/