package test.java;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import cn.itcast.common.springdao.SQLDAO;

public class TestSQLDAO {

	/**
	 * @测试sql
	 */
	public static void main(String[] args) {
		ApplicationContext ac = new ClassPathXmlApplicationContext("nu-template-dao.xml");
		SQLDAO sqlDAO = (SQLDAO)ac.getBean("sqlDao");
		
		String sql = "SELECT * FROM user_info_p";
		List<String> dataList = sqlDAO.executeSQL(sql);
		
		System.out.println(dataList.size());
		


	}

}
