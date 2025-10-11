/*
成功插入员工后，自动输出“成功插入一个新员工”
   CREATE  [or REPLACE] TRIGGER  触发器名
   {BEFORE | AFTER}
   {DELETE | INSERT | UPDATE [OF 列名]}
   ON  表名
   PLSQL 块

*/
create or replace trigger sayNewEmp
after insert
on emp
begin
  dbms_output.put_line('成功插入一个新员工');
end;
/