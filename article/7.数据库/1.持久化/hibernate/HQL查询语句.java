/**
 * 
 */
package com.b510.example;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 * HQL����ѯ 
 *
 * @author XHW
 * 
 * @date 2011-6-18
 * 
 */
public class HibernateTest {
 /**
  * @param args
  */
	public static void main(String[] args) {
		HibernateTest test = new HibernateTest();
		test.where();
		test.function();
		test.update();
		test.jiaoChaCheck();
		test.innerJoin();
		test.QBC();
		test.leftOuterJoin();
		test.rightOuterJoin();
	}
	// where��ѯ
	public void where() {		
		//����session
		Session session = HibernateSessionFactoryUtil.getSessionFactory().openSession();
		session.beginTransaction();
		
		// 1.ʹ��between...and...��ѯ
		Query query = session.createQuery("from User where id not between 200 and 2000");
		List<User> list = query.list();
		for (User user : list) {
			System.out.println(user.getId() + user.getUsername());
		}
		
		// 2.ͶӰ��ѯ ��ʹ��where�Ӿ�
		query = session.createQuery("select username from User where id=2");
		List<String> listname = query.list();
		for (String name : listname) {
			System.out.println(name);
		}
		
		// 3.in��ѯ
		query = session.createQuery("from User where username in ('Hongten','Hanyuan','dfgd')");
		List<User> listin = query.list();
		for (User user : listin) {
			System.out.println(user.getId() + user.getUsername());
		}
		
		// 4.like��ѯ
		query = session.createQuery("from User where username not like 'Hon%'");
		List<User> listlike = query.list();
		for (User user : listlike) {
			System.out.println(user.getId() + user.getUsername());
		}
		
		// 5.null��ѯ
		query = session.createQuery("from User where password is null");
		List<User> listnull = query.list();
		for (User user : listnull) {
			System.out.println(user.getId() + user.getUsername());
		}
		
		// 6.and��ѯ
		query = session.createQuery("from User where password is not null and id<5");
		List<User> listand = query.list();
		for (User user : listand) {
			System.out.println(user.getId() + user.getUsername()+ user.getPassword());
		}
		// 7.order by(��һ���SQL�﷨��ͬ)
		query = session.createQuery("from User order by username,id desc");
		List<User> listorderby = query.list();
		for (User user : listorderby) {
			System.out.println(user.getId() + user.getUsername());
		}
		
		// ʹ��"?"�� ��Ϊ����ռλ����һ��HQL����п���ʹ�ö����������PreparedStatement��ʹ�÷����������Ǵ�0��ʼ����
		// query.setInteger(0,2)
		// query.setString(0,"Hongten")
		query = session.createQuery("select username from User where username=?");
		query.setString(0, "Hongten");
		List<String> listwenhao = query.list();
		for (String name : listwenhao) {
			System.out.println(name);
		}
		session.getTransaction().commit();
	}
	
