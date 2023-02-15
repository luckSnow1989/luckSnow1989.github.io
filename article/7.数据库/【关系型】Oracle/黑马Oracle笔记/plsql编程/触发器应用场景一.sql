/*
ʵʩ���ӵİ�ȫ�Լ��

��ֹ�ڷǹ���ʱ�� ��emp���в�������
   CREATE  [or REPLACE] TRIGGER  ��������
   {BEFORE | AFTER}
   {DELETE | INSERT | UPDATE [OF ����]}
   ON  ����
   PLSQL ��

��ĩ:to_char(sysdate,'day') in ('������','������')
�ϰ�ǰ �°��: to_number(to_char(sysdate,'hh24')) not between 9 and 18
*/
create or replace trigger securityEmp
before insert
on emp
begin
  if to_char(sysdate,'day') in ('������','������') or 
      to_number(to_char(sysdate,'hh24')) not between 9 and 18 then 
      
    raise_application_error(-20001,'�����ڷǹ���ʱ���������');

  end if;
end;
/













