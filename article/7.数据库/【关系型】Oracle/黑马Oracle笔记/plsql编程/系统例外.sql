--��0��

set serveroutput on

declare
  pnum number;
begin
  pnum := 1/0;

exception
  when Zero_Divide then dbms_output.put_line('1:0������������');
                        dbms_output.put_line('2:0������������');
  when Value_error then dbms_output.put_line('������ת������');                 
  when others then dbms_output.put_line('��������');      
end;
/