<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!-- 告诉浏览器本网页符合XHTML1.0过渡型DOCTYPE -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
 
	<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../skin/default/css/default.css" media="all" />
	<script type="text/javascript" src="../../js/common.js"></script>
    <script type="text/javascript" src="../../js/datepicker/WdatePicker.js"></script>
	
</head>
<body>
<form>
	<input type="hidden" name="id" value="${id}"/>
	<input type="hidden" name="state" value="${state}"/>

<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="save"><a href="#" onclick="formSubmit('/basicinfo/factoryAction_save','_self');">确定</a></li>
<li id="back"><a href="/basicinfo/factoryAction_list">返回</a></li>
</ul>
    </div>
</div>
</div>
</div>
     
<div class="textbox" id="centerTextbox">
    
    <div class="textbox-header">
    <div class="textbox-inner-header">
    <div class="textbox-title">
       	修改生产厂家信息
    </div> 
    </div>
    </div>
<div>
 
 
    <div>
		<table class="commonTable" cellspacing="1">
	        <tr>
	            <td class="columnTitle_mustbe">厂家名称：</td>
	            <td class="tableContent"><s:textfield name="fullName"/></td>
	            <td class="columnTitle">缩写：</td>
	            <td class="tableContent"><s:textfield name="factoryName"/></td>
	        </tr>
	        <tr>
	            <td class="columnTitle_mustbe">联系人：</td>
	            <td class="tableContent"><s:textfield name="contactor"/></td>
	            <td class="columnTitle_mustbe">电话：</td>
				<td class="tableContent"><s:textfield name="phone"/></td>
	        </tr>
	        <tr>
	            <td class="columnTitle">手机：</td>
	            <td class="tableContent"><s:textfield name="mobile"/></td>
	            <td class="columnTitle">传真：</td>
	            <td class="tableContent"><s:textfield name="fax"/></td>
	        </tr>
	        <tr>
	            <td class="columnTitle">说明：</td>
	            <td class="tableContent"><s:textfield name="cnote"/></td>
	            <td class="columnTitle">验货员：</td>
	            <td class="tableContent"><s:textfield name="inspector"/></td>
	        </tr>
	        <tr>
	            <td class="columnTitle">类型：</td>
	            <td class="tableContent">
	            <s:select list="ctypeList" listKey="id" listValue="name" name="ctype" headerKey="" headerValue="--请选择--"></s:select>
				</td>
	        </tr>
		</table>
	</div>
</div>
 
 
</form>
</body>
</html>

