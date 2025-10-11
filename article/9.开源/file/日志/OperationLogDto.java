package com.yooli.cbs.api.consumer.front.common;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Project: cbs-api
 * @Title: OperationLogDto
 * @Description: 前端操作日志拦截器
 * @author: xue.zhang
 * @date: 2018年9月10日上午9:49:19
 * @company: alibaba
 * @Copyright: Copyright (c) 2017
 * @version v1.0
 */
public class OperationLogDto implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private static final SimpleDateFormat strToDateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	
	/** 当前登录人 */
	private String loginName;
	
	/** 操作时间 */
	private String OperationTime;
	
	/** 请求的url, request.getRequestURI() */
	private String url;
	
	/** 模块编号 */
	private String moduleNo;

	/** 模块名称 */
	private String moduleName;

	/** 操作编号 */
	private String operateNo;

	/** 操作编号 */
	private String operateName;

	/** 案件号 */
	private String loanNo;
	
	/** 联系人电话 */
	private String tel;

	public OperationLogDto() {	
		this.OperationTime = strToDateFormatter.format(new Date());
	}

	public OperationLogDto(String loginName, String OperationTime, String url, String moduleNo, String moduleName,
			String operateNo, String operateName, String loanNo, String tel) {
		this.loginName = loginName;
		this.OperationTime = strToDateFormatter.format(new Date());
		this.url = url;
		this.moduleNo = moduleNo;
		this.moduleName = moduleName;
		this.operateNo = operateNo;
		this.operateName = operateName;
		this.loanNo = loanNo;
		this.tel = tel;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getOperationTime() {
		return OperationTime;
	}

	public void setOperationTime(String operationTime) {
		OperationTime = operationTime;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getLoanNo() {
		return loanNo;
	}

	public void setLoanNo(String loanNo) {
		this.loanNo = loanNo;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getModuleNo() {
		return moduleNo;
	}

	public void setModuleNo(String moduleNo) {
		this.moduleNo = moduleNo;
	}

	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}

	public String getOperateNo() {
		return operateNo;
	}

	public void setOperateNo(String operateNo) {
		this.operateNo = operateNo;
	}

	public String getOperateName() {
		return operateName;
	}

	public void setOperateName(String operateName) {
		this.operateName = operateName;
	}
	
	
	@Override
	public String toString() {
		return "loginName=" + loginName + ", OperationTime=" + OperationTime + ", url=" + url
				+ ", moduleNo=" + moduleNo + ", moduleName=" + moduleName + ", operateNo=" + operateNo
				+ ", operateName=" + operateName + ", loanNo=" + loanNo + ", tel=" + tel;
	}
}
