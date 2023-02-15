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
	
 	<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../css/extreme/extremecomponents.css" />
    <link rel="stylesheet" rev="stylesheet" type="text/css" href="../../css/extreme/extremesite.css" />
</head>
 
<script language="javascript"> 
	function preSubmit(serviceName){
		if(serviceName=="查看"||serviceName=="修改"||serviceName=="删除"||serviceName=="打印"||serviceName=="委托"||serviceName=="发票"||serviceName=="财务"){
			if(_CheckAll(true,serviceName) == false){
	            return false;
	 		}
			if(serviceName=="删除"){
				return confirm("您确定要将所选记录删除吗?\n单击【确定】将删除所选记录! 单击【取消】将终止删除操作!");
			}
		}
	}
	
	function preCheck(serviceName) {
       	if(serviceName=="查看"||serviceName=="修改"||serviceName=="打印"||serviceName=="委托"||serviceName=="发票"||serviceName=="财务"){
    		return onlySelect(serviceName,"id",1);
    	}
	}
</script>
	
<body>
<form name="form2">
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="view"><a href="jPackingListView.jsp">查看</a></li>
<li id="update"><a href="jPackingListUpdate.jsp">修改</a></li>
<li id="delete"><a href="#">删除</a></li>
<li id="print"><a href="parkinglist.xls" target="_blank">打印</a></li>
<li id="accept"><a href="jShippingOrder.jsp">委托</a></li>
<li id="new"><a href="jInvoiceEdit.jsp">发票</a></li>
<li id="stat"><a href="jFinanceEdit.jsp">财务</a></li>
 
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
        <h2>装箱单列表</h2> 
    </div> 
    </div>
    </div>
	
 
 
<span class="noprint">
<div id="find_div" style="width:98%;">
<fieldset>
<legend><font color="000">查询条件&nbsp;</font></legend>
<div style="width:98%;padding-top:7px;text-align:left;">
 
类型：
<select name="f_type" style="width:130px;heigh:30px;" dataType="下拉列表" dispName="查询条件">
<option value='' selected>--请选择--</option><option value='invoiceNo'>发票号</option><option value='exportNos'>合同号</option><option value='seller'>卖家</option><option value='buyer'>买家</option><option value='marks'>唛头</option><option value='descriptions'>描述</option>
</select>
 
内容：	            	
<input type="text" name="f_conditionStr" value="" size="30"
	onFocus="this.select();"
	onKeyDown="javascript:if(event.keyCode==13){ document.getElementById('btnFind').onclick(); }"
/>
 
<input id="btnFind" type="button" name="查询" value="查询" onclick="this.blur();">
<input type="button" name="清空" value="清空" onclick="findReset();this.blur();">
 
</div>
</fieldset>
</div>
</span>
 
 
    
<div>
	
			 
			
				
				
				
				
				
				
			
	
			 
			
				
				
				
				
				
				
			
	
			 
			
				
				
				
				
				
				
			
	
			 
			
				
				
				
				
				
				
			
	
			 
			
				
				
				
				
				
				
			
	
			 
			
				
				
				
				
				
				
			
	
			 
			
				
				
				
				
				
				
			
	
			 
			
				
				
				
				
				
				
			
	
			 
			
				
				
				
				
				
				
			
	
			 
			
				
				
				
				
				
				
			
	
			 
			
				
				
				
				
				
				
			
	
