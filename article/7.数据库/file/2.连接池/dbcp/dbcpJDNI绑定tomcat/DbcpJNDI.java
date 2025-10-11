package com.dbcp;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
  * @Project: 20160518_connectionPool
  * @Title: DbcpJNDI
  * @Description: (1).但数据源不能通过程序，而是通过Tomcat的配置 ,文件路径：Tomcat/conf/context.xml，添加如下配置
		
						<Resource name="jdbc/TestDB" auth="Container" type="javax.sql.DataSource"
						maxActive="100" maxIdle="30" maxWait="10000"
						username="root" password="4100107223" driverClassName="com.mysql.jdbc.Driver"
						url="jdbc:mysql://localhost:3306/javatest?autoReconnect=true"/>
			
					(2).要把“据库驱动”拷贝到Tomcat的的lib下
					
					(3).程序中调用JNDI接口，创建连接池
						Context Context = new InitialContext();
						context.lookup("目录和名字");
  * @author: zhangxue
  * @date: 2016年5月18日下午10:14:52
  * @company: webyun
  * @Copyright: Copyright (c) 2015
  * @version v1.0
 */
public class DbcpJNDI {
	
	private static DataSource ds = null;
	
	static {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("jdbc/TestDB");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection(){
		Connection con = null;
		try {
			con = ds.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return con;
	}
	
	public static void main(String[] args) throws SQLException {
		ResultSet res = DbcpGeneral.getConnection().prepareStatement("select * from students where id=1").executeQuery();
		if(res.next())
			System.out.println(res.getInt(1) + "\t" + res.getString(2));
	}
}
