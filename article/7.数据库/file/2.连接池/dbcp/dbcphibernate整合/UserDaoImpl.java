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

public class UserDaoImpl {
	

	public List<User> getAllUser() {
		Session se = HibernateUtil.getSession();
		Transaction tr = se.beginTransaction();
		String hql = "from User";
		Query qu = se.createQuery(hql);
		List<User> li = qu.list();
		return li;
	}

	public boolean insert(User u) {
		Session se = HibernateUtil.getSession();
		Transaction tr = null;
		try {
			tr = se.beginTransaction();
			se.save(u);		
			tr.commit();
		} catch (Exception e) {
			tr.rollback();
			return false;
		} finally {
			if (se != null)
				se.close();
		}
		return true;
	}

	public boolean delete(User u) {
		Session se = HibernateUtil.getSession();
		Transaction tr = null;
		try {
			tr = se.beginTransaction();
			se.delete(u);
			tr.commit();
		} catch (Exception e) {
			tr.rollback();
			return false;
		} finally {
			if (se != null)
				se.close();
		}
		return true;
	}

	public boolean update(User u) {
		Session se = HibernateUtil.getSession();
		Transaction tr = null;
		try {
			tr = se.beginTransaction();
			se.update(u);
			tr.commit();
		} catch (Exception e) {
			tr.rollback();
			return false;
		} finally {
			if (se != null)
				se.close();
		}
		return true;
	}

	public User getById(int id) {
		Session se = HibernateUtil.getSession();
		Transaction tr = null;
		try {
			tr = se.beginTransaction();
			User u = se.get(User.class, id);
			tr.commit();
			return u;
		} catch (Exception e) {
			tr.rollback();
			return null;
		} finally {
			if (se != null)
				se.close();
		}
	}
	

}
