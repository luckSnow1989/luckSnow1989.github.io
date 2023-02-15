package cn.itcast.web.struts2.cargo.packinglist;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

import cn.itcast.entity.Export;
import cn.itcast.entity.PackingList;
import cn.itcast.entity.dao.ExportDAO;
import cn.itcast.entity.dao.PackingListDAO;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.print.PackingListPrint;
import cn.itcast.web.struts2._BaseStruts2Action;

public class PackingListAction extends _BaseStruts2Action implements ModelDriven<PackingList>{
	private PackingList model = new PackingList();
	public PackingList getModel() {
		return model;
	}
	
	//转向新增页面
	public String tocreate(){
		//如果由报运转入
		HttpServletRequest request = ServletActionContext.getRequest();
		String[] exportIds = request.getParameterValues("id");
		
		if(UtilFuns.isNotEmpty(exportIds)){
			String[] customerContracts = exportIds.clone();						//构造同样大小的数组
			ExportDAO eDao = (ExportDAO)super.getDao("daoExport");	
			Export export = null;
			
			//得到报运所对应的客户号
			for(int i=0;i<exportIds.length;i++){
				export = (Export)eDao.get(Export.class, exportIds[i]);
				customerContracts[i] = export.getCustomerContract();			//客户号
			}
			StringBuffer sBuf = new StringBuffer();
			if(exportIds!=null){
				for(int i=0;i<exportIds.length;i++){
					sBuf.append("<div style=\"float:left;width:150px;padding:5px;\">");
					sBuf.append("<input type=\"checkbox\" name=\"contractId\" value=\"").append(exportIds[i]).append("|").append(customerContracts[i]).append("\" checked class=\"input\">");
					sBuf.append(customerContracts[i].replaceAll("%23", "#"));
					sBuf.append("</div>");
				}
				request.setAttribute("mrecordData", sBuf.toString());
			}
		}
		
		return "pcreate";
	}
	
	public String save() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		PackingListDAO oDao = (PackingListDAO)this.getDao("daoPackingList");
		
		String[] contractId = request.getParameterValues("contractId");			//页面传入的报运ID
		String[] _temp = null;
		StringBuffer exportIds = new StringBuffer();
		StringBuffer exportNos = new StringBuffer();
		
		String s = "";
		
		if(UtilFuns.isNotEmpty(contractId)){
			for(int i = 0;i<contractId.length;i++){
				_temp = UtilFuns.splitStr(contractId[i], "|");						//利用checkbox存储2个值，1为ID，2为客户号
				exportIds.append(_temp[0]).append("|");
				exportNos.append(_temp[1].replaceAll("#", "%23")).append("|");		//兼容旧版本，旧版本中用#分割，但影响Oracle下SQL的解析。转换#，其会影响html页面，造成页面混乱
			}
		}

		model.setExportIds(UtilFuns.DelLastChar(exportIds.toString()));
		model.setExportNos(UtilFuns.DelLastChar(exportNos.toString()));
		
		model.setInvoiceNo(model.getInvoiceNo().toUpperCase());						//转大写
		
		oDao.saveOrUpdate(model);
		
		return list();
	}

	public String list() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		PackingListDAO oDao = (PackingListDAO)this.getDao("daoPackingList");
		
		UtilFuns utilFuns = new UtilFuns();
		
		String[] aConditionStr = utilFuns.splitFindStr(f_conditionStr);

		//传递到页面的查询参数
		String[] typeContext = {"seller","buyer","marks"};
		String[] typeValue = {"卖方","买方","唛头"};
		comboContentStr = utilFuns.ComboList(f_type,typeContext,typeValue);

		StringBuffer hql = new StringBuffer();
		hql.append("from PackingList o where 1=1");
		
		List paraList = new ArrayList();
		int j=0;j=0;
		
		if (UtilFuns.isNotEmpty(f_conditionStr)) {
			for(int i=0;i<aConditionStr.length;i++){
				if (UtilFuns.isNotEmpty(f_type)) {
					hql.append(" and o.").append(f_type).append(" like ?");
					paraList.add("%" + aConditionStr[i] + "%");
				}else{
					hql.append(" and (");
					for(j=0;j<typeContext.length;j++){
						hql.append("o.").append(typeContext[j]).append(" like ? or ");
						paraList.add("%" + aConditionStr[i] + "%");
					}
					hql.delete(hql.length()-3, hql.length());	//del last ' or'
					hql.append(")");
				}
			}
		}
		
		hql.append( " order by o.createTime desc");
		
		List<PackingList> dataList = oDao.find(hql.toString(), paraList.toArray());
		ActionContext.getContext().put("dataList", dataList);
		
		return "plist";
	}
	
	
	//批量删除
	public String delete() throws Exception{
		String[] ids = model.getId().replace(" ", "").split(",");
		PackingListDAO oDao = (PackingListDAO) this.getDao("daoPackingList");
		oDao.deleteAllById(ids, PackingList.class);

		return list();
	}	
	
	//转向修改页面
	public String toupdate(){
		HttpServletRequest request = ServletActionContext.getRequest();
		PackingListDAO oDao = (PackingListDAO)this.getDao("daoPackingList");
		PackingList obj = (PackingList)oDao.get(PackingList.class, model.getId());
		ActionContext.getContext().getValueStack().push(obj);

		//组织html串
		String[] exportIds = UtilFuns.splitStr(obj.getExportIds(),"|");
		String[] exportNos = UtilFuns.splitStr(obj.getExportNos(),"|");
		
		StringBuffer sBuf = new StringBuffer();
		if(exportIds!=null){
			for(int i=0;i<exportIds.length;i++){
				sBuf.append("<div style=\"float:left;width:150px;padding:5px;\">");
				sBuf.append("<input type=\"checkbox\" name=\"contractId\" value=\"").append(exportIds[i]).append("|").append(exportNos[i]).append("\" checked class=\"input\">");
				sBuf.append(exportNos[i].replaceAll("%23", "#"));
				sBuf.append("</div>");
			}
			request.setAttribute("mrecordData", sBuf.toString());
		}
		
		return "pupdate";
	}
	
	
	//转向浏览页面
	public String toview(){
		HttpServletRequest request = ServletActionContext.getRequest();
		PackingListDAO oDao = (PackingListDAO)this.getDao("daoPackingList");
		PackingList obj = (PackingList)oDao.get(PackingList.class, model.getId());
		ActionContext.getContext().getValueStack().push(obj);

		String[] exportIds = UtilFuns.splitStr(obj.getExportIds(),"|");
		String[] exportNos = UtilFuns.splitStr(obj.getExportNos(),"|");
		
		//拼接HTML
		StringBuffer sBuf = new StringBuffer();
		if(exportIds!=null){
			for(int i=0;i<exportIds.length;i++){
				sBuf.append("<div style=\"float:left;width:150px;padding:5px;\">");
				sBuf.append(exportNos[i]);
				sBuf.append("</div>");
			}
			request.setAttribute("mrecordData", sBuf.toString());
		}
		
		return "pview";
	}

	//打印
	public void print() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		PackingListDAO oDao = (PackingListDAO) this.getDao("daoPackingList");
		ExportDAO eDao = (ExportDAO) this.getDao("daoExport");
		
		PackingListPrint packingListPrint = new PackingListPrint();
		packingListPrint.print(request, response, oDao, eDao);
	}
}


