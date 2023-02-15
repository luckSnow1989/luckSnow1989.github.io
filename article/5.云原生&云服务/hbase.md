---
sort: 1
---
# hbase

## 1.安装

Hbase安装完全分布式（1个master，3个regionserver）

### 1.1.下载
url:http://archive.apache.org/dist/hbase/

HBase版本：0.90.5版本对应Hadoop版本：0.20.2


### 1.2.解压缩HBase安装文件
```shell
[hadoop@master ~]$ tar -zxvf hbase-0.90.5.tar.gz

解压缩成功后的HBase主目录结构如下：
[hadoop@master hbase-0.90.5]$ ls -l
total 3636
drwxr-xr-x. 3 hadoop root    4096 Dec  8  2011 bin
-rw-r--r--. 1 hadoop root  217043 Dec  8  2011 CHANGES.txt
drwxr-xr-x. 2 hadoop root    4096 Dec  8  2011 conf
drwxr-xr-x. 4 hadoop root    4096 Dec  8  2011 docs
-rwxr-xr-x. 1 hadoop root 2425490 Dec  8  2011 hbase-0.90.5.jar
-rwxr-xr-x. 1 hadoop root  997956 Dec  8  2011 hbase-0.90.5-tests.jar
drwxr-xr-x. 5 hadoop root    4096 Dec  8  2011 hbase-webapps
drwxr-xr-x. 3 hadoop root    4096 Apr 12 19:03 lib
-rw-r--r--. 1 hadoop root   11358 Dec  8  2011 LICENSE.txt
-rw-r--r--. 1 hadoop root     803 Dec  8  2011 NOTICE.txt
-rw-r--r--. 1 hadoop root   31073 Dec  8  2011 pom.xml
-rw-r--r--. 1 hadoop root    1358 Dec  8  2011 README.txt
drwxr-xr-x. 8 hadoop root    4096 Dec  8  2011 src
```

### 1.3.配置hbase-env.sh

```shell
[hadoop@master conf]$ vi hbase-env.sh

# The java implementation to use.  Java 1.6 required.
export JAVA_HOME=/usr/java/jdk

# Extra Java CLASSPATH elements.  Optional.
export HBASE_CLASSPATH=/home/hadoop/hadoop-0.20.2/conf
```


### 1.4.配置hbase-site.xml
```xml
[hadoop@master conf]$ vi hbase-site.xml

<configuration>
  <property>
     <name>hbase.rootdir</name>
     <value>hdfs://master:9000/hbase</value>
  </property>
  <property>
      <name>hbase.cluster.distributed</name>
      <value>true</value>
   </property>

   <property>
        <name>hbase.zookeeper.quorum</name>
        <value>master,node2,node3,node1</value>
    </property>
    <property>
         <name>hbase.zookeeper.property.dataDir</name>
         <value>/home/zhangxue/zookeeper</value>
     </property>

</configuration>
```

### 1.5.配置regionservers
```shell
[hadoop@master conf]$ vi regionservers

node1
node2
node3
```

### 1.6.替换Jar包

将Hadoop的hadoop-0.20.2-core.jar复制到hbase/lib目录下。

将hbase的hadoop-core-0.20-append-r1056497.jar修改为hadoop-core-0.20-append-r1056497.sav，作为备份

### 1.7. 向其它3个结点复制Hbase相关配置

```shell
[hadoop@master ~]$scp -r ./hbase-0.90.5 zhangxue@node1:/home/zhangxue
[hadoop@master ~]$scp -r ./hbase-0.90.5 zhangxue@node2:/home/zhangxue
[hadoop@master ~]$scp -r ./hbase-0.90.5 zhangxue@node3:/home/zhangxue
```

### 1.8.添加HBase相关环境变量 （所有结点，可以忽略）
```shell
[hadoop@master conf]$ su - root
Password:
[root@master ~]# vi /etc/profile

export HBASE_HOME=/home/hadoop/hbase-0.90.5
export PATH=$PATH:$HBASE_HOME/bin
```

