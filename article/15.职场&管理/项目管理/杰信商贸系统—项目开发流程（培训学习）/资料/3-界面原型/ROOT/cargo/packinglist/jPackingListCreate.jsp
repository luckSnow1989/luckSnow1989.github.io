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
	<script type="text/javascript" src="../../js/ajax/getExport.js"></script>
	<script type="text/javascript" src="../../js/tabledo.js"></script>
	
        <link href="/plugin/jquery_upload/css/uploadify.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="/plugin/jquery_upload/js/jquery-1.4.2.min.js"></script>
        <script type="text/javascript" src="/plugin/jquery_upload/js/swfobject.js"></script>
        <script type="text/javascript" src="/plugin/jquery_upload/js/jquery.uploadify.v2.1.4.js"></script>
 
	<script language="JavaScript">
   		function preSubmit(serviceName) {
			if(serviceName=="确定"||serviceName=="打印"||serviceName=="发票"||serviceName=="委托"||serviceName=="财务"){
				if(_CheckAll(true,serviceName) == false){
		            return false;
		 		}
				if(serviceName=="删除"){
					return confirm("您确定要将所选记录删除吗?\n单击【确定】将删除所选记录! 单击【取消】将终止删除操作!");
				}
		       	if(serviceName=="确定"){
		    		if(lineTextMaxLen(document.all.seller.value)>37){
		    			showError("卖家中最宽行超过了37个字符，会造成打印错乱!请修改.");
			    		return false;
		    		}
		    		if(lineTextMaxLen(document.all.buyer.value)>37){
		    			showError("买家中最宽行超过了37个字符，会造成打印错乱!请修改.");
			    		return false;
		    		}
		    		return true;
		    	}			
			}
	    }
	
	function preCheck(serviceName) {
       	if(serviceName=="确定"||serviceName=="打印"||serviceName=="财务"||serviceName=="财务"||serviceName=="财务"){
    		return onlySelect(serviceName,"id",1);
    	}
	}
 
	//返回多行文本中最大的一行的字符数 by tony 20111219
	function lineTextMaxLen( s ){
		var lenValue = 0;
		var a = s.split("\n");
		for(var i=0;i<a.length;i++){
			if(a[i].length>lenValue){
				lenValue = a[i].length;
			}
		}
		return lenValue;
	}
 

	</script>
<style> 
	#ts{
    position:absolute;
	display:none;
	top:130px;
	left:150px;
 
		width:450px;
		background:#dbfbf9;
		border:1px solid #cae9e7;
		text-align:left;
		color:#000000;
		padding:10px;
	}
	#ts a{
		display:block;
		height:25px;
		line-height:25px;
		cursor:pointer;
	}
	#ts a:hover, #ts a.selected{
		display:block;	
		background:#dbfbf9;
		height:25px;
		line-height:25px;
		color:#000000;
	}
</style>
</head>
 
<body>
<form method="post">
 
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="save"><a href="#">保存</a></li>
<li id="save"><a href="#">暂存</a></li>
 
 
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
        新建装箱单信息
	</div> 
    </div>
    </div>
</div>


<div> 
    <div>
		<table class="commonTable" cellspacing="1">
	        <tr>
	            <td class="columnTitle_mustbe" nowrap>发票号：</td>
	            <td class="tableContent">
					<div class="zc_line"><input type="text" style="text-transform:uppercase;" name="invoiceNo" id="invoiceNo"
					 	value="13JX340" maxLength="30">
				 	<div id="ts" style="z-index:1;"></div></div>
				</td>
	            <td class="columnTitle" nowrap>发票时间：</td>
	            <td class="tableContent">
					<input type="text" style="width:90px;" name="invoiceDate" dataType="非空日期" dispName="发票时间" value="2013-03-04" onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});"/> 
				</td>
			</tr>
	        <tr>
				<td class="columnTitle_mustbe">卖家：</td>
	            <td colspan="3">
	            	<textarea id="seller" name="seller" dataType="非空字符串" dispName="卖家" maxLength="200" rows="5" onkeyup="getMaxlength('seller');textareasize(this);" onmousemove ="getMaxlength('seller');" onmouseout ="getMaxlength('seller');" class="textarea">INT'L CO.,LTD.
8-C,JIATENG BUILDING.NO.108
HEPING RO0001</textarea>
	            	<div class="textarea_count">
	            	<span>字符：<a id="num_seller"><font color=#009900><script>getNownum('seller')</script> / <script>getMaxnum('seller')</script></font></a></span> | 
	            	<a style="cursor:pointer;" onclick="clearcontent('seller')">清空内容</a>
	            	</div>
	            </td>
			</tr>
	        <tr>
				<td class="columnTitle_mustbe">买家：</td>
	            <td colspan="3">
	            	<textarea id="buyer" name="buyer" dataType="非空字符串" dispName="买家" maxLength="200" rows="5" onkeyup="getMaxlength('buyer');textareasize(this);" onmousemove ="getMaxlength('buyer');" onmouseout ="getMaxlength('buyer');" class="textarea">LEE &CO.,LTD
NOS.9-12,17/FL,TOWER 3,
CHINA HONGKONG CITY,
33CANTON ROOWLOON.HK</textarea>
	            	<div class="textarea_count">
	            	<span>字符：<a id="num_buyer"><font color=#009900><script>getNownum('buyer')</script> / <script>getMaxnum('buyer')</script></font></a></span> | 
	            	<a style="cursor:pointer;" onclick="clearcontent('buyer')">清空内容</a>
	            	</div>
	            </td>
			</tr>
	        <tr>
				<td class="columnTitle">唛头：</td>
	            <td colspan="3">
	            	<textarea id="marks" name="marks" rows="5" dataType="字符串" dispName="唛头" maxLength="1000" onkeyup="getMaxlength('marks');textareasize(this);" onmousemove ="getMaxlength('marks');" onmouseout ="getMaxlength('marks');" class="textarea"></textarea>
	            	<div class="textarea_count">
	            	<span>字符：<a id="num_marks"><font color=#009900><script>getNownum('marks')</script> / <script>getMaxnum('marks')</script></font></a></span> | 
	            	<a style="cursor:pointer;" onclick="clearcontent('marks')">清空内容</a>
	            	</div>
	            </td>
			</tr>
	        <tr>
				<td class="columnTitle">描述：</td>
	            <td colspan="3">
	            	<textarea id="descriptions" name="descriptions" rows="5" dataType="字符串" dispName="描述" maxLength="200" onkeyup="getMaxlength('descriptions');textareasize(this);" onmousemove ="getMaxlength('descriptions');" onmouseout ="getMaxlength('descriptions');" class="textarea"></textarea>
	            	<div class="textarea_count">
	            	<span>字符：<a id="num_descriptions"><font color=#009900><script>getNownum('descriptions')</script> / <script>getMaxnum('descriptions')</script></font></a></span> | 
	            	<a style="cursor:pointer;" onclick="clearcontent('descriptions')">清空内容</a>
	            	</div>
	            </td>
			</tr>
		</table>
	</div>
</div>
 
 
<div class="listTablew">
	<div id="contractList" style="float:left;margin:8px;">
	
	</div>
</div>
 
 
</form>
</body>
</html>

