<%@ page language="java" pageEncoding="UTF-8"%>
<!-- html标识扩展，定义名字空间 -->
<html xmlns="http://www.w3.org/1999/xhtml">
 
<head>
    <title></title>
 
    <link rel="stylesheet" rev="stylesheet" type="text/css" href="/skin/default/css/default.css" media="all" title="default" />
	<link rel="stylesheet" rev="stylesheet" type="text/css" href="/skin/default/css/main.css" media="all"/>
	<script type="text/javascript" src="../../js/datepicker/WdatePicker.js"></script>
	
	<link rel="StyleSheet" href="../../js/dtree/tdtree/dtree.css" type="text/css" />
	<script type="text/javascript" src="../../js/dtree/tdtree/dtree.js"></script>
	<script type="text/javascript" src="../../js/common.js"></script>
	
	<script type="text/javascript" src="../../components/jquery-ui/jquery-1.2.6.js"></script>
	<script type="text/javascript" src="../../js/tabledo.js"></script>
	<script type="text/javascript" src="../../js/ajax/getSysCodeList.js"></script>
	
	<script language="JavaScript">
  	function preSubmit(serviceName) {
        if(serviceName=="返回"){
            return true;
        } else if (serviceName=="确定"){
        	doLastTR("resultTable");	//如果最后一行为空在删除,这样就不会因_CheckAll监测最后一行为空而提示未填写了
            return _CheckAll(true,serviceName);
        }
    }
	    
     $().ready(function(){
        sndReqFind('01');
     });
 
	function addTRRecord(objId, id, name, ico, state, cnote, quoteNum) {
		if(state=="null"){ state="0"; }
		
		var _tmpSelect = "";
		var tableObj = document.getElementById(objId);
		oTR = tableObj.insertRow();
		
		oTD = oTR.insertCell(0);
		oTD.style.width="25px";
		oTD.style.whiteSpace="nowrap";
		oTD.ondragover = function(){this.className="drag_over" };	//动态加事件, 改变样式类
		oTD.ondragleave = function(){this.className="drag_leave" };
		oTD.onmousedown = function(){ clearTRstyle("result"); this.parentNode.style.background = '#0099cc';};	
		//this.style.background="#0099cc url(../images/arroww.gif) 4px 9px no-repeat";
		oTD.innerHTML = "&nbsp;&nbsp;";		
		oTD = oTR.insertCell(1);
		oTD.style.width="25px";
		oTD.style.whiteSpace="nowrap";
		oTD.style.textAlign="center";
		oTD.innerHTML = "<input class=\"input\" type=\"checkbox\" name=\"del\" value=\""+id+"\"><input type=\"hidden\" name=\"id\" value=\""+id+"\"><input class=\"input\" type=\"hidden\" id=\"mr_changed\" name=\"mr_changed\">";
		oTD = oTR.insertCell(2);
		oTD.innerHTML = "<input class=\"input\" type=\"text\" name=\"orderNo\" readonly size=\"3\" value=\"\">";
		oTD = oTR.insertCell(3);
		oTD.innerHTML = "<input type=\"text\" name=\"name\" value=\""+name+"\" dataType=\"非空字符串\" dispName=\"名称\" maxLength=\"100\" style=\"width:200px;width:100%;\" onFocus=\"this.select();\" onBlur=\"setTRUpdateFlag(this);\" onmouseup=\"showTheWrite(this.value)\" onkeyup=\"showTheWrite(this.value)\" onKeydown=\"showTheWrite(this.value)\">";
		oTD = oTR.insertCell(4);
		oTD.innerHTML = "<input type=\"text\" name=\"ico\" value=\""+ico+"\" dataType=\"字符串\" dispName=\"图标\" style=\"width:150px;width:100%;\" maxLength=\"20\" onFocus=\"this.select();\" onBlur=\"setTRUpdateFlag(this);\" onmouseup=\"showTheWrite(this.value)\" onkeyup=\"showTheWrite(this.value)\" onKeydown=\"showTheWrite(this.value)\">";
		oTD = oTR.insertCell(5);
			_tmpSelect = "";
			_tmpSelect += "<input type=\"hidden\" name=\"state\" value=\""+state+"\">";
			_tmpSelect += "<input class=\"input\" type=\"checkbox\" name=\"ckt_state\" value=\""+state+"\"";
			if(state=="1"){
				_tmpSelect += " checked";
			}
			_tmpSelect += " onclick=\"if(this.checked){previousSibling.value=1;}else{previousSibling.value=0;}\" onBlur=\"setTRUpdateFlag(previousSibling);\">";
		oTD.innerHTML = _tmpSelect;
 
		oTD = oTR.insertCell(6);
		oTD.innerHTML = "<input type=\"text\" name=\"cnote\" value=\""+cnote+"\" dataType=\"字符串\" dispName=\"备注\" style=\"width:200px;width:100%;\" maxLength=\"100\" onFocus=\"this.select();\" onBlur=\"setTRUpdateFlag(this);\" onmouseup=\"showTheWrite(this.value)\" onkeyup=\"showTheWrite(this.value)\" onKeydown=\"showTheWrite(this.value)\">";
		oTD = oTR.insertCell(7);
		oTD.innerHTML = "<input type=\"text\" name=\"quoteNum\" value=\""+quoteNum+"\" dataType=\"非空数字\" dispName=\"引用次数\" style=\"width:50px;width:100%;\" maxLength=\"1\" onFocus=\"this.select();\" onBlur=\"setTRUpdateFlag(this);\" onmouseup=\"showTheWrite(this.value)\" onkeyup=\"showTheWrite(this.value)\" onKeydown=\"showTheWrite(this.value)\">";
 
		dragtableinit();	//拖动表格行
		sortnoTR();			//排序号
	}
	
	function treeStyle(obj) {
        var t = obj.innerText;
        if(t == "[展开树]") {
            obj.innerText = "[折叠树]";
            d_tree.oAll(open);
        } else {
            obj.innerText = "[展开树]";
            d_tree.oAll(closed);
        }
        
    }
	    
	</script>
