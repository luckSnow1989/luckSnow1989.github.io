package com.demo;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleTypes;

import org.junit.Test;
/**
  * @Title: Cursor
  * @Description: 调用存储过程，获得结果是一个游标
  * @author: zhangxue
  * @date: 2016年7月4日下午9:57:16
  * @version v1.0
  */
public class Cursor {

	@Test
	public void testCursor() {
		String sql = "{call MYPACKAGE.queryEmpList(?,?)}";

		Connection conn = null;
		CallableStatement call = null;
		ResultSet rs = null;
		try {
			conn = BaseDao.getConnection();
			call = conn.prepareCall(sql);

			// 对于in参数，赋值
			call.setInt(1, 20);

			// 对于out参数,申明
			call.registerOutParameter(2, OracleTypes.CURSOR);

			// 执行
			call.execute();

			// 取出结果
			rs = ((OracleCallableStatement) call).getCursor(2);
			while (rs.next()) {
				String name = rs.getString("ename");
				double sal = rs.getDouble("sal");

				System.out.println(name + "的薪水是" + sal);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			BaseDao.release(conn, call, rs);
		}
	}

}
