/*
create [or replace] PROCEDURE ������(�����б�)  
AS 
        PLSQL�ӳ����壻

Ϊָ����Ա����100��Ǯ  ����ӡ��ǰ���Ǻ��нˮ
*/
create or replace procedure raiseSalary(eno in number)
as
  psal emp.sal%type;
begin
  --��ǰнˮ
  select sal into psal from emp where empno=eno;
  
  --��100
  update emp set sal=sal+100 where empno=eno;
  
  --Ҫ��Ҫcommit???
  
  dbms_output.put_line('��ǰ:'||psal||'   �Ǻ�:'||(psal+100));

end;
/