	// �Ѵ�д��ĸת��ΪСд��ĸ
	public void function() {
		// ���ÿ������ڣ�������һ���û�ע��ĳ����У���Сд���������֣�����ȫ��ת��ΪСд��Ϳ��Ժ����׽��бȽ�
		Session session = HibernateSessionFactoryUtil.getSessionFactory().openSession();
		session.beginTransaction();
		// ���ԭʼ������
		Query query = session.createQuery("select username from User");
		List<String> list = query.list();

		for (String name : list) {
			System.out.println(name);
		}
		System.out.println("-------------------------------------------");
		// ���������ȫ��ת��ΪСд
		query = session.createQuery("select lower(username) from User");
		List<String> listChange = query.list();

		for (String name : listChange) {
			System.out.println(name);
		}
		session.getTransaction().commit();
	}
	//�޸ģ������޸ĵ�����
	public void update() {
		Session session = HibernateSessionFactoryUtil.getSessionFactory().openSession();
		session.beginTransaction();
		Query query = session.createQuery("update User set username='��ΰ1231' where id=?");
		query.setInteger(0, 3);
		int rowCount = query.executeUpdate();
		System.out.println(rowCount);
		session.getTransaction().commit();
	}
	//
	public void operateProfile() {// ��profile�����ִ��HQL������
		Session session = HibernateSessionFactoryUtil.getSessionFactory().openSession();
		session.beginTransaction();
		// ִ�в�ѯ����
		Query query = session.createQuery("from Profile");
		List<Profile> list = query.list();
		for (Profile profile : list) {
			System.out.println(profile.getId() + profile.getEmail()
				+ profile.getAddress() + profile.getMobile()
				+ profile.getPostcode());
		}
		// ִ��ɾ������
		query = session.createQuery("delete from Profile where id=?");
		query.setInteger(0, 3);
		int rowCount = query.executeUpdate();
		System.out.println(rowCount);
		session.getTransaction().commit();
	}
	//�����ѯ
	public void jiaoChaCheck() {
		//���ַ�����ѯ�����Ľ���ǵѿ��������������ǿ�����û�ж���ô�
		Session session = HibernateSessionFactoryUtil.getSessionFactory().openSession();
		session.beginTransaction();
		Query query=session.createQuery("from User,Profile");
		List<Object[]> list=query.list();
		for(Object[] values:list){
		User user=(User)values[0];
		System.out.print("ID :"+user.getId()+",UserName:"+user.getUsername()+",Password:"+user.getPassword());
		Profile profile=(Profile)values[1];
		System.out.println(profile.getEmail()+profile.getMobile()+profile.getAddress()+profile.getPostcode());
	}
  
  session.getTransaction().commit();
 }
	//�����Ӳ�ѯ
	public void innerJoin(){
	  /**
	   * ��������hql��䶼�ǿ��Եõ���ͬ�Ľ��
	   * String hql="select p from Profile as p inner join p.user";
	   * �������hql����м���"fetch"�󣬴�hql����Ϊ��"����HQL"��䣬�����Ĳ�ѯЧ��Ҫ�������hql���Ҫ��
	   * String hql="select p from Profile as p inner join fetch p.user";
	   * 
	   * String hql="select p from Profile p,User u where p.user=u";
	   * String hql="select p from Profile p,User u where p.user.id=u.id";
	   *  
	   */  
		Session session = HibernateSessionFactoryUtil.getSessionFactory().openSession();
		session.beginTransaction();
		String hql="select p from Profile as p inner join fetch p.user";
		//String hql="select p from Profile p,User u where p.user=u";
		//String hql="select p from Profile p,User u where p.user.id=u.id";
		Query query=session.createQuery(hql);
		List<Profile> list=query.list();
		for(Profile p:list){
			System.out.println("ID:"+p.getUser().getId()+"   Username: "+p.getUser().getUsername()+"   Email: "+p.getEmail()+",   Address: "+p.getAddress());
		}
		session.getTransaction().commit();
	}

	public void QBC(){//QBC��ʵ�������Ӳ�ѯ
		  Session session=HibernateSessionFactoryUtil.getSessionFactory().openSession();
		  session.beginTransaction();
		  Criteria criteria=session.createCriteria(Profile.class).createCriteria("user");
		  List<Profile> list=criteria.list();
		  
		  for(Profile p:list){
		   System.out.println("ID:"+p.getUser().getId()+"   Username: "+p.getUser().getUsername()+"   Email: "+p.getEmail()+",   Address: "+p.getAddress());
		  }
		  //QBC��ʵ��������
		  System.out.println("##################################################");
		  criteria=session.createCriteria(Profile.class).setFetchMode("user", FetchMode.JOIN);
		  List<Profile> listp=criteria.list();
		  
		  for(Profile p:list){
		   System.out.println("ID:"+p.getUser().getId()+"   Username: "+p.getUser().getUsername()+"   Email: "+p.getEmail()+",   Address: "+p.getAddress());    
		  }  
		  session.getTransaction().commit();
	}

