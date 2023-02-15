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
<form>
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
 
<li id="save"><a href="#">确定</a></li>
<li id="save"><a href="#">暂存</a></li>
 
 
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
        新建购销合同信息
    </div> 
    </div>
    </div>
<div>
 
 
    <div>
		<table class="commonTable" cellspacing="1">
	        <tr>
	            <td class="columnTitle_mustbe">收&nbsp;购&nbsp;方：</td>
	            <td class="tableContent"><input type="text" name="offeror" value="杰信商贸有限公司" dataType="非空字符串" dispName="收购方" maxLength="200"></td>
	            <td class="columnTitle">打印样式：</td>
	            <td class="tableContentAuto">
					<input type="radio" name="printStyle" value="1"  class="input">一个货物
					<input type="radio" name="printStyle" value="2" checked class="input">两个货物
				</td>
	        </tr>
	        <tr>
	            <td class="columnTitle_mustbe">合&nbsp;同&nbsp;号：</td>
	            <td class="tableContent"><input type="text" name="contractNo" value="" dataType="非空字符串" dispName="合同号" maxLength="30"></td>
	            <td class="columnTitle_mustbe">签单日期：</td>
				<td class="tableContent">
					<input type="text" style="width:90px;" name="signingDate" dataType="非空日期" dispName="签单日期" value="2013-03-04" onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});"/> 
				</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">制&nbsp;&nbsp;&nbsp;&nbsp;单：</td>
	            <td class="tableContent"><input type="text" name="inputBy" value="演示" dataType="字符串" dispName="制单" maxLength="30"></td>
	            <td class="columnTitle">审&nbsp;&nbsp;&nbsp;&nbsp;单：</td>
	            <td class="tableContent"><input type="text" name="checkBy" value="" dataType="字符串" dispName="审单" maxLength="30"></td>
	        </tr>
	        <tr>
	            <td class="columnTitle">验&nbsp;货&nbsp;员：</td>
	            <td class="tableContent"><input type="text" name="inspector" value="" dataType="字符串" dispName="验货员" maxLength="30"></td>
	            <td class="columnTitle">要&nbsp;&nbsp;&nbsp;&nbsp;求：</td>
	            <td class="tableContent"><input type="text" name="remark" value="待样品确认后方可安排生产" dataType="字符串" dispName="要求" maxLength="2000"></td>
	        </tr>
	        <tr>
	            <td class="columnTitle">客户名称：</td>
	            <td class="tableContent"><input type="text" name="customName" value="" dataType="字符串" dispName="客户名称" maxLength="200"></td>
	            <td class="columnTitle_mustbe">船&nbsp;&nbsp;&nbsp;&nbsp;期：</td>
				<td class="tableContent">
					<input type="text" style="width:90px;" name="shipTime" dataType="非空日期" dispName="船期" value="2013-03-04" onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});"/> 
				</td>
	        </tr>
	        <tr>
	            <td class="columnTitle" nowrap>贸易条款：</td>
	            <td class="tableContent"><input type="text" name="tradeTerms" value="" dataType="字符串" dispName="贸易条款" maxLength="30"></td>
	        </tr>	        
	        <tr>
	            <td class="columnTitle">重要程度：</td>
	            <td class="normalTD">
	            	<input type="radio" name="importNum" value="1" class="input">★
	            	<input type="radio" name="importNum" value="2" class="input">★★
	            	<input type="radio" name="importNum" value="3" class="input" checked>★★★
				</td>
	            <td class="columnTitle_mustbe">交&nbsp;&nbsp;&nbsp;&nbsp;期：</td>
				<td class="tableContent">
					<input type="text" style="width:90px;" name="deliveryPeriod" readonly dataType="非空日期" dispName="交期" value="2013-03-04" onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});"/> 
				</td>
	        </tr>
	        <tr>
	            <td colspan="6">
	            	<textarea name="request" dataType="字符串" dispName="要求" style="height:105px;" class="textarea">
  ★   产品与封样无明显差异，唛头、标签及包装质量务必符合公司要求。 
 ★★  产品生产前期、中期、后期抽验率不得少于10%，质量和封样一致， 
       并将验货照片传回公司。 
★★★ 重点客人的质量标准检验，产品抽验率不得少于50%，务必做到入箱前检查。 
 交期：deliveryPeriod/工厂。 
       没有经过我司同意无故延期交货造成严重后果的，按照客人的相关要求处理。 
 开票：出货后请将增值税发票、验货报告、合同复印件及出库单一并寄至我司，以便我司安排付款。
</textarea>
	            </td>
			</tr>
		</table>
	</div>
</div>
 
 
</form>
</body>
</html>

