package com.demo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class BaseDao {
	// 连库驱动类
	private final static String DRIVER_CLASS = "oracle.jdbc.OracleDriver";// oracle.jdbc.driver.OracleDriver
	// 数据库连接字符串
	private final static String URL = "jdbc:oracle:thin:@localhost:1521:orcl";// jdbc:oracle:thin:@localhost:1521:orcl
	// 数据库用户名
	private final static String USER = "hr";
	// 数据库登录密码
	private final static String PWD = "4100107223";

	static {
		try {
			Class.forName(DRIVER_CLASS);
		} catch (ClassNotFoundException e) {
			throw new ExceptionInInitializerError(e);
		}
	}

	public static Connection getConnection() {
		try {
			return DriverManager.getConnection(URL, USER, PWD);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * 执行Java程序 
	 * java -Xms100M -Xmx200M HelloWorld
	 * 死锁: ThreadDump 
	 * win: Ctrl+Break 
	 * linux: kill -3 pid
	 */
	public static void release(Connection conn, Statement st, ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				rs = null;// ????通过GC 回收
			}
		}
		if (st != null) {
			try {
				st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				st = null;// ????通过GC 回收
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				conn = null;// ????通过GC 回收
			}
		}
	}
}
