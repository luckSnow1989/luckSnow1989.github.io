<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!-- html标识扩展，定义名字空间 -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../skin/default/css/default.css" media="all" />
	<script type="text/javascript" src="../../js/common.js"></script>
	<script type="text/javascript" src="../../js/datepicker/WdatePicker.js"></script>
</head>

<body>
<form method="post">
	<input type="hidden" name="id" value="${id}"/>
	<input type="hidden" name="subid" value="${obj.id}"/>

<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="save"><a href="#" onclick="formSubmit('/finance/financeAction_save','_self');this.blur();">确定</a></li>
<li id="print"><a href="#" onclick="formSubmit('/finance/financeAction_print','_self');this.blur();">打印</a></li>
<li id="back"><a href="/packinglist/packingListAction_list">返回</a></li>
</ul>
    </div>
</div>
</div>
</div>
     
<div class="textbox" id="centerTextbox">
    
    <div class="textbox-header">
    <div class="textbox-inner-header">
    <div class="textbox-title">
       <s:if test="#request.obj==null">新增</s:if>
       <s:if test="#request.obj.id!=null">修改</s:if>
	        财务
	</div> 
    </div>
    </div>
<div>

    <div>
		<table class="commonTable" cellspacing="1">
	        <tr>
	            <td class="columnTitle">制单日期：</td>
	            <td class="tableContent"><input type="text" style="width:90px;" name="inputDate" dataType="日期" dispName="制单日期" value="<s:date name="inputDate" format="yyyy-MM-dd"/>" onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});"/> </td>
	        </tr>
	        <tr>
	            <td class="columnTitle" nowrap>制单人：</td>
	            <td class="tableContent"><input type="text" name="inputBy" value="${inputBy}" dataType="字符串" dispName="制单人" maxLength="30"></td>
	        </tr>
		</table>
	</div>
</div>


</form>
</body>
</html>
