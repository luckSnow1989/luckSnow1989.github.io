package com.dbcp;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.dbcp.BasicDataSource;

/**
  * @Project: 20160518_connectionPool
  * @Title: C3p0General
  * @Description: 使用java代码创建一个普通的c3p0连接池
  * @author: zhangxue
  * @date: 2016年5月18日下午9:58:10
  * @company: webyun
  * @Copyright: Copyright (c) 2015
  * @version v1.0
 */
public class DbcpGeneral {
	
	private static final String CLASS_DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/school?useUnicode=true&characterEncoding=utf-8";
	private static final String USER = "root";
	private static final String PSD = "4100107223";
	
	private static BasicDataSource ds = null;
	
	static {
		ds = new BasicDataSource();
		ds.setDriverClassName(CLASS_DRIVER);
		ds.setUrl(URL);
		ds.setUsername(USER);
		ds.setPassword(PSD);
		//设置连接池初始连接数
		ds.setInitialSize(5);
		//设置做多可以有多少回个活跃的连接数
		ds.setMaxActive(20);
		//设置最少有2个空闲的连接
		ds.setMinIdle(2);
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
	/**
	 * 关闭数据源
	 */
	public static void closeDataSource(){
		try {
			if(ds != null)
			ds.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) throws SQLException {
		ResultSet res = DbcpGeneral.getConnection().prepareStatement("select * from students where id=1").executeQuery();
		if(res.next())
			System.out.println(res.getInt(1) + "\t" + res.getString(2));
	}
}