	public void leftOuterJoin(){//��������
	  /**
	   * String hql="select p from Profile p left outer join p.user order by p.user.id";
	   * �������hql����м���"fetch"�󣬴�hql����Ϊ��"����HQL"��䣬�����Ĳ�ѯЧ��Ҫ�������hql���Ҫ��
	   * String hql="select p from Profile p left outer join fetch p.user order by p.user.id";
	   *
	   * String hqlu="select u from User u left outer join u.profiles";
	   *  �������hql����м���"fetch"�󣬴�hql����Ϊ��"����HQL"��䣬�����Ĳ�ѯЧ��Ҫ�������hql���Ҫ��
	   * String hqlu="select u from User u left outer join fetch u.profiles";
	   */
		Session session=HibernateSessionFactoryUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		String hql="select p from Profile p left outer join fetch p.user order by p.user.id";
		Query query=session.createQuery(hql);
  
		List<Profile> list=query.list();
		for(Profile p:list){
			System.out.println("ID:"+p.getUser().getId()+"   Username: "+p.getUser().getUsername()+"   Email: "+p.getEmail()+",   Address: "+p.getAddress());
		}

		System.out.println("-------------------------------------");
		String hqlu="select u from User u left outer join fetch u.profiles";
		query=session.createQuery(hqlu);
  
		List<User> listu=query.list();
		for(User u:listu){
			System.out.println(u.getId()+u.getUsername()+u.getProfiles());
		}
		session.getTransaction().commit();  
	}
 
	public void rightOuterJoin(){//��������
		Session session=HibernateSessionFactoryUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		String hql="select u from User u right outer join u.profiles order by u.id";
		Query query=session.createQuery(hql);
		  
		List<User> listu=query.list();
		for(User user:listu){
			System.out.println(user.getId()+user.getUsername()+user.getProfiles());
		}		  
		session.getTransaction().commit();		   
	} 
}

�����

log4j:WARN No appenders could be found for logger (org.hibernate.cfg.Environment).
log4j:WARN Please initialize the log4j system properly.
Hibernate: 
    select
        user0_.id as id0_,
        user0_.username as username0_,
        user0_.password as password0_ 
    from
        users.user user0_ 
    where
        user0_.id not between 200 and 2000
1hongten
2hanyuan
3hongwei
4mingliu
5shouzhang
Hibernate: 
    select
        user0_.username as col_0_0_ 
    from
        users.user user0_ 
    where
        user0_.id=2
hanyuan
Hibernate: 
    select
        user0_.id as id0_,
        user0_.username as username0_,
        user0_.password as password0_ 
    from
        users.user user0_ 
    where
        user0_.username in (
            'Hongten' , 'Hanyuan' , 'dfgd'
        )
1hongten
2hanyuan
Hibernate: 
    select
        user0_.id as id0_,
        user0_.username as username0_,
        user0_.password as password0_ 
    from
        users.user user0_ 
    where
        user0_.username not like 'Hon%'
2hanyuan
4mingliu
5shouzhang
Hibernate: 
    select
        user0_.id as id0_,
        user0_.username as username0_,
        user0_.password as password0_ 
    from
        users.user user0_ 
    where
        user0_.password is null
Hibernate: 
    select
        user0_.id as id0_,
        user0_.username as username0_,
        user0_.password as password0_ 
    from
        users.user user0_ 
    where
        (
            user0_.password is not null
        ) 
        and user0_.id<5
1hongten123
2hanyuan5645645
3hongwei5645645
4mingliu5645645
Hibernate: 
    select
        user0_.id as id0_,
        user0_.username as username0_,
        user0_.password as password0_ 
    from
        users.user user0_ 
    order by
        user0_.username,
        user0_.id desc
2hanyuan
1hongten
3hongwei
4mingliu
5shouzhang
Hibernate: 
    select
        user0_.username as col_0_0_ 
    from
        users.user user0_ 
    where
        user0_.username=?
hongten
Hibernate: 
    select
        user0_.username as col_0_0_ 
    from
        users.user user0_
hongten
hanyuan
hongwei
mingliu
shouzhang
-------------------------------------------
Hibernate: 
    select
        lower(user0_.username) as col_0_0_ 
    from
        users.user user0_
hongten
hanyuan
hongwei
mingliu
shouzhang
Hibernate: 
    update
        users.user 
    set
        username='Hongwei1231' 
    where
        id=?
1
Hibernate: 
    select
        user0_.id as id0_0_,
        profile1_.id as id1_1_,
        user0_.username as username0_0_,
        user0_.password as password0_0_,
        profile1_.user_id as user2_1_1_,
        profile1_.email as email1_1_,
        profile1_.phone as phone1_1_,
        profile1_.mobile as mobile1_1_,
        profile1_.address as address1_1_,
        profile1_.postcode as postcode1_1_ 
    from
        users.user user0_,
        users.profile profile1_
