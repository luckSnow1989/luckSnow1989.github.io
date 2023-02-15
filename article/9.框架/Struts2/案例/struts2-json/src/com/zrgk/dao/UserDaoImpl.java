package com.zrgk.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import com.zrgk.entity.User;
import com.zrgk.util.DBUtil;

public class UserDaoImpl implements UserDao {

	@Override
	public List<User> findUserByName(String name) {
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<User> list = new ArrayList<User>();
		
		try{
			
			conn = DBUtil.getConnection();
			
			String sql = "select * from user where name like ?";
			
			ps = conn.prepareStatement(sql);
			
			ps.setObject(1, "%"+name+"%");
			
			rs = ps.executeQuery();
			
			while(rs.next()){
				
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setAge(rs.getInt("age"));
				
				list.add(user);
				
			}
			
		}catch(Exception e){
			
			e.printStackTrace();
			
		}finally{
			
			DBUtil.closeAll(rs,ps, conn);
			
		}
		
		return list;
	}

}
