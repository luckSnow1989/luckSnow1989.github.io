package cn.itcast.proxy;

public class WaiterProxy implements Waiter {
	private Waiter waiter;
	public WaiterProxy(Waiter waiter) {
		this.waiter = waiter;
	}
	public void serve() {
		waiter.serve();
	}
}
