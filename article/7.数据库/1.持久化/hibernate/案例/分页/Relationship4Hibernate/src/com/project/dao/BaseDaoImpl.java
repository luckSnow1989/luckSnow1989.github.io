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
		// 1.查询信息总条数---计算总页数
		String countHQL="select count(*) from "+className+" "+where;
		Query q = session.createQuery(countHQL);
		long temp = (Long)q.uniqueResult();
		// 查询到的信息总条数
		page.setCountInfo((int)temp);
		// 计算总页数
		int totalPage = (page.getCountInfo()+Constants.NUM_PER_PAGE-1)/Constants.NUM_PER_PAGE;
		page.setCurrentPage(currentPage);
		page.setTotalPage(totalPage);				
		// 2.查询数据
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
		Criteria cri = dc.getExecutableCriteria(session);//将脱管的criteria与session关联起来，变成可执行的criteria
		// 1.查询信息总条数---计算总页数
		cri.setProjection(Projections.rowCount());		
		long temp = (Long)cri.uniqueResult();
		// 查询到的信息总条数
		page.setCountInfo((int)temp);
		// 计算总页数
		int totalPage = (page.getCountInfo()+Constants.NUM_PER_PAGE-1)/Constants.NUM_PER_PAGE;
		page.setCurrentPage(currentPage);
		page.setTotalPage(totalPage);				
		// 2.查询数据		
		cri.setProjection(null);// 计算总页数的时候，在cri中添加了投影，在去查询数据的时候必须去掉
		cri.setFirstResult((currentPage-1)*Constants.NUM_PER_PAGE);
		cri.setMaxResults(Constants.NUM_PER_PAGE);		
		List li = cri.list();
		page.setList(li);
		return page;
	}
}
