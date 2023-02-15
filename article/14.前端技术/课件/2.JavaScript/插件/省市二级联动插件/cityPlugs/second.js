/**
 * 二级联动的市
 */
function addListerForSecond(firstId,second_id){
	//选择城市之后,删除原来的站点框，并生成新的站点框，之后隐藏
	$('#'+firstId).blur(function(){
		$('#'+second_id).val("");//清空站点原有的站点
		$("#city_stations").remove();//删除原来的站点框
	});
  	
	$('#'+second_id).focus(function(){
		$("#city_stations").remove();//删除原来的站点框
		city = $('#'+firstId).val();//获得当前所选城市的名称
		var html = createDivHtml(second_id);//生成站点文本框的html代码
		$('body').append(html);//在页面最后生成站点框
		
		$('#stations_dd a').click(function(){
			$('#'+second_id).val($(this).html());
			$("#city_stations").remove();//删除原来的站点框
		});
		$('html').mousedown(function(e){
    		e=e? e:window.event;
    		//判断鼠标点击位置是否在指定位置
    		var b1 = assertIn(e.clientX,e.clientY,"city_stations");
    		var b2 = assertIn(e.clientX,e.clientY,"station_div");
    		if(!b1 && !b2) {
    			$("#city_stations").remove();//删除原来的站点框
    		}
   		});
	});
}

//生成站点文本框的html代码
function createDivHtml(second_id){
	//获得指定input的四个点的相对于body的距离
	var inputPos = getNode(document.getElementById(second_id));
	var html = '<div class="citySelector" style="position: absolute; left: '+inputPos.left+'px; top: '+inputPos.bottom+'px; z-index: 999999;" id="city_stations" >'
					+'	<div class="cityBox"  style="max-width: 700px;">'
					+'		<p class="tip" id="city_name">'+city+'全部站点</p>'
					+'		<div class="hotCity"></div>'
					+'		<div class="hot cityTab" >'
					+'			<dl style="margin-bottom: 8px;">'
					+'				<dt>&nbsp;<dt><dd id="stations_dd">';
	var a = "";
	//生成站点				
	for (var i = 0; i < all_stations.length; i++) {
		if(all_stations[i].province == city){
			a += '<a  href="javascript:">'+all_stations[i].site+'</a>';
		}
	}
	if(a.length == 0){
		a = "<h4>该城市没有站点</h4>";
	}
			html += a;
			html +=  '				</dd>'				
					+'			</dl>'
					+'		</div>'
					+'	</div>'
					+'</div>';
	return html;
}
//获得某个节点在window中的位置
function getNode(node) {
	var scrollx = document.documentElement.scrollLeft || document.body.scrollLeft;
	var scrollt = document.documentElement.scrollTop || document.body.scrollTop;
	var pos = node.getBoundingClientRect();
	return {
		top : pos.top + scrollt,
		right : pos.right + scrollx,
		bottom : pos.bottom + scrollt,
		left : pos.left + scrollx
	};
}
//判断坐标x,y，是否在节点的范围内
function assertIn(x,y,id){
	var node = getNode(document.getElementById(id));
	if((y > node.top && y < node.bottom) && (x > node.left && x < node.right) ){
		return true;
	}
	return false;
}