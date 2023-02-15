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
 
	
	//autocomplete add by tony 2011.8.11
	var a_i;
	function showGs(event){
		if($.browser.msie){
			var keyStr=event.keyCode;
		}else{
			var keyStr=event.which;
		}
		if(keyStr!=38&&keyStr!=40&&keyStr!=13){
			$("#ts").empty();
			var vinvoiceNo=($("#invoiceNo").val());
			vinvoiceNo = encodeURI((vinvoiceNo));			//中文乱码
			
			if(vinvoiceNo!=""){
				$("#ts").html("正在加载...");
				$.post("/../../ajaxPackingListAutoCompleteAction.do",{invoiceNo:vinvoiceNo},function(m){
					m = m.replaceAll('\r\n','<br>');
					$("#ts").html("<span style=\"float:right;cursor:hand;\"><img src=\"../../skin/default/images/title/close.gif\" onclick=\"closemsg();\")/></span><font color=#ff8800;><strong>提示：用鼠标或方向键选取</strong></font>"+unescape(m));
					$("#ts>a").bind("click",vst);
					$("#ts").css("display","block");
					//初始化全局变量
					a_i=-1;
				});
			}else{
				$("#ts").css("display","none");
			}
		}else{
			//使用键盘上下键选择
			if($("#ts").css("display")=="block"){
				//得到选择列表的长度
				var aLen=$("#ts>a").length;
				var _aLen=Number(aLen)-1;
				//按下键盘向下方向键
				if(keyStr==38){
					if(a_i>=0&&a_i<=_aLen) $("#ts>a").get(a_i).style.backgroundColor="";
					a_i=Number(a_i)-1;
					if(a_i<0) a_i=_aLen;
					$("#ts>a").get(a_i).style.backgroundColor="#9ddbd7";
				}else if(keyStr==40){	//按下键盘的向上方向键
					if(a_i>=0&&a_i<=_aLen) $("#ts>a").get(a_i).style.backgroundColor="";
					a_i=Number(a_i)+1;
					if(a_i>=aLen) a_i=0;
					$("#ts>a").get(a_i).style.backgroundColor="#9ddbd7";
				}else if(keyStr==13){//按下回车键
					try{
						var liText=$("#ts>a").get(a_i).innerHTML;
						if(liText.indexOf("(")>-1){
							invoiceNoText =  liText.substring(0,liText.indexOf("("));				//截取
							byuerText =  liText.substring(liText.indexOf("(")+1,liText.length-1);	//截取
						}else{
							invoiceNoText =  liText;
							byuerText =  "";	//截取
						}
						
						$("#invoiceNo").val(invoiceNoText);
						$("#buyer").val(byuerText);
					}catch(e){ }
					$("#ts").css("display","none");
					document.getElementById("invoiceDate").focus();
			 	}
			}
		}
	}
	
	function closemsg(){
		$("#ts").css("display","none");
	}
 
	function vst(){
		var liText=$(this).text();													//set invoiceNo inputbox
		if(liText!=null&&liText.length>0){
			if(liText.indexOf("(")>-1){
				invoiceNoText =  liText.substring(0,liText.indexOf("("));				//截取
				byuerText =  liText.substring(liText.indexOf("(")+1,liText.length-1);	//截取
			}else{
				invoiceNoText =  liText;
				byuerText =  "";	//截取
			}
		}
		$("#invoiceNo").val(invoiceNoText);
		byuerText = byuerText.replace("[]","\n").replace("[]","\n").replace("[]","\n").replace("[]","\n").replace("[]","\n");	//实现换行的转换 tip
		$("#buyer").val(byuerText);
		$("#ts").css("display","none");
		
		document.getElementById("invoiceDate").focus();
	}
	    
	function searchExport() {
		var findNo = document.all.findItemNo.value;
		if(findNo==""){
			showError("请输入查询条件!");
			return false;
		}		
		findExport(findNo);
		showWKP();
	}
	
	function addGoods(id,no){
		_comparestr = id+"|"+no;		//innerHTML方法会处理html，导致和新加入的格式不同，比较失败 by tony 2012-02-14
		_tempstr = document.getElementById("contractList").innerHTML;
		_element = "<div style=\"float:left;width:150px;padding:5px;\"><input type=\"checkbox\" name=\"contractId\" value=\""+id+"|"+no+"\" checked class=\"input\">"+no+"</div>";
		if(_tempstr.indexOf(_comparestr)==-1){
			document.getElementById("contractList").innerHTML += _element;
		}else{
			showError(no+"已经加入!");
		}
	}	
	
	function showWKP() {
		document.all.wkp_tr.style.display = "";
		document.all.hiddenWKP.style.display = "";
		document.all.showWKP.style.display = "none";
	}
 
	function hidWKP() {
		document.all.wkp_tr.style.display = "none";
		document.all.showWKP.style.display = "";
		document.all.hiddenWKP.style.display = "none";
	}
	
	function clearWKP() {
		document.all.itemsInfo_div.innerHTML = "";
		document.all.wkp_tr.style.display = "none";
		document.all.showWKP.style.display = "";
		document.all.hiddenWKP.style.display = "none";
	}
    
	</script>
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
	<input type="hidden" name="id" id="id" value="4028817a3b3a59cd013b3b64c7f80032"/>
	<input type="hidden" name="delIds" value="">
 
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="save"><a href="#" onclick="_Submit('/cargo/doPackingListUpdateSaveAction.do',null,'保存');this.blur();">保存</a></li>
<li id="save"><a href="#" onclick="_Submit('/cargo/doPackingListUpdateSaveAction.do?flag=tempsuccess',null,'暂存');this.blur();">暂存</a></li>
 
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
        修改装箱单信息
       &nbsp;&nbsp;&nbsp;
 
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
					 	value="12JX307"
						onkeyup="showGs(event)"
					 	onFocus="this.select();"
					 	autocomplete="off" 
					 	dataType="非空字符串" dispName="发票号" maxLength="30">
				 	<div id="ts" style="z-index:1;"></div></div>
				</td>
	            <td class="columnTitle" nowrap>发票时间：</td>
	            <td class="tableContent">
					<input type="text" style="width:90px;" name="invoiceDate" dataType="非空日期" dispName="发票时间" value="2012-11-26" onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});"/> 
				</td>
			</tr>
	        <tr>
				<td class="columnTitle_mustbe">卖家：</td>
	            <td colspan="3">
	            	<textarea id="seller" name="seller" dataType="非空字符串" dispName="卖家" maxLength="200" rows="5" onkeyup="getMaxlength('seller');textareasize(this);" onmousemove ="getMaxlength('seller');" onmouseout ="getMaxlength('seller');" class="textarea">INT'L CO.,LTD.
