package com.c3p0;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mchange.v2.c3p0.ComboPooledDataSource;
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
public class C3p0General {
	
	private static final String CLASS_DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/school?useUnicode=true&characterEncoding=utf-8";
	private static final String USER = "root";
	private static final String PSD = "4100107223";
	
	private static ComboPooledDataSource ds = null;
	
	static {
		try {
			ds = new ComboPooledDataSource();
			ds.setDriverClass(CLASS_DRIVER);
			ds.setJdbcUrl(URL);
			ds.setUser(USER);
			ds.setPassword(PSD);
			//设置连接池初始连接数
			ds.setInitialPoolSize(2);
			//设置最大连接数
			ds.setMaxPoolSize(20);
			//设置最小连接数
			ds.setMinPoolSize(5);
			//设置最大Statement缓存数量
			ds.setMaxStatements(180);
		} catch (PropertyVetoException e) {
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
	/**
	 * 关闭数据源
	 */
	public static void closeDataSource(){
		if(ds != null)
			ds.close();
	}
	
	public static void main(String[] args) throws SQLException {
		ResultSet res = C3p0General.getConnection().prepareStatement("select * from students where id=1").executeQuery();
		if(res.next())
			System.out.println(res.getInt(1) + "\t" + res.getString(2));
	}
}
