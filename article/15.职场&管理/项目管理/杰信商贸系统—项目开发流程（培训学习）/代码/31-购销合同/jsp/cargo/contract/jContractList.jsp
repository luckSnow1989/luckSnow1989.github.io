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
<li id="view"><a href="#" onclick="formSubmit('/contract/contractAction_toview','_self');this.blur();">查看</a></li>
<li id="new"><a href="#" onclick="formSubmit('/contract/contractAction_tocreate','_self');this.blur();">新建</a></li>
<li id="update"><a href="#" onclick="formSubmit('/contract/contractAction_toupdate','_self');this.blur();">修改</a></li>
<li id="delete"><a href="#" onclick="formSubmit('/contract/contractAction_delete','_self');this.blur();">删除</a></li>
<li id="print"><a href="#" onclick="formSubmit('/contract/contractAction_print','_self');this.blur();">打印</a></li>
<li id="stat"><a href="#" onclick="formSubmit('/outproduct/outProductAction_toedit','_self');this.blur();">出货表</a></li>
<li id="new"><a href="#" onclick="formSubmit('/contract/contractAction_submit','_self');this.blur();">上报</a></li>
<li id="new"><a href="#" onclick="formSubmit('/contract/contractAction_cancelsubmit','_self');this.blur();">取消</a></li>
<li id="back"><a href="#" onclick="formSubmit('/contract/contractAction_copy','_self');this.blur();">复制</a></li>
<li id="stat"><a href="#" onclick="formSubmit('/export/exportAction_contractsave','_self');this.blur();">报运</a></li>
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
        <h2>购销合同列表</h2> 
    </div> 
    </div>
    </div>
	
 
 
<span class="noprint">
<div id="find_div" style="width:98%;">
<fieldset>
<legend><font color="000">查询条件&nbsp;</font></legend>
<div style="width:98%;padding-top:7px;text-align:left;">
 
类型：
<select name="f_type" style="width:130px;heigh:30px;">
${comboContentStr}
</select>
 
内容：	            	
<input type="text" name="f_conditionStr" value="${f_conditionStr}" size="30"
	onFocus="this.select();"
	onKeyDown="javascript:if(event.keyCode==13){ document.getElementById('btnFind').onclick(); }"
/>
 
<input id="btnFind" type="button" name="btnFind" value="查询" onclick="formSubmit('/contract/contractAction_list','_self');this.blur();">
<input type="button" name="btnReset" value="清空" onclick="findReset();this.blur();">
 
</div>
</fieldset>
</div>
</span>
 
 
    
<div>
	
			 
	
<div class="eXtremeTable" >
<table id="ec_table"  border="0"  cellspacing="0"  cellpadding="0"  class="tableRegion"  width="98%" >
	<thead>
	<tr>
		<td class="tableHeader"><input type="checkbox"  id="id_selector"  name="id_selector"  title="(Un)Select All"  onclick="for(i = 0; i < document.getElementsByName('id').length; i++)document.getElementsByName('id').item(i).checked=document.getElementById('id_selector').checked;" ></td>
		<td class="tableHeader">合同号</td>
		<td class="tableHeader">客户名称</td>
		<td class="tableHeader">交期</td>
		<td class="tableHeader">船期</td>
		<td class="tableHeader">签单日期</td>
		<td class="tableHeader">总金额</td>
		<td class="tableHeader">状态</td>
		<td class="tableHeader">操作</td>
	</tr>
	</thead>
	<tbody class="tableBody" >
	
	<s:iterator value="#dataList" var="cp">
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td><input type="checkbox" name="id" value="${id}"/></td>
		<td><a href="contractAction_toview?id=${id}">${contractNo}</a></td>
		<td>
		</td>
		<td>${customName}</td>
		<td><s:date name="deliveryPeriod" format="yyyy-MM-dd"/></td>
		<td><s:date name="shipTime" format="yyyy-MM-dd"/></td>
		<td><s:date name="signingDate" format="yyyy-MM-dd"/></td>
		<td>${totalAmount}</td>
		<td>
			<s:if test="state==0">草稿</s:if>
			<s:elseif test="state==1"><font color="green">已上报</font></s:elseif>
		</td>
		<td>
			<input type="button" name="btnAdd" value="添加货物"
				 onclick="formSubmit('/contract/contractProductAction_tocreate?contract.id=${id}','_self');">
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

