<%@ page language="java" pageEncoding="UTF-8"%>

<!-- 告诉浏览器本网页符合XHTML1.0过渡型DOCTYPE -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<title></title>
 
		<!-- 调用样式表 -->
		<link rel="stylesheet" rev="stylesheet" type="text/css" href="../../skin/default/css/default.css" media="all" />
	<script type="text/javascript" src="../../js/common.js"></script>
 
		<script language="JavaScript"> 

	
	/* 根据下拉框选择的值，制定对应类型的默认文字 */
	function setProductRequest( obj ){
		var _productRequest = obj.parentNode.nextSibling.nextSibling.firstChild.firstChild;
				if(obj.value==1){
			_productRequest.innerText = "1.彩盒要求350克面纸；\n2.工厂待用安全包装，待我司运至工厂；\n3.工厂免费提供1%余量，以防划伤，破损；\n4.交期:。";
		}else if(obj.value==2){
			_productRequest.innerText = "1.产品的颜色、造型、尺寸、重量务必同我司封样一致；\n2.工厂免费提供2% 余量，以防损耗，代用包装送至指定工厂；请在外包装上注明相对应的合同号及货号；\n3.交期:。";
		}else if(obj.value==3){
			_productRequest.innerText = "1.产品质量要好，颗粒细小，压制密实，无毛边；\n2.工厂待用安全包装，运至指定工厂；\n3.交期：。";
		}else if(obj.value==4){
			_productRequest.innerText = "★   产品与封样无明显差异，唛头、标签及包装质量务必符合公司要求。 \n ★★  产品生产前期、中期、后期抽验率不得少于10%，质量和封样一致， \n       并将验货照片传回公司。 \n★★★ 重点客人的质量标准检验，产品抽验率不得少于50%，务必做到入箱前检查。 \n 交期：deliveryPeriod/工厂。毛坯送至祁县瑞成玻璃镀膜厂。 \n       没有经过我司同意无故延期交货造成严重后果的，按照客人的相关要求处理。 \n 开票：出货后请将增值税发票、验货报告、合同复印件及出库单一并寄至我司，以便我司安排付款。";
		}else if(obj.value==5){
			_productRequest.innerText = "";
		}else if(obj.value==6){
			_productRequest.innerText = "1.包装：暗转包装送指定工厂。\n2.交期：。\n3.付款方式：货到付款。";
		}
 
	}
	
	/* 根据下拉框选择的值，制定对应类型的默认文字 */
	function setTypeProductRequest( obj ){
		var _productRequest = obj.parentNode.nextSibling.firstChild.firstChild;
				if(obj.value==1){
			_productRequest.innerText = "1.彩盒要求350克面纸；\n2.工厂待用安全包装，待我司运至工厂；\n3.工厂免费提供1%余量，以防划伤，破损；\n4.交期:。";
		}else if(obj.value==2){
			_productRequest.innerText = "1.产品的颜色、造型、尺寸、重量务必同我司封样一致；\n2.工厂免费提供2% 余量，以防损耗，代用包装送至指定工厂；请在外包装上注明相对应的合同号及货号；\n3.交期:。";
		}else if(obj.value==3){
			_productRequest.innerText = "1.产品质量要好，颗粒细小，压制密实，无毛边；\n2.工厂待用安全包装，运至指定工厂；\n3.交期：。";
		}else if(obj.value==4){
			_productRequest.innerText = "★   产品与封样无明显差异，唛头、标签及包装质量务必符合公司要求。 \n ★★  产品生产前期、中期、后期抽验率不得少于10%，质量和封样一致， \n       并将验货照片传回公司。 \n★★★ 重点客人的质量标准检验，产品抽验率不得少于50%，务必做到入箱前检查。 \n 交期：deliveryPeriod/工厂。毛坯送至祁县瑞成玻璃镀膜厂。 \n       没有经过我司同意无故延期交货造成严重后果的，按照客人的相关要求处理。 \n 开票：出货后请将增值税发票、验货报告、合同复印件及出库单一并寄至我司，以便我司安排付款。";
		}else if(obj.value==5){
			_productRequest.innerText = "";
		}else if(obj.value==6){
			_productRequest.innerText = "1.包装：暗转包装送指定工厂。\n2.交期：。\n3.付款方式：货到付款。";
		}
 
	}

 
</script>
 
	</head>
 
	<body>
		<form>
			<input type="hidden" name="mid" value="{mid}" />
 
			<div id="menubar">
				<div id="middleMenubar">
					<div id="innerMenubar">
						<div id="navMenubar">
							<ul>
								<li id="save"><a href="#" onclick="formSubmit('/contract/extCproductAction_save','_self');">确定</a></li>
