package com.project.dao;

import java.io.Serializable;

import org.hibernate.criterion.DetachedCriteria;

import com.project.entity.Page;

public interface BaseDao<T , PK extends Serializable> {
	boolean insert(T t);
	boolean delete(T t);
	boolean update(T t);
	T getById(PK pk);	
	
	public Page getPageByHQL(int currentPage,String className,String where);
	
	public Page getPageByCriteria(int currentPage,DetachedCriteria dc);
	//DetachedCriteria 脱管的Criteria与session不关联	  
}
