package com.project.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.project.entity.Page;
import com.project.entity.User;

public interface UserDao extends BaseDao<User, Integer> {
	/*
	 * BaseDao中的方法已经存在
	 * 
	 */

	// 1查询全部
	List<User> getAllUser();

	// 2根据名字查询 绑定？
	List<User> getUserByName(String name);

	// 3根据名字查询 绑定参数
	List<User> getUserByName2(String name);

	// 4根据名字查询 模糊查询 like
	List<User> getUserByName3(String name);

	// 5 假设 name唯一 使用 uniqueResult()
	User getUserByName4(String name);

	// 6 根据名字和年龄查询
	List<User> getUserByNameAndAge(String name, int age);

	// 7查询结果排序
	List<User> getUserOrderByAge();

	// 8 关于分页查询
	List<User> getUserByPage();

	// 9使用setProperties() 绑定参数
	List<User> getUserWithProperties(User user);

	// 10 HQL 写在xml中
	List<User> getUserByNameInXML(String name);

	// 11 count
	int getUserCount();

	// 12 投影
	List<Object[]> getUserWithProjection();
	
	Page getUserPageByHQL(int currentPage,User user);
	Page getUserPageByCriteria(int currentPage,User user);
}