### 1.9.启动Hadoop，创建HBase主目录

```shell
[hadoop@master ~]$ $HADOOP_INSTALL/bin/start-all.sh

starting namenode, logging to /home/hadoop/hadoop-0.20.2/bin/../logs/hadoop-hadoop-namenode-master.out
node2: starting datanode, logging to /home/hadoop/hadoop-0.20.2/bin/../logs/hadoop-hadoop-datanode-node2.out
node1: starting datanode, logging to /home/hadoop/hadoop-0.20.2/bin/../logs/hadoop-hadoop-datanode-node1.out
node3: starting datanode, logging to /home/hadoop/hadoop-0.20.2/bin/../logs/hadoop-hadoop-datanode-node3.out
hadoop@master's password:
master: starting secondarynamenode, logging to /home/hadoop/hadoop-0.20.2/bin/../logs/hadoop-hadoop-secondarynamenode-master.out
starting jobtracker, logging to /home/hadoop/hadoop-0.20.2/bin/../logs/hadoop-hadoop-jobtracker-master.out
node1: starting tasktracker, logging to /home/hadoop/hadoop-0.20.2/bin/../logs/hadoop-hadoop-tasktracker-node1.out
node2: starting tasktracker, logging to /home/hadoop/hadoop-0.20.2/bin/../logs/hadoop-hadoop-tasktracker-node2.out
node3: starting tasktracker, logging to /home/hadoop/hadoop-0.20.2/bin/../logs/hadoop-hadoop-tasktracker-node3.out

[hadoop@master ~]$ jps
5332 Jps
5030 NameNode
5259 JobTracker
5185 SecondaryNameNode

[hadoop@node2 ~]$ jps
4603 Jps
4528 TaskTracker
4460 DataNode

[hadoop@master ~]$ hadoop fs -mkdir hbase
```

### 1.10.启动HBase

```shell

[hadoop@master conf]$ start-hbase.sh
hadoop@master's password: node3: starting zookeeper, logging to /home/hadoop/hbase-0.90.5/bin/../logs/hbase-hadoop-zookeeper-node3.out
node1: starting zookeeper, logging to /home/hadoop/hbase-0.90.5/bin/../logs/hbase-hadoop-zookeeper-node1.out
node2: starting zookeeper, logging to /home/hadoop/hbase-0.90.5/bin/../logs/hbase-hadoop-zookeeper-node2.out

master: starting zookeeper, logging to /home/hadoop/hbase-0.90.5/bin/../logs/hbase-hadoop-zookeeper-master.out
starting master, logging to /home/hadoop/hbase-0.90.5/logs/hbase-hadoop-master-master.out
node3: starting regionserver, logging to /home/hadoop/hbase-0.90.5/bin/../logs/hbase-hadoop-regionserver-node3.out
node2: starting regionserver, logging to /home/hadoop/hbase-0.90.5/bin/../logs/hbase-hadoop-regionserver-node2.out
node1: starting regionserver, logging to /home/hadoop/hbase-0.90.5/bin/../logs/hbase-hadoop-regionserver-node1.out

[hadoop@master conf]$ jps
7437 HQuorumPeer
7495 HMaster
5030 NameNode
5259 JobTracker
5185 SecondaryNameNode
7597 Jps

[hadoop@node2 ~]$ jps
5965 HRegionServer
4528 TaskTracker
4460 DataNode
5892 HQuorumPeer
6074 Jps
```

### 1.11.停止HBase
```shell
[hadoop@master logs]$ stop-hbase.sh
stopping hbase..........
hadoop@master's password: node2: stopping zookeeper.
node3: stopping zookeeper.
node1: stopping zookeeper.

master: stopping zookeeper.

[hadoop@master logs]$ jps
5030 NameNode
5259 JobTracker
5185 SecondaryNameNode
7952 Jps

[hadoop@node2 logs]$ jps
6351 Jps
4528 TaskTracker
4460 DataNode
```

