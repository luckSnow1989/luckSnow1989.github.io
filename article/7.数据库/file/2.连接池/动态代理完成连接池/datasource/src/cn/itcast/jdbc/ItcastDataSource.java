package cn.itcast.jdbc;

import java.io.PrintWriter;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

public class ItcastDataSource implements DataSource {
	private String username;
	private String password;
	private String url;
	private String driverClassName;
	
	private List<Connection> list = new ArrayList<Connection>(); 
	private boolean flag = true;

	private void init() throws SQLException {
		flag = false;
		try {
			Class.forName(driverClassName);
		} catch(ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
		for(int i = 0; i < 5; i++) {
			final Connection con = DriverManager.getConnection(url, username, password);
			ClassLoader l = Thread.currentThread().getContextClassLoader();
			Class[] ins = {Connection.class};
			InvocationHandler h = new InvocationHandler() {
				public Object invoke(Object proxy, Method method, Object[] args)
						throws Throwable {
					if(method.getName().equals("close")) {
						list.add((Connection)proxy);
						synchronized (ItcastDataSource.this) {
							ItcastDataSource.this.notify();
						}
						return null;
					} else {
						return method.invoke(con, args);
					}
				}
			};
			Connection proxy = (Connection)Proxy.newProxyInstance(l, ins, h);
			list.add(proxy);
		}
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
		} catch(Exception e) {
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
