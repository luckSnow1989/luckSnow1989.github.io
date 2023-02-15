package test.java;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.junit.Test;

import cn.itcast.entity.TestTable;

public class TestHibernate {

	@Test
	public void save(){
		Configuration config = new Configuration();
		config.configure();
	
		SessionFactory sf = config.buildSessionFactory();
		Session s = sf.openSession();
		Transaction tr = s.beginTransaction();
		
		TestTable tt = new TestTable();
		
		tt.setName("测试Hibernate");
		tt.setCreateTime(new java.util.Date());
		tt.setRemark("备注Hibernate");
		
		s.save(tt);
		tr.commit();
		s.close();
		
	}
}
