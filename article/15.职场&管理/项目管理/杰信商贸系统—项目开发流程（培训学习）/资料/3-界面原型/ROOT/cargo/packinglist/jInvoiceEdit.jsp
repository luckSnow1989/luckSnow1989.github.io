<%@ page language="java" pageEncoding="UTF-8"%>

<!-- 告诉浏览器本网页符合XHTML1.0过渡型DOCTYPE -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../css/extreme/extremecomponents.css" />
<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../css/extreme/extremesite.css" />
<script type="text/javascript" src="../../js/common.js"></script>
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../skin/default/css/default.css" media="all" />
	<script type="text/javascript" src="../../js/datepicker/WdatePicker.js"></script>
 
	<script language="JavaScript">
   		function preSubmit(serviceName) {
	        if(serviceName=="返回"){
	            return true;
	        } else if (serviceName=="确定"){
	            return _CheckAll(true,serviceName);
	        }
	    }
	</script>
</head>
 
<body>
<form method="post">
	<input type="hidden" name="id" value="4028817a3579c83e01357a6fd7e2000d"/>
	<input type="hidden" name="subid" value="4028817a3579c83e01357a6fd7e2000d"/>
 
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="save"><a href="#">确定</a></li>
<li id="print"><a href="invoice.xls" target="_blank">打印</a></li>
 
	<li id="back">
		<a href="jPackingListList.jsp">返回</a>
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
       修改发票
       &nbsp;&nbsp;&nbsp;
 
	</div> 
    </div>
    </div>
<div>
 
    <div>
		<table class="commonTable" cellspacing="1">
	        <tr>
	            <td class="columnTitle">B/L No.：</td>
	            <td class="tableContent"><input type="text" name="blno" value="" dataType="字符串" dispName="B/L No." maxLength="30"></td>
	        </tr>
	        <tr>
	            <td class="columnTitle" nowrap>贸易条款：</td>
	            <td class="tableContent"><input type="text" name="tradeTerms" value="FCA XINGANG" dataType="字符串" dispName="贸易条款" maxLength="30"></td>
	        </tr>
		</table>
	</div>
</div>
 
 
</form>
</body>
</html>



