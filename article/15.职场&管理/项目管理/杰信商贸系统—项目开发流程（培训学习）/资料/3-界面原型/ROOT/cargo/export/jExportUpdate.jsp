<%@ page language="java" pageEncoding="UTF-8"%>

<!-- 告诉浏览器本网页符合XHTML1.0过渡型DOCTYPE -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
 
    <!-- 调用样式表 -->
	<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../skin/default/css/default.css" media="all" />
    <script type="text/javascript" src="../../js/datepicker/WdatePicker.js"></script>
	<script type="text/javascript" src="../js/tabledo.js"></script>
	
<script language="JavaScript"> 
   		
  	function preSubmit(serviceName) {
        if(serviceName=="返回"){
            return true;
        }else if (serviceName=="确定"||serviceName=="暂存"||serviceName=="货物"){
			doLastTR("resultTable");	//如果最后一行为空在删除,这样就不会因_CheckAll监测最后一行为空而提示未填写了
			return _CheckAll(true,serviceName);
        }
	}
	
	function preCheck(serviceName) {
       	if(serviceName=="货物"){
    		FormSubmit('/cargo/toProductSelectAction.do?id=4028817a3b3a59cd013b3b5bbd94001a','');
    	}
	}
	
	
    $().ready(function(){
		//addTRRecord('resultTable','','','','','','');	//默认增加一个空行
		addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d002d','JK0007/JK1101025','套6全明料刻网格酒杯，网格描亮油<br>尺寸：8.5X25 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸60X31X30CM ,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','5.50','3.50','61.50','30.50','30.50','11.58','63.00','c480978b-62e3-4efd-a38d-cbb20899ef68.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d0026','JK0008/JK1101026','套6全明料刻网格酒杯，网格描亮油<br>尺寸：7.7X23.5 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸55X29X28.5 CM ,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','5.50','3.50','56.50','27.50','28.50','10.83','60.00','883938f8-9c1a-407d-a017-6b395b86b919.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d0029','JK0009/JK1101027','套6全明料刻网格香槟杯，网格描亮油<br>尺寸：5.8X27 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸44X23.5X32CM ,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','5.00','3.00','55.50','26.50','32.00','10.83','57.00','948f3d34-8cd3-4883-b905-6a8d5e97bb2f.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d0030','JK0010/JK1102290-G','套6全明料刻花酒杯，描亮油，口部描3MM黄金<br>尺寸：8X23.5 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸57X30X28.5CM ,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','5.50','3.50','58.50','28.00','28.50','11.32','61.20','24f52aff-2177-4aae-89a8-c3fb801b09a2.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d0024','JK0011/JK1102291-G','套6全明料刻花酒杯，描亮油，口部描3MM黄金<br>尺寸：7.5X21.5 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸54X28X26.5CM ,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','5.00','3.00','58.50','28.00','26.50','10.71','60.00','15c81f0d-3594-4411-9a1e-c214a8b849ca.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e0e001e','JK0012/JK1102292-G','套6全明料刻花香槟杯，描亮油，口部描3MM黄金<br>尺寸：6X25.5 CM H<br>1套/五层内盒   4套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸45X30.5X30.5CM ,如果实际尺寸相差较大请及时通知我司。','宏艺','1/4','SETS','20','200','5','5.50','3.50','49.50','33.00','30.50','10.10','57.00','8db5bacc-9a49-45cd-b441-1c86aba83214.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d0027','JK0013/JK1102295-G','套6全明料刻花低口杯，描亮油，口部描3MM黄金<br>尺寸：8X9.5 CM H<br>1套/五层内盒   4套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸57X20.5X25CM ,如果实际尺寸相差较大请及时通知我司。','宏艺','1/4','SETS','20','200','5','7.00','5.00','46.00','32.50','27.50','10.10','57.00','7f231a16-a93e-439c-b261-cb1458c2a857.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e0e001f','JK0014/JK1102290','套6全明料刻花酒杯，描亮油，口部描3MM白金<br>尺寸：8X23.5 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸57X30X28.5CM ,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','5.50','3.50','58.50','28.00','28.50','11.32','61.20','a7c889de-fded-4ec7-963e-04e18c582fb6.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d002f','JK0015/JK1102291','套6全明料刻花酒杯，描亮油，口部描3MM白金<br>尺寸：7.5X21.5 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸54X28X26.5CM ,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','5.00','3.00','58.50','28.00','26.50','10.71','60.00','2639a0d1-79a7-426b-ab1d-3cd4ce6dcc25.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d0022','JK0016/JK1102292','套6全明料刻花香槟杯，描亮油，口部描3MM白金<br>尺寸：6X25.5 CM H<br>1套/五层内盒   4套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸45X30.5X30.5CM ,如果实际尺寸相差较大请及时通知我司。','宏艺','1/4','SETS','20','200','5','5.50','3.50','49.00','33.00','30.50','10.10','57.00','031edc74-5f75-4e44-a0a3-e2fa77ea8344.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d0025','JK0017/JK1102295','套6全明料刻花低口杯，描亮油，口部描3MM白金<br>尺寸：8X9.5 CM H<br>1套/五层内盒   4套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸57X20.5X25CM ,如果实际尺寸相差较大请及时通知我司。','宏艺','1/4','SETS','20','200','5','7.00','5.00','46.00','32.50','27.50','10.10','57.00','4f411504-e8bf-4fa0-99e7-2164c132fab6.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d0020','JK0018/JK1102314','套6全明料刻花酒杯，描亮油，口部描3MM黄金，圆珠子描黄金<br>尺寸：8.5X22.5 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸60X31.5X27.5 CM,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','6.50','4.50','61.50','30.50','27.50','12.24','69.00','daf104c4-493d-4483-a1a8-3f4815eb6109.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d0021','JK0019/JK1102315','套6全明料刻花酒杯，描亮油，口部描3MM黄金，圆珠子描黄金<br>尺寸：9.5X23.5 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸66X34X28.5 CM,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','7.50','5.50','67.00','32.50','28.50','13.15','72.00','0a3c80e0-0be6-4e4e-b69b-2eadc27a603e.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d002c','JK0020/JK1102136','套6全明料刻花香槟杯，描亮油，口部描3MM黄金，圆珠子描黄金<br>尺寸：5.5X28  CM H<br>1套/五层内盒   4套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸42X28.5X33 CM,如果实际尺寸相差较大请及时通知我司。','宏艺','1/4','SETS','20','200','5','6.50','4.50','54.00','37.00','33.00','11.93','66.00','2bd5940f-1e8e-4caa-889b-db7e6722c8eb.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d0028','JK0021/JK1102314-S','套6全明料刻花酒杯，描亮油，口部描3MM白金，圆珠子描白金<br>尺寸：8.5X22.5 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸60X31.5X27.5 CM,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','6.50','4.50','61.50','30.50','27.50','12.24','69.00','831679a9-44e1-4f2b-b343-b185fe519894.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d0031','JK0022/JK1102315-S','套6全明料刻花酒杯，描亮油，口部描3MM白金，圆珠子描白金<br>尺寸：9.5X23.5 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸66X34X28.5 CM,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','7.50','5.50','67.00','32.50','28.50','13.15','72.00','4c6a3d70-7243-4e35-9632-9527890dd902.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d002b','JK0023/JK1102136-S','套6全明料刻花香槟杯，描亮油，口部描3MM白金，圆珠子描白金<br>尺寸：5.5X28  CM H<br>1套/五层内盒   4套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸42X28.5X33 CM,如果实际尺寸相差较大请及时通知我司。','宏艺','1/4','SETS','20','200','5','6.50','4.50','54.00','37.00','33.00','11.93','66.00','fd7f404e-bdf0-4f19-9139-0e14a66df32b.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e0e001c','JK0024/JK1104003-D','套6全明料烤蒙砂花纸香槟杯，口部描3MM白金，圆珠子描白金，花纸我司供<br>尺寸：6.3X27  CM H<br>1套/五层内盒   4套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸46.5X32X32 CM,如果实际尺寸相差较大请及时通知我司。','宏艺','1/4','SETS','20','200','5','6.50','4.50','54.00','37.00','32.00','9.48','51.00','5de54629-05a2-4716-a05d-fc2f819dfbd5.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6dfe001b','JK0025/JK1102331-D','套6全明料烤蒙砂花纸酒杯，口部描3MM白金，圆珠子描白金，花纸我司供<br>尺寸：10.5X22 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸72X37X27 CM,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','5.50','3.50','73.50','35.50','27.00','10.71','54.00','a756712e-cd07-4896-b534-3e3737f65d2c.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e0e001d','JK0026/JK1102332-D','套6全明料烤蒙砂花纸酒杯，口部描3MM白金，圆珠子描白金，花纸我司供<br>尺寸：9X19.5 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸63X32.5X24.5 CM,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','5.50','3.50','64.50','31.00','24.50','10.09','52.80','7b20bb90-6f89-4e23-bb63-3798929f9729.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d002e','JK0027/JK1104003','套6全明料刻花香槟杯，描亮油，口部描3MM白金，圆珠子描白金<br>尺寸：6.3X27  CM H<br>1套/五层内盒   4套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸46.5X32X32 CM,如果实际尺寸相差较大请及时通知我司。','宏艺','1/4','SETS','20','200','5','6.50','4.50','54.00','37.00','32.00','10.52','57.00','ffac3ac8-6354-4869-856e-28cfd29f6a02.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d0023','JK0028/JK1102331','套6全明料刻花酒杯，描亮油，口部描3MM白金，圆珠子描白金<br>尺寸：10.5X22  CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸72X37X27CM,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','5.50','3.50','73.50','35.50','27.00','11.75','60.00','70f71a48-e175-45eb-933d-69380c7c8d47.jpg');addTRRecord('resultTable','4028817a3b3a59cd013b3b5e6e1d002a','JK0029/JK1102332','套6全明料刻花酒杯，描亮油，口部描3MM白金，圆珠子描白金<br>尺寸：9X19.5 CM H<br>1套/五层内盒   3套/大箱<br>产品用白纸、瓦纸、汽泡纸包裹入内盒，然后入大箱，大箱用透明胶带工字封口。<br>大箱尺寸63X32.5X24.5 CM,如果实际尺寸相差较大请及时通知我司。','宏艺','1/3','SETS','21','201','7','5.50','3.50','64.50','31.00','24.50','11.13','57.00','be7f2343-5cfc-4dd0-8374-89240af19cca.jpg');
    });
        
	/* 实现表格序号列自动调整 created by tony 20081219 */
	function sortnoTR(){
		sortno('resultTable', 2, 1);
	}
	
	//根据装率和数量自动计算箱数=数量/装率的分母
	function computeBoxNum( loadingRate, qty){
		if(loadingRate!="" && qty!=""){
			if(loadingRate.indexOf("/")>-1){
				_rate = qty/loadingRate.substring(loadingRate.indexOf("/")+1,loadingRate.length);
				return Math.round(_rate);
			}
		}
		return "";
	}
		
	/* 自动计算箱数 tip:利用对象寻找前后对象 by tony 20111020 */
	function keyUpQty( obj ){
		var _boxNum = obj.parentNode.nextSibling.firstChild;
		//if(_boxNum.value==""){
			var _loadingRate = obj.parentNode.previousSibling.firstChild.value;
			_boxNum.value = computeBoxNum(_loadingRate, obj.value);
		//}
	}
		
	function addTRRecord(objId, id, itemNo, description, factory, loadingRate, packingUnit, cnumber, maxcnumber, boxNum, grossWeight, netWeight, sizeLenght, sizeWidth, sizeHeight, exPrice, tax, productImage) {
		//description = description.replaceAll('<br>','\r\n');
		
		var _tmpSelect = "";
		var tableObj = document.getElementById(objId);
		var rowLength = tableObj.rows.length;
		
		oTR = tableObj.insertRow();
		
		oTD = oTR.insertCell(0);
		oTD.style.whiteSpace="nowrap";
		oTD.ondragleave = function(){this.className="drag_leave" };
		oTD.onmousedown = function(){ clearTRstyle("result"); this.parentNode.style.background = '#0099cc';};	
		//this.style.background="#0099cc url(../images/arroww.gif) 4px 9px no-repeat";
		oTD.innerHTML = "&nbsp;&nbsp;";		
		oTD = oTR.insertCell(1);
		oTD.innerHTML = "<input class=\"input\" type=\"checkbox\" name=\"del\" value=\""+id+"\"><input type=\"hidden\" name=\"mr_id\" value=\""+id+"\"><input class=\"input\" type=\"hidden\" id=\"mr_changed\" name=\"mr_changed\">";
		oTD = oTR.insertCell(2);
		oTD.innerHTML = "<input class=\"input\" type=\"text\" name=\"orderNo\" readonly size=\"3\" value=\"\">";
		oTD = oTR.insertCell(3);
		oTD.style.width="10%";
		//oTD.innerHTML = "<img src='/ufiles/jquery/"+productImage+"' class='product_image' height='100'><br>"+itemNo;
		oTD.innerHTML = itemNo;
		oTD = oTR.insertCell(4);
		oTD.style.width="35%";
		oTD.innerHTML = description;
		oTD = oTR.insertCell(5);
		oTD.style.width="5%";
		oTD.innerHTML = factory;
		oTD = oTR.insertCell(6);
		oTD.style.width="5%";
		oTD.innerHTML = loadingRate;
		oTD = oTR.insertCell(7);
		oTD.style.width="5%";
		oTD.innerHTML = "<input type=\"hidden\" name=\"loadingRate\" value=\""+loadingRate+"\">"+packingUnit;
		oTD = oTR.insertCell(8);
		oTD.style.width="5%";
		oTD.innerHTML = "<input type=\"text\" name=\"cnumber\" dataType=\"数字\" dispName=\"数量\" size=\"5\" maxLength=\"10\" value=\""+cnumber+"\" onKeyUp=\"keyUpQty(this)\" onBlur=\"setTRUpdateFlag(this);\">";
		oTD = oTR.insertCell(9);
		oTD.style.width="5%";
		oTD.innerHTML = "<input type=\"text\" name=\"boxNum\" dataType=\"数字\" dispName=\"箱数\" size=\"5\" maxLength=\"10\" value=\""+boxNum+"\" onBlur=\"setTRUpdateFlag(this);\">";
		oTD = oTR.insertCell(10);
		oTD.style.width="5%";
		oTD.innerHTML = "<input type=\"text\" name=\"grossWeight\" dataType=\"数字\" dispName=\"毛重\" size=\"5\" maxLength=\"10\" value=\""+grossWeight+"\" onBlur=\"setTRUpdateFlag(this);\">";
		oTD = oTR.insertCell(11);
		oTD.style.width="5%";
		oTD.innerHTML = "<input type=\"text\" name=\"netWeight\" dataType=\"数字\" dispName=\"净重\" size=\"5\" maxLength=\"10\" value=\""+netWeight+"\" onBlur=\"setTRUpdateFlag(this);\">";
		oTD = oTR.insertCell(12);
		oTD.style.width="5%";
		oTD.innerHTML = "<input type=\"text\" name=\"sizeLenght\" dataType=\"数字\" dispName=\"长\" size=\"5\" maxLength=\"10\" value=\""+sizeLenght+"\" onBlur=\"setTRUpdateFlag(this);\">";
		oTD = oTR.insertCell(13);
		oTD.style.width="5%";
		oTD.innerHTML = "<input type=\"text\" name=\"sizeWidth\" dataType=\"数字\" dispName=\"宽\" size=\"5\" maxLength=\"10\" value=\""+sizeWidth+"\" onBlur=\"setTRUpdateFlag(this);\">";
		oTD = oTR.insertCell(14);
		oTD.style.width="5%";
		oTD.innerHTML = "<input type=\"text\" name=\"sizeHeight\" dataType=\"数字\" dispName=\"高\" size=\"5\" maxLength=\"10\" value=\""+sizeHeight+"\" onBlur=\"setTRUpdateFlag(this);\">";
		oTD = oTR.insertCell(15);
		oTD.innerHTML = "<input type=\"text\" name=\"exPrice\" dataType=\"数字\" dispName=\"出口单价\" size=\"5\" maxLength=\"10\" value=\""+exPrice+"\" onBlur=\"setTRUpdateFlag(this);\">";
		oTD.style.width="5%";
		oTD = oTR.insertCell(16);
		oTD.innerHTML = tax+"<input type=\"hidden\" name=\"tax\" value=\""+tax+"\">";
		oTD.style.width="5%";
 
		
	}
 
