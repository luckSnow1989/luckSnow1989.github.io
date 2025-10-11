/*
为员工长工资。从最低工资调起每人长10％，但工资总额不能超过5万元,
请计算长工资的人数和长工资后的工资总额，并输出输出长工资人数及工资总额。

SQL语句:
1. select empno,sal from emp order by sal;-->光标 -->循环(1. > 5w  2. 涨完)
2. countEmp number := 0;
3. 长工资后的工资总额: *. select sum(sal) from emp
                    *.  涨后=涨前+sal*0.1 (*)
                    
练习： 工资<5w                    
*/
set serveroutput on
declare
  cursor cemp is select empno,sal from emp order by sal;
  pempno emp.empno%type;
  psal   emp.sal%type;
  
  --人数
  countEmp number := 0;
  
  --工资总额
  salTotal number;
begin
  --初始的工资总额
  select sum(sal) into salTotal from emp;

  open cemp;
  loop
    --第一个退出条件
    exit when salTotal> 50000;
    
    --取一个员工
    fetch cemp into pempno,psal;
    
    --第二个退出条件
    exit when cemp%notfound;
    
    --涨工资
    update emp set sal =sal *1.1 where empno=pempno;
    
    --人数
    countEmp := countEmp+1;
    
    
     --工资总额
    salTotal := salTotal + psal *0.1;
  end loop;
  close cemp;

  commit;
  
  dbms_output.put_line('人数:'||countEmp||'  工资总额:'||salTotal);

end;
/















