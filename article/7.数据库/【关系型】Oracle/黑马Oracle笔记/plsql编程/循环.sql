--��ӡ1~10

set serveroutput on

declare
  pnum number := 1;
begin
  loop
    --�˳�ѭ��
    exit when pnum > 10;
    
    dbms_output.put_line(pnum);

    --��һ
    pnum := pnum + 1;

  end loop;
end;
/