<div>
<input type="hidden"  name="ec_i"  value="ec" />
<input type="hidden"  name="ec_crd"  value="10" />
<input type="hidden"  name="ec_p"  value="1" />
</div>
<div class="eXtremeTable" >
<table id="ec_table"  border="0"  cellspacing="0"  cellpadding="0"  class="tableRegion"  width="98%" >
	<thead>
	<tr style="padding: 0px;" >
		<td colspan="6" >
		<table border="0"  cellpadding="0"  cellspacing="0"  width="100%" >
			<tr>
				<td class="statusBar" >找到269 条记录, 显示 1 到 10 </td>
				<td class="compactToolbar"  align="right" >
				<table border="0"  cellpadding="1"  cellspacing="2" >
					<tr>
					<td><img src="/images/table/firstPageDisabled.gif"  style="border:0"  alt="第一页" /></td>
					<td><img src="/images/table/prevPageDisabled.gif"  style="border:0"  alt="上一页" /></td>
					<td><a href="javascript:document.forms.form2.ec_p.value='2';document.forms.form2.setAttribute('action', 'doPackingListListAction.do');document.forms.form2.setAttribute('method', 'post');document.forms.form2.submit()"><img src="/images/table/nextPage.gif"  style="border:0"  title="下一页"  alt="下一页" /></a></td>
					<td><a href="javascript:document.forms.form2.ec_p.value='27';document.forms.form2.setAttribute('action', 'doPackingListListAction.do');document.forms.form2.setAttribute('method', 'post');document.forms.form2.submit()"><img src="/images/table/lastPage.gif"  style="border:0"  title="最后页"  alt="最后页" /></a></td>
					<td><img src="/images/table/separator.gif"  style="border:0"  alt="Separator" /></td>
					<td><select name="ec_rd"  onchange="javascript:document.forms.form2.ec_crd.value=this.options[this.selectedIndex].value;document.forms.form2.ec_p.value='1';document.forms.form2.setAttribute('action', 'doPackingListListAction.do');document.forms.form2.setAttribute('method', 'post');document.forms.form2.submit()" >
				<option value="10"  selected="selected">10</option><option value="50" >50</option><option value="100" >100</option>
				</select></td>
					</tr>
				</table></td>
			</tr>
		</table>
		</td>
	</tr>		
 
	<tr>
		<td class="tableHeader" ><input type="checkbox"  id="id_selector"  name="id_selector"  title="(Un)Select All"  onclick="for(i = 0; i < document.getElementsByName('id').length; i++)document.getElementsByName('id').item(i).checked=document.getElementById('id_selector').checked;" ></td>
		<td class="tableHeader" >发票号</td>
		<td class="tableHeader" >报运号</td>
		<td class="tableHeader" >发票时间</td>
		<td class="tableHeader" >备注</td>
		<td class="tableHeader" >创建日期</td>
	</tr>
	</thead>
	<tbody class="tableBody" >
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="装箱单管理" minSelect="1" value="4028817a3b3a59cd013b3b64c7f80032"/>
				</td>
		<td style="white-space:nowrap" >
					<a href="jPackingListView.jsp">
					12JX307
					</a>
				</td>
		<td>
					671112
				</td>
		<td>2012-11-26</td>
		<td>
					GLASSWARE
				</td>
		<td>2012-11-26</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="装箱单管理" minSelect="1" value="4028817a3b3a59cd013b3b40a7fc0019"/>
				</td>
		<td style="white-space:nowrap" >
					<a href="jPackingListView.jsp">
					12JX306
					</a>
				</td>
		<td>
					671112
				</td>
		<td>2012-11-26</td>
		<td>
					GLASSWARE
				</td>
		<td>2012-11-26</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="装箱单管理" minSelect="1" value="4028817a3b2abde9013b2b32dd9f0009"/>
				</td>
		<td style="white-space:nowrap" >
					<a href="jPackingListView.jsp">
					12JX296
					</a>
				</td>
		<td>
					635286
				</td>
		<td>2012-11-23</td>
		<td>
					GLASSWARE
				</td>
		<td>2012-11-23</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="装箱单管理" minSelect="1" value="4028817a3b207271013b2234f558000d"/>
				</td>
		<td style="white-space:nowrap" >
					<a href="jPackingListView.jsp">
					12JX295
					</a>
				</td>
		<td>
					C/2211/12
				</td>
		<td>2012-11-21</td>
		<td>
					GLASSWARE
				</td>
		<td>2012-11-21</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="装箱单管理" minSelect="1" value="4028817a3b207271013b21150d3e0006"/>
				</td>
		<td style="white-space:nowrap" >
					<a href="jPackingListView.jsp">
					12JX294
					</a>
				</td>
		<td>
					061456
				</td>
		<td>2012-11-21</td>
		<td>
					GLASSWARE
				</td>
		<td>2012-11-21</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="装箱单管理" minSelect="1" value="4028817a3b1b4a71013b1b9325790001"/>
				</td>
		<td style="white-space:nowrap" >
					<a href="jPackingListView.jsp">
					12JX293
					</a>
				</td>
		<td>
					12JK1073
				</td>
		<td>2012-11-20</td>
		<td>
					GLASSWARE
				</td>
		<td>2012-11-20</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="装箱单管理" minSelect="1" value="4028817a3b06ac0c013b07035fe10009"/>
				</td>
		<td style="white-space:nowrap" >
					<a href="jPackingListView.jsp">
					12JX292
					</a>
				</td>
		<td>
					12JK1092
				</td>
		<td>2012-11-16</td>
		<td>
					GLASSWARE
				</td>
		<td>2012-11-16</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="装箱单管理" minSelect="1" value="4028817a3b06ac0c013b06ebfa710008"/>
				</td>
		<td style="white-space:nowrap" >
					<a href="jPackingListView.jsp">
					12JX291
					</a>
				</td>
		<td>
					12JK1089
				</td>
		<td>2012-11-16</td>
		<td>
					GLASSWARE
				</td>
		<td>2012-11-16</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="装箱单管理" minSelect="1" value="4028817a3b018a50013b030a84250028"/>
				</td>
		<td style="white-space:nowrap" >
					<a href="jPackingListView.jsp">
					12JX290
					</a>
				</td>
		<td>
					I1200709<br>I1200879<br>I1201048
				</td>
		<td>2012-11-15</td>
		<td>
					GLASSWARE
				</td>
		<td>2012-11-15</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="装箱单管理" minSelect="1" value="4028817a3b018a50013b028533f8001e"/>
				</td>
		<td style="white-space:nowrap" >
					<a href="jPackingListView.jsp">
					12JX289
					</a>
				</td>
		<td>
					104709<br>104717
				</td>
		<td>2012-11-15</td>
		<td>
					GLASSWARE
				</td>
		<td>2012-11-15</td>
	</tr>
	</tbody>
</table>
</div>
 
</div>
 
 
</form>
</body>
</html>


