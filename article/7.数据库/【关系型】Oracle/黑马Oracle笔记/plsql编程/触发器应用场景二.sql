/*
数据确认

涨后的薪水不能少于涨前的薪水
   CREATE  [or REPLACE] TRIGGER  触发器名
   {BEFORE | AFTER}
   {DELETE | INSERT | UPDATE [OF 列名]}
   ON  表名
   [FOR EACH ROW [WHEN(条件) ] ]
   PLSQL 块

*/
create or replace trigger checksal
before update
on emp
for each row
begin
    --if 涨后的薪水< 涨前的薪水 then 
    if :new.sal < :old.sal then   
      raise_application_error(-20002,'涨后的薪水不能少于涨前的薪水.涨前:'||:old.sal||'  涨后:'||:new.sal);
    end if;
end;
/














