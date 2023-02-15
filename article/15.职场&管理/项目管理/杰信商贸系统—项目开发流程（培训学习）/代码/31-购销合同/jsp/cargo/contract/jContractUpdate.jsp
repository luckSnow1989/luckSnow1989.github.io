<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!-- 告诉浏览器本网页符合XHTML1.0过渡型DOCTYPE -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<title></title>
<style type="text/css" media=screen> 
 
#centerbox{
	position: absolute;
	border: 1px solid gray;
	left: expression((body.clientWidth-320)/2);
	top: expression(body.scrollTop+100);
	width: 320px;
	height: 240px;
	background: #FFF;
	display:none;
}
 
</style>
 
		<!-- 调用样式表 -->
		<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../skin/default/css/default.css" media="all" />
		<script type="text/javascript" src="../../js/common.js"></script>
		<script type="text/javascript" src="../../js/datepicker/WdatePicker.js"></script>
	</head>
 
	<body>
	
		<form method="post">
			<input type="hidden" name="id" value="${id}" />
 
			<div id="menubar">
				<div id="middleMenubar">
					<div id="innerMenubar">
						<div id="navMenubar">
<ul>
<li id="save"><a href="#" onclick="formSubmit('/contract/contractAction_save','_self');">确定</a></li>
<li id="back"><a href="/contract/contractAction_list">返回</a></li>
</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="textbox" id="centerTextbox">
 
				<div class="textbox-header">
					<div class="textbox-inner-header">
						<div class="textbox-title">
							修改购销合同信息
						</div>
					</div>
				</div>
				<div>
 
 
					<div>
						<table class="commonTable" cellspacing="1">
							<tr>
								<td class="columnTitle_mustbe">
									收&nbsp;购&nbsp;方：
								</td>
								<td class="tableContent">
									<input type="text" name="offeror" value="${offeror}" dataType="非空字符串" dispName="收购方" maxLength="200">
								</td>
								<td class="columnTitle">
									打印样式：
								</td>
								<td class="tableContentAuto">
									<input type="radio" name="printStyle" value="1" <s:if test="printStyle==1">checked</s:if> class="input">
									一个货物
									<input type="radio" name="printStyle" value="2" <s:if test="printStyle==2">checked</s:if> class="input">
									两个货物
								</td>
							</tr>
							<tr>
								<td class="columnTitle_mustbe">
									合&nbsp;同&nbsp;号：
								</td>
								<td class="tableContent">
									<input type="text" name="contractNo" value="${contractNo}" dataType="非空字符串" dispName="合同号" maxLength="30">
								</td>
								<td class="columnTitle_mustbe">
									签单日期：
								</td>
								<td class="tableContent">
									<input type="text" style="width: 90px;" name="signingDate"
										dataType="非空日期" dispName="签单日期"
										value="<s:date name="signingDate" format="yyyy-MM-dd"/>"
										onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});" />
								</td>
							</tr>
							<tr>
								<td class="columnTitle">
									制&nbsp;&nbsp;&nbsp;&nbsp;单：
								</td>
								<td class="tableContent">
									<input type="text" name="inputBy" value="${inputBy}" dataType="字符串" dispName="制单人" maxLength="30">
								</td>
								<td class="columnTitle">
									审&nbsp;&nbsp;&nbsp;&nbsp;单：
								</td>
								<td class="tableContent">
									<input type="text" name="checkBy" value="${checkBy}" dataType="字符串" dispName="审单人" maxLength="30">
								</td>
							</tr>
							<tr>
								<td class="columnTitle">
									验&nbsp;货&nbsp;员：
								</td>
								<td class="tableContent">
									<input type="text" name="inspector" value="${inspector}" dataType="字符串" dispName="验货员" maxLength="30">
								</td>
								<td class="columnTitle">
									要&nbsp;&nbsp;&nbsp;&nbsp;求：
								</td>
								<td class="tableContent">
									<input type="text" name="remark" value="${remark}" dataType="字符串" dispName="要求" maxLength="2000">
								</td>
							</tr>
							<tr>
								<td class="columnTitle">
									客户名称：
								</td>
								<td class="tableContent">
									<input type="text" name="customName" value="${customName}" dataType="字符串" dispName="客户名称" maxLength="200">
								</td>
								<td class="columnTitle_mustbe">
									船&nbsp;&nbsp;&nbsp;&nbsp;期：
								</td>
								<td class="tableContent">
									<input type="text" style="width: 90px;" name="shipTime"
										dataType="非空日期" dispName="船期"
										value="<s:date name="shipTime" format="yyyy-MM-dd"/>"
										onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});" />
								</td>
					        </tr>
					        <tr>
					            <td class="columnTitle" nowrap>贸易条款：</td>
					            <td class="tableContent"><input type="text" name="tradeTerms" value="${tradeTerms}" dataType="字符串" dispName="贸易条款" maxLength="30"></td>
					        </tr>
							<tr>
								<td class="columnTitle">
									重要程度：
								</td>
								<td class="normalTD">
									<input type="radio" name="importNum" value="1" class="input" <s:if test="importNum==1">checked</s:if>>
									★
									<input type="radio" name="importNum" value="2" class="input" <s:if test="importNum==2">checked</s:if>>
									★★
									<input type="radio" name="importNum" value="3" class="input" <s:if test="importNum==3">checked</s:if>>
									★★★
								</td>
								<td class="columnTitle_mustbe">
									交&nbsp;&nbsp;&nbsp;&nbsp;期：
								</td>
								<td class="tableContent">
									<input type="text" style="width: 90px;" name="deliveryPeriod"
										dataType="非空日期" dispName="交期"
										value="<s:date name="deliveryPeriod" format="yyyy-MM-dd"/>"
										onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});" />
								</td>
							</tr>
							<tr>
								<td colspan="6">
									<textarea name="request" dataType="字符串" dispName="要求" style="height: 105px;" class="textarea">${crequest}</textarea>
								</td>
							</tr>
						</table>
					</div>
				</div>
 
 
		</form>
	</body>
</html>

