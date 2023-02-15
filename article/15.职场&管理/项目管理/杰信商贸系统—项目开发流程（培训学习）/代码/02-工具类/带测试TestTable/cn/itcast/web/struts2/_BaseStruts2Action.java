package cn.itcast.web.struts2;

import cn.itcast.common.db.AppContext;
import com.opensymphony.xwork2.ActionSupport;

public class _BaseStruts2Action extends ActionSupport {
	public Object getDao(String dao){
		return AppContext.getInstance().getAppContext().getBean(dao);		//获取DAO对象
	}
	
	//统一查询框架
	public String f_conditionStr;			//用户输入的查询条件
	public String f_type;					//下拉框选择的当前值
	public String comboContentStr;			//下拉框option串
	
	public String getF_conditionStr() {
		return f_conditionStr;
	}
	public void setF_conditionStr(String fConditionStr) {
		f_conditionStr = fConditionStr;
	}
	public String getF_type() {
		return f_type;
	}
	public void setF_type(String fType) {
		f_type = fType;
	}
	public String getComboContentStr() {
		return comboContentStr;
	}
	public void setComboContentStr(String comboContentStr) {
		this.comboContentStr = comboContentStr;
	}
}
