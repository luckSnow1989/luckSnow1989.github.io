/*
����ȷ��

�Ǻ��нˮ����������ǰ��нˮ
   CREATE  [or REPLACE] TRIGGER  ��������
   {BEFORE | AFTER}
   {DELETE | INSERT | UPDATE [OF ����]}
   ON  ����
   [FOR EACH ROW [WHEN(����) ] ]
   PLSQL ��

*/
create or replace trigger checksal
before update
on emp
for each row
begin
    --if �Ǻ��нˮ< ��ǰ��нˮ then 
    if :new.sal < :old.sal then   
      raise_application_error(-20002,'�Ǻ��нˮ����������ǰ��нˮ.��ǰ:'||:old.sal||'  �Ǻ�:'||:new.sal);
    end if;
end;
/














