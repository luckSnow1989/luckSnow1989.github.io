package cn.itcast.web.struts2.cargo.contract;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

import cn.itcast.entity.Contract;
import cn.itcast.entity.ContractProduct;
import cn.itcast.entity.Factory;
import cn.itcast.entity.dao.ContractProductDAO;
import cn.itcast.web.common.util.Arith;
import cn.itcast.web.struts2._BaseStruts2Action;

public class ContractProductAction extends _BaseStruts2Action implements ModelDriven<ContractProduct> {
	private ContractProduct model = new ContractProduct();
	public ContractProduct getModel() {
		return model;
	}
	
	//新建保存
	public String save(){
		ContractProductDAO oDao = (ContractProductDAO) this.getDao("daoContractProduct");
		
		//计算
		Arith arith = new Arith();
		model.setAmount(new BigDecimal(arith.mul(model.getCnumber(), model.getPrice().doubleValue())));
		
		//初始化
		model.setFinished(false);
		model.setAccessories(false);		
		
		oDao.saveOrUpdate(model);
		
		return tocreate();
	}
	
	//删除
	public String delete(){
		String[] ids = model.getId().replace(" ", "").split(",");
		ContractProductDAO oDao = (ContractProductDAO) this.getDao("daoContractProduct");
		oDao.deleteAllById(ids, ContractProduct.class);

		return tocreate();
	}

	//转向新增页面
	public String tocreate(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("contract.id");
		
		ContractProductDAO oDao = (ContractProductDAO) this.getDao("daoContractProduct");
		
		//列表数据
		List<ContractProduct> dataList = oDao.find("from ContractProduct o where o.contract.id='"+model.getContract().getId()+"'");
		ActionContext.getContext().put("dataList", dataList);

		//工厂下拉框数据准备
		List<Factory> factoryList = oDao.find("from Factory o where o.state=1");
		ActionContext.getContext().put("factoryList", factoryList);
		
		return "pcreate";
	}
	
	
}
