package com.zrgk.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;

public class DBUtil {
	
	private static String driverClass;
	private static String url;
	private static String username;
	private static String password;
	
	static{
		
		ResourceBundle rb = ResourceBundle.getBundle("dbconfig");
		
		driverClass = rb.getString("driverclass");
		url = rb.getString("url");
		username = rb.getString("username");
		password = rb.getString("password");
		
		try {
			Class.forName(driverClass);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public static Connection getConnection(){
		
		Connection conn = null;
		
		try {
			conn = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return conn;
	}
	
	
	public static void closeAll(ResultSet rs,Statement st,Connection conn){
		
		if(rs!=null){
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(st!=null){
			try {
				st.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		
		if(conn!=null){
			
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	

}
