package com.project.test;


import org.hibernate.Session;
import org.hibernate.Transaction;
import org.junit.Test;
import com.project.entity.Husband;
import com.project.entity.Wife;
import com.project.util.HibernateUtil;

public class TestDemo {
	@Test
	public void test1(){
		Session session = HibernateUtil.getSession();
		Transaction tr = session.beginTransaction();
		
		Husband h = new Husband();
		h.setName("小王");
		
		
		Wife w = new Wife();
		w.setName("小美");
		
		
		h.setWife(w);
		session.save(h);
		
		tr.commit();
		session.close();
		
	}
	
	@Test
	public void test2(){
		Session session = HibernateUtil.getSession();
		Transaction tr = session.beginTransaction();
		
		Husband h = (Husband)session.get(Husband.class, 1);

		session.delete(h);
		tr.commit();
		session.close();
		
	}
}