## 2.常用命令

```shell
1.启动所有
	./start-hbase.sh
	
2.停止所有	
	./stop-hbase.sh
	
3.进入shell
	./hbase shell
	
常见的hbase shell操作

1.查看数据库状态：status

2.查看数据库版本：version

3.创建表：create 'student','id','name','address','info'（create 表名 列族1 列族2 列族3 列族4）

4.查看表信息：describe 'student'

5.结果有两列：第二列是是否可操作，默认是true	ENDABLED  = true
第一列是详细信息DESCRIPTION：	                                                                                                                             
{NAME => 'student', 
    FAMILIES => [
        {NAME => 'address', BLOOMFILTER => 'NONE', REPLICATION_SCOPE => '0', COMPRESSION => 'NONE', VERSIONS => '3', 
            TTL => '2147483647', BLOCKSIZE => '65536', IN_MEMORY => 'false', BLOCKCACHE => 'true'},
            
        {NAME => 'id', BLOOMFILTER => 'NONE', REPLICATION_SCOPE => '0', COMPRESSION => 'NONE', VERSIONS => '3', 
            TTL => '2147483647', BLOCKSIZE => '65536', IN_MEMORY => 'false', BLOCKCACHE => 'true'},
            
        {NAME => 'info', BLOOMFILTER => 'NONE', REPLICATION_SCOPE => '0', COMPRESSION => 'NONE', VERSIONS => '3', 
            TTL => '2147483647', BLOCKSIZE => '65536', IN_MEMORY => 'false', BLOCKCACHE => 'true'}, 
            
        {NAME => 'name', BLOOMFILTER => 'NONE', REPLICATION_SCOPE => '0', COMPRESSION => 'NONE', VERSIONS => '3',
            TTL => '2147483647', BLOCKSIZE => '65536', IN_MEMORY => 'false', BLOCKCACHE => 'true'}                                                        
    ]
}

6.查看所有表：list

7.修改可操作性：disable 'student'（ddl等操作必须使表不可操作）

8.修改可操作性：enable 'student'（ddl等操作必须使表不可操作）

9.修改表：alter 'student' ,{NAME=>'id',METHOD=>'delete'}

10.删除表：drop 'student'

11.查询一个表是否存在：exists 'student'

12.判断表是否enable或disable:
    is_enabled 'student'        
    is_disabled 'student'

13.插入记录
    put'student','scutshuxue','info:age','24'
    put'student','scutshuxue','info:birthday','1987-06-17'
    put'student','scutshuxue','info:company','alibaba'
    put'student','scutshuxue','address:contry','china'
    put'student','scutshuxue','address:province','zhejiang'
    put'student','scutshuxue','address:city','hangzhou'
    put'student','xiaofeng','info:birthday','1987-4-17'
    put'student','xiaofeng','info:favorite','movie'
    put'student','xiaofeng','info:company','alibaba'
    put'student','xiaofeng','address:contry','china'
    put'student','xiaofeng','address:province','guangdong'
    put'student','xiaofeng','address:city','jieyang'
    put'student','xiaofeng','address:town','xianqiao'

14.获取一个行健的所有数据：get 'student','scutshuxue' （get 表名 行健）

15.获取一个行键，一个列族的所有数据：get 'student','scutshuxue','info'

16.获取一个行键，一个列族中一个列的所有数据：get 'student','scutshuxue','info:age'

17.更新一条记录：put 'student','scutshuxue','info:age' ,'99'

18.通过timestamp来获取数据：get 'student','scutshuxue',{COLUMN=>'info:age',TIMESTAMP=>1481636831943}

19.全表扫描：scan 'student'

20.删除指定行键的字段:delete 'student','scutshuxue','info:age'

21.删除整行:deleteall 'student','xiaofeng'

22.查询表中有多少行:count 'student'

23.清空表：truncate 'student'
```