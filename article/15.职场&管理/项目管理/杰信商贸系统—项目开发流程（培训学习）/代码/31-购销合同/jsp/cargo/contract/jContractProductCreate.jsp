<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="selffn" uri="/WEB-INF/tlds/selffn.tld" %>

<!-- 告诉浏览器本网页符合XHTML1.0过渡型DOCTYPE -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
 
	<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../skin/default/css/default.css" media="all" />
	<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../css/extreme/extremecomponents.css" />
    <link rel="stylesheet" rev="stylesheet" type="text/css" href="../../css/extreme/extremesite.css" />
	<script type="text/javascript" src="../../js/common.js"></script>
    <script type="text/javascript" src="../../js/datepicker/WdatePicker.js"></script>
	
</head>
<body>
<s:form name="nuform">
	<input type="hidden" name="contract.id" value="${contract.id}"/>

<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="save"><a href="#" onclick="formSubmit('/contract/contractProductAction_save','_self');">确定</a></li>
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
      新增 购销合同货物信息
    </div> 
    </div>
    </div>
<div>
 
 
    <div>
		<table class="commonTable" cellspacing="1">
	        <tr>
	            <td class="columnTitle_mustbe">货物：</td>
	            <td class="tableContent"><input type="text" name="productNo"></td>
	            <td class="columnTitle">货物描述：</td>
	            <td class="tableContent">
	            <textarea name="productDesc" rows="3" cols="50"></textarea>
	            </td>
	        </tr>
	        <tr>
	            <td class="columnTitle">生产厂家：</td>
	            <td class="tableContent">
<s:select          
            list="factoryList" name="factory.id"
            listKey="id" listValue="factoryName"
            headerValue="--请选择--" headerKey=""
            emptyOption="false"
            />

				</td>
	            <td class="columnTitle">装率：</td>
	            <td class="tableContent"><input type="text" name="loadingRate" value=""></td>
	        </tr>
	        <tr>
	            <td class="columnTitle">数量：</td>
	            <td class="tableContent"><input type="text" name="cnumber" value=""></td>
	            <td class="columnTitle">包装单位：</td>
	            <td class="tableContent">
<select name="packingUnit">
<option value=''>--请选择--</option>
<option value='PCS'>PCS</option>
<option value='SETS'>SETS</option>
</select>				
				</td>
	        </tr>
	        <tr>
	            <td class="columnTitle_mustbe">箱数：</td>
	            <td class="tableContent"><input type="text" name="boxNum" value=""></td>
	            <td class="columnTitle" nowrap>单价：</td>
	            <td class="tableContent"><input type="text" name="price" value=""></td>
	        </tr>	        
		</table>
	</div>
</div>

     
<div class="textbox" id="centerTextbox">
    
    <div class="textbox-header">
    <div class="textbox-inner-header">
    <div class="textbox-title">
       购销合同货物列表信息
    </div> 
    </div>
    </div>
<div>

<div class="listTablew">
<table class="commonTable_main" cellSpacing="1" id="resultTable">
	<tr class="rowTitle" align="middle">
		<td width="33">序号</td>
		<td>货号</td>
		<td style="width:400px;">附件描述</td>
		<td>生产厂家</td>
		<td>数量</td>
		<td>单位</td>
		<td>单价</td>
		<td>总金额</td>
		<td nowrap>操作</td>
	</tr>
<s:iterator value="#dataList" var="cp" status="line">
	<tr>
		<td width="33"><s:property value="#line.index+1"/></td>
		<td>${cp.productNo}</td>
		<td style="width:400px;">${selffn:htmlNewline(cp.productDesc)}</td>
		<td>${cp.factory.factoryName}</td>
		<td>${cp.cnumber}</td>
		<td>${cp.packingUnit}</td>
		<td>${cp.price}</td>
		<td>${cp.amount}</td>
		<td>
			<input type="button" name="btnAdd" value="删除"
				 onclick="formSubmit('/contract/contractProductAction_delete?id=${cp.id}','_self');">
			<input type="button" name="btnAdd" value="添加附件"
				 onclick="formSubmit('/extcproduct/extCproductAction_tocreate?contractProduct.id=${id}','_self');">
		</td>
	</tr>
</s:iterator>	
</table>
</div>
 
</s:form>
</body>
</html>

