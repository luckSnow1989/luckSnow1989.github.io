-- ��ѯ���ݿ⵱ǰ���̵�������
select count(*) from v$process;

-- �鿴���ݿ⵱ǰ�Ự����������
select count(*) from v$session;

--�鿴���ݿ�Ĳ�����������
select count(*) from v$session where status='ACTIVE';��

--�鿴��ǰ���ݿ⽨���ĻỰ�����
select sid,serial#,username,program,machine,status from v$session;

--���ݿ���������������
select value from v$parameter where name ='processes';
select value from v$parameter where name ='sessions';

--�޸����������:spfile��ʾ��������Ч
alter system set processes = 300 scope = spfile;
alter system set sessions=335 scope=spfile;


--��ǰ������session������(ÿ���û����Ե�������)
select SCHEMANAME,count(*) from v$session group by SCHEMANAME;  

--�鿴��ǰ����Щ�û�����ʹ�����ݣ�
select osuser,a.username,cpu_time/executions/1000000||'s',sql_fulltext,machine
from v$session a,v$sqlarea b
where a.sql_address = b.address
order by cpu_time/executions desc;