</script>
 
<style> 
	.linkBar{ text-align:left;width:100%;padding:15px; }
	.linkSpace{ float:left;margin:6px;padding:5px;border:1px solid gray;background-color:#F2F2F2;width:220px;overflow:hidden; }
	.linkSpace a:link { text-decoration: none; }
</style>
 
</head>
 
<body>
<form>
	<input type="hidden" name="id" value="4028817a3b3a59cd013b3b5bbd94001a"/>
	<input type="hidden" name="delIds" value="">
 
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
    <div id="navMenubar">
<ul>
<li id="save"><a href="#">确定</a></li>
<li id="save"><a href="#">暂存</a></li>
	<li id="back">
		<a href="jExportList.jsp">返回</a>
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
        修改报运信息
    </div> 
        	
    </div>
    </div>
<div>
 
 
    <div>
		<table class="commonTable" cellspacing="1">
	        <tr>
	            <td class="columnTitle">客户号：</td>
	            <td class="tableContent">
					<input type="text" name="customerContract" dataType="字符串" dispName="客户号" value="671112" maxLength="100"/> 
				</td>
	            <td class="columnTitle">制单日期：</td>
	            <td class="tableContent">
					<input type="text" style="width:90px;" name="inputDate" dataType="非空日期" dispName="签单日期" value="2012-11-26" onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});"/> 
				</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">L/C No.：</td>
	            <td class="tableContentAuto">
	            	<input type="radio" name="lcno" value="L/C" checked class="input">L/C
					<input type="radio" name="lcno" value="T/T" checked class="input">T/T
	            </td>	            <td class="columnTitle">装运港：</td>
	            <td class="tableContent"><input type="text" name="shipmentPort" value="XINGANG" dataType="字符串" dispName="装运港" maxLength="100"></td>
	        </tr>
	        <tr>
	            <td class="columnTitle">收货人及地址：</td>
	            <td class="tableContentAuto" colspan="3"><input type="text" name="consignee" value="BTC" dataType="非空字符串" dispName="收货人及地址" maxLength="100" style="width:100%"></td>
	        </tr>
	        <tr>
	            <td class="columnTitle">运输方式：</td>
	            <td class="tableContentAuto">
	            	<input type="radio" name="transportMode" value="SEA" checked class="input">海运
					<input type="radio" name="transportMode" value="AIR"  class="input">空运
	            </td>
	            <td class="columnTitle">价格条件：</td>
	            <td class="tableContent"><input type="text" name="priceCondition" value="FOB" dataType="字符串" dispName="价格条件" maxLength="10"></td>
	        </tr>
	        <tr>
				<td class="columnTitle">唛头：</td>
	            <td colspan="3">
	            	<textarea id="textarea_marks" onkeyup="getMaxlength('textarea_marks');textareasize(this);" onmousemove ="getMaxlength('textarea_marks');" onmouseout ="getMaxlength('textarea_marks');" class="textarea" name="marks" rows="5" dataType="字符串" dispName="唛头" maxLength="1000"></textarea>
	            	<div class="textarea_count">
	            	<span>字符：<a id="num_textarea_marks"><font color=#009900><script>getNownum('textarea_marks')</script> / <script>getMaxnum('textarea_marks')</script></font></a></span> | 
	            	<a style="cursor:pointer;" onclick="clearcontent('textarea_marks')">清空内容</a>
	            	</div>
	            </td>
			</tr>
	        <tr>
				<td class="columnTitle">备注：</td>
	            <td colspan="3">
	            	<textarea id="textarea" onkeyup="getMaxlength('textarea');textareasize(this);" onmousemove ="getMaxlength('textarea');" onmouseout ="getMaxlength('textarea');" class="textarea" name="remark" rows="5" dataType="字符串" dispName="备注" maxLength="100"></textarea>
	            	<div class="textarea_count">
	            	<span>字符：<a id="num_textarea"><font color=#009900><script>getNownum('textarea')</script> / <script>getMaxnum('textarea')</script></font></a></span> | 
	            	<a style="cursor:pointer;" onclick="clearcontent('textarea')">清空内容</a>
	            	</div>
	            </td>
			</tr>
		</table>
	</div>
