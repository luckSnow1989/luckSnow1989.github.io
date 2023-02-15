package cn.itcast.web.struts2.cargo.contract;

import java.text.ParseException;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

import cn.itcast.entity.Contract;
import cn.itcast.entity.ContractProduct;
import cn.itcast.entity.ExtCproduct;
import cn.itcast.entity.dao.ContractDAO;
import cn.itcast.entity.dao.ContractProductDAO;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.print.ContractPrint;
import cn.itcast.web.struts2._BaseStruts2Action;

public class ContractAction extends _BaseStruts2Action implements ModelDriven<Contract> {
	private Contract model = new Contract();
	public Contract getModel() {
		return model;
	}
	
	//列表
	public String list(){
		ContractDAO oDao = (ContractDAO) this.getDao("daoContract");
		List<Contract> dataList = oDao.find("from Contract o");
		ActionContext.getContext().put("dataList", dataList);
		
		return "plist";
	}
	
	//保存
	public String save() throws ParseException{
		ContractDAO oDao = (ContractDAO) this.getDao("daoContract");
		if(UtilFuns.isEmpty(model.getId())){
			model.setState(0);		//草稿
			//替换船期
			if(UtilFuns.isNotEmpty(model.getDeliveryPeriod())){
				model.setCrequest(model.getCrequest().replaceFirst("deliveryPeriod", UtilFuns.dateTimeFormat(model.getDeliveryPeriod())));
			}
		}

		oDao.saveOrUpdate(model);
		
		return list();
	}
	
	//批量删除
	public String delete(){
		String[] ids = model.getId().replace(" ", "").split(",");
		ContractDAO oDao = (ContractDAO) this.getDao("daoContract");
		oDao.deleteAllById(ids, Contract.class);

		return list();
	}
	
	//复制
	public String copy() throws Exception{
		ContractDAO oDao = (ContractDAO)this.getDao("daoContract");
		Contract oldContract = (Contract)oDao.get(Contract.class, model.getId());
		Contract newContract = new Contract();
		
		BeanUtils.copyProperties(newContract, oldContract);		//将oldContract的个属性复制到newContract对象中
		
		//初始化合同的初始值
		newContract.setContractNo("[复制]"+oldContract.getContractNo());
		newContract.setOldState(null);
		newContract.setState(0);
		
		//初始化货物、附件的初始值...
		
		oDao.saveOrUpdate(newContract);
		
		return list();
	}

	
	public String copyx() throws Exception{
		
		ContractDAO oDao = (ContractDAO)this.getDao("daoContract");
		Contract oldContract = (Contract)oDao.get(Contract.class, model.getId());
		
		Contract newContract = new Contract();
		newContract.setCheckBy(oldContract.getCheckBy());
		newContract.setContractNo("[复制]"+oldContract.getContractNo());
		newContract.setCustomName(oldContract.getCustomName());
		newContract.setDeliveryPeriod(oldContract.getDeliveryPeriod());
		newContract.setImportNum(oldContract.getImportNum());
		newContract.setInputBy(oldContract.getInputBy());
		newContract.setInspector(oldContract.getInspector());
		newContract.setOfferor(oldContract.getOfferor());
		newContract.setOldState(null);
		newContract.setPrintStyle(oldContract.getPrintStyle());
		newContract.setRemark(oldContract.getRemark());
		newContract.setCrequest(oldContract.getCrequest());
		newContract.setShipTime(oldContract.getShipTime());
		newContract.setSigningDate(oldContract.getSigningDate());
		newContract.setTotalAmount(oldContract.getTotalAmount());
		
		newContract.setState(0);
		
		//商品
		Set<ContractProduct> newContractProductSet = new HashSet<ContractProduct>();
		ContractProduct newProduct = null;
		ContractProduct oldProduct = null;
		
		for (Iterator<ContractProduct> iter = oldContract.getContractProduct().iterator(); iter.hasNext();) {
			oldProduct = iter.next();
			newProduct = new ContractProduct();
			
			newProduct.setAccessories(oldProduct.isAccessories());
			newProduct.setAmount(oldProduct.getAmount());
			newProduct.setBoxNum(oldProduct.getBoxNum());
			newProduct.setCnumber(oldProduct.getCnumber());
			newProduct.setCostPrice(oldProduct.getCostPrice());
			newProduct.setCostTax(oldProduct.getCostPrice());
			newProduct.setCunit(oldProduct.getCunit());
			newProduct.setExPrice(oldProduct.getExPrice());
			newProduct.setExUnit(oldProduct.getExUnit());
			newProduct.setFactory(oldProduct.getFactory());
			newProduct.setGrossWeight(oldProduct.getGrossWeight());
			newProduct.setLoadingRate(oldProduct.getLoadingRate());
			newProduct.setNetWeight(oldProduct.getNetWeight());
			newProduct.setNoTax(oldProduct.getNoTax());
			newProduct.setOrderNo(oldProduct.getOrderNo());
			newProduct.setPackingUnit(oldProduct.getPackingUnit());
			newProduct.setPrice(oldProduct.getPrice());
			newProduct.setProductDesc(oldProduct.getProductDesc());
			newProduct.setProductImage(oldProduct.getProductImage());
			newProduct.setProductName(oldProduct.getProductName());
			newProduct.setProductNo(oldProduct.getProductNo());
			newProduct.setProductRequest(oldProduct.getProductRequest());
			newProduct.setSizeHeight(oldProduct.getSizeHeight());
			newProduct.setSizeLength(oldProduct.getSizeLength());
			newProduct.setSizeWidth(oldProduct.getSizeWidth());
			newProduct.setTax(oldProduct.getTax());
			
			//state
			newProduct.setFinished(false);
			newProduct.setOutNumber(0);

			
			//附件
			Set<ExtCproduct> newExtCproductSet = new HashSet<ExtCproduct>();
			ExtCproduct newExtCproduct = null;
			ExtCproduct oldExtCproduct = null;
			
			for (Iterator<ExtCproduct> itExtCproduct = oldProduct.getExtCproduct().iterator(); itExtCproduct.hasNext();) {
				oldExtCproduct = itExtCproduct.next();
				newExtCproduct = new ExtCproduct();
				
				newExtCproduct.setAccessories(oldExtCproduct.isAccessories());
				newExtCproduct.setAmount(oldExtCproduct.getAmount());
				newExtCproduct.setBoxNum(oldExtCproduct.getBoxNum());
				newExtCproduct.setCnumber(oldExtCproduct.getCnumber());
				newExtCproduct.setCostPrice(oldExtCproduct.getCostPrice());
				newExtCproduct.setCostTax(oldExtCproduct.getCostTax());
				newExtCproduct.setCtype(oldExtCproduct.getCtype());
				newExtCproduct.setCunit(oldExtCproduct.getCunit());
				newExtCproduct.setExPrice(oldExtCproduct.getExPrice());
				newExtCproduct.setExUnit(oldExtCproduct.getExUnit());
				newExtCproduct.setFactory(oldExtCproduct.getFactory());
				newExtCproduct.setGrossWeight(oldExtCproduct.getGrossWeight());
				newExtCproduct.setLoadingRate(oldExtCproduct.getLoadingRate());
				newExtCproduct.setNetWeight(oldExtCproduct.getNetWeight());
				newExtCproduct.setNoTax(oldExtCproduct.getNoTax());
				newExtCproduct.setOrderNo(oldExtCproduct.getOrderNo());
				newExtCproduct.setPackingUnit(oldExtCproduct.getPackingUnit());
				newExtCproduct.setPrice(oldExtCproduct.getPrice());
				newExtCproduct.setProductDesc(oldExtCproduct.getProductDesc());
				newExtCproduct.setProductImage(oldExtCproduct.getProductImage());
				newExtCproduct.setProductName(oldExtCproduct.getProductName());
				newExtCproduct.setProductNo(oldExtCproduct.getProductNo());
				newExtCproduct.setProductRequest(oldExtCproduct.getProductRequest());
				newExtCproduct.setSizeHeight(oldExtCproduct.getSizeHeight());
				newExtCproduct.setSizeLength(oldExtCproduct.getSizeLength());
				newExtCproduct.setSizeWidth(oldExtCproduct.getSizeWidth());
				newExtCproduct.setTax(oldExtCproduct.getTax());
				newExtCproduct.setTypeName(oldExtCproduct.getTypeName());
				
				//state
				newExtCproduct.setFinished(false);
				newExtCproduct.setOutNumber(0);
				
				newExtCproduct.setContractProduct(newProduct);
				
				newExtCproductSet.add(newExtCproduct);
			}
			
			newProduct.setExtCproduct(newExtCproductSet);
			newProduct.setContract(newContract);
			
			newContractProductSet.add(newProduct);				
		}
	
		
		newContract.setContractProduct(newContractProductSet);
		
		oDao.saveOrUpdate(newContract);
		
		return list();
	}	
	
