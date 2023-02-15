package com.zrgk.web.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.zrgk.dao.UserDao;
import com.zrgk.dao.UserDaoImpl;
import com.zrgk.entity.User;

public class User2Action extends ActionSupport {

	private String username;
	
	private Map dataMap=new HashMap();
	
	//{username:'a',dataMap:{list:[{},{},{},{}]}}
	
	//可以指定root  
	
	/*
	 * <result type="json">
              <param name="root">dataMap</param>
        </result>
	 * 
	 * 将只会把  dataMap转成json
	 * 
	 * {list:[{},{},{}]}
	 * */
	public Map getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map dataMap) {
		this.dataMap = dataMap;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String findUser() throws Exception {
		
        UserDao dao =  new UserDaoImpl();
		
		List<User> list = dao.findUserByName(username);
		
		
		dataMap.put("list",list);
		
		return SUCCESS;
	}
	
	@Override
	public String execute() throws Exception {

		
		return super.execute();
	}
}