</div>
 
 
 
 
<div class="textbox" id="centerTextbox">
    
    <div class="textbox-header">
    <div class="textbox-inner-header">
    <div class="textbox-title">
        货物信息
    </div> 
    </div>
    </div>
 
<div>
<div class="listTablew">
<table class="commonTable_main" cellSpacing="1" id="resultTable">
	<tr class="rowTitle" align="middle">
		<td width="25" title="可以拖动下面行首,实现记录的位置移动."><img src="../../images/drag.gif"></td>
		<td width="20"><input class="input" type="checkbox" name="ck_del" onclick="checkGroupBox(this);" /></td>
		<td width="33">序号</td>
		<td>货物</td>
		<td nowrap>货物描述</td>
		<td>厂家</td>
		<td>装率</td>
		<td>单位</td>
		<td>数量</td>
		<td>箱数</td>
		<td>毛重</td>
		<td>净重</td>
		<td>长</td>
		<td>宽</td>
		<td>高</td>
		<td nowrap>出口单价</td>
		<td nowrap>收购单价</td>
	</tr>
</table>
</div>
 
 
 
 
<div class="textbox" id="centerTextbox">
    
    <div class="textbox-header">
    <div class="textbox-inner-header">
    <div class="textbox-title">
        附件信息
    </div> 
    </div>
    </div>
 
