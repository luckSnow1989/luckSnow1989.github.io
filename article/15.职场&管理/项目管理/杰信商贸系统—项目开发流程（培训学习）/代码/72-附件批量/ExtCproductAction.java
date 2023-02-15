package cn.itcast.web.struts2.cargo.extcproduct;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import cn.itcast.entity.ContractProduct;
import cn.itcast.entity.ExtCproduct;
import cn.itcast.entity.Factory;
import cn.itcast.entity.dao.ContractProductDAO;
import cn.itcast.entity.dao.ExtCproductDAO;
import cn.itcast.entity.dao.FactoryDAO;
import cn.itcast.web.common.util.ComboList;
import cn.itcast.web.common.util.Convert;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.struts2._BaseStruts2Action;

public class ExtCproductAction extends _BaseStruts2Action {
	
	public String save(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("id");
		request.setAttribute("id",id);
		
		String _delIds = request.getParameter("delIds");
		String[] delIds = null;
		
		String[] mr_changed = request.getParameterValues("mr_changed");	//是否此条记录已经被修改 0否1是			
		String[] mr_id = request.getParameterValues("mr_id");
		
		String[] contractProductNo = request.getParameterValues("contractProductNo");
		//String[] productNo = request.getParameterValues("productNo");
		String[] ctype = request.getParameterValues("ctype");
		String[] productDesc = request.getParameterValues("productDesc");
		String[] productRequest = request.getParameterValues("productRequest");
		String[] factory = request.getParameterValues("factory");
		String[] packingUnit = request.getParameterValues("packingUnit");
		String[] cnumber = request.getParameterValues("cnumber");
		String[] price = request.getParameterValues("price");
		
		String[] orderNo = request.getParameterValues("orderNo");
		
		FactoryDAO fDao = (FactoryDAO) this.getDao("daoFactory");
		Factory fobj = null;
		
		BigDecimal bTotal = new BigDecimal(0);
		if(contractProductNo!=null){
			BigDecimal b1 = null;
			BigDecimal b2 = null;
			BigDecimal bAmount = null;
			
			ContractProductDAO cDao = (ContractProductDAO) this.getDao("daoContractProduct");
			ContractProduct cProduct = null;
			ExtCproductDAO oDao = (ExtCproductDAO) this.getDao("daoExtCproduct");
			ExtCproduct oProduct = null;
			
			Set<ExtCproduct> oSet = new HashSet<ExtCproduct>();
			
			for(int h = 0; h < orderNo.length; h++){
				if(UtilFuns.isNotEmpty(mr_id[h])){
					//不能判断，否则自动计算、排序功能将不正确。因为记录内容未改变，但排序顺序可能发生改变
//					if(!mr_changed[h].equals("1")){
//						continue;						//修改时,如果记录值用户未改变,则对此条记录不进行操作,以加快处理速度;
//					}
					oProduct = (ExtCproduct)oDao.get(ExtCproduct.class, mr_id[h]);
				}else{
					oProduct = new ExtCproduct();		//新增
				}
				
				cProduct = (ContractProduct)cDao.get(ContractProduct.class, contractProductNo[h]);
				oProduct.setContractProduct(cProduct);
				
				oProduct.setCtype(UtilFuns.parseInt(ctype[h]));
				oProduct.setProductNo(cProduct.getProductNo());		//附件名称就是对应货物的货号
				oProduct.setProductDesc(productDesc[h]);
				oProduct.setProductRequest(productRequest[h]);
				
				fobj = (Factory)fDao.get(Factory.class, factory[h]);
				oProduct.setFactory(fobj);
				oProduct.setPackingUnit(packingUnit[h]);
				if(UtilFuns.isNotEmpty(cnumber)){
					oProduct.setCnumber(UtilFuns.parseInt(cnumber[h]));
				}
				if(UtilFuns.isNotEmpty(price)){
					oProduct.setPrice(new BigDecimal(price[h]));
				}
				
				if(UtilFuns.isNotEmpty(cnumber[h]) && UtilFuns.isNotEmpty(price[h])){
					b1 = new BigDecimal(cnumber[h]);
					b2 = new BigDecimal(price[h]);
					bAmount = b1.multiply(b2);
					bTotal = bTotal.add(bAmount);
					oProduct.setAmount(bAmount);
				}
				oProduct.setOrderNo(Integer.parseInt(orderNo[h]));
				oSet.add(oProduct);
			}
			if(UtilFuns.isNotEmpty(_delIds)){
				delIds = UtilFuns.splitStr(_delIds, ",");
				oDao.deleteAllById(delIds, ExtCproduct.class);
			}
			
			oDao.saveOrUpdateAll(oSet);
			
		}
		return toedit();
	}
	
