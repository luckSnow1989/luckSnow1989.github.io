<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title></title>
	<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../skin/default/css/default.css" media="all" />
	<script type="text/javascript" src="../../js/datepicker/WdatePicker.js"></script>
	<script type="text/javascript" src="../../js/common.js"></script>
	
</head>
<body>
<form name="icform" method="post">
	<input type="hidden" name="id" value="${id}">

<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="save"><a href="#" onclick="formSubmit('/baseinfo/textCodeAction_save','_self');this.blur();">保存</a></li>
<li id="back"><a href="#" onclick="formSubmit('/baseinfo/textCodeAction_list','_self');this.blur();">返回</a></li>
</ul>
    </div>
</div>
</div>
</div>
     
<div>
    <div class="textbox-header">
    <div class="textbox-inner-header">
    <div class="textbox-title">
修改代码
    </div> 
    </div>
    </div>

    <div>
		<table class="commonTable" cellspacing="1">
	        <tr>
	            <td class="columnTitle">分类：</td>
	            <td class="tableContent">
	            	<s:select name="classCode.id" list="classCodeList"
	            	  listKey="id" listValue="name"
	            	  headerKey="" headerValue="--请选择--"/>
				</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">名称：</td>
	            <td class="tableContent"><input type="text" name="name" value="${name}"/></td>
	        </tr>
		</table>
	</div>
</div>

 
</form>
</body>
</html>

