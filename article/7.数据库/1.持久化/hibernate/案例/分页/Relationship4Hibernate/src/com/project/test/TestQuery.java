package com.project.test;

import java.util.Date;
import java.util.List;

import org.junit.Test;

import com.project.dao.UserDao;
import com.project.dao.UserDaoImpl;
import com.project.entity.Page;
import com.project.entity.User;



public class TestQuery {
	@Test
	public void test1() {
		UserDao ud = new UserDaoImpl();
		for (int i = 0; i < 10; i++) {
			User u = new User(null, "admin"+i, 20, new Date());
		//	ud.insert(u);
		}
	}
	
	@Test
	public void test2(){
		UserDao ud = new UserDaoImpl();
		List<Object[]> li = ud.getUserWithProjection();
		for (Object[] os : li) {
			for (Object obj : os) {
				System.out.print(obj+"\t");
			}
			System.out.println();
		}
	}
	@Test
	public void test3(){
		UserDao ud = new UserDaoImpl();
		User li = ud.getUserByName4("admin0");
		
		System.out.println(li.getId()+"\t"+li.getName()+"\t"+li.getAge()+"\t"+li.getBirthday());
		
	}
	@Test
	public void test4(){
		UserDao ud = new UserDaoImpl();
		User user = new User(0, null, 0, null);
		Page page = ud.getUserPageByHQL(2, user);
		for(Object obj :page.getList()) {
			User u = (User)obj;
			System.out.println(u.getId()+"	"+u.getName()+"	"+u.getBirthday());
		}
	}
	@Test
	public void test5(){
		UserDao ud = new UserDaoImpl();
		User user = new User(0, null, 0, null);
		Page page = ud.getUserPageByCriteria(2, user);
		for(Object obj :page.getList()) {
			User u = (User)obj;
			System.out.println(u.getId()+"	"+u.getName()+"	"+u.getBirthday());
		}
	}
}
