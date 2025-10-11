-- 查询数据库当前进程的连接数
select count(*) from v$process;

-- 查看数据库当前会话的连接数：
select count(*) from v$session;

--查看数据库的并发连接数：
select count(*) from v$session where status='ACTIVE';　

--查看当前数据库建立的会话情况：
select sid,serial#,username,program,machine,status from v$session;

--数据库允许的最大连接数
select value from v$parameter where name ='processes';
select value from v$parameter where name ='sessions';

--修改最大连接数:spfile表示重启后生效
alter system set processes = 300 scope = spfile;
alter system set sessions=335 scope=spfile;


--当前的所有session连接数(每个用户各自的连接数)
select SCHEMANAME,count(*) from v$session group by SCHEMANAME;  

--查看当前有哪些用户正在使用数据：
select osuser,a.username,cpu_time/executions/1000000||'s',sql_fulltext,machine
from v$session a,v$sqlarea b
where a.sql_address = b.address
order by cpu_time/executions desc;







