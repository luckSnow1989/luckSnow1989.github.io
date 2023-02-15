http://www.bitscn.com/pdb/oracle/201402/240874.html


一、首先明确分区表和表分区的区别：
	表分区是一种思想，分区表示一种技术实现。当表的大小过G的时候可以考虑进行表分区，提高查询效率，均衡IO。
	oracle分区表是oracle数据库提供的一种表分区的实现形式。表进行分区后，逻辑上仍然是一张表，原来的查询SQL同样生效，
	同时可以采用使用分区查询来优化SQL查询效率，不至于每次都扫描整个表

	
二、分区表基本操作(以创建表的同时创建分区为例)

1、按时间分区表创建：
	(1)
	create table t_test (
		pk_id                number(30)                   not null,
		add_date_time        DATE,
		constraint PK_T_TEST  primary key (pk_id)
	)
	
	PARTITION BY RANGE (add_date_time)--add_date_time 是字段名称
	(
	  PARTITION t_test_2013_less VALUES LESS THAN (TO_DATE('2013-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss')) TABLESPACE TS_MISPS,
	  PARTITION t_test_2013      VALUES LESS THAN (TO_DATE('2014-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss')) TABLESPACE TS_MISPS,
	  PARTITION t_test_2014      VALUES LESS THAN (TO_DATE('2015-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss')) TABLESPACE TS_MISPS
	)--TS_MISPS是使用的表空间的名称
	(2) 插入100W数据做测试
	declare
	  i    int := 1;
	  year VARCHAR2(20);
	begin
	  loop
		year := CASE mod(i, 3)
				 WHEN 0 THEN
				  '2012-01-14 12:00:00'
				 WHEN 1 THEN
				  '2013-01-14 12:00:00'
				 ELSE
				  '2014-01-14 12:00:00'
				END;
			   insert into t_test values(i, to_date(year, 'yyyy-mm-dd hh24:mi:ss'));
		exit when i= 1000000;
		i := i + 1;
	  end loop;
	end;	
	
	(3)查看分区表的分区的详细信息
	Select table_name,partition_name,high_value from dba_tab_partitions where table_name='T_TEST';
	
2、分区表修改	
	2.1增加一个分区
		分两种情况：1.没有maxvalue分区。2.有maxvalue分区。我们创建的分区就是没有maxValue的分区
		2.1.1.没有maxvalue分区添加新分区：
		alter table t_test add partition t_test_2015 
		VALUES LESS THAN (TO_DATE('2015-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss')) TABLESPACE TS_MISPS ;
		
		2.1.2、有maxvalue分区添加新分区：
		有了maxvalue，就不能直接add partition，而是需要max分区split。例如我们将创建的分区的语句修改下：
		create table t_test (
			pk_id                number(30)                      not null,
			add_date_time        DATE,
			constraintPK_T_TEST  primary key (pk_id)
		)
		PARTITION BY RANGE (add_date_time)
		(
		  PARTITION t_test_2013_less VALUES LESS THAN 
			(TO_DATE('2013-01-01 00:00:00','yyyy-mm-ddhh24:mi:ss')) TABLESPACE TS_MISPS,
		  PARTITION t_test_2013 VALUES LESS THAN 
			(TO_DATE('2014-01-01 00:00:00','yyyy-mm-ddhh24:mi:ss')) TABLESPACE TS_MISPS,
		  PARTITION t_test_2014 VALUES LESS THAN 
			(TO_DATE('2015-01-01 00:00:00','yyyy-mm-ddhh24:mi:ss')) TABLESPACE TS_MISPS,
			PARTITION t_test_max VALUES LESS THAN (MAXVALUE)
		)
		增加一个2016年的分区语句为：
		alter table t_test split partition t_test_max 
		at(TO_DATE('2016-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss')) into (partitiont_test_2015,partition t_test_max);
		
	2.2删除一个分区
		alter table t_test drop partition t_test_2014 
		注：drop partition时，该分区内存储的数据也将同时删除，你的本意是希望删除掉指定的分区但保留数据，你应该使用
			merge partition，执行该语句会导致glocal索引的失效需要重建全局索引

	2.3合并分区
		相邻的分区可以merge为一个分区，新分区的下边界为原来边界值较低的分区，上边界为原来边界值较高的分区，原先的局部索引相应也会合并，全局索引会失效，需要rebuild。
		Alter  table t_test  merge partitions t_test_2013  ,t_Test_2014 into partition t_Test_2013_to_2014
	
3、对分区表进行查询
	3.1查询
	
		不使用分区查询：默认查询所有分区数据
		select * from t_test 
		
		使用分区查询：只查询该分区数据
		select * from t_test partition(t_test_2014) where add_date_time >=
			TO_DATE('2014-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss');
	
	3.2插入
		insert into t_test values(i, to_date(year,'yyyy-mm-dd hh24:mi:ss'));
	
	3.3删除
		使用分区删除
		更新的时候指定了分区，而根据查询的记录不在该分区中时，将不会删除数据	
		delete t_test partition(t_test_2013) where id=1;
	
		不使用分区删除
		delete t_test  whereid=1;
		
	3.4修改
		使用分区更新
		更新的时候指定了分区，而根据查询的记录不在该分区中时，将不会更新数据
		delete t_test where id=1;
		update t_test partition(t_test)  set id=1 where id=2;
		
		不使用分区
		delete t_test where id=1;
		update t_test  set id=1 where id=2;
		
三、普通表和分区表互转步骤

	1、新建一个字段一样的中间的分区表（T_NEW）

	2、将T数据导入到T_NEW中

	INSERT INTO T SELECT field1,filed2, …from T
	将老表重命名

	RENAME T TO T_OLD;
	将新表重命名

	RENAME T_NEW TO T;
	这种适合静态操作，不保证数据一致性。如果在生产环境切换，利用在线重定义功能	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	