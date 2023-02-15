<%@ page language="java" pageEncoding="UTF-8"%>
--标签区域--
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title></title>
 
--css、js区域--
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
--按钮区域--
<li id="new"><a href="#" onclick="formSubmit('/baseinfo/classCodeAction_tocreate','_self');this.blur();">新建</a></li>
<li id="update"><a href="#" onclick="formSubmit('/baseinfo/classCodeAction_toupdate','_self');this.blur();">修改</a></li>
<li id="delete"><a href="#" onclick="formSubmit('/baseinfo/classCodeAction_delete','_self');this.blur();">删除</a></li>
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
--标题区域--
    </div> 
    </div>
    </div>
</div>

--查询条--
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
 
--查询链接--
<input id="btnFind" type="button" name="btnFind" value="查询" onclick="formSubmit('/baseinfo/classCodeAction_list','_self');this.blur();">
<input type="button" name="btnReset" value="清空" onclick="findReset();this.blur();">
 
</div>
</fieldset>
</div>
</span>
    
<div>



--内容区域--
			 
	
--列表区域--
	<div class="eXtremeTable" >
	<table id="ec_table"  border="0"  cellspacing="0"  cellpadding="0"  class="tableRegion"  width="98%" >
		<thead>
		<tr>
			<td class="tableHeader"></td>
			<td class="tableHeader">编号</td>
			<td class="tableHeader">名称</td>
		</tr>
		</thead>
		<tbody class="tableBody" >
		
		<s:iterator value="#dataList" var="dl">
		<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
			<td><input type="radio" name="id" value="${id}"/></td>
			<td>${id}</td>
			<td>${name}</td>
		</tr>
		</s:iterator>
		
		</tbody>
	</table>
	</div>

</div>
 
 
</form>
</body>
</html>

