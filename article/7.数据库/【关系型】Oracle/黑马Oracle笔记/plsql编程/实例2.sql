/*
ΪԱ�������ʡ�����͹��ʵ���ÿ�˳�10�����������ܶ�ܳ���5��Ԫ,
����㳤���ʵ������ͳ����ʺ�Ĺ����ܶ�������������������������ܶ

SQL���:
1. select empno,sal from emp order by sal;-->��� -->ѭ��(1. > 5w  2. ����)
2. countEmp number := 0;
3. �����ʺ�Ĺ����ܶ�: *. select sum(sal) from emp
                    *.  �Ǻ�=��ǰ+sal*0.1 (*)
                    
��ϰ�� ����<5w                    
*/
set serveroutput on
declare
  cursor cemp is select empno,sal from emp order by sal;
  pempno emp.empno%type;
  psal   emp.sal%type;
  
  --����
  countEmp number := 0;
  
  --�����ܶ�
  salTotal number;
begin
  --��ʼ�Ĺ����ܶ�
  select sum(sal) into salTotal from emp;

  open cemp;
  loop
    --��һ���˳�����
    exit when salTotal> 50000;
    
    --ȡһ��Ա��
    fetch cemp into pempno,psal;
    
    --�ڶ����˳�����
    exit when cemp%notfound;
    
    --�ǹ���
    update emp set sal =sal *1.1 where empno=pempno;
    
    --����
    countEmp := countEmp+1;
    
    
     --�����ܶ�
    salTotal := salTotal + psal *0.1;
  end loop;
  close cemp;

  commit;
  
  dbms_output.put_line('����:'||countEmp||'  �����ܶ�:'||salTotal);

end;
/















