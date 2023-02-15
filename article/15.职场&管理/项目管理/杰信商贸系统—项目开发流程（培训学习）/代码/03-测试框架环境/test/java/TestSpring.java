package test.java;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.itcast.entity.TestTable;
import cn.itcast.entity.dao.TestTableDAO;

public class TestSpring {

	@Test
	public void save(){
		ApplicationContext ac = new ClassPathXmlApplicationContext("beans.xml");
		TestTableDAO oDao = (TestTableDAO)ac.getBean("daoTestTable");
		
		TestTable tt = new TestTable();
		
		tt.setName("测试Spring");
		tt.setCreateTime(new java.util.Date());
		tt.setRemark("备注Spring");
		
		oDao.save(tt);
	}
}
