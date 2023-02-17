package com.project.entity;

import java.util.List;

public class Page {
	private Integer currentPage;//当前页数
	private Integer totalPage;//总页数
	private Integer countInfo;//信息总条数
	//每页显示的条数在一个工具类中；public final static Integer NUM_PER_PAGE = 3;
	private List list;//用于存储数据
	
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public Integer getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
	public Integer getCountInfo() {
		return countInfo;
	}
	public void setCountInfo(Integer countInfo) {
		this.countInfo = countInfo;
	}
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}
}
