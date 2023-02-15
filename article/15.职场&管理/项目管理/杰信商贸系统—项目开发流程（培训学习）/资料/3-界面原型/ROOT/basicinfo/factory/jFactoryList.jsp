<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../skin/default/css/default.css" media="all" />
	
 	<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../css/extreme/extremecomponents.css" />
    <link rel="stylesheet" rev="stylesheet" type="text/css" href="../../css/extreme/extremesite.css" />
	<script type="text/javascript" src="../../js/common.js"></script>
</head>
	
<body>
<form name="form2">
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="view"><a href="#">查看</a></li>
<li id="new"><a href="#">新建</a></li>
<li id="update"><a href="#">修改</a></li>
<li id="delete"><a href="#">删除</a></li>
<li id="new"><a href="#">启用</a></li>
<li id="new"><a href="#">停止</a></li>
 
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
        <h2>厂家列表</h2> 
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
<option value='' selected>--请选择--</option><option value='fullName'>全称</option><option value='factoryName'>简称</option><option value='contractor'>联系人</option><option value='phone'>电话</option><option value='mobile'>手机</option><option value='fax'>传真</option><option value='cnote'>说明</option>
</select>
 
内容：	            	
<input type="text" name="f_conditionStr" value="" size="30"
	onFocus="this.select();"
	onKeyDown="javascript:if(event.keyCode==13){ document.getElementById('btnFind').onclick(); }"
/>
 
<input id="btnFind" type="button" name="查询" value="查询">
<input type="button" name="清空" value="清空" onclick="findReset();this.blur();">
 
</div>
</fieldset>
</div>
</span>
 
 
    