8-C,JIATENG BUILDING.NO.108
HEPING 10001</textarea>
	            	<div class="textarea_count">
	            	<span>字符：<a id="num_seller"><font color=#009900><script>getNownum('seller')</script> / <script>getMaxnum('seller')</script></font></a></span> | 
	            	<a style="cursor:pointer;" onclick="clearcontent('seller')">清空内容</a>
	            	</div>
	            </td>
			</tr>
	        <tr>
				<td class="columnTitle_mustbe">买家：</td>
	            <td colspan="3">
	            	<textarea id="buyer" name="buyer" dataType="非空字符串" dispName="买家" maxLength="200" rows="5" onkeyup="getMaxlength('buyer');textareasize(this);" onmousemove ="getMaxlength('buyer');" onmouseout ="getMaxlength('buyer');" class="textarea">ACAO E EXPORTACAO LTDA 
RUA COMENDADOR VICENTE MELILLO,306 CAPELA DO SOCORRO 
CEP:047AULO SP BRASIL 
CNPJ:08.219.102/0002-95</textarea>
	            	<div class="textarea_count">
	            	<span>字符：<a id="num_buyer"><font color=#009900><script>getNownum('buyer')</script> / <script>getMaxnum('buyer')</script></font></a></span> | 
	            	<a style="cursor:pointer;" onclick="clearcontent('buyer')">清空内容</a>
	            	</div>
	            </td>
			</tr>
	        <tr>
				<td class="columnTitle">唛头：</td>
	            <td colspan="3">
	            	<textarea id="marks" name="marks" rows="5" dataType="字符串" dispName="唛头" maxLength="1000" onkeyup="getMaxlength('marks');textareasize(this);" onmousemove ="getMaxlength('marks');" onmouseout ="getMaxlength('marks');" class="textarea">GLASS</textarea>
	            	<div class="textarea_count">
	            	<span>字符：<a id="num_marks"><font color=#009900><script>getNownum('marks')</script> / <script>getMaxnum('marks')</script></font></a></span> | 
	            	<a style="cursor:pointer;" onclick="clearcontent('marks')">清空内容</a>
	            	</div>
	            </td>
			</tr>
	        <tr>
				<td class="columnTitle">描述：</td>
	            <td colspan="3">
	            	<textarea id="descriptions" name="descriptions" rows="5" dataType="字符串" dispName="描述" maxLength="200" onkeyup="getMaxlength('descriptions');textareasize(this);" onmousemove ="getMaxlength('descriptions');" onmouseout ="getMaxlength('descriptions');" class="textarea">GLASSWARE</textarea>
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
	<div style="float:left;width:150px;padding:5px;"><input type="checkbox" name="contractId" value="4028817a3b3a59cd013b3b5bbd94001a|671112" checked class="input">671112</div>
	</div>
</div>
 

 
</form>
</body>
</html>

