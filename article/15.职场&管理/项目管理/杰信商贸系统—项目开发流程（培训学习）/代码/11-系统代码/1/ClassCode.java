package cn.itcast.entity;

import java.util.Set;

public class ClassCode {
	private Set<SysCode> sysCode;
	private String id;
	private String name;
	public Set<SysCode> getSysCode() {
		return sysCode;
	}
	public void setSysCode(Set<SysCode> sysCode) {
		this.sysCode = sysCode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

}