</head>
 
<body>
<form>
<div class="textbox" id="centerTextbox">
 
	<input type="hidden" name="delIds" value=""/>
	<input type="hidden" id="mainId" name="mainId"/>
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="save"><a href="#">确定</a></li>
 
</ul>
    </div>
</div>
</div>
</div>
     
        <table class="commonTable_main">
        	<tr>
        		<td class="modelTitle" colspan="2">&nbsp;系统代码管理 (两级树形结构)&nbsp;&nbsp;
        		<span>
					<a href="#" onclick="treeStyle(this);">[展开树]</a>
				</span>
				&nbsp;> 您输入的内容是:&nbsp;
				<span id="div_write" style="color:blue;"/></span>
        		</td>
        	</tr>
			<tr>
				<td valign="top" style="BACKGROUND: #f0fcfa; FONT: 8pt 宋体;padding:20px;width:150px;">
<div class="dtree">
			<div class="dtree">
<script type="text/javascript"> 
d_tree = new dTree("d_tree","../../js/dtree/tdtree/");
d_tree.add("0101","01","人员级别","javascript:clearDelId();sndReqFind('0101');");
d_tree.add("0102","01","栏目","javascript:clearDelId();sndReqFind('0102');");
d_tree.add("0103","01","厂家类型","javascript:clearDelId();sndReqFind('0103');");
d_tree.add("0104","01","附件类型","javascript:clearDelId();sndReqFind('0104');");
d_tree.add("010102","0101","管理员","javascript:clearDelId();");
d_tree.add("010103","0101","总经理","javascript:clearDelId();");
d_tree.add("010104","0101","部门经理","javascript:clearDelId();");
d_tree.add("010105","0101","组长","javascript:clearDelId();");
d_tree.add("010106","0101","员工","javascript:clearDelId();");
d_tree.add("010202","0102","新闻报道","javascript:clearDelId();");
d_tree.add("010203","0102","通知公告","javascript:clearDelId();");
d_tree.add("010204","0102","公司制度","javascript:clearDelId();");
d_tree.add("010205","0102","行业报道","javascript:clearDelId();");
d_tree.add("010206","0102","大事记","javascript:clearDelId();");
d_tree.add("010302","0103","玻璃","javascript:clearDelId();");
d_tree.add("010303","0103","彩盒","javascript:clearDelId();");
d_tree.add("010304","0103","PVC","javascript:clearDelId();");
d_tree.add("010305","0103","花纸","javascript:clearDelId();");
d_tree.add("010306","0103","保丽龙","javascript:clearDelId();");
d_tree.add("010307","0103","电镀","javascript:clearDelId();");
d_tree.add("010308","0103","水龙头","javascript:clearDelId();");
d_tree.add("010309","0103","蜡","javascript:clearDelId();");
d_tree.add("010402","0104","彩盒","javascript:clearDelId();");
d_tree.add("010403","0104","花纸","javascript:clearDelId();");
d_tree.add("010404","0104","保丽龙","javascript:clearDelId();");
d_tree.add("010405","0104","电镀","javascript:clearDelId();");
d_tree.add("010406","0104","蜡","javascript:clearDelId();");
d_tree.add("010407","0104","PVC","javascript:clearDelId();");
d_tree.add("010408","0104","喷头","javascript:clearDelId();");
d_tree.add("010409","0104","不锈钢勺子","javascript:clearDelId();");
d_tree.add("010410","0104","asdf","javascript:clearDelId();");
d_tree.add("010411","0104","afe","javascript:clearDelId();");
d_tree.add("01","-1","系统代码","javascript:clearDelId();sndReqFind('01');");
document.write(d_tree);
</script>
</div>
		
