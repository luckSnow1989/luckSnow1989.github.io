package com.zrgk.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.zrgk.util.DBUtil;

public class AccountDaoImpl implements AccountDao {
	
	Log log = LogFactory.getLog(AccountDaoImpl.class);


	// 调用  hr下的zhuanzhang存储过程
	public String zhuanzhang(int id1, int id2, int money) {
		
		Connection conn = null;
		CallableStatement cs = null;
		String result = "";
		
		try{
			
			//获取连接
			conn = DBUtil.getConnection();  
			
			//获得CallableStatement
			cs = conn.prepareCall("call zhuanzhang(?,?,?,?)");
			
			//对于in参数，赋值
			cs.setObject(1, id1);
			cs.setObject(2, id2);
			cs.setObject(3, money);
			
			
			//对于in参数，赋值
			cs.registerOutParameter(4, Types.VARCHAR);
			
			
			//执行 CallableStatement
			cs.execute();
			
			
			//获得出参
			result = cs.getString(4);
			
		}catch(Exception e){
			
			//e.printStackTrace();
			
		    log.debug("xxx");
			
			log.error(e);
			
		}finally{
			
			DBUtil.closeAll(null, cs, conn);
		}
		
		return result;
	}

}
