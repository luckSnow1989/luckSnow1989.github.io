package cn.itcast.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;

import org.junit.Test;

public class Demo2 {
	@Test
	public void fun1() {
		ClassLoader loader = Thread.currentThread().getContextClassLoader();
		Class[] interfaces = {Waiter.class};
		Waiter watier = new WaiterImpl();
		InvocationHandler h = new WaiterHandler(watier);
		Waiter proxy = (Waiter)Proxy.newProxyInstance(loader, interfaces, h);
		proxy.serve();
	}
}
