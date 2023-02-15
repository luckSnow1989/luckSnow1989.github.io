package com.project.entity;

public class Demand {
	private int demId;
	private String demName;
	private Project pro;
	public Demand() {}
	
	public Demand(int demId, String demName) {
		super();
		this.demId = demId;
		this.demName = demName;
	}
	
	public int getDemId() {
		return demId;
	}
	public void setDemId(int demId) {
		this.demId = demId;
	}
	public String getDemName() {
		return demName;
	}
	public void setDemName(String demName) {
		this.demName = demName;
	}
	public Project getPro() {
		return pro;
	}
	public void setPro(Project pro) {
		this.pro = pro;
	}
	
}
