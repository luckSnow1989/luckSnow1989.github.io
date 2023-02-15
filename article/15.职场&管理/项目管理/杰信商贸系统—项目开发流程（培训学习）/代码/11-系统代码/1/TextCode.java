package cn.itcast.entity;

import java.io.Serializable;

public class TextCode implements Serializable {
	private ClassCode classCode;
	public ClassCode getClassCode() {
		return classCode;
	}
	public void setClassCode(ClassCode classCode) {
		this.classCode = classCode;
	}
	private static final long serialVersionUID = 8172709319496000359L;
	
	private String id;
	private String name;
	
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
