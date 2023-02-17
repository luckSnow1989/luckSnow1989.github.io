package com.dbcp;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSourceFactory;


/**
  * @Project: 20160518_connectionPool
  * @Title: C3p0XML
  * @Description: 使用properties配置。如：DbcpProperties和SRC下的dbcp.properties,这是主流
  * @author: zhangxue
  * @date: 2016年5月18日下午10:25:38
  * @company: webyun
  * @Copyright: Copyright (c) 2015
  * @version v1.0
 */
public class DbcpProperties {
	
	private static DataSource ds = null;
	
	static {
		Properties dbProperties = new Properties();
		try {
			dbProperties.load(DbcpProperties.class.getClassLoader().getResourceAsStream("dbcp.properties"));
			ds = BasicDataSourceFactory.createDataSource(dbProperties);
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
		ResultSet res = DbcpProperties.getConnection().prepareStatement("select * from students where id=1").executeQuery();
		if(res.next())
			System.out.println(res.getInt(1) + "\t" + res.getString(2));
	}
}