</div>
				</td>
				<td valign="top">
 
	<div style="text-align:center;padding:5px;">
		<div class="listTablew">
		<table class="commonTable_main" cellSpacing="1" id="resultTable" style="width:100%;text-align:left;">
			<tr class="rowTitle" align="middle">
				<td title="可以拖动下面行首,实现记录的位置移动."><img src="../../images/drag.gif"></td>
				<td width="25"><input class="input" type="checkbox" name="ck_del" onclick="checkGroupBox(this);" /></td>
				<td width="30">序号</td>
				<td nowrap>名称</td>
				<td nowrap>图标</td>
				<td nowrap title="0停用 1启用" width="30">状态</td>
				<td nowrap>备注</td>
				<td nowrap title="引用一次以上次节点既不能删除" width="40">引用<br/>次数</td>
			</tr>
		</table>
		</div>
	</div>
	
			<div style="float:left;left:5px;top:138px;font-size:12px;color:gray;font-weight:normal;padding:12px;text-align:left;">
			       <div style="float:left;"><img style="margin:0 5px 0 0;" src="../../skin/default/images/notice.gif" /></div>
			       <div style="float:left;padding-left:10px;">可以拖动行首,实现记录的位置移动。或者上移、下移按钮,实现记录的位置的上下移动。</div>
			</div>
			
			<div style="float:right;padding:10px;white-space: nowrap;">
			<button class="b_button" style="MARGIN-RIGHT: 10px" onclick="clearTRstyle('result'); newTRRecord('resultTable', true);dragtableinit();sortnoTR();" name="add" value="add">增加一条</button>
			<button class="b_button" style="MARGIN-RIGHT: 10px" onclick="delIdsRecord('del');delTRRecord('del','resultTable',1);sortnoTR();" name="delone" value="delone">删除</button>
			<button class="b_button" style="MARGIN-RIGHT: 10px" onclick="swapTRRecord('del','resultTable',1,'up');sortnoTR();" name="btnSwapUp">上移</button>
			<button class="b_button" style="MARGIN-RIGHT: 10px" onclick="swapTRRecord('del','resultTable',1,'dn');sortnoTR();" name="btnSwapDown">下移</button>
			</div> 
 
				</td>
        	</tr>
        </table>
 
 
 
<div id="div_Info"></div>
 
</div>
</form>
</body>
</html>

