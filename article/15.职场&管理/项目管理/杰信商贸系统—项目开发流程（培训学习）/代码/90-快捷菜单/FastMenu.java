package cn.itcast.entity;

import java.io.Serializable;

public class FastMenu implements Serializable {
	private java.lang.String id;
	public java.lang.String getId() {
		return id;
	}
	public void setId(java.lang.String id) {
		this.id = id;
	}
	public java.lang.String getName() {
		return name;
	}
	public void setName(java.lang.String name) {
		this.name = name;
	}
	public java.lang.String getCnname() {
		return cnname;
	}
	public void setCnname(java.lang.String cnname) {
		this.cnname = cnname;
	}
	public java.lang.String getCurl() {
		return curl;
	}
	public void setCurl(java.lang.String curl) {
		this.curl = curl;
	}
	public java.lang.Integer getClickNum() {
		return clickNum;
	}
	public void setClickNum(java.lang.Integer clickNum) {
		this.clickNum = clickNum;
	}
	public java.lang.String getBelongUser() {
		return belongUser;
	}
	public void setBelongUser(java.lang.String belongUser) {
		this.belongUser = belongUser;
	}
	public java.lang.String getCtype() {
		return ctype;
	}
	public void setCtype(java.lang.String ctype) {
		this.ctype = ctype;
	}
	private java.lang.String name;
	private java.lang.String cnname;
	private java.lang.String curl;
	private java.lang.Integer clickNum;
	private java.lang.String belongUser;
	private java.lang.String ctype;

}