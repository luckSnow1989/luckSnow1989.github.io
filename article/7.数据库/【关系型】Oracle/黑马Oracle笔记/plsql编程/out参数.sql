/*
create [or replace] PROCEDURE 过程名(参数列表)  
AS 
        PLSQL子程序体；
查询并返回某个员工的姓名 月薪和职位

思考: out参数太多???
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