ID :1,UserName:hongten,Password:123hongtenzone@foxmail.com45464Guangzhoushi65465
ID :1,UserName:hongten,Password:123hanyuan@foxmail.com45648255GuangzhoushiDianbian65465
ID :1,UserName:hongten,Password:123hanyuan@foxmail.com45648255GuangzhoushiDianbian65465
ID :2,UserName:hanyuan,Password:5645645hongtenzone@foxmail.com45464Guangzhoushi65465
ID :2,UserName:hanyuan,Password:5645645hanyuan@foxmail.com45648255GuangzhoushiDianbian65465
ID :2,UserName:hanyuan,Password:5645645hanyuan@foxmail.com45648255GuangzhoushiDianbian65465
ID :3,UserName:Hongwei1231,Password:5645645hongtenzone@foxmail.com45464Guangzhoushi65465
ID :3,UserName:Hongwei1231,Password:5645645hanyuan@foxmail.com45648255GuangzhoushiDianbian65465
ID :3,UserName:Hongwei1231,Password:5645645hanyuan@foxmail.com45648255GuangzhoushiDianbian65465
ID :4,UserName:mingliu,Password:5645645hongtenzone@foxmail.com45464Guangzhoushi65465
ID :4,UserName:mingliu,Password:5645645hanyuan@foxmail.com45648255GuangzhoushiDianbian65465
ID :4,UserName:mingliu,Password:5645645hanyuan@foxmail.com45648255GuangzhoushiDianbian65465
ID :5,UserName:shouzhang,Password:5645645hongtenzone@foxmail.com45464Guangzhoushi65465
ID :5,UserName:shouzhang,Password:5645645hanyuan@foxmail.com45648255GuangzhoushiDianbian65465
ID :5,UserName:shouzhang,Password:5645645hanyuan@foxmail.com45648255GuangzhoushiDianbian65465
Hibernate: 
    select
        profile0_.id as id1_0_,
        user1_.id as id0_1_,
        profile0_.user_id as user2_1_0_,
        profile0_.email as email1_0_,
        profile0_.phone as phone1_0_,
        profile0_.mobile as mobile1_0_,
        profile0_.address as address1_0_,
        profile0_.postcode as postcode1_0_,
        user1_.username as username0_1_,
        user1_.password as password0_1_ 
    from
        users.profile profile0_ 
    inner join
        users.user user1_ 
            on profile0_.user_id=user1_.id
ID:1   Username: hongten   Email: hongtenzone@foxmail.com,   Address: Guangzhoushi
ID:2   Username: hanyuan   Email: hanyuan@foxmail.com,   Address: GuangzhoushiDianbian
ID:3   Username:Hongwei1231   Email: hanyuan@foxmail.com,   Address: GuangzhoushiDianbian
Hibernate: 
    select
        this_.id as id1_1_,
        this_.user_id as user2_1_1_,
        this_.email as email1_1_,
        this_.phone as phone1_1_,
        this_.mobile as mobile1_1_,
        this_.address as address1_1_,
        this_.postcode as postcode1_1_,
        user1_.id as id0_0_,
        user1_.username as username0_0_,
        user1_.password as password0_0_ 
    from
        users.profile this_ 
    inner join
        users.user user1_ 
            on this_.user_id=user1_.id
ID:1   Username: hongten   Email: hongtenzone@foxmail.com,   Address: Guangzhoushi
ID:2   Username: hanyuan   Email: hanyuan@foxmail.com,   Address: GuangzhoushiDianbian
ID:3   Username: Hongwei1231   Email: hanyuan@foxmail.com,   Address: GuangzhoushiDianbian
##################################################
Hibernate: 
    select
        this_.id as id1_1_,
        this_.user_id as user2_1_1_,
        this_.email as email1_1_,
        this_.phone as phone1_1_,
        this_.mobile as mobile1_1_,
        this_.address as address1_1_,
        this_.postcode as postcode1_1_,
        user2_.id as id0_0_,
        user2_.username as username0_0_,
        user2_.password as password0_0_ 
    from
        users.profile this_ 
    left outer join
        users.user user2_ 
            on this_.user_id=user2_.id
