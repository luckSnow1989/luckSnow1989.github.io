package test.java;

import cn.itcast.web.common.util.Arith;

public class TestArith {
	public static void main(String[] args) {
		
		//浮点数精度处理
		double a = (3.3-2.4)/0.1;
		System.out.println(a);

		
		
		Arith arith = new Arith();
		
		double d1 = 3.3-2.4;
		double d2 = 0.1;
		System.out.println(arith.div(d1, d2));
	}

}
