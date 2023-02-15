<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/WEB-INF/tlds/selffn.tld" prefix="selffn"%>

<!-- 告诉浏览器本网页符合XHTML1.0过渡型DOCTYPE -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../skin/default/css/default.css" media="all" />
	<script type="text/javascript" src="../../js/common.js"></script>
	
<style> 
	.product_image{ margin:5px;border:1px solid black;height:100px;weight:80px; }
</style>	
</head>
 
<body>
<form method="post">
 
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
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
        浏览购销合同信息
       &nbsp;&nbsp;&nbsp;
 
	</div> 
    </div>
    </div>
<div>
 
    <div>
		<table class="commonTable" cellspacing="1">
	        <tr>
	            <td class="columnTitle">收&nbsp;购&nbsp;方：</td>
	            <td class="tableContent">${offeror}</td>
	            <td class="columnTitle">打印样式：</td>
	            <td class="tableContent">${printStyle}个货物</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">合&nbsp;同&nbsp;号：</td>
	            <td class="tableContent">${contractNo}</td>
	            <td class="columnTitle">签单日期：</td>
				<td class="tableContent"><s:date name="signingDate" format="yyyy-MM-dd"/></td>
	        </tr>
	        <tr>
	            <td class="columnTitle">制&nbsp;&nbsp;&nbsp;&nbsp;单：</td>
	            <td class="tableContent">${inputBy}</td>
	            <td class="columnTitle">总&nbsp;金&nbsp;额：</td>
	            <td class="tableContent">${totalAmount}</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">审&nbsp;&nbsp;&nbsp;&nbsp;单：</td>
	            <td class="tableContent">${checkBy}</td>
	            <td class="columnTitle">验&nbsp;货&nbsp;员：</td>
	            <td class="tableContent">${inspector}</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">客户名称：</td>
	            <td class="tableContent">${customName}</td>
	            <td class="columnTitle">船&nbsp;&nbsp;&nbsp;&nbsp;期：</td>
	            <td class="tableContent"><s:date name="shipTime" format="yyyy-MM-dd"/></td>
	        </tr>
	        <tr>
	            <td class="columnTitle">交&nbsp;&nbsp;&nbsp;&nbsp;期：</td>
				<td class="tableContent"><s:date name="deliveryPeriod" format="yyyy-MM-dd"/></td>
	            <td class="columnTitle">要&nbsp;&nbsp;&nbsp;&nbsp;求：</td>
	            <td class="tableContent">${remark}</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">贸易条款：</td>
				<td class="tableContent">${tradeTerms}</td>
	            <td class="columnTitle">&nbsp;</td>
	            <td class="tableContent">&nbsp;</td>
	        </tr>
	        <tr>
	            <td colspan="4" style="padding:20px;">${selffn:htmlNewline(crequest)}</td>
			</tr>
		</table>
	</div>
</div>
 
<!-- 货物列表 -->
<div class="textbox" id="centerTextbox">
    
    <div class="textbox-header">
    <div class="textbox-inner-header">
    <div class="textbox-title">
        货物信息
    </div> 
    </div>
    </div>
</div>
 
<div class="listTablew">
<table class="commonTable_main" cellSpacing="1" id="resultTable">
	<tr class="rowTitle" align="middle">
		<td width="33">序号</td>
		<td>货号</td>
		<td>货物描述</td>
		<td>厂家</td>
		
		<td>数量</td>
		<td>单位</td>
		<td>箱数</td>
		<td>单价</td>
		<td>总金额</td>
	</tr>
	
	<s:iterator value="%{#root.contractProduct}" var="cp" status="line">
		<tr height="30">
			<td align="center"><s:property value="#line.index+1"/></td>
			<td>${cp.productNo}</td>
			<td width="400">${cp.productDesc}</td>
			<td>${cp.factory.factoryName}</td>
			<td>${cp.cnumber}/${cp.outNumber}</td>
			<td>${cp.packingUnit}</td>
			<td>${cp.boxNum}</td>
			<td>${cp.price}</td>
			<td>${cp.amount}</td>
		</tr>
	<s:iterator value="%{#cp.extCproduct}" var="ep" status="line">
		<tr height="30">
			<td align="center"></td>
			<td><font color="blue">附件<s:property value="#line.index+1"/>: </font>${cp.productNo}</td>
			<td>${selffn:htmlNewline(ep.productDesc)}</td>
			<td>${ep.factory.factoryName}</td>
			<td>${ep.cnumber}</td>
			<td>${ep.packingUnit}</td>
			<td></td>
			<td>${ep.price}</td>
			<td>${ep.amount}</td>
		</tr>
	</s:iterator>
	</s:iterator>
</table>
</div>
 
 
 
 
</form>
</body>
</html>

