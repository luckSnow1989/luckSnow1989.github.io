package cn.itcast.web.struts2.test;

import com.opensymphony.xwork2.ModelDriven;

import cn.itcast.entity.TestTable;
import cn.itcast.entity.dao.TestTableDAO;
import cn.itcast.web.struts2._BaseStruts2Action;

public class TestTableAction extends _BaseStruts2Action implements ModelDriven<TestTable>{
	private TestTable model = new TestTable();
	public TestTable getModel() {
		return model;
	}
	
	public String create(){
		TestTableDAO oDao = (TestTableDAO)this.getDao("daoTestTable");
		
		TestTable tt = new TestTable();
		tt.setName(model.getName());
		tt.setCreateTime(model.getCreateTime());
		tt.setName(model.getRemark());
		
		
		oDao.save(model);
		
		return null;
	}


}
