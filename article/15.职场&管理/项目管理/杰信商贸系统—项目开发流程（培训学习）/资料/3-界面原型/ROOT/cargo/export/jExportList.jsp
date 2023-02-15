<%@ page language="java" pageEncoding="UTF-8"%>

<!-- 告诉浏览器本网页符合XHTML1.0过渡型DOCTYPE -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../skin/default/css/default.css" media="all" />
	
 	<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../css/extreme/extremecomponents.css" />
    <link rel="stylesheet" rev="stylesheet" type="text/css" href="../../css/extreme/extremesite.css" />
</head>
	
<body>
<form name="form2">
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="view"><a href="jExportView.jsp">查看</a></li>
<li id="update"><a href="jExportUpdate.jsp">修改</a></li>
<li id="delete"><a href="#">删除</a></li>
<li id="print"><a href="export.xls" target="_blank">打印</a></li>
<li id="back"><a href="#" >复制</a></li>
<li id="new"><a href="#">上报</a></li>
<li id="new"><a href="#">取消</a></li>
 
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
        <h2>报运单列表</h2> 
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
<option value='' selected>--请选择--</option><option value='customerContract'>合同号</option><option value='exportProduct.productNo'>货号</option><option value='packingList.invoiceNo'>发票号</option><option value='consignee'>收货人及地址</option><option value='transportMode'>运输方式</option><option value='marks'>唛头</option>
</select>
 
内容：	            	
<input type="text" name="f_conditionStr" value="" size="30"
	onFocus="this.select();"
	onKeyDown="javascript:if(event.keyCode==13){ document.getElementById('btnFind').onclick(); }"
/>
 
