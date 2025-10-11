一、闪回的应用场合
	1.错误删除数据，并且commit；
	2.错误drop table；
	3.何如获得表上的历史记录；
	4.如何撤销一个已经提交过的事务；
	
二、闪回的类型
	1.闪回表(flashback table)：将表会退到过去的一个时间点上。
	2.闪回删除(flashback drop)：操作oracle回收站
	3.闪回版本查询(flashback version query)：表上的历史记录
	4.闪回事务查询(flashback transaction query)：获取一个undo_sql
	5.闪回数据库()：将数据库回退到过去上的一个时间上
	6.闪回归档日志

三、闪回的好处
	1.恢复中，闪回技术是革命性的进步
	2.传统的恢复技术，效率低，速率慢
		(1).他是整个数据库或是一个数据文件的恢复，不仅仅恢复错误处理的数据
		(2).在数据库日志中每个修改都必须被检查
	3.闪回速度快
		(1).通过行和事务把改变编入索引
		(2).仅仅恢复被改变的数据
	4.闪回命令很容易
		(1).没有复杂棘手的多步操作
		
四、闪回表(flashback table)
	1.实际上就是将表中的数据快速的恢复到过去的一个焦点或系统改变号SCN上。实现表的闪回，需要使用undo信息(撤销表空间相关的undo)
		(1)可以使用：show parameter undo ,了解相关信息。
		name				type		value
		------------------------------------
		undo_managent 		string		auto
		undo_retention		integer		900			--->这个是闪回数据保留的时间900s,15分钟，
													--->修改的命令：alter system set undo_retention=1200 scope=both;
		undo_tablespace		string		undotbs1
		(2)scope的取值,表示修改之后作用的范围，或是时效
			memoery,修改内存中的，等数据库启动后，修改的信息回复
			spfile,修改系统配置文件，但是不能直接使用，必须重启之后生效
			both,上面两个
	
		(3)系统改变号SCN
			select to_char(sysdate ,'yyyy-mm-dd hh24:mi:ss:mm') 当前时间, timestamp_to_scn(sysdate) scn from dual;
			会获得一个scn,如2234571，
			
	2.执行表的闪回，需要用户的权限:flashback any table;
		执行sql命令:grant flashback any table to scott;
	
	3.语法：(需要开启行移动功能，alter table 表名 enable row movement);
		flashback table [用户名.]<table_name>
		to scn 2893625
	
	4.如何获得离该操作最近的一个时间或scn?
		
	
	案例：
		--1.操作表之前的某一个时间，获得scn2893625
		select timestamp_to_scn(to_date('2016-07-06 21:10:00','yyyy-mm-dd hh24:mi:ss')) from dual;
		--2.开启行移动功能
		alter table person enable row movement;
		--3.闪回到某个时间
		flashback table hr.person to scn 2893625;
  
	5.注意：
		(1)表的统计数据，不能被闪回
		(2)当前的索引和从属的对象，不会被闪回
		(3)系统表不能被闪回
		(4)不能跨越ddl操作
		(5)会被写入警告日志
		(6)产生撤销和重做的数据
  
  
五、闪回删除(flashback drop)：
	1.注意：
		(1)操作oracle回收站，恢复删除的对象
		(2)只能对普通用户有作用
		(3)管理员是没有回收站的
		
	2.显示回收站里面的对象：show recyclebin
	  清空回收站：purge recyclebin
	  彻底删除：drop table 表名 purge
		
	3.恢复删除：
		(1)flashback table 表名 to before drop [rename to 新表名];
		(2)flashback table '回收站内的表名' to before drop [rename to 新表名];
  
  
六、闪回版本查询(flashback version query)：表上的历史记录
	select id, name, versions_operation,versions_starttime,versions_endtime,versions_xid
	from PERSON
	versions between timestamp minvalue and maxvalue
  
七、闪回事务查询
	1.需要权限：select any transaction
	2.通过闪回版本查询获得，xid,事务id
		select id, name, versions_operation,versions_starttime,versions_endtime,versions_xid
		from PERSON
		versions between timestamp minvalue and maxvalue
	如：xid='0400215454545454'
	3.select operation,undo_sql from flashback_transcation_query where xid='';
	得到的undo_sql，可能是多个sql,依次执行，即可撤销事务。
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
