/*
实施复杂的安全性检查

禁止在非工作时间 往emp表中插入数据
   CREATE  [or REPLACE] TRIGGER  触发器名
   {BEFORE | AFTER}
   {DELETE | INSERT | UPDATE [OF 列名]}
   ON  表名
   PLSQL 块

周末:to_char(sysdate,'day') in ('星期六','星期日')
上班前 下班后: to_number(to_char(sysdate,'hh24')) not between 9 and 18
*/
create or replace trigger securityEmp
before insert
on emp
begin
  if to_char(sysdate,'day') in ('星期六','星期日') or 
      to_number(to_char(sysdate,'hh24')) not between 9 and 18 then 
      
    raise_application_error(-20001,'不能在非工作时间插入数据');

  end if;
end;
/