<input id="btnFind" type="button" name="查询" value="查询" onclick="_Submit('doExportListAction.do',null,'查询');this.blur();">
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
		<td colspan="10" >
		<table border="0"  cellpadding="0"  cellspacing="0"  width="100%" >
			<tr>
				<td class="statusBar" >找到380 条记录, 显示 1 到 10 </td>
				<td class="compactToolbar"  align="right" >
				<table border="0"  cellpadding="1"  cellspacing="2" >
					<tr>
					<td><img src="/images/table/firstPageDisabled.gif"  style="border:0"  alt="第一页" /></td>
					<td><img src="/images/table/prevPageDisabled.gif"  style="border:0"  alt="上一页" /></td>
					<td><a href="javascript:document.forms.form2.ec_p.value='2';document.forms.form2.setAttribute('action', 'doExportListAction.do');document.forms.form2.setAttribute('method', 'post');document.forms.form2.submit()"><img src="/images/table/nextPage.gif"  style="border:0"  title="下一页"  alt="下一页" /></a></td>
					<td><a href="javascript:document.forms.form2.ec_p.value='38';document.forms.form2.setAttribute('action', 'doExportListAction.do');document.forms.form2.setAttribute('method', 'post');document.forms.form2.submit()"><img src="/images/table/lastPage.gif"  style="border:0"  title="最后页"  alt="最后页" /></a></td>
					<td><img src="/images/table/separator.gif"  style="border:0"  alt="Separator" /></td>
					<td><select name="ec_rd"  onchange="javascript:document.forms.form2.ec_crd.value=this.options[this.selectedIndex].value;document.forms.form2.ec_p.value='1';document.forms.form2.setAttribute('action', 'doExportListAction.do');document.forms.form2.setAttribute('method', 'post');document.forms.form2.submit()" >
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
		<td class="tableHeader" >报运号</td>
		<td class="tableHeader" >货物数/附件数</td>
		<td class="tableHeader" >L/C</td>
		<td class="tableHeader" >装运港</td>
		<td class="tableHeader" >收货人及地址</td>
		<td class="tableHeader" >运输方式</td>
		<td class="tableHeader" >价格条件</td>
		<td class="tableHeader" >录入日期</td>
		<td class="tableHeader" >状态</td>
	</tr>
	</thead>
	<tbody class="tableBody" >
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="报运管理" minSelect="1" value="4028817a3b3a59cd013b3ba084c1003a"/>
				</td>
		<td>
					<a href="jExportView.jsp">
					404058
					</a>
				</td>
		<td>
					
					
						
					
					1/0 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>T/T</td>
		<td>XINGANG</td>
		<td>@ HOME</td>
		<td>SEA</td>
		<td>FOB</td>
		<td>2012-11-26</td>
		<td>
					
					已上报
					
					
					
					
				</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="报运管理" minSelect="1" value="4028817a3b3a59cd013b3b96187b0033"/>
				</td>
		<td>
					<a href="jExportView.jsp">
					C/2256/12
					</a>
				</td>
		<td>
					
					
						
							
						
					
						
							
						
					
						
							
						
					
						
							
						
					
						
							
						
					
						
							
						
					
					6/6 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>T/T</td>
		<td>XINGANG</td>
		<td>BEAKIE LEE</td>
		<td>SEA</td>
		<td>FOB</td>
		<td>2012-11-26</td>
		<td>
					
					已上报
					
					
					
					
				</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="报运管理" minSelect="1" value="4028817a3b3a59cd013b3b5bbd94001a"/>
				</td>
		<td>
					<a href="jExportView.jsp">
					671112
					</a>
				</td>
		<td>
					
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
							
						
					
						
							
						
					
						
							
						
					
						
					
						
					
						
					
					23/3 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>T/T</td>
		<td>XINGANG</td>
		<td>BTC</td>
		<td>SEA</td>
		<td>FOB</td>
		<td>2012-11-26</td>
		<td>
					
					
					
					
					<font color='blue'>发票</font>
					
				</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="报运管理" minSelect="1" value="4028817a3b3a59cd013b3aded3bb0001"/>
				</td>
		<td>
					<a href="jExportView.jsp">
					671112
					</a>
				</td>
		<td>
					
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
							
						
					
						
							
						
					
						
							
						
					
						
					
						
					
						
					
					23/3 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>T/T</td>
		<td>XINGANG</td>
		<td>BTC</td>
		<td>SEA</td>
		<td>FOB</td>
		<td>2012-11-26</td>
		<td>
					
					
					
					
					<font color='blue'>发票</font>
					
				</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="报运管理" minSelect="1" value="4028817a3b2abde9013b2b2755290007"/>
				</td>
		<td>
					<a href="jExportView.jsp">
					635749
					</a>
				</td>
		<td>
					
					
						
							
						
					
					1/1 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>L/C</td>
		<td>XINGANG</td>
		<td>IMPRESSIONEN</td>
		<td>SEA</td>
		<td>FOB</td>
		<td>2012-11-23</td>
		<td>
					
					已上报
					
					
					
					
				</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="报运管理" minSelect="1" value="4028817a3b2abde9013b2b23e1750005"/>
				</td>
		<td>
					<a href="jExportView.jsp">
					635286
					</a>
				</td>
		<td>
					
					
						
							
						
					
					1/1 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>L/C</td>
		<td>XINGANG</td>
		<td>IMPRESSIONEN</td>
		<td>SEA</td>
		<td>FOB</td>
		<td>2012-11-23</td>
		<td>
					
					
					
					<font color='blue'>委托</font>
					
					
				</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="报运管理" minSelect="1" value="4028817a3add7a3b013ade8e067e000b"/>
				</td>
		<td>
					<a href="jExportView.jsp">
					12JK1081
					</a>
				</td>
		<td>
					
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
							
						
					
						
							
						
					
						
							
						
					
						
					
						
					
						
					
						
							
						
					
						
					
						
					
					17/4 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>T/T</td>
		<td>XINGANG</td>
		<td>BRISSI</td>
		<td>SEA</td>
		<td>FOB</td>
		<td>2012-11-08</td>
		<td>
					
					
					
					
					<font color='blue'>发票</font>
					
				</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="报运管理" minSelect="1" value="4028817a3afc5d3d013afcc66f980019"/>
				</td>
		<td>
					<a href="jExportView.jsp">
					101204
					</a>
				</td>
		<td>
					
					
						
							
						
					
						
							
						
					
						
							
						
					
						
					
						
					
						
					
						
					
						
							
						
					
						
							
						
					
						
							
						
					
					10/6 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>T/T</td>
		<td>XINGANG</td>
		<td>KISS THAT FRIG</td>
		<td>SEA</td>
		<td>FOB</td>
		<td>2012-11-14</td>
		<td>
					
					
					
					<font color='blue'>委托</font>
					
					
				</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="报运管理" minSelect="1" value="4028817a3b207271013b20f6e8820001"/>
				</td>
		<td>
					<a href="jExportView.jsp">
					061456
					</a>
				</td>
		<td>
					
					
						
					
					1/0 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>T/T</td>
		<td>XINGANG</td>
		<td>WAX</td>
		<td>SEA</td>
		<td>FOB</td>
		<td>2012-11-21</td>
		<td>
					
					
					
					
					<font color='blue'>发票</font>
					
				</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="报运管理" minSelect="1" value="4028817a3b06ac0c013b06c618710001"/>
				</td>
		<td>
					<a href="jExportView.jsp">
					12JK1089
					</a>
				</td>
		<td>
					
					
						
					
						
					
						
					
					3/0 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>T/T</td>
		<td>XINGANG</td>
		<td>SEPTEMBER MOON</td>
		<td>SEA</td>
		<td>FOB</td>
		<td>2012-11-16</td>
		<td>
					
					
					
					
					<font color='blue'>发票</font>
					
				</td>
	</tr>
	</tbody>
</table>
</div>
 
</div>
 
 
</form>
</body>
</html>


