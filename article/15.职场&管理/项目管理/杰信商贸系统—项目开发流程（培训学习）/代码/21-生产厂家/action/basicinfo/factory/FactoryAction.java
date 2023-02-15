package cn.itcast.web.struts2.basicinfo.factory;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import cn.itcast.entity.ClassCode;
import cn.itcast.entity.Factory;
import cn.itcast.entity.SysCode;
import cn.itcast.entity.dao.FactoryDAO;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.struts2._BaseStruts2Action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class FactoryAction extends _BaseStruts2Action implements ModelDriven<Factory> {
	private Factory model = new Factory();
	public Factory getModel() {
		return model;
	}
	
	public String list(){
		FactoryDAO oDao = (FactoryDAO) this.getDao("daoFactory");
		List<Factory> dataList = oDao.find("from Factory o");
		ActionContext.getContext().put("dataList", dataList);
		
		return "plist";
	}
	
	public String save(){
		FactoryDAO oDao = (FactoryDAO) this.getDao("daoFactory");
		if(UtilFuns.isEmpty(model.getId())){
			model.setState("1");
		}
		oDao.saveOrUpdate(model);
		
		return list();
	}
	
	public String deleteone(){
		FactoryDAO oDao = (FactoryDAO) this.getDao("daoFactory");
		oDao.delete(model.getId(), Factory.class);
		
		return list();
	}
	
	public String delete(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String[] ids = request.getParameterValues("id");
		
		if(ids!=null && ids.length>0){
			FactoryDAO oDao = (FactoryDAO) this.getDao("daoFactory");
			oDao.deleteAllById(ids, Factory.class);
		}
		
		return list();
	}
	
	public String tocreate(){
		FactoryDAO oDao = (FactoryDAO) this.getDao("daoFactory");
		//准备下拉列表
		List<SysCode> ctypeList = oDao.find("from SysCode t where t.classCode.id='0103'");
		ActionContext.getContext().put("ctypeList", ctypeList);
		
		return "pcreate";
	}
	
	public String toupdate(){
		FactoryDAO oDao = (FactoryDAO) this.getDao("daoFactory");
		Factory obj = (Factory) oDao.get(Factory.class, model.getId());
		ActionContext.getContext().getValueStack().push(obj);
		
		//准备下拉列表
		List<SysCode> ctypeList = oDao.find("from SysCode t where t.classCode.id='0103'");
		ActionContext.getContext().put("ctypeList", ctypeList);
		
		return "pupdate";
	}
	
	public String toview(){
		FactoryDAO oDao = (FactoryDAO) this.getDao("daoFactory");
		Factory obj = (Factory) oDao.get(Factory.class, model.getId());
		ActionContext.getContext().getValueStack().push(obj);
		
		return "pview";
	}
	
	public String begin(){
		this.state("1");		return list();
	}
	public String stop(){
		this.state("0");		return list();
	}
	private void state(String curValue){
		HttpServletRequest request = ServletActionContext.getRequest();
		String[] ids = request.getParameterValues("id");
		
		if(ids!=null && ids.length>0){
			Set oSet = new HashSet();
			FactoryDAO oDao = (FactoryDAO) this.getDao("daoFactory");
			Factory obj = null;
			for(int i=0;i<ids.length;i++){
				obj = (Factory) oDao.get(Factory.class, ids[i]);
				obj.setState(curValue);
				oSet.add(obj);
			}
			oDao.saveOrUpdateAll(oSet);
		}
	}
}
