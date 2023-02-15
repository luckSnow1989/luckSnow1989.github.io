package com.zrgk.web.action;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.zrgk.dao.UserDao;
import com.zrgk.dao.UserDaoImpl;
import com.zrgk.entity.User;

public class UserAction extends ActionSupport {

	private String username;
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String findUser() throws Exception {
		
		UserDao dao =  new UserDaoImpl();
		
		List<User> list = dao.findUserByName(username);
		
		JSONObject json = new JSONObject();
		
		json.put("list", JSONArray.fromObject(list));
		
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		PrintWriter out  = response.getWriter();
				
		System.out.println(json.toString());
		
		out.print(json.toString());	
		
		return null;
	}
	
	@Override
	public String execute() throws Exception {

		
		return super.execute();
	}
}
