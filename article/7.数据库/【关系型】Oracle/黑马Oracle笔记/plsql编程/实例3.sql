/*
用PL/SQL语言编写一程序，实现按部门分段（6000以上、(6000，3000)、3000元以下)
统计各工资段的职工人数、以及各部门的工资总额(工资总额中不包括奖金)

SQL语句
1. 部门: select deptno from dept; --> 光标 --> 循环
2. 部门中员工的薪水: select sal from emp where deptno=??? --> 带参数的光标 -->  循环
3. count1 number; count2 number; count3 number;
4. 部门工资总额: salTotal number;
               select sum(sal) into salTotal from emp where deptno=???
*/
set serveroutput on

declare
  --部门
  cursor cdept is select deptno from dept;
  pdeptno dept.deptno%type;
  
  --部门中员工的薪水
  cursor cemp(dno number) is select sal from emp where deptno=dno;
  psal emp.sal%type;
  
  --计数器
  count1 number; count2 number; count3 number;
  
  --部门的工资总额
  salTotal number;
begin
  open cdept;
  loop
    --取一个部门
    fetch cdept into pdeptno;
    exit when cdept%notfound;
    
    --初始化 
    count1:=0;count2:=0;count3:=0;
    
    --部门的工资总额
    select sum(sal) into salTotal from emp where deptno=pdeptno;
    
    --部门中员工的薪水
    open cemp(pdeptno);
    loop
      --取一个员工的薪水cl
      fetch cemp into psal;
      exit when cemp%notfound;
      
      --判断
      if psal< 3000 then count1:=count1+1;
        elsif psal>=3000 and psal<6000 then count2:=count2+1;
        else count3:=count3+1;
      end if;        

    end loop;
    close cemp;
    
    -- 保存当前结果
    insert into msg1 values(pdeptno,count1,count2,count3,nvl(salTotal,0));

  end loop;
  close cdept;
  
  commit;
  
  dbms_output.put_line('完成');
end;
/
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    
  
  
  
  
  