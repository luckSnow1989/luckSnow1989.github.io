package cn.itcast.entity;

public class Finance {
	private java.lang.String id;
	private java.lang.String inputBy;
	private java.util.Date inputDate;
	private java.lang.String createBy;
	private java.lang.String createDept;
	private java.util.Date createTime;
	private PackingList packingList;
	public java.lang.String getId() {
		return id;
	}
	public void setId(java.lang.String id) {
		this.id = id;
	}
	public java.lang.String getInputBy() {
		return inputBy;
	}
	public void setInputBy(java.lang.String inputBy) {
		this.inputBy = inputBy;
	}
	public java.util.Date getInputDate() {
		return inputDate;
	}
	public void setInputDate(java.util.Date inputDate) {
		this.inputDate = inputDate;
	}
	public java.lang.String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(java.lang.String createBy) {
		this.createBy = createBy;
	}
	public java.lang.String getCreateDept() {
		return createDept;
	}
	public void setCreateDept(java.lang.String createDept) {
		this.createDept = createDept;
	}
	public java.util.Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(java.util.Date createTime) {
		this.createTime = createTime;
	}
	public PackingList getPackingList() {
		return packingList;
	}
	public void setPackingList(PackingList packingList) {
		this.packingList = packingList;
	}
}
