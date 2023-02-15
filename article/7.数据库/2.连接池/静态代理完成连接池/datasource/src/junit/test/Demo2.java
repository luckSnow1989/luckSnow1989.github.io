package junit.test;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.Connection;
import java.sql.SQLException;

import org.junit.Test;

public class Demo2 {
	@Test
	public void fun1() throws SQLException {
		ClassLoader loader = Thread.currentThread().getContextClassLoader();
		Class[] interfaces = {Connection.class};
		InvocationHandler h = new InvocationHandler() {
			@Override
			public Object invoke(Object proxy, Method method, Object[] args)
					throws Throwable {
				System.out.println("hello");
				return null;
			}	
		};
		Connection con = (Connection)Proxy.newProxyInstance(loader, interfaces, h);
		con.createStatement();
		con.toString();
	}
	
	@Test
	public void fun2() throws SQLException {
		ClassLoader loader = Thread.currentThread().getContextClassLoader();
		Class[] interfaces = {Connection.class};
		InvocationHandler h = new HelloWorldHandler();
		Connection con = (Connection)Proxy.newProxyInstance(loader, interfaces, h);
		con.close();
		con.toString();
		con.createStatement();
	}
}

class HelloWorldHandler implements InvocationHandler {
	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {
		System.out.println("Hello 动态代理!");
		return null;
	}
}
