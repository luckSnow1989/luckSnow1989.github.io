/*
create [or replace] PROCEDURE ������(�����б�)  
AS 
        PLSQL�ӳ����壻

��ӡHello World

���ô洢����
1. exec sayHelloWorld();
2. begin
      sayHelloWorld();
      sayHelloWorld();
   end;
   /
*/

create or replace procedure sayHelloWorld
as
  --˵������
begin
  dbms_output.put_line('Hello World');

end;
/