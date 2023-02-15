package com.zx.action;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.util.ServletContextAware;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zx.dao.UserDao;
import com.zx.dao.imp.UserDaoImpl;
import com.zx.entity.User;

public class UserAction extends ActionSupport implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private UserDao ud = new UserDaoImpl();
	
	private int id;
	private String name;
	private String password;
	private String brithday;
	
	public String login(){
		HttpServletRequest request = ServletActionContext.getRequest();			
		User user = ud.login(name, password);
		if(user == null){
			request.setAttribute("msg", "<span style='color:red;'>账号或密码错误</span>");
			this.addFieldError("msg", "<span style='color:red;'>账号或密码错误</span>");
			return ERROR;
		}
		request.setAttribute("user", user);
		return SUCCESS;
	}
	
	public String add(){
		HttpServletRequest request = ServletActionContext.getRequest();			
		System.out.println("#####增加用户####");
		System.out.println("name:" + name);
		System.out.println("password:" + password);
		System.out.println("brithday:" + brithday);
		System.out.println("###########");
		request.setAttribute("success", "添加成功");
		return SUCCESS;
	}
	
	public String error(){
		System.out.println("出现异常啦1");
		int a = 1/0;
		System.out.println("出现异常啦2");
		return SUCCESS;
	}
	//*封装页面的值 ,必须有setter/getter*/
	User user = new User();
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}

	/**
	 * 封装页面的值
	 * @return
	 */
	public String pack(){
		System.out.println(user);
		return SUCCESS;
	}
	
	
	@Override
	public void validate() {
		if(this.name == null || this.name.equals(this.name.trim()))
			addFieldError("msg", "用户不能为空");
		if(this.password == null || this.password.matches("\\d{3,6}"))
			addFieldError("msg", "密码必须是3~6位数字");
	}
	
	
	public void setId(int id) {
		this.id = id;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setBrithday(String brithday) {
		this.brithday = brithday;
	}
	
}
