package com.zx.entity;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable {
	
	private static final long serialVersionUID = -5671167113004047348L;

	private Integer id;
	
	private String name;
	
	private Date brithday;
	
	private String pwd;
	
	private String email;
	
	public User() {	}

	public User(Integer id, String name, Date brithday, String pwd, String email) {
		super();
		this.id = id;
		this.name = name;
		this.brithday = brithday;
		this.pwd = pwd;
		this.email = email;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getBrithday() {
		return brithday;
	}

	public void setBrithday(Date brithday) {
		this.brithday = brithday;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", brithday=" + brithday + ", pwd=" + pwd + ", email=" + email
				+ "]";
	}
	
}
