package cn.itcast.web.struts2.cargo.extcproduct;

import java.util.List;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

import cn.itcast.entity.Contract;
import cn.itcast.entity.ContractProduct;
import cn.itcast.entity.ExtCproduct;
import cn.itcast.entity.Factory;
import cn.itcast.entity.dao.ContractProductDAO;
import cn.itcast.entity.dao.ExtCproductDAO;
import cn.itcast.web.struts2._BaseStruts2Action;

public class ExtCproductAction extends _BaseStruts2Action implements ModelDriven<ExtCproduct> {
	private ExtCproduct model = new ExtCproduct();
	public ExtCproduct getModel() {
		return model;
	}
	
	//保存
	public String save(){
		ExtCproductDAO oDao = (ExtCproductDAO) this.getDao("daoExtCproduct");
		oDao.saveOrUpdate(model);
		
		return tocreate();
	}
	
	//删除
	public String delete(){
		String[] ids = model.getId().replace(" ", "").split(",");
		ExtCproductDAO oDao = (ExtCproductDAO) this.getDao("daoExtCproduct");
		oDao.deleteAllById(ids, ExtCproduct.class);

		return tocreate();
	}
	
	//转向新增页面
	public String tocreate(){
		ExtCproductDAO oDao = (ExtCproductDAO) this.getDao("daoExtCproduct");
		
		//列表数据
		List<Contract> dataList = oDao.find("from ExtCproduct o where o.contractProduct.id='"+model.getContractProduct().getId()+"'");
		ActionContext.getContext().put("dataList", dataList);

		//工厂下拉框数据准备
		List<Factory> factoryList = oDao.find("from Factory o where o.state=1");
		ActionContext.getContext().put("factoryList", factoryList);
		
		return "pcreate";
	}
}