<div>
 
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
		<td>单价</td>
		<td>总金额</td>
		<td align="center">操作</td>
	</tr>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
		
		<tr height="30">
			<td align="center">1</td>
			<td><img src="../../images/no.jpg" class="product_image" width="133" height="100" onerror="this.src='../../images/no.jpg'"></td>
			<td>JK0024/JK1104003-D</td>
			<td>蒙砂花纸，配全明料香槟杯
<br>送祁县宏艺厂</td>
			<td>综艺花纸</td>
			<td><input type="hidden" name="ep_id" value="20121026141902000000"><input type="hidden" name="ep_cnumber_old" value="1200"><input type="text" name="ep_cnumber" value="1200" size="10"></td>
			<td>PCS</td>
			<td><input type="hidden" name="ep_price" value="0.10">0.10</td>
			<td>120.00</td>
			<td align="center"><button class="b_button" style="MARGIN-RIGHT: 10px"
								onclick="location.href='doExportExtEproductDeleteAction.do?id=4028817a3b3a59cd013b3b5bbd94001a&extid=20121026141902000000'"
								name="btnSwapDown">
								删除</button></td>
		</tr>
	
	
	
		
		
		<tr height="30">
			<td align="center">2</td>
			<td><img src="../../images/no.jpg" class="product_image" width="133" height="100" onerror="this.src='../../images/no.jpg'"></td>
			<td>JK0025/JK1102331-D</td>
			<td>蒙砂花纸，配全明料酒杯
