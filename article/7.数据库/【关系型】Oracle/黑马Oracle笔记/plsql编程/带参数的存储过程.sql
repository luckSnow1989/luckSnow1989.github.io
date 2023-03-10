/*
create [or replace] PROCEDURE 过程名(参数列表)  
AS 
        PLSQL子程序体；

为指定的员工涨100块钱  并打印涨前和涨后的薪水
*/
create or replace procedure raiseSalary(eno in number)
as
  psal emp.sal%type;
begin
  --涨前薪水
  select sal into psal from emp where empno=eno;
  
  --涨100
  update emp set sal=sal+100 where empno=eno;
  
  --要不要commit???
  
  dbms_output.put_line('涨前:'||psal||'   涨后:'||(psal+100));

end;
/