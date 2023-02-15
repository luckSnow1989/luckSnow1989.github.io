--查询并打印7839的姓名和薪水

set serveroutput on

declare 
  --定义引用型变量
  pename emp.ename%type;
  psal   emp.sal%type;
begin

  --查询7839的姓名和薪水
  select ename,sal into pename,psal from emp where empno=7839;

  -- 打印
  dbms_output.put_line(pename||'的薪水是'||psal);
end;
/