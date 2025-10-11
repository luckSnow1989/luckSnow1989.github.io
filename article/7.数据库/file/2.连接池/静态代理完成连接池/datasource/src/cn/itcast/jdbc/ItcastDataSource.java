package cn.itcast.jdbc;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import cn.itcast.jdbc.listener.CloseListener;

public class ItcastDataSource implements DataSource {
	private String username;
	private String password;
	private String url;
	private String driverClassName;
	
	private List<ItcastConnection> list = new ArrayList<ItcastConnection>(); 
	private boolean flag = true;
	
	public void add(ItcastConnection con) {
		list.add(con);
	}
	
	public int size() {
		return list.size();
	}
	
	private void init() throws SQLException {
		flag = false;
		try {
			Class.forName(driverClassName);
		} catch(ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
		for(int i = 0; i < 5; i++) {
			Connection con = DriverManager.getConnection(url, username, password);
			ItcastConnection ic = new ItcastConnection(con);
			ic.setCloseListener(new CloseListener() {
				// 当调用Connection的close()方法时，这个方法内容会被执行
				public void run(Connection con) {
					closing(con);
				}
			});
			list.add(ic);
		}
	}
	
	private synchronized void closing(Connection con) {
		ItcastConnection ic = (ItcastConnection)con;
		ic.setClose(false);
		list.add(ic);
		this.notify();
	}
	
	public synchronized Connection getConnection() throws SQLException {
		if(flag) {
			init();
		}
		if(list.size() > 0) {
			return list.remove(0);
		}
		try {
			this.wait();
		} catch (InterruptedException e) {
			throw new RuntimeException(e);
		}
		if(list.size() > 0) {
			return list.remove(0);
		}
		throw new RuntimeException();
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getDriverClassName() {
		return driverClassName;
	}

	public void setDriverClassName(String driverClassName) {
		this.driverClassName = driverClassName;
	}


	@Override
	public Connection getConnection(String username, String password)
			throws SQLException {
		return null;
	}
	
	@Override
	public PrintWriter getLogWriter() throws SQLException {
		return null;
	}

	@Override
	public void setLogWriter(PrintWriter out) throws SQLException {
		
	}

	@Override
	public void setLoginTimeout(int seconds) throws SQLException {
		
	}

	@Override
	public int getLoginTimeout() throws SQLException {
		return 0;
	}

	@Override
	public <T> T unwrap(Class<T> iface) throws SQLException {
		return null;
	}

	@Override
	public boolean isWrapperFor(Class<?> iface) throws SQLException {
		return false;
	}
}
