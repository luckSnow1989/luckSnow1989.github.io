/*
ʵ��1��ͳ��ÿ����ְ��Ա��������

SQL���
1. select to_char(hiredate,'RR') from emp; --> ���  --> ѭ��(notfound)
2. count80 number := 0;
   count81 number := 0;
   count82 number := 0;
   count87 number := 0;
*/
set serveroutput on 

declare
  cursor cemp is select to_char(hiredate,'RR') from emp;
  phiredate varchar2(4);
  
  --������
  count80 number := 0;
  count81 number := 0;
  count82 number := 0;
  count87 number := 0;
begin
  open cemp;
  loop
    --ȡһ��Ա��
    fetch cemp into phiredate;
    exit when cemp%notfound;

    --�ж����
    if phiredate = '80' then count80:=count80+1;
      elsif phiredate = '81' then count81:=count81+1;
      elsif phiredate = '82' then count82:=count82+1;
      else count87:=count87+1;
    end if;

  end loop;
  close cemp;
  
  dbms_output.put_line('Total:'||(count80+count81+count82+count87));
  dbms_output.put_line('80:'||count80);
  dbms_output.put_line('81:'||count81);
  dbms_output.put_line('82:'||count82);
  dbms_output.put_line('87:'||count87);
end;
/


















