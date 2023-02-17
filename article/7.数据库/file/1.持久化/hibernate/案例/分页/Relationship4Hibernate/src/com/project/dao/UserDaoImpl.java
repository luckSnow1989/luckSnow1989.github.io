package com.project.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import com.project.entity.Page;
import com.project.entity.User;
import com.project.util.HibernateUtil;

public class UserDaoImpl extends BaseDaoImpl<User, Integer> implements UserDao {
	
	public UserDaoImpl() {
		this.entityClass = User.class;
	}

	public List<User> getAllUser() {
		Session se = HibernateUtil.getSession();
		Transaction tr = se.beginTransaction();
		String hql = "from User";
		Query qu = se.createQuery(hql);
		List<User> li = qu.list();
		return li;
	}

	public List<User> getUserByName(String name) {
		Session se = HibernateUtil.getSession();
		Transaction tr = se.beginTransaction();
		String hql = "from User where name=?";
		Query qu = se.createQuery(hql);
		Criteria c = se.createCriteria(User.class);
		c.setProjection(Projections.count("id"));
		
		qu.setString(0, name);
		List<User> li = qu.list();
		return li;
	}

	public List<User> getUserByName2(String name) {
		Session se = HibernateUtil.getSession();
		Transaction tr = se.beginTransaction();
		String hql = "from User where name=?";
		Query qu = se.createQuery(hql);
		qu.setParameter(0, name);
		List<User> li = qu.list();
		return li;
	}

	public List<User> getUserByName3(String name) {
		Session se = HibernateUtil.getSession();
		Transaction tr = se.beginTransaction();
		String hql = "from User where name like:con";
		Query qu = se.createQuery(hql);
		qu.setParameter("con", "%"+name+"%");
		List<User> li = qu.list();
		return li;
	}

	public User getUserByName4(String name) {
		Session se = HibernateUtil.getSession();
		Transaction tr = se.beginTransaction();
		String hql = "from User where name=?";
		Query qu = se.createQuery(hql);
		qu.setString(0, name);
		User user = (User)qu.uniqueResult();
		return user;
	}

	public List<User> getUserByNameAndAge(String name, int age) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<User> getUserOrderByAge() {
		Session se = HibernateUtil.getSession();
		Transaction tr = se.beginTransaction();
		String hql = "from User order by age desc";
		Query qu = se.createQuery(hql);
		List<User> li = qu.list();
		return li;
	}

	public List<User> getUserByPage() {
		Session se = HibernateUtil.getSession();
		Transaction tr = se.beginTransaction();
		String hql = "from User";
		Query qu = se.createQuery(hql);
		qu.setFirstResult(0);
		qu.setMaxResults(5);
		List<User> li = qu.list();
		return li;
	}

	public List<User> getUserWithProperties(User user) {
		Session se = HibernateUtil.getSession();
		Transaction tr = se.beginTransaction();
		String hql = "from User where name=:name and age=:age";
		Query qu = se.createQuery(hql);
		qu.setProperties(user);
		List<User> li = qu.list();
		return li;
	}

	public List<User> getUserByNameInXML(String name) {
		// TODO Auto-generated method stub
		return null;
	}

	public int getUserCount() {
		
		return 0;
	}

	public List<Object[]> getUserWithProjection() {
		Session se = HibernateUtil.getSession();
		Transaction tr = se.beginTransaction();
		String hql = "select name,age from User";
		Query qu = se.createQuery(hql);
		List<Object[]> li = qu.list();
		return li;
	}

	public Page getUserPageByHQL(int currentPage, User user) {
		String className = "User";
		StringBuffer where = new StringBuffer(" where 1=1 ");
		if(user.getName() != null && user.getName().length()!=0 ) {
			where.append(" and name like '%"+user.getName()+"%'");
		}
		if(user.getAge() > 0) {
			where.append(" and age="+user.getAge()+"");
		}		
		return this.getPageByHQL(currentPage, className, where.toString());
	}

	public Page getUserPageByCriteria(int currentPage, User user) {
		DetachedCriteria dc = DetachedCriteria.forClass(User.class);	
		
		if(user.getName()!=null && user.getName().length()!=0 ) {
			dc.add(Restrictions.like("name", "%"+user.getName()+"%"));
		}
		if(user.getAge() > 0) {
			dc.add(Restrictions.eq("age", user.getAge()));
		}		
			
		return this.getPageByCriteria(currentPage, dc);
	}
	

}
