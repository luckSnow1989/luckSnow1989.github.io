--1.�����ֵ�Ҳ��һ�ű������ݿ����Աά��������Ա������ֱ�Ӳ���(ԭ������������)
select * from tab;
--��Oracle���ݿ��У���������Ϊ����
       --(1)������ҵ���ݵı�person,students
       --(2)�����ֵ䣺dictionary��user_objects,user_tables,user_tab_column��user_view
       
--2.�鿴dictionary�����ݽṹ��������
desc dictionary
Name       Type           Nullable Default Comments                   
---------- -------------- -------- ------- -------------------------- 
TABLE_NAME VARCHAR2(30)   Y                Name of the object         
COMMENTS   VARCHAR2(4000) Y                Text comment on the object
              
--3.�鿴��ǰ�û���ʹ����Щ�����ֵ�
select * from dictionary

--4.�鿴��ǰ�û������ı�
select * from user_tables

--5.�����ֵ����������
       ǰ׺                 ˵��
---------- -------------- -------- ------- -------------------------- 
       user_              �û��Լ���
       all_               �û����Է��ʵ���
       dba_               ����Ա��ͼ
       v$                 ������ص�����

--6.�������ע��
comment on table person is '�ҵĲ�������';       
       
--7.�鿴�Լ���Ȩ��,��ͼ
select * from session_privs  

--8.�鿴���У���ͼ
select * from user_synonyms   
       
--9.�鿴������,��ͼ
select * from user_triggers
       
--10.�鿴������Դ����,��ͼ
select * from user_source
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