	//打印
	public void print() throws Exception{
		HttpServletResponse response = ServletActionContext.getResponse();
		
		ContractProductDAO oDao = (ContractProductDAO)this.getDao("daoContractProduct");
		ContractDAO pDao = (ContractDAO)this.getDao("daoContract");
		
		ContractPrint cp  = new ContractPrint();
		cp.print(model.getId(), response, oDao, pDao);
		
	}
	
	
	//转向新增页面
	public String tocreate(){
		
		return "pcreate";
	}
	
	//转向修改页面
	public String toupdate(){
		ContractDAO oDao = (ContractDAO) this.getDao("daoContract");
		Contract obj  = (Contract) oDao.get(Contract.class, model.getId());
		ActionContext.getContext().getValueStack().push(obj);
		
		return "pupdate";
	}
	
	//转向查看页面
	public String toview(){
		ContractDAO oDao = (ContractDAO) this.getDao("daoContract");
		Contract obj  = (Contract) oDao.get(Contract.class, model.getId());
		ActionContext.getContext().getValueStack().push(obj);
		
		return "pview";
	}
	
	//上报
	public String submit(){
		this.state(1);
		return list();
	}
	
	//取消
	public String cancelsubmit(){
		this.state(0);
		return list();
	}
	
	//改变状态
	private void state(Integer curValue){
		String[] ids = model.getId().replace(" ", "").split(",");
		ContractDAO oDao = (ContractDAO) this.getDao("daoContract");
		Contract obj;
		
		Set oSet = new HashSet();
		for(int i=0;i<ids.length;i++){
			obj  = (Contract) oDao.get(Contract.class, ids[i]);
			obj.setState(curValue);
			oSet.add(obj);
		}
		oDao.saveOrUpdateAll(oSet);
	}
}
