package com.c3p0;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mchange.v2.c3p0.ComboPooledDataSource;

/**
  * @Project: 20160518_connectionPool
  * @Title: C3p0XML
  * @Description: 使用xml配置。如：C3p0XML和SRC下的c3p0-config.xml,这是主流
  * @author: zhangxue
  * @date: 2016年5月18日下午10:25:38
  * @company: webyun
  * @Copyright: Copyright (c) 2015
  * @version v1.0
 */
public class C3p0XML {
	
	private static ComboPooledDataSource ds = null;
	
	static {
		ds = new ComboPooledDataSource();
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
		ResultSet res = C3p0General.getConnection().prepareStatement("select * from students where id=1").executeQuery();
		if(res.next())
			System.out.println(res.getInt(1) + "\t" + res.getString(2));
	}
}
