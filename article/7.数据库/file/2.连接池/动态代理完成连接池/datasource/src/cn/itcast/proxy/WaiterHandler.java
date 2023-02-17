package cn.itcast.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

public class WaiterHandler implements InvocationHandler {
	private Waiter waiter;
	public WaiterHandler(Waiter waiter) {
		this.waiter = waiter;
	}
	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {
		return method.invoke(waiter, args);
	}
}
