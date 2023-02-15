1. -- 查看所有的session
SHOW FULL PROCESSLIST

-- Mysql中查看每个IP的连接数
SELECT SUBSTRING_INDEX(HOST,':',1) AS ip , COUNT(*) FROM information_schema.processlist GROUP BY ip;


2. -- 查看当前数据库服务的状态
SHOW STATUS

具体成参数如下(比较重要的)：
	Aborted_clients 由于客户没有正确关闭连接已经死掉，已经放弃的连接数量。 
	Aborted_connects 尝试已经失败的MySQL服务器的连接的次数。 
	Connections 试图连接MySQL服务器的次数。 
	Created_tmp_tables 当执行语句时，已经被创造了的隐含临时表的数量。 
	Delayed_insert_threads 正在使用的延迟插入处理器线程的数量。 
	Delayed_writes 用INSERT DELAYED写入的行数。 
	Delayed_errors 用INSERT DELAYED写入的发生某些错误(可能重复键值)的行数。 
	Flush_commands 执行FLUSH命令的次数。 
	Handler_delete 请求从一张表中删除行的次数。 
	Handler_read_first 请求读入表中第一行的次数。 
	Handler_read_key 请求数字基于键读行。 
	Handler_read_next 请求读入基于一个键的一行的次数。 
	Handler_read_rnd 请求读入基于一个固定位置的一行的次数。 
	Handler_update 请求更新表中一行的次数。 
	Handler_write 请求向表中插入一行的次数。 
	Key_blocks_used 用于关键字缓存的块的数量。 
	Key_read_requests 请求从缓存读入一个键值的次数。 
	Key_reads 从磁盘物理读入一个键值的次数。 
	Key_write_requests 请求将一个关键字块写入缓存次数。 
	Key_writes 将一个键值块物理写入磁盘的次数。 
	Max_used_connections 同时使用的连接的最大数目。 
	Not_flushed_key_blocks 在键缓存中已经改变但是还没被清空到磁盘上的键块。 
	Not_flushed_delayed_rows 在INSERT DELAY队列中等待写入的行的数量。 
	Open_tables 打开表的数量。 
	Open_files 打开文件的数量。 
	Open_streams 打开流的数量(主要用于日志记载） 
	Opened_tables 已经打开的表的数量。 
	Questions 发往服务器的查询的数量。 
	Slow_queries 要花超过long_query_time时间的查询数量。 
	Threads_connected 当前打开的连接的数量。 
	Threads_running 不在睡眠的线程数量。 
	Uptime 服务器工作了多少秒。



关于当前连接数： SHOW STATUS LIKE 'Threads%';
	+-------------------+-------+
	| Variable_name     | VALUE |
	+-------------------+-------+
	| Threads_cached    | 58    |
	| Threads_connected | 57    |   ###这个数值指的是打开的连接数
	| Threads_created   | 3676  |
	| Threads_running   | 4     |   ###这个数值指的是激活的连接数，这个数值一般远低于connected数值
	+-------------------+-------+
	### Threads_connected 跟show processlist结果相同，表示当前连接数。准确的来说，Threads_running是代表当前并发数
	如果我们在MySQL服务器配置文件中设置了thread_cache_size，当客户端断开之后，服务器处理此客户的线程将会缓存起来以响应下一个客户而不是销毁(前提是缓存数未达上限)。
	Threads_created表示创建过的线程数，如果发现Threads_created值过大的话，表明MySQL服务器一直在创建线程，这也是比较耗资源，可以适当增加配置文件中thread_cache_size值，查询服务器thread_cache_size配置：

	1. mysql> SHOW VARIABLES LIKE 'thread_cache_size';
	2. +-------------------+-------+
	3. | Variable_name | VALUE |
	4. +-------------------+-------+
	5. | thread_cache_size | 64 |
	6. +-------------------+-------+
	示例中的服务器还是挺健康的。

3. -- 修改最大连接数(临时的)

	-- 修改最大连接数，使用命令行执行, mysql的最大连接数默认是100, 最大可以达到16384
	SET GLOBAL max_connections=10240;

	-- 查看最大的连接数
	SHOW VARIABLES LIKE 'max_connections';


4. -- 关于连接数的解释
	1 确切的说，是连接和线程关联，而不是账号。一般是一个客户端连接（可以是客户端工具的一个连接或应用程序创建的一个连接），服务端会启动一个线程给予服务，连接做完一些事情（比如查询或更新等操作）后close连接，则线程会被设置为空闲（其销毁则由服务端来控制）。
	2 服务端有线程池（连接池）的技术，可能你连接时正好使用的是一个已创建好的但空闲的连接线程，也可能是立即创建的新线程。
	3 查看服务端线程相关设置：
	show variables like 'thread%';
	thread_handling (这个就是处理连接的线程模式)默认是 one-thread-per-connection, 即一个连接一个线程；
	thread_concurrency(线程的并发数)
	thread_cache_size(线程缓存池的大小)，服务端如果性能好，可以设得较大点。