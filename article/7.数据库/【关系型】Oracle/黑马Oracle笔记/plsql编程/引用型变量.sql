--��ѯ����ӡ7839��������нˮ

set serveroutput on

declare 
  --���������ͱ���
  pename emp.ename%type;
  psal   emp.sal%type;
begin

  --��ѯ7839��������нˮ
  select ename,sal into pename,psal from emp where empno=7839;

  -- ��ӡ
  dbms_output.put_line(pename||'��нˮ��'||psal);
end;
/