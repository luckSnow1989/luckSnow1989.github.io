<%@ page language="java" pageEncoding="UTF-8"%>

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
<form method="post">
 
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="print"><a href="outproduct(1).xls" target="_blank">打印</a></li>
 
	<li id="back">
		<a href="jContractList.jsp">返回</a>
	</li>
</ul>
    </div>
</div>
</div>
</div>
     
<div class="textbox" id="centerTextbox">
    
    <div class="textbox-header">
    <div class="textbox-inner-header">
    <div class="textbox-title">
       出货表
	</div> 
    </div>
    </div>
<div>
 
    <div>
		<table class="commonTable" cellspacing="1">
	        <tr>
	            <td class="columnTitle">统计年月：</td>
	            <td class="tableContent"><input type="text" style="width:90px;" name="inputDate"
	             value="2013-03"
	             onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM'});"/> </td>
	        </tr>
		</table>
	</div>
 
	 
	<div style="float:left;left:5px;top:138px;font-size:12px;color:gray;font-weight:normal;padding:12px;text-align:left;">
	       <div style="float:left;"><img style="margin:0 5px 0 0;" src="/skin/default/images/notice.gif" /></div>
	       <div style="float:left;padding-left:10px;">按船期进行月统计</div>
	</div>
</div>
 
 
</form>
</body>
</html>


