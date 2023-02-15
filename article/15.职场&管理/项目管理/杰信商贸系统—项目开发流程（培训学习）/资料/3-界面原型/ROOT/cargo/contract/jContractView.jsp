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
 
	<script language="JavaScript">
   		function preSubmit(serviceName) {
	        if(serviceName=="返回"){
	            return true;
	        } else if (serviceName=="确定"){
	            return _CheckAll(true,serviceName);
	        }
	    }
	</script>
	
<style> 
	.product_image{ margin:5px;border:1px solid black;height:100px;weight:80px; }
</style>	
</head>
 
<body>
<form method="post">
	<input type="hidden" name="id" id="id" value="4028817a3a4303cb013a4497bebf000d"/>
 
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
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
        浏览购销合同信息
       &nbsp;&nbsp;&nbsp;
 
	</div> 
    </div>
    </div>
<div>
 
    <div>
		<table class="commonTable" cellspacing="1">
	        <tr>
	            <td class="columnTitle">收&nbsp;购&nbsp;方：</td>
	            <td class="tableContent">杰信商贸有限公司</td>
	            <td class="columnTitle">打印样式：</td>
	            <td class="tableContent">2个货物</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">合&nbsp;同&nbsp;号：</td>
	            <td class="tableContent">1028</td>
	            <td class="columnTitle">签单日期：</td>
				<td class="tableContent">
				2012-10-10
				</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">制&nbsp;&nbsp;&nbsp;&nbsp;单：</td>
	            <td class="tableContent">王丽</td>
	            <td class="columnTitle">总&nbsp;金&nbsp;额：</td>
	            <td class="tableContent">16864.00</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">审&nbsp;&nbsp;&nbsp;&nbsp;单：</td>
	            <td class="tableContent"></td>
	            <td class="columnTitle">验&nbsp;货&nbsp;员：</td>
	            <td class="tableContent">高志</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">客户名称：</td>
	            <td class="tableContent">INDABA</td>
	            <td class="columnTitle">船&nbsp;&nbsp;&nbsp;&nbsp;期：</td>
	            <td class="tableContent">2012-11-30</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">交&nbsp;&nbsp;&nbsp;&nbsp;期：</td>
				<td class="tableContent">
					2012-11-23
				</td>
	            <td class="columnTitle">要&nbsp;&nbsp;&nbsp;&nbsp;求：</td>
	            <td class="tableContent"></td>
	        </tr>
	        <tr>
	            <td class="columnTitle">贸易条款：</td>
				<td class="tableContent">T/T</td>
	            <td class="columnTitle">&nbsp;</td>
	            <td class="tableContent">&nbsp;</td>
	        </tr>
	        <tr>
	            <td colspan="4" style="padding:20px;">&nbsp;&nbsp;★&nbsp;&nbsp;&nbsp;产品与封样无明显差异，唛头、标签及包装质量务必符合公司要求。&nbsp;
<br>&nbsp;★★&nbsp;&nbsp;产品生产前期、中期、后期抽验率不得少于10%，质量和封样一致，&nbsp;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;并将验货照片传回公司。&nbsp;
<br>★★★&nbsp;重点客人的质量标准检验，产品抽验率不得少于50%，务必做到入箱前检查。&nbsp;
<br>&nbsp;包装：产品用白纸，瓦楞纸，气泡纸包裹后入内盒，大箱，大箱用胶带纸工字封口；
<br>&nbsp;交期：2012年11月23日/工厂。&nbsp;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;没有经过我司同意无故延期交货造成严重后果的，按照客人的相关要求处理。&nbsp;
<br>&nbsp;开票：出货后请将增值税发票、验货报告、合同复印件及出库单一并寄至我司，以便我司安排付款。</td>
			</tr>
		</table>
	</div>
</div>
 
<!-- 货物列表 -->
<div class="textbox" id="centerTextbox">
    
    <div class="textbox-header">
    <div class="textbox-inner-header">
    <div class="textbox-title">
        货物信息
    </div> 
    </div>
    </div>
</div>
 
<div class="listTablew">
<table class="commonTable_main" cellSpacing="1" id="resultTable">
	<tr class="rowTitle" align="middle">
		<td width="33">序号</td>
		<td>图片</td>
		<td>货号</td>
		<td>货物描述</td>
		<td>厂家</td>
		<td>数量</td>
		<td>单位</td>
		<td>箱数</td>
		<td>单价</td>
		<td>总金额</td>
		<td nowrap>走货<br>状态</td>
	</tr>
	
	
		
		<tr height="30">
			<td align="center">1</td>
			<td><img src="../../images/no.jpg" class="product_image" width="133" height="100" onerror="this.src='../../images/no.jpg'"></td>
			<td>03-3521-1/JK1050328</td>
			<td>全明料酒杯&nbsp;&nbsp;&nbsp;刻花&nbsp;，&nbsp;不描亮油
<br>直径10&nbsp;X&nbsp;19CM高
<br>4只/内盒&nbsp;&nbsp;&nbsp;16只/大箱</td>
			<td>宏艺</td>
			<td>496/496</td>
			<td>PCS</td>
			<td>31</td>
			<td>8.50</td>
			<td>4216.00</td>
			<td align="center">
			
			
			全部
			</td>
		</tr>
	
	
		
		<tr height="30">
			<td align="center">2</td>
			<td><img src="../../images/no.jpg" class="product_image" width="133" height="100" onerror="this.src='../../images/no.jpg'"></td>
			<td>03-3522-1/JK1050328</td>
			<td>全明料酒杯&nbsp;&nbsp;&nbsp;刻花，&nbsp;不描亮油
<br>直径10&nbsp;X&nbsp;19CM&nbsp;高
<br>4只/内盒&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;16只/大箱</td>
			<td>宏艺</td>
			<td>496/496</td>
			<td>PCS</td>
			<td>31</td>
			<td>8.50</td>
			<td>4216.00</td>
			<td align="center">
			
			
			全部
			</td>
		</tr>
	
	
		
		<tr height="30">
			<td align="center">3</td>
			<td><img src="../../images/no.jpg" class="product_image" width="133" height="100" onerror="this.src='../../images/no.jpg'"></td>
			<td>03-3523-1/JK1050328</td>
			<td>全明料酒杯&nbsp;&nbsp;&nbsp;&nbsp;刻花，&nbsp;不描亮油
<br>直径10X19CM高
<br>4只/内盒&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;16只/大箱</td>
			<td>宏艺</td>
			<td>496/496</td>
			<td>PCS</td>
			<td>31</td>
			<td>8.50</td>
			<td>4216.00</td>
			<td align="center">
			
			
			全部
			</td>
		</tr>
	
	
		
		<tr height="30">
			<td align="center">4</td>
			<td><img src="../../images/no.jpg" class="product_image" width="133" height="100" onerror="this.src='../../images/no.jpg'"></td>
			<td>03-3524-1/JK1050328</td>
			<td>全明料酒杯&nbsp;&nbsp;&nbsp;&nbsp;刻花，&nbsp;不描亮油
<br>直径10X19CM&nbsp;高
<br>4只/内盒&nbsp;&nbsp;&nbsp;&nbsp;16只/大箱</td>
			<td>宏艺</td>
			<td>496/496</td>
			<td>PCS</td>
			<td>31</td>
			<td>8.50</td>
			<td>4216.00</td>
			<td align="center">
			
			
			全部
			</td>
		</tr>
	
	
</table>
</div>
 
 
 
 
 
</form>
</body>
</html>

