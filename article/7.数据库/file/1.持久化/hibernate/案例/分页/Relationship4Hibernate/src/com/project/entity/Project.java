package com.project.entity;

import java.util.HashSet;
import java.util.Set;

public class Project {
	private int proId ;
	private String proName;
	private Set<Demand> demSet = new HashSet<Demand>();
	
	public Project() {}
	
	public Project(int proId, String proName) {
		super();
		this.proId = proId;
		this.proName = proName;
	}
	
	public int getProId() {
		return proId;
	}
	public void setProId(int proId) {
		this.proId = proId;
	}
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	public Set<Demand> getDemSet() {
		return demSet;
	}
	public void setDemSet(Set<Demand> demSet) {
		this.demSet = demSet;
	}
	
}
