package cn.itcast.test;

import static org.junit.Assert.fail;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.junit.Test;

import cn.itcast.dao.UserDao;
import cn.itcast.dao.impl.UserDaoMySqlImpl;
import cn.itcast.domain.User;
import cn.itcast.util.MD5Util;

public class UserDaoMySqlImplTest {
	private UserDao dao = new UserDaoMySqlImpl();
	@Test
	public void testAddUser() {
		User user = new User();
		user.setId(UUID.randomUUID().toString());
		user.setUsername("gfy");
		user.setNick("С����");
		user.setPassword(MD5Util.encode("123"));
		user.setSex("1");
		user.setBirthday(new Date());
		user.setEducation("�о���");
		user.setTelephone("110");
		user.setHobby("����,����,ƹ����");
		user.setPath("/path");
		user.setFilename("gxzp.jpg");
		user.setRemark("���Ǽ��");
		dao.addUser(user);
	}

	@Test
	public void testDeleteUser() {
		dao.deleteUser("9bc65fcb-5c49-486f-a3a5-f1dc3e5b1efe");
	}

	@Test
	public void testFindAllUsers() {
		List<User> users = dao.findAllUsers();
		for(User u:users)
			System.out.println(u);
	}

	@Test
	public void testFindUsersByCondition() {
		List<User> users = dao.findUsersByCondition("where nick like 'С%'");
		for(User u:users)
			System.out.println(u);
	}

	@Test
	public void testFindUserById() {
		User user = dao.findUserById("9bc65fcb-5c49-486f-a3a5-f1dc3e5b1efe");
		System.out.println(user);
	}

	@Test
	public void testUpdateUser() {
		User user = dao.findUserById("9bc65fcb-5c49-486f-a3a5-f1dc3e5b1efe");
		user.setNick("������");
		dao.updateUser(user);
	}

}
