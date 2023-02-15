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
		if(serviceName=="查看"||serviceName=="修改"||serviceName=="删除"||serviceName=="附件"||serviceName=="归档"||serviceName=="撤消"||serviceName=="打印"||serviceName=="上报"||serviceName=="取消"){
			if(_CheckAll(true,serviceName) == false){
	            return false;
	 		}
			if(serviceName=="删除"){
				return confirm("您确定要将所选记录删除吗?\n单击【确定】将删除所选记录! 单击【取消】将终止删除操作!");
			}
		}
	}
	
	function preCheck(serviceName) {
       	if(serviceName=="查看"||serviceName=="修改"||serviceName=="附件"||serviceName=="报运"||serviceName=="委托"||serviceName=="装箱"||serviceName=="发票"||serviceName=="财务"||serviceName=="打印"){
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
<li id="view"><a href="jContractView.jsp">查看</a></li>
<li id="new"><a href="jContractCreate.jsp">新建</a></li>
<li id="update"><a href="jContractUpdate.jsp">修改</a></li>
<li id="delete"><a href="#">删除</a></li>
<li id="stat"><a href="jOutProduct.jsp">出货表</a></li>
<li id="print"><a href="contract.xls" target="_blank">打印</a></li>
<li id="new"><a href="#">上报</a></li>
<li id="new"><a href="#">取消</a></li>
<li id="back"><a href="#">复制</a></li>
 
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
        <h2>购销合同列表</h2> 
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
<option value='' selected>--请选择--</option><option value='contractNo'>合同号</option><option value='contractProduct.productNo'>货号</option><option value='inputBy'>制单人</option><option value='checkBy'>审单人</option><option value='inspector'>验货员</option>
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
		<td colspan="10" >
		<table border="0"  cellpadding="0"  cellspacing="0"  width="100%" >
			<tr>
				<td class="statusBar" >找到215 条记录, 显示 1 到 10 </td>
				<td class="compactToolbar"  align="right" >
				<table border="0"  cellpadding="1"  cellspacing="2" >
					<tr>
					<td><img src="/images/table/firstPageDisabled.gif"  style="border:0"  alt="第一页" /></td>
					<td><img src="/images/table/prevPageDisabled.gif"  style="border:0"  alt="上一页" /></td>
					<td><a href="javascript:document.forms.form2.ec_p.value='2';document.forms.form2.setAttribute('action', 'doContractListAction.do');document.forms.form2.setAttribute('method', 'post');document.forms.form2.submit()"><img src="/images/table/nextPage.gif"  style="border:0"  title="下一页"  alt="下一页" /></a></td>
					<td><a href="javascript:document.forms.form2.ec_p.value='22';document.forms.form2.setAttribute('action', 'doContractListAction.do');document.forms.form2.setAttribute('method', 'post');document.forms.form2.submit()"><img src="/images/table/lastPage.gif"  style="border:0"  title="最后页"  alt="最后页" /></a></td>
					<td><img src="/images/table/separator.gif"  style="border:0"  alt="Separator" /></td>
					<td><select name="ec_rd"  onchange="javascript:document.forms.form2.ec_crd.value=this.options[this.selectedIndex].value;document.forms.form2.ec_p.value='1';document.forms.form2.setAttribute('action', 'doContractListAction.do');document.forms.form2.setAttribute('method', 'post');document.forms.form2.submit()" >
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
		<td class="tableHeader" >合同号</td>
		<td class="tableHeader" >货物数/附件数</td>
		<td class="tableHeader" >客户名称</td>
		<td class="tableHeader" >交期</td>
		<td class="tableHeader" >船期</td>
		<td class="tableHeader" >签单日期</td>
		<td class="tableHeader" >总金额</td>
		<td class="tableHeader" >状态</td>
		<td class="tableHeader" >走货状态</td>
	</tr>
	</thead>
	<tbody class="tableBody" >
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="购销合同管理" minSelect="1" value="4028817a3a4303cb013a4497bebf000d"/>
				</td>
		<td>
					<a href="jContractView.jsp">
					102811
					</a>
				</td>
		<td>
					
					
						
					
						
					
						
					
						
					
					4/0 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>INDABA</td>
		<td>2012-11-23</td>
		<td>2012-11-30</td>
		<td>2012-10-10</td>
		<td>16,864.00  </td>
		<td>
					
					已上报
					
				</td>
		<td>
					
					
					
					
						
						
					
						
						
					
						
						
					
						
						
					
					
					
					<font color="green">全部</font>
				</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="购销合同管理" minSelect="1" value="4028817a39bcfe9f0139be8f8ac2000c"/>
				</td>
		<td>
					<a href="jContractView.jsp">
					12JK1081
					</a>
				</td>
		<td>
					
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
							
						
					
						
							
						
					
						
							
						
					
						
					
						
					
						
					
						
							
						
					
						
					
						
					
					17/4 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>BRISSI</td>
		<td>2012-11-10</td>
		<td>2012-11-26</td>
		<td>2012-09-13</td>
		<td>65,308.00  </td>
		<td>
					
					已上报
					
				</td>
		<td>
					
					
					
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
					
					<font color="red">部分</font>
					
				</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="购销合同管理" minSelect="1" value="4028817a39c440a20139d20b3ff80006"/>
				</td>
		<td>
					<a href="jContractView.jsp">
					C/2211/12
					</a>
				</td>
		<td>
					
					
						
							
						
					
						
					
					2/1 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>HOME</td>
		<td>2012-10-20</td>
		<td>2012-10-30</td>
		<td>2012-09-17</td>
		<td>12,000.00  </td>
		<td>
					
					已上报
					
				</td>
		<td>
					
					
					
					
						
						
					
						
						
					
					
					
					<font color="green">全部</font>
				</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="购销合同管理" minSelect="1" value="4028817a3a6c2ae7013a6df8e8c20002"/>
				</td>
		<td>
					<a href="jContractView.jsp">
					12JK1092
					</a>
				</td>
		<td>
					
					
						
							
						
					
						
							
						
					
					2/2 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>ACCENT IMPORTS</td>
		<td>2012-11-15</td>
		<td>2012-11-30</td>
		<td>2012-10-17</td>
		<td>7,296.00  </td>
		<td>
					
					已上报
					
				</td>
		<td>
					
					
					
					
						
						
					
						
						
					
					
					
					<font color="green">全部</font>
				</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="购销合同管理" minSelect="1" value="4028817a3a670a6f013a68766d460001"/>
				</td>
		<td>
					<a href="jContractView.jsp">
					C/2256/12
					</a>
				</td>
		<td>
					
					
						
							
						
					
						
							
						
					
						
							
						
					
						
							
						
					
						
							
						
					
						
							
						
					
					6/6 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>HOME</td>
		<td>2012-11-25</td>
		<td>2012-12-15</td>
		<td>2012-05-28</td>
		<td>30,120.00  </td>
		<td>
					
					已上报
					
				</td>
		<td>
					
					
					
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
					<font color="blue">未走货</font>
					<font color="red">部分</font>
					
				</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="购销合同管理" minSelect="1" value="4028817a39facfc90139fb6f6c160001"/>
				</td>
		<td>
					<a href="jContractView.jsp">
					12JK1089
					</a>
				</td>
		<td>
					
					
						
					
						
					
						
					
					3/0 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>SEPTEMBER MOON</td>
		<td>2012-11-30</td>
		<td>2012-09-25</td>
		<td>2012-09-25</td>
		<td>33,600.00  </td>
		<td>
					
					已上报
					
				</td>
		<td>
					
					
					
					
						
						
					
						
						
					
						
						
					
					
					
					<font color="green">全部</font>
				</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="购销合同管理" minSelect="1" value="4028817a39f5a6af0139f61ca4820001"/>
				</td>
		<td>
					<a href="jContractView.jsp">
					I1201048
					</a>
				</td>
		<td>
					
					
						
							
						
					
						
							
						
					
						
							
						
							
						
							
						
					
						
							
						
					
						
							
						
					
						
					
					6/7 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>RIVIERA MAISON</td>
		<td>2012-11-22</td>
		<td>2012-12-06</td>
		<td>2012-09-24</td>
		<td>101,960.00  </td>
		<td>
					
					已上报
					
				</td>
		<td>
					
					
					
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
					
					
					<font color="green">全部</font>
				</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="购销合同管理" minSelect="1" value="4028817a38df83f70138e61243c70031"/>
				</td>
		<td>
					<a href="jContractView.jsp">
					12JK1073
					</a>
				</td>
		<td>
					
					
						
							
						
					
						
					
						
					
						
					
						
					
						
					
						
					
					7/1 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>TANIA</td>
		<td>2012-11-15</td>
		<td>2012-11-30</td>
		<td>2012-09-20</td>
		<td>103,394.40  </td>
		<td>
					
					已上报
					
				</td>
		<td>
					
					
					
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
						
						
					
					
					
					<font color="green">全部</font>
				</td>
	</tr>
	<tr class="odd"  onmouseover="this.className='highlight'"  onmouseout="this.className='odd'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="购销合同管理" minSelect="1" value="4028817a37d9b16c0137e9f9b83f0036"/>
				</td>
		<td>
					<a href="jContractView.jsp">
					C/1850/12
					</a>
				</td>
		<td>
					
					
						
					
						
					
					2/0 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>HOME</td>
		<td>2012-09-20</td>
		<td>2012-10-06</td>
		<td>2012-06-14</td>
		<td>38,400.00  </td>
		<td>
					
					已上报
					
				</td>
		<td>
					
					
					
					
						
						
					
						
						
					
					
					
					<font color="green">全部</font>
				</td>
	</tr>
	<tr class="even"  onmouseover="this.className='highlight'"  onmouseout="this.className='even'" >
		<td>
					<input type="checkbox" name="id" dataType="复选框" dispName="购销合同管理" minSelect="1" value="4028817a39bcfe9f0139be999204004e"/>
				</td>
		<td>
					<a href="jContractView.jsp">
					12JK1084
					</a>
				</td>
		<td>
					
					
						
							
						
					
						
					
						
							
						
					
					3/2 <!-- 无法两次级联,所以通过forecach循环 -->
				</td>
		<td>BRISSI</td>
		<td>2012-11-10</td>
		<td>2012-11-26</td>
		<td>2012-09-13</td>
		<td>11,880.00  </td>
		<td>
					
					已上报
					
				</td>
		<td>
					
					
					
					
						
						
					
						
						
					
						
						
					
					
					
					<font color="green">全部</font>
				</td>
	</tr>
	</tbody>
</table>
</div>
 
</div>
 
 
</form>
</body>
</html>

