---
sort: 1
---

# jdbc

## 1.介绍

JDBC API 是一个 JDK 提出的规范，它可以访问任何类型的表格数据，特别是可以访问存储在关系数据库里的数据。

需要各个数据库的厂商按照jdk的接口实现对应的客户端。

## 2.教程

[https://www.w3cschool.cn/jdbc/](https://www.w3cschool.cn/jdbc/)


## 3.各种数据库驱动
```java
1,Oracle 数据库（thin模式）
Class.forName("oracle.jdbc.driver.OracleDriver");
String url="jdbc:oracle:thin:@localhost:1521/orcl"; //orcl为数据库的SID
String user="test";
String password="test";
Connection conn= DriverManager.getConnection(url,user,password);

2、DB2数据库
Class.forName("com.ibm.db2.jdbc.app.DB2Driver ");
String url="jdbc:db2://localhost:5000/sample"; //sample为你的数据库名
String user="admin";
String password="";
Connection conn= DriverManager.getConnection(url,user,password);

3、Sql Server7.0/2000数据库
Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
String url="jdbc:microsoft:sqlserver://localhost:1433;DatabaseName=mydb";//mydb为数据库名称
String user="sa";
String password="";
Connection conn= DriverManager.getConnection(url,user,password);

4、Sybase数据库
Class.forName("com.sybase.jdbc.SybDriver");
String url =" jdbc:sybase:Tds:localhost:5007/myDB";//myDB为你的数据库名称
Properties sysProps = System.getProperties();
SysProps.put("user","userid");
SysProps.put("password","user_password");
Connection conn= DriverManager.getConnection(url, SysProps);

5、Informix数据库
Class.forName("com.informix.jdbc.IfxDriver");
String url = "jdbc:informix-sqli://123.45.67.89:1533/myDB:INFORMIXSERVER=myserver; //myDB为数据库名
user=testuser;
password=testpassword";
Connection conn= DriverManager.getConnection(url);

6、MySQL数据库
Class.forName("org.gjt.mm.mysql.Driver");
String url ="jdbc:mysql://localhost/myDB?user=root&password=soft1234&useUnicode=true&characterEncoding=utf-8"
或者： String url ="jdbc:mysql://localhost/myDB?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&allowMultiQueries=true&serverTimezone=PRC&useSSL=false"
//myDB为数据库名
Connection conn= DriverManager.getConnection(url);

7、PostgreSQL数据库
Class.forName("org.postgresql.Driver");
String url ="jdbc:postgresql://localhost/myDB" //myDB为数据库名
String user="myuser";
String password="mypassword";
Connection conn= DriverManager.getConnection(url,user,password);

8、access数据库直连用JDBC-ODBC桥连接
Class.forName("sun.jdbc.odbc.JdbcOdbcDriver") ;
String url="jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ="+application.getRealPath("/Data/ReportDemo.mdb");
Connection conn = DriverManager.getConnection(url,"","");
Statement stmtNew=conn.createStatement() ;

		
		
		
```