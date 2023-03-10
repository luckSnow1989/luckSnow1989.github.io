/*
CREATE [OR REPLACE] FUNCTION 函数名(参数列表) 
 RETURN  函数值类型
AS
PLSQL子程序体；

查询某个员工的年收入

*/
create or replace function queryEmpIncome(eno in number)
return number
as
  psal emp.sal%type;
  pcomm emp.comm%type;
begin

  select sal,comm into psal,pcomm from emp where empno=eno;

  return psal*12+nvl(pcomm,0);
end;
/