<div>
	
			 
			
			
				
		 		
		 		
				
				
				
				
				
				
				
				
				
			
	
			 
			
			
				
		 		
		 		
				
				
				
				
				
				
				
				
				
			
	
			 
			
			
				
		 		
		 		
				
				
				
				
				
				
				
				
				
			
	
			 
			
			
				
		 		
		 		
				
				
				
				
				
				
				
				
				
			
	
			 
			
			
				
		 		
		 		
				
				
				
				
				
				
				
				
				
			
	
			 
			
			
				
		 		
		 		
				
				
				
				
				
				
				
				
				
			
	
			 
			
			
				
		 		
		 		
				
				
				
				
				
				
				
				
				
			
	
			 
			
			
				
		 		
		 		
				
				
				
				
				
				
				
				
				
			
	
			 
			
			
				
		 		
		 		
				
				
				
				
				
				
				
				
				
			
	
			 
			
			
				
		 		
		 		
				
				
				
				
				
				
				
				
				
			
	
			 
			
			
				
		 		
		 		
				
				
				
				
				
				
				
				
				
			
	
<div>
<input type="hidden"  name="ec_i"  value="ec" />
<input type="hidden"  name="ec_eti" />
<input type="hidden"  name="ec_ev" />
<input type="hidden"  name="ec_efn" />
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
				<td class="statusBar" >找到41 条记录, 显示 1 到 10 </td>
				<td class="compactToolbar"  align="right" >
				<table border="0"  cellpadding="1"  cellspacing="2" >
					<tr>
					<td><img src="/images/table/firstPageDisabled.gif"  style="border:0"  alt="第一页" /></td>
					<td><img src="/images/table/prevPageDisabled.gif"  style="border:0"  alt="上一页" /></td>
					<td><a href="javascript:document.forms.form2.ec_eti.value='';document.forms.form2.ec_p.value='2';document.forms.form2.setAttribute('action', 'doFactoryListAction.do');document.forms.form2.setAttribute('method', 'post');document.forms.form2.submit()"><img src="/images/table/nextPage.gif"  style="border:0"  title="下一页"  alt="下一页" /></a></td>
					<td><a href="javascript:document.forms.form2.ec_eti.value='';document.forms.form2.ec_p.value='5';document.forms.form2.setAttribute('action', 'doFactoryListAction.do');document.forms.form2.setAttribute('method', 'post');document.forms.form2.submit()"><img src="/images/table/lastPage.gif"  style="border:0"  title="最后页"  alt="最后页" /></a></td>
					<td><img src="/images/table/separator.gif"  style="border:0"  alt="Separator" /></td>
					<td><select name="ec_rd"  onchange="javascript:document.forms.form2.ec_eti.value='';document.forms.form2.ec_crd.value=this.options[this.selectedIndex].value;document.forms.form2.ec_p.value='1';document.forms.form2.setAttribute('action', 'doFactoryListAction.do');document.forms.form2.setAttribute('method', 'post');document.forms.form2.submit()" >
				<option value="10"  selected="selected">10</option><option value="50" >50</option><option value="100" >100</option>
				</select></td>
					<td><img src="/images/table/separator.gif"  style="border:0"  alt="Separator" /></td>
					<td><a href="#"><img src="/images/table/xls.gif"  style="border:0"  title="Export Excel"  alt="Excel" /></a></td>
					</tr>
				</table></td>
			</tr>
		</table>
		</td>
	</tr>		
 
	<tr>
		<td class="tableHeader" ><input type="checkbox"  id="id_selector"  name="id_selector"  title="(Un)Select All"  onclick="for(i = 0; i < document.getElementsByName('id').length; i++)document.getElementsByName('id').item(i).checked=document.getElementById('id_selector').checked;" ></td>
		<td class="tableHeader"  style="text-align: center" >状态</td>
		<td class="tableHeader" >类型</td>
		<td class="tableHeader" >厂家全称</td>
		<td class="tableHeader" >简称</td>
		<td class="tableHeader" >联系人</td>
		<td class="tableHeader" >联系电话</td>
		<td class="tableHeader" >手机</td>
		<td class="tableHeader" >传真</td>
		<td class="tableHeader" >验货员</td>
	</tr>
	</thead>
	<tbody class="tableBody" >
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td> 
		 			<input type="checkbox" name="id" dataType="复选框" dispName="厂家管理" minSelect="1"  value="4028817a3ae2ac42013ae3550357000d"/>
		 		</td>
		<td style="text-align: center" >&nbsp;</td>
		<td>蜡</td>
		<td>
					<a href="#">
					华清蜡厂
					</a>
				</td>
		<td>华清蜡厂</td>
		<td>王波</td>
		<td>1903219</td>
		<td>&#160;</td>
		<td>&#160;</td>
		<td>&#160;</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td> 
		 			<input type="checkbox" name="id" dataType="复选框" dispName="厂家管理" minSelect="1"  value="4028817a3abe8f15013ac019a61f0031"/>
		 		</td>
		<td style="text-align: center" >&nbsp;</td>
		<td>玻璃</td>
		<td>
					<a href="#">
					福来电镀厂
					</a>
				</td>
		<td>电镀厂</td>
		<td>王乃卫</td>
		<td>082581</td>
		<td>&#160;</td>
		<td>&#160;</td>
		<td>李光</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td> 
		 			<input type="checkbox" name="id" dataType="复选框" dispName="厂家管理" minSelect="1"  value="4028817a3aa9f950013ab97f64110053"/>
		 		</td>
		<td style="text-align: center" >&nbsp;</td>
		<td>玻璃</td>
		<td>
					<a href="#">
					远玻璃制品有限公司
					</a>
				</td>
		<td>致远厂</td>
		<td>曹升</td>
		<td>18236896660</td>
		<td>&#160;</td>
		<td>&#160;</td>
		<td>&#160;</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td> 
		 			<input type="checkbox" name="id" dataType="复选框" dispName="厂家管理" minSelect="1"  value="4028817a3aa9f950013ab0b6c98d0050"/>
		 		</td>
		<td style="text-align: center" >&nbsp;</td>
		<td>玻璃</td>
		<td>
					<a href="#">
					一先厂
					</a>
				</td>
		<td>一先厂</td>
		<td>李权刚</td>
		<td>08470</td>
		<td>&#160;</td>
		<td>&#160;</td>
		<td>李光</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td> 
		 			<input type="checkbox" name="id" dataType="复选框" dispName="厂家管理" minSelect="1"  value="4028817a39b2b37f0139b46268c40025"/>
		 		</td>
		<td style="text-align: center" >&nbsp;</td>
		<td>玻璃</td>
		<td>
					<a href="#">
					玻璃厂
					</a>
				</td>
		<td>馨艺</td>
		<td>袁厂长</td>
		<td>41338</td>
		<td>&#160;</td>
		<td>&#160;</td>
		<td>李光</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td> 
		 			<input type="checkbox" name="id" dataType="复选框" dispName="厂家管理" minSelect="1"  value="4028817a389cc7b701389d1efd940001"/>
		 		</td>
		<td style="text-align: center" >&nbsp;</td>
		<td>彩盒</td>
		<td>
					<a href="#">
					包装彩印厂
					</a>
				</td>
		<td>包装厂</td>
		<td>翟帅</td>
		<td>0399123</td>
		<td>3470988</td>
		<td>0098123</td>
		<td>&#160;</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td> 
		 			<input type="checkbox" name="id" dataType="复选框" dispName="厂家管理" minSelect="1"  value="4028817a38736298013874c51a800036"/>
		 		</td>
		<td style="text-align: center" >&nbsp;</td>
		<td>玻璃</td>
		<td>
					<a href="#">
					玻璃有限公司
					</a>
				</td>
		<td>展厂</td>
		<td>史厂长</td>
		<td>04-526186</td>
		<td>348800</td>
		<td>326197</td>
		<td>李光</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td> 
		 			<input type="checkbox" name="id" dataType="复选框" dispName="厂家管理" minSelect="1"  value="4028817a382b4fd401382b9aad2a0008"/>
		 		</td>
		<td style="text-align: center" >&nbsp;</td>
		<td>玻璃</td>
		<td>
					<a href="#">
					仲玉玻璃厂
					</a>
				</td>
		<td>仲</td>
		<td>吕军</td>
		<td>0354-5018888</td>
		<td>&#160;</td>
		<td>&#160;</td>
		<td>李光</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td> 
		 			<input type="checkbox" name="id" dataType="复选框" dispName="厂家管理" minSelect="1"  value="4028817a38024a04013803e3a8a2004b"/>
		 		</td>
		<td style="text-align: center" >&nbsp;</td>
		<td>保丽龙</td>
		<td>
					<a href="#">
					泡沫有限公司
					</a>
				</td>
		<td>泡沫厂</td>
		<td>杰</td>
		<td>0839793</td>
		<td>&#160;</td>
		<td>&#160;</td>
		<td>&#160;</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td> 
		 			<input type="checkbox" name="id" dataType="复选框" dispName="厂家管理" minSelect="1"  value="4028817a37583d45013758d152450038"/>
		 		</td>
		<td style="text-align: center" >&nbsp;</td>
		<td>玻璃</td>
		<td>
					<a href="#">
					顺驰厂
					</a>
				</td>
		<td>驰</td>
		<td>王明</td>
		<td>03398</td>
		<td>&#160;</td>
		<td>&#160;</td>
		<td>李光</td>
	</tr>
	</tbody>
</table>
</div>
 
</div>
 
 
 
</form>
 
</body>
</html>

