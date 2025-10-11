--打印1~10

set serveroutput on

declare
  pnum number := 1;
begin
  loop
    --退出循环
    exit when pnum > 10;
    
    dbms_output.put_line(pnum);

    --加一
    pnum := pnum + 1;

  end loop;
end;
/