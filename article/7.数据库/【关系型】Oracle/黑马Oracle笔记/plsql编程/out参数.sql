/*
create [or replace] PROCEDURE ������(�����б�)  
AS 
        PLSQL�ӳ����壻
��ѯ������ĳ��Ա�������� ��н��ְλ

˼��: out����̫��???
*/
create or replace procedure queryEmpInfo(eno in number,
                                         pename out varchar2,
                                         psal   out number,
                                         pjob   out varchar2)
as
begin
  select ename,sal,empjob into pename,psal,pjob from emp where empno=eno;

end;
/