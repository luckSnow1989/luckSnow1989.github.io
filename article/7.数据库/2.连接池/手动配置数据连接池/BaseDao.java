package com.web.dao;

import java.sql.Connection;
import java.sql.SQLException;
import javax.sql.DataSource;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class BaseDao {
	Connection conn = null;
	public Connection getConnection() {
		Context ctx;
		try {
			ctx = new InitialContext();
			// ��ȡ���߼��������������Դ����
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/news");
			conn = ds.getConnection();
		} catch (SQLException exception) {
			exception.printStackTrace();
		} catch (NamingException namingException) {
			namingException.printStackTrace();
		}
		return conn;
	}
}