package cn.itcast.entity;

public class Invoice {
	private java.lang.String id;
	private java.lang.String scNo;
	private java.lang.String blNo;
	private java.lang.String tradeTerms;
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
	public java.lang.String getScNo() {
		return scNo;
	}
	public void setScNo(java.lang.String scNo) {
		this.scNo = scNo;
	}
	public java.lang.String getBlNo() {
		return blNo;
	}
	public void setBlNo(java.lang.String blNo) {
		this.blNo = blNo;
	}
	public java.lang.String getTradeTerms() {
		return tradeTerms;
	}
	public void setTradeTerms(java.lang.String tradeTerms) {
		this.tradeTerms = tradeTerms;
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
