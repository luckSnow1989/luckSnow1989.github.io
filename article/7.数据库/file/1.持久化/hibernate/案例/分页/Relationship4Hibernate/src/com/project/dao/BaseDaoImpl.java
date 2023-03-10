package com.project.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;

import com.project.entity.Page;
import com.project.entity.User;
import com.project.util.Constants;
import com.project.util.HibernateUtil;

public class BaseDaoImpl<T, PK extends Serializable> implements BaseDao<T, PK> {

	protected Class entityClass;

	@SuppressWarnings("unchecked")
	public BaseDaoImpl(){
		Type genType = getClass().getGenericSuperclass();
		Type[] params = ((ParameterizedType)genType).getActualTypeArguments();
		entityClass = (Class<T>)params[0];
	}
	
	public boolean insert(T t) {
		Session se = HibernateUtil.getSession();
		Transaction tr = null;
		try {
			tr = se.beginTransaction();
			se.save(t);
			
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

	public boolean delete(T t) {
		Session se = HibernateUtil.getSession();
		Transaction tr = null;
		try {
			tr = se.beginTransaction();
			se.delete(t);
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

	public boolean update(T t) {
		Session se = HibernateUtil.getSession();
		Transaction tr = null;
		try {
			tr = se.beginTransaction();
			se.update(t);
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

	public T getById(PK pk) {
		Session se = HibernateUtil.getSession();
		Transaction tr = null;
		try {
			tr = se.beginTransaction();
			T t = (T) se.get(this.entityClass, pk);
			tr.commit();
			return t;
		} catch (Exception e) {
			tr.rollback();
			return null;
		} finally {
			if (se != null)
				se.close();
		}
	}

	public Page getPageByHQL(int currentPage, String className, String where) {
		Session session = HibernateUtil.getSession();
		Page page = new Page();
		// 1.?????????????????????---???????????????
		String countHQL="select count(*) from "+className+" "+where;
		Query q = session.createQuery(countHQL);
		long temp = (Long)q.uniqueResult();
		// ???????????????????????????
		page.setCountInfo((int)temp);
		// ???????????????
		int totalPage = (page.getCountInfo()+Constants.NUM_PER_PAGE-1)/Constants.NUM_PER_PAGE;
		page.setCurrentPage(currentPage);
		page.setTotalPage(totalPage);				
		// 2.????????????
		String dataHQL = "from "+className+" "+where;
		q = session.createQuery(dataHQL);		
		q.setFirstResult((currentPage-1)*Constants.NUM_PER_PAGE);
		q.setMaxResults(Constants.NUM_PER_PAGE);		
		List li = q.list();
		page.setList(li);
		return page;
	}

	public Page getPageByCriteria(int currentPage, DetachedCriteria dc) {
		Session session = HibernateUtil.getSession();
		Page page = new Page();
		Criteria cri = dc.getExecutableCriteria(session);//????????????criteria???session?????????????????????????????????criteria
		// 1.?????????????????????---???????????????
		cri.setProjection(Projections.rowCount());		
		long temp = (Long)cri.uniqueResult();
		// ???????????????????????????
		page.setCountInfo((int)temp);
		// ???????????????
		int totalPage = (page.getCountInfo()+Constants.NUM_PER_PAGE-1)/Constants.NUM_PER_PAGE;
		page.setCurrentPage(currentPage);
		page.setTotalPage(totalPage);				
		// 2.????????????		
		cri.setProjection(null);// ??????????????????????????????cri????????????????????????????????????????????????????????????
		cri.setFirstResult((currentPage-1)*Constants.NUM_PER_PAGE);
		cri.setMaxResults(Constants.NUM_PER_PAGE);		
		List li = cri.list();
		page.setList(li);
		return page;
	}
}
