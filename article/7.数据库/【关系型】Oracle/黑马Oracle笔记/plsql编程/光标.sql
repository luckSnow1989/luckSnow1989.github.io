--使用游标查询员工姓名和工资，并打印

/*
1. 光标的属性
%isopen: 是否打开
%rowcount: 行数
%notfound: 没有记录

2. 默认允许一次打开300个光标(修改光标： 第四天 管理方案)
SQL> show parameters cursor

NAME                                 TYPE        VALUE
------------------------------------ ----------- -------
cursor_sharing                       string      EXACT
cursor_space_for_time                boolean     FALSE
open_cursors                         integer     300
session_cached_cursors               integer     20
*/

set serveroutput on

declare
  --定义光标代表员工集合
  cursor cemp is select ename,sal from emp;
  pename emp.ename%type;
  psal   emp.sal%type;
begin
  open cemp;
  
  loop
    --取一个员工
    fetch cemp into pename,psal;
    
    --退出条件
    exit when cemp%notfound;

    dbms_output.put_line(pename||'的薪水是'||psal);

  end loop;
  
  close cemp;
end;
/












