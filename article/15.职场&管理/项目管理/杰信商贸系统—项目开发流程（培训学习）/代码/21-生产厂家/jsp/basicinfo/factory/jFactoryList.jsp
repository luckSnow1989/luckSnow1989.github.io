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
</head>
 
<body>
<form name="icform" method="post">

<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="view"><a href="#" onclick="formSubmit('/basicinfo/factoryAction_toview','_self');this.blur();">查看</a></li>
<li id="new"><a href="#" onclick="formSubmit('/basicinfo/factoryAction_tocreate','_self');this.blur();">新建</a></li>
<li id="update"><a href="#" onclick="formSubmit('/basicinfo/factoryAction_toupdate','_self');this.blur();">修改</a></li>
<li id="delete"><a href="#" onclick="formSubmit('/basicinfo/factoryAction_delete','_self');this.blur();">删除</a></li>
<li id="new"><a href="#" onclick="formSubmit('/basicinfo/factoryAction_begin','_self');this.blur();">启用</a></li>
<li id="new"><a href="#" onclick="formSubmit('/basicinfo/factoryAction_stop','_self');this.blur();">停止</a></li>
 
</ul>
    </div>
</div>
</div>
</div>
     
<!-- 页面主体部分（列表等） -->    
<div class="textbox" id="centerTextbox">
    <div class="textbox-header">
    <div class="textbox-inner-header">
    <div class="textbox-title">
        <h2>生产厂家列表</h2> 
    </div> 
    </div>
    </div>
    
<div>
	
			 
	
<div class="eXtremeTable" >
<table id="ec_table"  border="0"  cellspacing="0"  cellpadding="0"  class="tableRegion"  width="98%" >
	<thead>
	<tr>
		<td class="tableHeader"><input type="checkbox"  id="id_selector"  name="id_selector"  title="(Un)Select All"></td>
		<td class="tableHeader">序号</td>
		<td class="tableHeader">厂家全称</td>
		<td class="tableHeader">缩写</td>
		<td class="tableHeader">联系人</td>
		<td class="tableHeader">电话</td>
		<td class="tableHeader">手机</td>
		<td class="tableHeader">说明</td>
		<td class="tableHeader">类型</td>
		<td class="tableHeader">验货员</td>
		<td class="tableHeader">状态</td>
	</tr>
	</thead>
	<tbody class="tableBody" >
	
	<s:iterator value="#dataList" var="cp">
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td><input type="checkbox" name="id" value="${id}"/></td>
		<td></td>
		<td><a href="factoryAction_toview?id=${id}">${fullName}</a></td>
		<td>${factoryName}</td>
		<td>${contactor}</td>
		<td>${phone}</td>
		<td>${mobile}</td>
		<td>${cnote}</td>
		<td>${inspector}</td>
		<td>
			<s:if test="state==0">停止</s:if>
			<s:elseif test="state==1"><font color="green">正常</font></s:elseif>
		</td>
	</tr>
	</s:iterator>
	
	</tbody>
</table>
</div>
 
</div>
 
 
</form>
</body>
</html>