<br>送祁县宏艺厂</td>
			<td>综艺花纸</td>
			<td><input type="hidden" name="ep_id" value="20121026141902000001"><input type="hidden" name="ep_cnumber_old" value="1206"><input type="text" name="ep_cnumber" value="1206" size="10"></td>
			<td>PCS</td>
			<td><input type="hidden" name="ep_price" value="0.20">0.20</td>
			<td>241.20</td>
			<td align="center"><button class="b_button" style="MARGIN-RIGHT: 10px"
								onclick="location.href='doExportExtEproductDeleteAction.do?id=4028817a3b3a59cd013b3b5bbd94001a&extid=20121026141902000001'"
								name="btnSwapDown">
								删除</button></td>
		</tr>
	
	
	
		
		
		<tr height="30">
			<td align="center">3</td>
			<td><img src="../../images/no.jpg" class="product_image" width="133" height="100" onerror="this.src='../../images/no.jpg'"></td>
			<td>JK0026/JK1102332-D</td>
			<td>蒙砂花纸，配全明料酒杯
<br>送祁县宏艺厂</td>
			<td>综艺花纸</td>
			<td><input type="hidden" name="ep_id" value="20121026141902000002"><input type="hidden" name="ep_cnumber_old" value="1206"><input type="text" name="ep_cnumber" value="1206" size="10"></td>
			<td>PCS</td>
			<td><input type="hidden" name="ep_price" value="0.20">0.20</td>
			<td>241.20</td>
			<td align="center"><button class="b_button" style="MARGIN-RIGHT: 10px"
								onclick="location.href='doExportExtEproductDeleteAction.do?id=4028817a3b3a59cd013b3b5bbd94001a&extid=20121026141902000002'"
								name="btnSwapDown">
								删除</button></td>
		</tr>
	
	
	
	
	
	
	
	
</table>
</div>
 
 
</form>
</body>
</html>

