<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

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
<form method="post">
	<input type="hidden" name="contractProduct.id" value="${contractProduct.id}"/>

<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="save"><a href="#" onclick="formSubmit('/extcproduct/extCproductAction_save','_self');">确定</a></li>
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
      新增 货物附件信息 【货号：${contractProduct.productNo}】
      <input type="hidden" name="productNo" value="${productNo}"/>
    </div> 
    </div>
    </div>
<div>
 
 
    <div>
		<table class="commonTable" cellspacing="1">
	        <tr>
	            <td class="columnTitle_mustbe">附件类型：</td>
	            <td class="tableContent">
<select size="1" name="ctype">
<option value='' selected>--请选择--</option>
<option value='1'>彩盒</option>
<option value='2'>花纸</option>
<option value='3'>保丽龙</option>
<option value='4'>电镀</option>
<option value='5'>蜡</option>
<option value='6'>PVC</option>
<option value='7'>喷头</option>
<option value='8'>不锈钢勺子</option>
</select>
	            </td>
	            <td class="columnTitle">货物描述：</td>
	            <td class="tableContent"><textarea name="productDesc" rows="3" cols="50"></textarea></td>
	        </tr>
	        <tr>
	            <td class="columnTitle">要求：</td>
	            <td class="tableContent"><input type="text" name="productRequest"></td>
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
	            <td class="columnTitle">包装单位：</td>
	            <td class="tableContent">
<select size="1" name="packingUnit">
<option value=''>--请选择--</option>
<option value='PCS'>PCS</option>
<option value='SETS'>SETS</option>
</select>				
				</td>
	        </tr>	        
	        </tr>
	            <td class="columnTitle">数量：</td>
	            <td class="tableContent"><input type="text" name="cnumber" value=""></td>
	            <td class="columnTitle" nowrap>单价：</td>
	            <td class="tableContent"><input type="text" name="price" value=""></td>
	        <tr>
		</table>
	</div>
</div>

     
<div class="textbox" id="centerTextbox">
    
    <div class="textbox-header">
    <div class="textbox-inner-header">
    <div class="textbox-title">
       货物附件列表信息
    </div> 
    </div>
    </div>
<div>

<div class="listTablew">
<table class="commonTable_main" cellSpacing="1" id="resultTable">
	<tr class="rowTitle" align="middle">
		<td width="33">序号</td>
		<td>附件类型</td>
		<td>货物描述</td>
		<td>要求</td>
		<td>生产厂家</td>
		<td>包装单位</td>
		<td>数量</td>
		<td>单价</td>
		<td>操作</td>
	</tr>
	
	<s:iterator value="#dataList" var="ep" status="line">
		<tr height="30">

			<td align="center"><s:property value="#line.index+1"/></td>
			<td>${ep.ctype}</td>
			<td>${ep.productDesc}</td>
			<td>${ep.productRequest}</td>
			<td>${ep.factory.factoryName}</td>
			<td>${ep.packingUnit}</td>
			<td>${ep.cnumber}</td>
			<td>${ep.price}</td>
			<td>
				<input type="button" name="btnDel" value="删除"
					 onclick="formSubmit('/extcproduct/extCproductAction_delete?id=${ep.id}','_self');">
			</td>
		</tr>
	</s:iterator>
</table>
</div>
 
</form>
</body>
</html>

