/*
��PL/SQL���Ա�дһ����ʵ�ְ����ŷֶΣ�6000���ϡ�(6000��3000)��3000Ԫ����)
ͳ�Ƹ����ʶε�ְ���������Լ������ŵĹ����ܶ�(�����ܶ��в���������)

SQL���
1. ����: select deptno from dept; --> ��� --> ѭ��
2. ������Ա����нˮ: select sal from emp where deptno=??? --> �������Ĺ�� -->  ѭ��
3. count1 number; count2 number; count3 number;
4. ���Ź����ܶ�: salTotal number;
               select sum(sal) into salTotal from emp where deptno=???
*/
set serveroutput on

declare
  --����
  cursor cdept is select deptno from dept;
  pdeptno dept.deptno%type;
  
  --������Ա����нˮ
  cursor cemp(dno number) is select sal from emp where deptno=dno;
  psal emp.sal%type;
  
  --������
  count1 number; count2 number; count3 number;
  
  --���ŵĹ����ܶ�
  salTotal number;
begin
  open cdept;
  loop
    --ȡһ������
    fetch cdept into pdeptno;
    exit when cdept%notfound;
    
    --��ʼ�� 
    count1:=0;count2:=0;count3:=0;
    
    --���ŵĹ����ܶ�
    select sum(sal) into salTotal from emp where deptno=pdeptno;
    
    --������Ա����нˮ
    open cemp(pdeptno);
    loop
      --ȡһ��Ա����нˮcl
      fetch cemp into psal;
      exit when cemp%notfound;
      
      --�ж�
      if psal< 3000 then count1:=count1+1;
        elsif psal>=3000 and psal<6000 then count2:=count2+1;
        else count3:=count3+1;
      end if;        

    end loop;
    close cemp;
    
    -- ���浱ǰ���
    insert into msg1 values(pdeptno,count1,count2,count3,nvl(salTotal,0));

  end loop;
  close cdept;
  
  commit;
  
  dbms_output.put_line('���');
end;
/
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    
  
  
  
  
  