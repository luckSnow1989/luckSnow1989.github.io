package cn.itcast.dao;

import java.util.List;

import cn.itcast.domain.User;

public interface UserDao {
	/**
	 * ��ѯ���еĿͻ�
	 * @return
	 */
	List<User> findAllUsers();
	/**
	 * ���ݲ�ѯ������ѯ�ͻ�
	 * @param condition ���Ϊnull����""�����ǲ�ѯȫ��
	 * @return
	 */
	List<User> findUsersByCondition(String condition);
	/**
	 * ����û������ݿ���
	 * @param user
	 */
	void addUser(User user);
	/**
	 * ����ID������ȡ�û���Ϣ
	 * @param userId
	 * @return
	 */
	User findUserById(String userId);
	/**
	 * �޸Ŀͻ���Ϣ
	 * @param user
	 */
	void updateUser(User user);
	/**
	 * �����û���idɾ����¼
	 * @param userId
	 */
	void deleteUser(String userId);
}
