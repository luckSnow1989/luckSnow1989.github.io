--��ѯ50�Ų��ŵ�Ա��

set serveroutput on

declare
  cursor cemp is select ename from emp where deptno=50;
  pename emp.ename%type;
  
  --�Զ�������
  no_emp_found exception;
begin
  open cemp;

  --ȡһ��Ա��
  fetch cemp into pename;
  
  if cemp%notfound then
    --�׳�����
    raise no_emp_found;
  end if;

  --���׳����⣬�Զ��ر�
  close cemp;
  
exception
  when no_emp_found then dbms_output.put_line('û���ҵ�Ա��');
  when others then dbms_output.put_line('��������');   
end;
/













