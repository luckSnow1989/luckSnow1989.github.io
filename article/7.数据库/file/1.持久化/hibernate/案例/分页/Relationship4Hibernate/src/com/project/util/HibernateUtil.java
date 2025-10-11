package com.project.util;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {
	private static SessionFactory sf;
	public static SessionFactory getSessionfFactory(){
		if(sf == null ) {
			Configuration configure = new Configuration().configure();
			sf = configure.buildSessionFactory();
		}	
		return sf;
	}
	public static Session getSession(){
		return getSessionfFactory().openSession();
	}
}
