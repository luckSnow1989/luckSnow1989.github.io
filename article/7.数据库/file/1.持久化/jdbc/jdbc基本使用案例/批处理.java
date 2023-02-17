package cn.itcast.demo4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.junit.Test;

import cn.itcast.demo3.JdbcUtils;

/**
 * 批处理
 * @author zx
 *
 */
public class Demo5 {
	/**
	 * ps对象内部有集合
	 * 1. 用循环疯狂向ps中添加sql参数，它自己有模板，使用一组参数与模板罚没可以匹配出一条sql语句
	 * 2. 调用它的执行批方法，完成向数据库发送！
	 * @throws SQLException 
	 */
	@Test
	public void fun5() throws SQLException {
		/*
		 * ps：
		 * > 添加参数到批中
		 * > 执行批！
		 */
		Connection con = JdbcUtils.getConnection();
		String sql = "INSERT INTO t_stu VALUES(?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		// 疯狂的添加参数
		for(int i = 0; i < 10000; i++) {
			ps.setInt(1, i+1);
			ps.setString(2, "stu_" + i);
			ps.setInt(3, i);
			ps.setString(4, i%2==0?"男":"女");
			
			ps.addBatch();//添加批！这一组参数就保存到集合中了。
		}
		long start = System.currentTimeMillis();
		ps.executeBatch();//执行批！
		long end = System.currentTimeMillis();
		
		System.out.println(end - start);//412764, 301
	}
}
