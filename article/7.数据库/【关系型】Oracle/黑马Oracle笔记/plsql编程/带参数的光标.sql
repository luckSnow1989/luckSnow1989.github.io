--��ѯĳ��������Ա��������

set serveroutput on

declare
  --�������Ĺ��
  cursor cemp(dno number) is select ename from emp where deptno=dno;
  pename emp.ename%type;
begin
  open cemp(20);
  loop  
    fetch cemp into pename;
    exit when cemp%notfound;
    
    dbms_output.put_line(pename);

  end loop;
  close cemp;
end;
/