ID:1   Username: hongten   Email: hongtenzone@foxmail.com,   Address: Guangzhoushi
ID:2   Username: hanyuan   Email: hanyuan@foxmail.com,   Address: GuangzhoushiDianbian
ID:3   Username: ��ΰ1231   Email: hanyuan@foxmail.com,   Address: GuangzhoushiDianbian
Hibernate: 
    select
        profile0_.id as id1_0_,
        user1_.id as id0_1_,
        profile0_.user_id as user2_1_0_,
        profile0_.email as email1_0_,
        profile0_.phone as phone1_0_,
        profile0_.mobile as mobile1_0_,
        profile0_.address as address1_0_,
        profile0_.postcode as postcode1_0_,
        user1_.username as username0_1_,
        user1_.password as password0_1_ 
    from
        users.profile profile0_ 
    left outer join
        users.user user1_ 
            on profile0_.user_id=user1_.id 
    order by
        profile0_.user_id
ID:1   Username: hongten   Email: hongtenzone@foxmail.com,   Address: Guangzhoushi
ID:2   Username: hanyuan   Email: hanyuan@foxmail.com,   Address: GuangzhoushiDianbian
ID:3   Username: ��ΰ1231   Email: hanyuan@foxmail.com,   Address: GuangzhoushiDianbian
-------------------------------------
Hibernate: 
    select
        user0_.id as id0_0_,
        profiles1_.id as id1_1_,
        user0_.username as username0_0_,
        user0_.password as password0_0_,
        profiles1_.user_id as user2_1_1_,
        profiles1_.email as email1_1_,
        profiles1_.phone as phone1_1_,
        profiles1_.mobile as mobile1_1_,
        profiles1_.address as address1_1_,
        profiles1_.postcode as postcode1_1_,
        profiles1_.user_id as user2_0__,
        profiles1_.id as id0__ 
    from
        users.user user0_ 
    left outer join
        users.profile profiles1_ 
            on user0_.id=profiles1_.user_id
1hongten[com.b510.example.Profile@14eaec9]
2hanyuan[com.b510.example.Profile@569c60]
3Hongwei1231[com.b510.example.Profile@d67067]
4mingliu[]
5shouzhang[]
Hibernate: 
    select
        user0_.id as id0_,
        user0_.username as username0_,
        user0_.password as password0_ 
    from
        users.user user0_ 
    right outer join
        users.profile profiles1_ 
            on user0_.id=profiles1_.user_id 
    order by
        user0_.id
Hibernate: 
    select
        profiles0_.user_id as user2_1_,
        profiles0_.id as id1_,
        profiles0_.id as id1_0_,
        profiles0_.user_id as user2_1_0_,
        profiles0_.email as email1_0_,
        profiles0_.phone as phone1_0_,
        profiles0_.mobile as mobile1_0_,
        profiles0_.address as address1_0_,
        profiles0_.postcode as postcode1_0_ 
    from
        users.profile profiles0_ 
    where
        profiles0_.user_id=?
1hongten[com.b510.example.Profile@10c0f66]
Hibernate: 
    select
        profiles0_.user_id as user2_1_,
        profiles0_.id as id1_,
        profiles0_.id as id1_0_,
        profiles0_.user_id as user2_1_0_,
        profiles0_.email as email1_0_,
        profiles0_.phone as phone1_0_,
        profiles0_.mobile as mobile1_0_,
        profiles0_.address as address1_0_,
        profiles0_.postcode as postcode1_0_ 
    from
        users.profile profiles0_ 
    where
        profiles0_.user_id=?
2hanyuan[com.b510.example.Profile@e265d0]
Hibernate: 
    select
        profiles0_.user_id as user2_1_,
        profiles0_.id as id1_,
        profiles0_.id as id1_0_,
        profiles0_.user_id as user2_1_0_,
        profiles0_.email as email1_0_,
        profiles0_.phone as phone1_0_,
        profiles0_.mobile as mobile1_0_,
        profiles0_.address as address1_0_,
        profiles0_.postcode as postcode1_0_ 
    from
        users.profile profiles0_ 
    where
        profiles0_.user_id=?
3Hongwei1231[com.b510.example.Profile@8997d1]