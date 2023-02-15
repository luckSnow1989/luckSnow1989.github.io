package cn.itcast.web.struts2.cargo.export;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

import cn.itcast.entity.ContractProduct;
import cn.itcast.entity.Export;
import cn.itcast.entity.ExportProduct;
import cn.itcast.entity.ExtCproduct;
import cn.itcast.entity.ExtEproduct;
import cn.itcast.entity.dao.ContractProductDAO;
import cn.itcast.entity.dao.ExportDAO;
import cn.itcast.entity.dao.ExportProductDAO;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.struts2._BaseStruts2Action; 

public class ExportAction extends _BaseStruts2Action implements ModelDriven<Export> {
	private Export model = new Export();
	public Export getModel() {
		return model;
	}
	
	public String list(){
		//准备数据
		ExportDAO oDao = (ExportDAO) this.getDao("daoExport");
		List<Export> dataList = oDao.find("from Export o");
		ActionContext.getContext().put("dataList", dataList);
		
		return "plist";
	}
	
	
	//复制选中的多个合同中的货物，附件信息，加入到新的报运中
	public String contractsave() throws Exception{
		/*
		 * step:
		 * 1.得到选择的id数组
		 * 2.得到合同对象、取它下面的货物、取货物下的附件
		 * 3.保存
		 */
		
		HttpServletRequest request = ServletActionContext.getRequest();
		String contractIds = "";
		String customerContract = "";
		
		UtilFuns utilFuns = new UtilFuns();
		ExportDAO oDao = (ExportDAO) this.getDao("daoExport");
		
		
		
		Export export = new Export();
		String[] selContractIds = request.getParameterValues("id");
		
		String selIds = utilFuns.joinInStr(selContractIds);		//构造子查询串
		//查到多个合同下的所有货物
		String _tmpstr = oDao.findString("select o.id from ContractProduct o where o.contract.id in ("+selIds+")");
		
		String[] contractProductIds = utilFuns.splitStr(_tmpstr, ",");
		
		
		ContractProductDAO cpDao = (ContractProductDAO) this.getDao("daoContractProduct");
		ContractProduct contractProduct = null;
		
		
		

		BigDecimal bTotal = new BigDecimal(0);
		
		//复制选择的合同货物信息到报运货物，及附件，以及修改主表相应信息 
		
			ExportProductDAO epDao = (ExportProductDAO) this.getDao("daoExportProduct");
			ExportProduct eProduct = null;
			Set<ExportProduct> exportProductSet = new HashSet<ExportProduct>();
			
			Set extEproductSet = new HashSet();
			ExtCproduct extcproduct = null;
			ExtEproduct eproduct = null;
			int _rate = 0;
			
			for(int h = 0; h < contractProductIds.length; h++){
				eProduct = new ExportProduct();
				contractProduct = (ContractProduct)cpDao.get(ContractProduct.class, contractProductIds[h]);
				eProduct.setExport(export);
				
				if(contractProduct!=null && contractProduct.getContract()!=null){
					if(customerContract.indexOf(contractProduct.getContract().getContractNo()+",")==-1){	//排除已经在串中的
						customerContract += contractProduct.getContract().getContractNo() +",";				//实现合同号的拼接
					}
					if(contractIds.indexOf(contractProduct.getContract().getId()+",")==-1){					//排除已经在串中的
						contractIds += contractProduct.getContract().getId() +",";							//实现合同ID的拼接
					}
				}
				
				
				eProduct.setContractProductId(contractProductIds[h]);
				eProduct.setContractId(contractProduct.getContract().getId());
				eProduct.setContractNo(contractProduct.getContract().getContractNo());
				
				eProduct.setProductNo(contractProduct.getProductNo());
				eProduct.setProductImage(contractProduct.getProductImage());
				eProduct.setProductDesc(contractProduct.getProductDesc());
				eProduct.setFactory(contractProduct.getFactory());
				eProduct.setLoadingRate(contractProduct.getLoadingRate());
				eProduct.setPackingUnit(contractProduct.getPackingUnit());
				eProduct.setOutNumber(contractProduct.getOutNumber());
				
				//合同货物的走货状态
				if(contractProduct.getOutNumber()>0){
					eProduct.setCnumber(contractProduct.getCnumber()-contractProduct.getOutNumber());		//如果出过货，则界面显示剩余的货
					if(contractProduct.getLoadingRate()!=null && contractProduct.getCnumber()!=null){
						_rate = Integer.parseInt(contractProduct.getLoadingRate().substring(contractProduct.getLoadingRate().indexOf("/")+1));
						eProduct.setBoxNum(eProduct.getCnumber()/_rate);										//箱数=数量/装率的分母
					}
				}else{
					eProduct.setCnumber(contractProduct.getCnumber());
					eProduct.setBoxNum(contractProduct.getBoxNum());
				}
				contractProduct.setOutNumber(contractProduct.getCnumber());
				contractProduct.setFinished(true);	//默认全部出货
				
				eProduct.setGrossWeight(contractProduct.getGrossWeight());
				eProduct.setNetWeight(contractProduct.getNetWeight());
				eProduct.setSizeLength(contractProduct.getSizeLength());
				eProduct.setSizeWidth(contractProduct.getSizeWidth());
				eProduct.setSizeHeight(contractProduct.getSizeHeight());
				eProduct.setExPrice(contractProduct.getExPrice());
				eProduct.setTax(contractProduct.getPrice());		//收购单价.含税=合同单价
				eProduct.setAmount(contractProduct.getAmount());
				
				eProduct.setOrderNo(h+1);	//根据list的顺序排序
				
				for(Iterator<ExtCproduct> it = contractProduct.getExtCproduct().iterator(); it.hasNext(); ){
					eproduct = new ExtEproduct();
					extcproduct = it.next();
					
					eproduct.setAccessories(extcproduct.isAccessories());
					eproduct.setAmount(extcproduct.getAmount());
					eproduct.setBoxNum(extcproduct.getBoxNum());
					eproduct.setCnumber(extcproduct.getCnumber());
					eproduct.setCostPrice(extcproduct.getCostPrice());
					eproduct.setCtype(extcproduct.getCtype());
					eproduct.setCunit(extcproduct.getCunit());
					eproduct.setExPrice(extcproduct.getExPrice());
					eproduct.setExUnit(extcproduct.getExUnit());
					eproduct.setFactory(extcproduct.getFactory());
					eproduct.setFinished(extcproduct.isFinished());
					eproduct.setGrossWeight(extcproduct.getGrossWeight());
					eproduct.setLoadingRate(extcproduct.getLoadingRate());
					eproduct.setNetWeight(extcproduct.getNetWeight());
					eproduct.setNoTax(extcproduct.getNoTax());
					eproduct.setOutNumber(extcproduct.getOutNumber());
					eproduct.setPackingUnit(extcproduct.getPackingUnit());
					eproduct.setPrice(extcproduct.getPrice());
					eproduct.setProductDesc(extcproduct.getProductDesc());
					eproduct.setProductImage(extcproduct.getProductImage());
					eproduct.setProductName(extcproduct.getProductName());
					eproduct.setProductNo(extcproduct.getProductNo());
					eproduct.setProductRequest(extcproduct.getProductRequest());
					eproduct.setSizeHeight(extcproduct.getSizeHeight());
					eproduct.setSizeLength(extcproduct.getSizeLength());
					eproduct.setSizeWidth(extcproduct.getSizeWidth());
					eproduct.setExPrice(extcproduct.getExPrice());
					eproduct.setTax(extcproduct.getTax());
					
					eproduct.setOrderNo(extcproduct.getOrderNo());
					
					eproduct.setExportProduct(eProduct);
					extEproductSet.add(eproduct);
				}
				
				eProduct.setExtEproduct(extEproductSet);
				
				exportProductSet.add(eProduct);
			}
			
			export.setContractIds(utilFuns.DelLastChar(contractIds));
			export.setCustomerContract(utilFuns.DelLastChar(customerContract));
			export.setExportProduct(exportProductSet);


			oDao.saveOrUpdate(export);


		return list();		
	}

