--查询50号部门的员工

set serveroutput on

declare
  cursor cemp is select ename from emp where deptno=50;
  pename emp.ename%type;
  
  --自定义例外
  no_emp_found exception;
begin
  open cemp;

  --取一个员工
  fetch cemp into pename;
  
  if cemp%notfound then
    --抛出例外
    raise no_emp_found;
  end if;

  --当抛出例外，自动关闭
  close cemp;
  
exception
  when no_emp_found then dbms_output.put_line('没有找到员工');
  when others then dbms_output.put_line('其他例外');   
end;
/