<li id="print"><a href="#">打印</a></li>
 
								<li id="back"><a href="jContractList.jsp">返回</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
 
			<div class="textbox" id="centerTextbox">
				<div class="textbox-header">
					<div class="textbox-inner-header">
						<div class="textbox-title">
							编辑附件&nbsp;&nbsp; <span style="font-size:12px;color:blue">[ 打印时, 不选择则打印所有附件, 选择将只打印选择的附件。]</span>
								
							<div style="padding: 10px; text-align: left; font-size: 12px;">
								打印样式：
								<input type="radio" name="printStyle" value="1" checked class="input">一个货物
								<input type="radio" name="printStyle" value="2" checked class="input">两个货物
							<div>
 
						</div>
					</div>
				</div>
			<div>
 
							<div id="fileQueue"></div>
 
 
							<div class="listTablew">
								<table class="commonTable_main" cellSpacing="1" id="resultTable">
									<tr class="rowTitle" align="middle">
										<td width="25" title="可以拖动下面行首,实现记录的位置移动.">
											<img src="../../images/drag.gif">
										</td>
										<td width="20">
											<input class="input" type="checkbox" name="ck_del" onclick="checkGroupBox(this);" />
										</td>
										<td width="33">序号</td>
										<td>货号</td>
										<td>类型</td>
										<td>货物描述</td>
										<td>要求</td>
										<td>厂家</td>
										<td>单位</td>
										<td>数量</td>
										<td>单价</td>
										<td>照片</td>
									</tr>
								</table>
							</div>
 
							<div
								style="float: left; left: 5px; top: 138px; font-size: 12px; color: gray; font-weight: normal; padding: 12px; text-align: left;">
								<div style="float: left;">
									<img style="margin: 0 5px 0 0;" src="../../skin/default/images/notice.gif" />
								</div>
								<div style="float: left; padding-left: 10px;">
									可以拖动行首,实现记录的位置移动。或者上移、下移按钮,实现记录的位置的上下移动。
								</div>
							</div>
 
							<div style="float: right; padding: 10px; white-space: nowrap;">
								<button class="b_button" style="MARGIN-RIGHT: 10px"
									onclick="addTRRecord('resultTable','','','','','','','','','','');dragtableinit();sortnoTR();"
									name="add" value="add">
									增加一条
								</button>
								<button class="b_button" style="MARGIN-RIGHT: 10px"
									onclick="delIdsRecord('del');delTRRecord('del','resultTable',1);sortnoTR();"
									name="delone" value="delone">
									删除
								</button>
								<button class="b_button" style="MARGIN-RIGHT: 10px"
									onclick="swapTRRecord('del','resultTable',1,'up');sortnoTR();"
									name="btnSwapUp">
									上移
								</button>
								<button class="b_button" style="MARGIN-RIGHT: 10px"
									onclick="swapTRRecord('del','resultTable',1,'dn');sortnoTR();"
									name="btnSwapDown">
									下移
								</button>
							</div>
						</div>
						<div class="textbox-bottom">
							<div class="textbox-inner-bottom">
								<div class="textbox-go-top">
								</div>
							</div>
						</div>
					</div>
</div>	
</div>				
 
 
 
 
<div style="padding-top:10px;padding-bottom:30px;width:97%;display:none;">
							<div class="listTablew">
								<table class="commonTable_main" cellSpacing="1" id="typeTable">
									<tr class="rowTitle" align="middle">
										<td width="25" title="可以拖动下面行首,实现记录的位置移动.">
											<img src="../images/drag.gif">
										</td>
										<td width="20">
											<input class="input" type="checkbox" name="ck_delType" onclick="checkGroupBox(this);" />
										</td>
										<td width="33">序号</td>
										<td>类 型</td>
										<td>要 求</td>
									</tr>
								</table>
							</div>	
 
							<div style="float: right; padding: 10px; white-space: nowrap;">
								<button class="b_button" style="MARGIN-RIGHT: 10px"
									onclick="addTypeRecord('typeTable','','','');sortTypeTable();"
									name="add" value="add">
									增加一条
								</button>
								<button class="b_button" style="MARGIN-RIGHT: 10px"
									onclick="delIdsRecord('delType','typeTable');delTRRecord('del','typeTable',1);sortTypeTable();"
									name="delone" value="delone">
									删除
								</button>
								<button class="b_button" style="MARGIN-RIGHT: 10px"
									onclick="swapTRRecord('delType','typeTable',1,'up');sortTypeTable();"
									name="btnSwapUp">
									上移
								</button>
								<button class="b_button" style="MARGIN-RIGHT: 10px"
									onclick="swapTRRecord('delType','typeTable',1,'dn');sortTypeTable();"
									name="btnSwapDown">
									下移
								</button>
							</div>
</div>
		</form>
	</body>
</html>


