--ʹ���α��ѯԱ�������͹��ʣ�����ӡ

/*
1. ��������
%isopen: �Ƿ��
%rowcount: ����
%notfound: û�м�¼

2. Ĭ������һ�δ�300�����(�޸Ĺ�꣺ ������ ������)
SQL> show parameters cursor

NAME                                 TYPE        VALUE
------------------------------------ ----------- -------
cursor_sharing                       string      EXACT
cursor_space_for_time                boolean     FALSE
open_cursors                         integer     300
session_cached_cursors               integer     20
*/

set serveroutput on

declare
  --���������Ա������
  cursor cemp is select ename,sal from emp;
  pename emp.ename%type;
  psal   emp.sal%type;
begin
  open cemp;
  
  loop
    --ȡһ��Ա��
    fetch cemp into pename,psal;
    
    --�˳�����
    exit when cemp%notfound;

    dbms_output.put_line(pename||'��нˮ��'||psal);

  end loop;
  
  close cemp;
end;
/












