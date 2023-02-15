package cn.itcast.web.struts2.baseinfo.classcode;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import cn.itcast.entity.ClassCode;
import cn.itcast.entity.dao.ClassCodeDAO;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.struts2._BaseStruts2Action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.util.ValueStack;

public class ClassCodeAction extends _BaseStruts2Action implements ModelDriven<ClassCode> {
	private ClassCode model = new ClassCode();
	public ClassCode getModel() {
		return model;
	}
	
	public String list(){
		ClassCodeDAO oDao = (ClassCodeDAO) this.getDao("daoClassCode");
		List<ClassCode> dataList = oDao.find("from ClassCode o");
		ActionContext.getContext().put("dataList", dataList);
		
		return "plist";
	}
	
	public String save(){
		ClassCodeDAO oDao = (ClassCodeDAO) this.getDao("daoClassCode");
		oDao.saveOrUpdate(model);
		
		return list();
	}
	
	public String deleteone(){
		ClassCodeDAO oDao = (ClassCodeDAO) this.getDao("daoClassCode");
		oDao.delete(model.getId(), ClassCode.class);
		
		return list();
	}
	
	public String delete(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String[] ids = request.getParameterValues("id");
		
		if(ids!=null && ids.length>0){
			ClassCodeDAO oDao = (ClassCodeDAO) this.getDao("daoClassCode");
			oDao.deleteAllById(ids, ClassCode.class);
		}
		
		return list();
	}
	
	public String tocreate(){
		return "pcreate";
	}
	
	public String toupdate(){
		ClassCodeDAO oDao = (ClassCodeDAO) this.getDao("daoClassCode");
		ClassCode obj = (ClassCode) oDao.get(ClassCode.class, model.getId());
		ActionContext.getContext().getValueStack().push(obj);
		
		return "pupdate";
	}
}
