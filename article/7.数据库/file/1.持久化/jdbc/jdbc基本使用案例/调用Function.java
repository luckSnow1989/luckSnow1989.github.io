package com.demo;

import java.sql.CallableStatement;
import java.sql.Connection;

import oracle.jdbc.OracleTypes;

import org.junit.Test;
/**
  * @Title: Function
  * @Description: 调用函数
  * @author: zhangxue
  * @date: 2016年7月4日下午9:57:57
  * @version v1.0
  */
public class Function {

	@Test
	public void testFunction(){
		// {?= call <procedure-name>[(<arg1>,<arg2>, ...)]}
		String sql = "{?=call substr(?,?,?)}";
		
		Connection conn = null;
		CallableStatement call = null;
		try {
			conn = BaseDao.getConnection();
			call = conn.prepareCall(sql);

			//对于out参数,申明
			call.registerOutParameter(1, OracleTypes.VARCHAR);			
			
			//对于in参数，赋值
			call.setString(2, "abcdefg");
			call.setInt(3, 0);
			call.setInt(4, 3);
			
			//执行
			call.execute();
			
			//取出结果--->abc
			String income = call.getString(1);
			
			System.out.println(income);
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			BaseDao.release(conn, call, null);
		}
	}	
	
}






























