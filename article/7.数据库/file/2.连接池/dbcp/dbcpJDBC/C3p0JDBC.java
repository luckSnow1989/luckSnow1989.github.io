package com.c3p0;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.mchange.v2.c3p0.DataSources;

/**
  * @Project: 20160518_connectionPool
  * @Title: C3p0JDBC
  * @Description: 使用统的JDBC驱动建立一个无连接池的DataSource，然后转化为连接池的DataSource
  * @author: zhangxue
  * @date: 2016年5月18日下午10:14:52
  * @company: webyun
  * @Copyright: Copyright (c) 2015
  * @version v1.0
 */
public class C3p0JDBC {
	
	private static final String CLASS_DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/school?useUnicode=true&characterEncoding=utf-8";
	private static final String USER = "root";
	private static final String PSD = "4100107223";
	
	private static DataSource ds = null;
	
	static {
		try {
			Class.forName(CLASS_DRIVER);
			
			DataSource dataSource = DataSources.unpooledDataSource(URL, USER, PSD);
			//设置参数
			Map<String, Integer> overrides = new HashMap<>();
			overrides.put("initialPoolSize", 2);
			overrides.put("maxPoolSize", 20);
			overrides.put("minPoolSize", 5);
			overrides.put("maxStatements", 100);
			ds = DataSources.pooledDataSource(dataSource, overrides);
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
	/**
	 * 关闭数据源
	 */
	public static void closeDataSource(){
		try {
			if(ds != null)
			DataSources.destroy(ds);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args) throws SQLException {
		ResultSet res = C3p0General.getConnection().prepareStatement("select * from students where id=1").executeQuery();
		if(res.next())
			System.out.println(res.getInt(1) + "\t" + res.getString(2));
	}
}
