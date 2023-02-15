<%@ page language="java" pageEncoding="UTF-8"%>

<!-- 告诉浏览器本网页符合XHTML1.0过渡型DOCTYPE -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../css/extreme/extremecomponents.css" />
<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../css/extreme/extremesite.css" />
<script type="text/javascript" src="../../js/common.js"></script>
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<title></title>
<style type="text/css" media=screen> 
 
#centerbox{
	position: absolute;
	border: 1px solid gray;
	left: expression((body.clientWidth-320)/2);
	top: expression(body.scrollTop+100);
	width: 320px;
	height: 240px;
	background: #FFF;
	display:none;
}
 
</style>
 
		<!-- 调用样式表 -->
		<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../skin/default/css/default.css" media="all" />
		<script type="text/javascript" src="../../js/datepicker/WdatePicker.js"></script>
	</head>
 
	<body>
		<div id="centerbox" onclick="showhidediv('centerbox')"></div>
	
		<form>
			<input type="hidden" name="id" value="4028817a3a4303cb013a4497bebf000d" />
			<input type="hidden" name="delIds" value="">
 
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
							修改购销合同信息
						</div>
					</div>
				</div>
				<div>
 
 
					<div>
						<table class="commonTable" cellspacing="1">
							<tr>
								<td class="columnTitle_mustbe">
									收&nbsp;购&nbsp;方：
								</td>
								<td class="tableContent">
									<input type="text" name="offeror" value="杰信商贸有限公司"
										dataType="非空字符串" dispName="收购方" maxLength="200">
								</td>
								<td class="columnTitle">
									打印样式：
								</td>
								<td class="tableContentAuto">
									<input type="radio" name="printStyle" value="1" checked
										class="input">
									一个货物
									<input type="radio" name="printStyle" value="2"
										checked class="input">
									两个货物
								</td>
							</tr>
							<tr>
								<td class="columnTitle_mustbe">
									合&nbsp;同&nbsp;号：
								</td>
								<td class="tableContent">
									<input type="text" name="contractNo" value="1028"
										dataType="非空字符串" dispName="合同号" maxLength="30">
								</td>
								<td class="columnTitle_mustbe">
									签单日期：
								</td>
								<td class="tableContent">
									<input type="text" style="width: 90px;" name="signingDate"
										dataType="非空日期" dispName="签单日期"
										value="2012-10-10"
										onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});" />
								</td>
							</tr>
							<tr>
								<td class="columnTitle">
									制&nbsp;&nbsp;&nbsp;&nbsp;单：
								</td>
								<td class="tableContent">
									<input type="text" name="inputBy" value="王丽"
										dataType="字符串" dispName="制单人" maxLength="30">
								</td>
								<td class="columnTitle">
									审&nbsp;&nbsp;&nbsp;&nbsp;单：
								</td>
								<td class="tableContent">
									<input type="text" name="checkBy" value=""
										dataType="字符串" dispName="审单人" maxLength="30">
								</td>
							</tr>
							<tr>
								<td class="columnTitle">
									验&nbsp;货&nbsp;员：
								</td>
								<td class="tableContent">
									<input type="text" name="inspector" value="高志"
										dataType="字符串" dispName="验货员" maxLength="30">
								</td>
								<td class="columnTitle">
									要&nbsp;&nbsp;&nbsp;&nbsp;求：
								</td>
								<td class="tableContent">
									<input type="text" name="remark" value=""
										dataType="字符串" dispName="要求" maxLength="2000">
								</td>
							</tr>
							<tr>
								<td class="columnTitle">
									客户名称：
								</td>
								<td class="tableContent">
									<input type="text" name="customName" value="INDABA"
										dataType="字符串" dispName="客户名称" maxLength="200">
								</td>
								<td class="columnTitle_mustbe">
									船&nbsp;&nbsp;&nbsp;&nbsp;期：
								</td>
								<td class="tableContent">
									<input type="text" style="width: 90px;" name="shipTime"
										dataType="非空日期" dispName="船期"
										value="2012-11-30"
										onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});" />
								</td>
					        </tr>
					        <tr>
					            <td class="columnTitle" nowrap>贸易条款：</td>
					            <td class="tableContent"><input type="text" name="tradeTerms" value="T/T" dataType="字符串" dispName="贸易条款" maxLength="30"></td>
					        </tr>
							<tr>
								<td class="columnTitle">
									重要程度：
								</td>
								<td class="normalTD">
									<input type="radio" name="importNum" value="1" class="input"
										>
									★
									<input type="radio" name="importNum" value="2" class="input"
										>
									★★
									<input type="radio" name="importNum" value="3" class="input"
										checked>
									★★★
								</td>
								<td class="columnTitle_mustbe">
									交&nbsp;&nbsp;&nbsp;&nbsp;期：
								</td>
								<td class="tableContent">
									<input type="text" style="width: 90px;" name="deliveryPeriod"
										dataType="非空日期" dispName="交期"
										value="2012-11-23"
										onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});" />
								</td>
							</tr>
							<tr>
								<td colspan="6">
									<textarea name="request" dataType="字符串" dispName="要求"
										style="height: 105px;" class="textarea">&nbsp;&nbsp;★   产品与封样无明显差异，唛头、标签及包装质量务必符合公司要求。 
 ★★  产品生产前期、中期、后期抽验率不得少于10%，质量和封样一致， 
       并将验货照片传回公司。 
★★★ 重点客人的质量标准检验，产品抽验率不得少于50%，务必做到入箱前检查。 
 包装：产品用白纸，瓦楞纸，气泡纸包裹后入内盒，大箱，大箱用胶带纸工字封口；
 交期：2012年11月23日/工厂。 
       没有经过我司同意无故延期交货造成严重后果的，按照客人的相关要求处理。 
 开票：出货后请将增值税发票、验货报告、合同复印件及出库单一并寄至我司，以便我司安排付款。</textarea>
								</td>
							</tr>
						</table>
					</div>
				</div>
 
 
		</form>
	</body>
</html>