	public String toedit(){
		HttpServletRequest request = ServletActionContext.getRequest();
		ExtCproductDAO oDao = (ExtCproductDAO)super.getDao("daoExtCproduct");
		
		String id = request.getParameter("id");		//contract id
		request.setAttribute("id",id);
		
		String hql = null;
		Convert convert = new Convert();
		ComboList comboList = new ComboList();
		//获得某合同下的货物
		hql = "select o.id,o.productNo from ContractProduct o where o.contract.id='"+id+"' order by o.orderNo";
		List contractProductList = convert.toStringList(oDao.find(hql));
		request.setAttribute("contractProductComboList", comboList.combo(contractProductList, ""));

		//获取附件类型 
		hql = "select o.orderNo,o.name from SysCode o where o.state=1 and o.parentSysCode.id='0104' order by o.orderNo";		//0104为基础代码分类
		List extproductList = convert.toStringList(oDao.find(hql));
		request.setAttribute("extProductTypeComboList", comboList.combo(extproductList, ""));
		
		//获取ctype=2彩盒厂家
		hql = "select o.id,o.factoryName from Factory o where o.state=1 and o.ctype=1 order by o.factoryName";
		List factoryList = convert.toStringList(oDao.find(hql));
		request.setAttribute("factoryBoxComboList", comboList.combo(factoryList, ""));
		
		//获得货物的包装单位
		String[] packingUnit  = {"PCS","SETS"};
		request.setAttribute("clPackingUnit", comboList.combo(packingUnit, packingUnit, null));	//使value和text一样

		
		if(UtilFuns.isNotEmpty(id)){
			hql = "from ExtCproduct o where o.contractProduct.contract.id='"+id+"' order by o.orderNo";

			String productImage = "";
			StringBuffer sBuf = new StringBuffer();
			List aList = oDao.find(hql);
			if(UtilFuns.isNotEmpty(aList)) {
				for (int i = 0; i < aList.size(); i++) {
					ExtCproduct cp = (ExtCproduct)aList.get(i);
					productImage = cp.getProductImage();
					if(UtilFuns.isEmpty(productImage)){
						productImage = cp.getContractProduct().getProductImage();	//如果没有上传图片，就是合同货物对应的图片
					}
					
					sBuf.append("addTRRecord('resultTable',")
					.append("'").append(cp.getId()).append("',")
					.append("'").append(cp.getContractProduct().getId()).append("',")
					.append("'").append(cp.getCtype()).append("',")
					.append("'").append(cp.getProductNo()).append("',");
					if(UtilFuns.isNotEmpty(cp.getProductDesc())){
						sBuf.append("'").append(cp.getProductDesc().replaceAll("\r\n", "<br>")).append("',");
					}else{
						sBuf.append("'',");
					}
					if(UtilFuns.isNotEmpty(cp.getProductRequest())){
						sBuf.append("'").append(cp.getProductRequest().replaceAll("\r\n", "<br>")).append("',");
					}else{
						sBuf.append("'',");
					}
					sBuf.append("'").append(cp.getFactory().getId()).append("',")
					.append("'").append(cp.getPackingUnit()).append("',")
					.append("'").append(cp.getCnumber()).append("',")
					.append("'").append(cp.getPrice()).append("',")
					.append("'").append(productImage).append("'")
					.append(");");					
				}
			}else{
				sBuf.append("addTRRecord('resultTable','','','','','','','','','','','','','');");
			}
			request.setAttribute("mrecordData", sBuf.toString());
		}		
		return "pedit";
	}
	
}
