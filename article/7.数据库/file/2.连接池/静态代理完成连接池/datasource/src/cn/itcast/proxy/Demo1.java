package cn.itcast.proxy;

public class Demo1 {
	public static void main(String[] args) {
		Waiter w = new WaiterImpl();
		w.serve();
	}
}
