package com.zrgk.dao;

import java.util.List;

import com.zrgk.entity.User;

public interface UserDao {
	
	public List<User> findUserByName(String name);

}