	public String delete() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		String[] ids = request.getParameterValues("id");
		
		ExportDAO oDao = (ExportDAO)this.getDao("daoExport");
		oDao.deleteAllById(ids, Export.class);
		
		return list();
	}	
	
	//转向查看页面
	public String toview(){
		ExportDAO oDao = (ExportDAO) this.getDao("daoExport");
		Export obj  = (Export) oDao.get(Export.class, model.getId());
		ActionContext.getContext().getValueStack().push(obj);
		
		return "pview";
	}
	
	//转向修改页面
	public String toupdate(){
		HttpServletRequest request = ServletActionContext.getRequest();
		
		ExportDAO oDao = (ExportDAO) this.getDao("daoExport");
		Export obj  = (Export) oDao.get(Export.class, model.getId());
		ActionContext.getContext().getValueStack().push(obj);
		 
		//批量处理
		/*
		 * 1.拼接成js串，传到页面
		 * 2.动态执行js
		 * 3.动态添加信息到table
		 * */
		
		String id = request.getParameter("id");		//export id
		request.setAttribute("id",id);
		
		String hql = null;
		if(UtilFuns.isNotEmpty(id)){
			hql = "from ExportProduct o where o.export.id='"+id+"' order by o.orderNo";

			String productImage = "";
			StringBuffer sBuf = new StringBuffer();
			List aList = oDao.find(hql);
			if(UtilFuns.isNotEmpty(aList)) {
				for (int i = 0; i < aList.size(); i++) {
					ExportProduct ep = (ExportProduct)aList.get(i);
					
					sBuf.append("addTRRecord('resultTable',")
					.append("'").append(ep.getId()).append("',")
					.append("'").append(ep.getProductNo()).append("',")
					.append("'").append(ep.getCnumber()).append("',")
					.append("'").append(UtilFuns.convertNull(ep.getGrossWeight())).append("',")
					.append("'").append(UtilFuns.convertNull(ep.getNetWeight())).append("'")
					.append(");");					
				}
			}else{
				sBuf.append("addTRRecord('resultTable','','','','','');");
			}
			request.setAttribute("mrecordData", sBuf.toString());
		}		
		
		return "pupdate";

	}
	
	//保存
	public String save() throws Exception{
		ExportDAO oDao = (ExportDAO)this.getDao("daoExport");
		if(model.getId()==null){
			model.setState(0);	//新增时默认设置0=草稿
		}
		
		//批量保存ExportProduct
		HttpServletRequest request = ServletActionContext.getRequest();
		String[] mr_id = request.getParameterValues("mr_id");
		String[] mr_changed = request.getParameterValues("mr_changed");
		String[] ep_productNo = request.getParameterValues("ep_productNo");
		String[] ep_cnumber = request.getParameterValues("ep_cnumber");
		String[] ep_grossWeight = request.getParameterValues("ep_grossWeight");
		String[] ep_netWeight = request.getParameterValues("ep_netWeight");
		
		Set eSet = new HashSet();
		ExportProductDAO eDao = (ExportProductDAO)this.getDao("daoExportProduct");
		ExportProduct obj = null;
		int j=0;
		for(int i=0;i<ep_productNo.length;i++){
			if(mr_changed[i]!=null && !mr_changed[i].equals("")){
				obj = (ExportProduct) oDao.get(ExportProduct.class, mr_id[i]);
				obj.setProductNo(ep_productNo[i]);
				if(ep_cnumber[i]!=null && !ep_cnumber[i].equals("")){
					obj.setCnumber(Integer.parseInt(ep_cnumber[i]));
				}
				if(ep_grossWeight[i]!=null && !ep_grossWeight[i].equals("")){
					obj.setGrossWeight(new BigDecimal(ep_grossWeight[i]));
				}
				if(ep_netWeight[i]!=null && !ep_netWeight[i].equals("")){
					obj.setNetWeight(new BigDecimal(ep_netWeight[i]));
				}
				eSet.add(obj);
				System.out.println(j++);
			}
		}
		eDao.saveOrUpdateAll(eSet);		//批量提交
		
		oDao.saveOrUpdate(model);
		
		return list();
	}

}
