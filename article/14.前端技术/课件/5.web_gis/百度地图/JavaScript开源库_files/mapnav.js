var mnav = function(ids) {
	var htmlBody = document.getElementsByTagName("body")[0];
	var header = document.createElement("div");
	header.setAttribute("id", "header");
	var more = '<li id="mapnav_creatmap"><a  href="javascript:openGuide();" onclick="_addStatNew(' + 'lbsapi_guanwang' + ',{' + 'operate' + ': ' + 'guanwang_productclick' + '})">产品指引</a><b>|</b></li>\r\n';

	var str1 = ['<ul id="mapnav_tool_two">\r\n',
		'<li id="mapnav_creatmap"><a  href="http://api.map.baidu.com/lbsapi/creatmap/index.html">地图生成器</a><b>|</b></li>\r\n',
		'<li id="mapnav_getpoint"><a  href="http://api.map.baidu.com/lbsapi/getpoint/index.html">坐标拾取工具</a><b>|</b></li>\r\n',
		'<li id="mapnav_mapcard"><a  href="http://api.map.baidu.com/mapCard/">地图名片</a><b>|</b></li>\r\n',
		'<li id="mapnav_tuan"><a  href="http://api.map.baidu.com/lbsapi/tuan/index.html">团购插件</a><b>|</b></li>\r\n',
		'<li id="mapnav_move"><a  href="http://developer.baidu.com/map/move.htm">零成本搬家</a></li>',
		'</ul>\r\n'
	].join('');
	var str2 = ['<ul id="mapnav_support_two">\r\n', 
		'<li><a target="_blank" href="http://bbs.lbsyun.baidu.com">技术论坛</a><b>|</b></li>',
		'<li><a target="_blank" href="http://lbsyun.baidu.com/news">新闻动态</a><b>|</b></li>',
		'<li id="mapnav_help"><a  href="http://developer.baidu.com/map/help_index.html">商务合作</a><b>|</b></li>',
		'<li id="mapnav_suggest"><a  href="http://bbs.lbsyun.baidu.com/">咨询反馈</a></li>',
		'</ul>\r\n'
	].join('');
	
	var str3 = ['<ul id="mapnav_product_two">\r\n',
		'<li id="mapnav_yun"><a  href="http://developer.baidu.com/map/lbs-cloud.htm">LBS.云</a><b>|</b></li>\r\n',
		'<li id="mapnav_javascript" class="nav-item"><a class="Top_two_triangle" href="http://developer.baidu.com/map/jshome.htm">JavaScript API</a>',
		'<div  class="homeTab webTab" >\r\n',
		'<ul>\r\n',		
		'<li><a style="color:#000" href="http://developer.baidu.com/map/jshome.htm ">JavaScript API大众版</a></li>\r\n',
		'<li><a style="color:#000" href="http://developer.baidu.com/map/jsmobile.htm">JavaScript API极速版</a></li>\r\n',
		'<li><a style="color:#000" href="http://developer.baidu.com/map/webcomponents.htm">Web组件 API</a></li>\r\n',
		'<li><a style="color:#000" href="http://developer.baidu.com/map/library.htm ">JavaScript API开源库</a></li>\r\n',
		'<div class="clear"></div>\r\n',
		'</ul>\r\n',
		'</div>\r\n',

		'</li>\r\n',
		'<li id="mapnav_flash"><a href="http://developer.baidu.com/map/flash.htm">Flash API</a><b>|</b></li>\r\n',
		'<li>\r\n',
		'<ul>\r\n',
		'<li id="mapnav_and" class="nav-item" ><a href="http://developer.baidu.com/map/sdk-android.htm" class="Top_two_triangle">Android 平台</a>\r\n',
		'<div  class="homeTab webTab" >\r\n',
		'<ul>\r\n',		
		'<li><a href="http://developer.baidu.com/map/sdk-android.htm">Android SDK</a></li>\r\n',
		'<li><a href="http://developer.baidu.com/map/geosdk.htm">定位 SDK</a></li>\r\n',
		'<li><a href="http://developer.baidu.com/map/navsdk.htm">导航 SDK</a></li>\r\n',
		'<li><a href="http://developer.baidu.com/map/andsdk_review.html">全景 SDK</a></li>\r\n',
		'<li><a href="http://developer.baidu.com/map/android-fullnavsdk.htm">离线导航</a></li>\r\n',
		'<div class="clear"></div>\r\n',
		'</ul>\r\n',
		'</div>\r\n',
		'</li>\r\n',
		'<li id="mapnav_ios" class="nav-item"><a class="Top_two_triangle"href="http://developer.baidu.com/map/sdk-ios.htm">iOS SDK</a>',
			'<div  class="homeTab webTab" >\r\n',
			'<ul>\r\n',		
			'<li><a href="http://developer.baidu.com/map/sdk-ios.htm">iOS SDK</a></li>\r\n',
			'<li><a href="http://developer.baidu.com/map/sdk-nav-ios.htm">iOS 导航 SDK</a></li>\r\n',
			'<li><a href="http://developer.baidu.com/map/sdk-pano-ios.htm">iOS 全景 SDK</a></li>\r\n',
			'<li><a href="http://developer.baidu.com/map/ios-fullnavsdk.htm">iOS离线导航</a></li>\r\n',
			'<div class="clear"></div>\r\n',
			'</ul>\r\n',
			'</div>\r\n',
		'</li>\r\n',


		'</ul>\r\n',
		'</li>\r\n',
		'<li>\r\n',
		'<ul>\r\n',
		'<li id="mapnav_web" class="nav-item"><a href="http://developer.baidu.com/map/webservice.htm" class="Top_two_triangle">Web服务API</a>\r\n',
		'<div  class="homeTab webTab" >\r\n',
		'<ul>\r\n',		
		'<li><a href="http://developer.baidu.com/map/webservice-placeapi.htm">Place API</a></li>\r\n',
		'<li><a href="http://developer.baidu.com/map/place-suggestion-api.htm">Place suggestion API</a></li>\r\n',
		'<li><a href="http://developer.baidu.com/map/webservice-geocoding.htm">Geocoding API</a></li>\r\n',
		'<li><a href="http://developer.baidu.com/map/direction-api.htm">Direction API</a></li>\r\n',
		'<li><a href="http://developer.baidu.com/map/route-matrix-api.htm">Route Matrix API</a></li>\r\n',
		'<li><a href="http://developer.baidu.com/map/ip-location-api.htm">IP定位 API</a></li>\r\n',
		'<li><a href="http://developer.baidu.com/map/changeposition.htm">坐标转换 API</a></li>\r\n',
		'<div class="clear"></div>\r\n',
		'</ul>\r\n',
		'</div>\r\n',
		'</li>\r\n',
		'<li id="mapnav_static" class="nav-item"><a href="http://developer.baidu.com/map/staticimg.htm" class="Top_two_triangle">静态图API</a>\r\n',
		'<div  class="homeTab webTab" >\r\n',
		'<ul>\r\n',		
		'<li><a href="http://developer.baidu.com/map/staticimg.htm">静态图 API</a></li>\r\n',
		'<li><a href="http://developer.baidu.com/map/viewstatic.htm">全景静态图 API</a></li>\r\n',
		'</ul>\r\n',
		'</div>\r\n',
		'</li>\r\n',
		'<li id="mapnav_car"><a href="http://developer.baidu.com/map/carhome.htm" class="Top_two">车联网API</a></li>\r\n',
		'<li id="mapnav_uri"><a href="http://developer.baidu.com/map/uri.htm" >URI API</a></li>\r\n',
		'</ul>\r\n'
	].join('');
	var str4 = ['<ul id="mapnav_success_two">\r\n',
		'<li id="mapnav_openmap"><a  href="http://developer.baidu.com/map/openmap.htm">Openmap计划</a> <a href="openmap-1.htm">文档</a><b>|</b></li>\r\n',
		'<li id="mapnav_houseProperty"><a  href="http://developer.baidu.com/map/case.htm">行业解决方案</a><b>|</b></li>\r\n',
		'<li id="mapnav_more_case"><a  href="http://developer.baidu.com/map/case-more.htm">成功案例</a><b>|</b></li>\r\n',
		'<li id="mapnav_baiduplan"><a  href="http://developer.baidu.com/map/baiduplan.htm">百度优先收录计划</a><b></b></li>\r\n',
		'</ul>\r\n'
	].join('');
	var support = '<a href="javascript:openGuide();" onclick="_addStatNew(' + '"lbsapi_guanwang"' + ',{' + 'operate' + ': ' + 'guanwang_productclick' + '})">产品指引</a> | <a href="question.htm">常见问题</a> | <a href="devRes.htm">开发资源</a>\r\n';

	var content = [
		'<div class="top-bg"><div class="top-mid">',
			'<a class="martop5 l" href="http://developer.baidu.com/map/">',
			'<img src="http://lbc.baidu.com/static/cms/images/logo.png" /></a>',
			'<div id="logins">\r\n',
				'<ul class="user-nav">\r\n',
				'<li class="user-nav-item " id="user-state-li" style="display:none">\r\n',
					'<a id="userName"></a><label>|</label>\r\n',
					'<ul class="username-dropdown" style="visibility: hidden;">\r\n',
						'<li><a target="_top" href="http://passport.baidu.com/center" class="bd-cloud-dropdown-link">帐号设置</a></li>\r\n',		
						'<li><a target="_top" href="" id="logout">退出</a></li>\r\n',
						'<div class="clear"></div>\r\n',
					'</ul>\r\n',
					'<div class="clear"></div>\r\n',
				'</li>\r\n',
				'<li class="user-nav-item">\r\n',
					'<a target="_blank" href="http://lbsyun.baidu.com/apiconsole/key" style="color:#EF4142;">API控制台</a><label>|</label>\r\n',
				'</li>',
				'<li class="user-nav-item">',
					'<a  target="_blank" href="http://developer.baidu.com/">百度开放云</a>\r\n',
				'</li>',
				'<li id="login-reg-li" class="user-nav-item" style="display:none;">\r\n',
					'<label id="dot-line">|</label><a id="login" href="" target="_top">登录</a>\r\n',
					'<a id="register" href="" target="_top">注册</a>\r\n',
				'</li>',
				'<div class="clear"></div>',
				'</ul>',
			'</div>\r\n',
			'</div></div>',

		'<div id="top_main">\r\n',
		'<div id="nav">\r\n',
		'<ul class="navul">\r\n',
		'<li >\r\n',
		'<a id="mapnav_home" href="http://developer.baidu.com/map/index.html">首页</a>\r\n',
		'</li>\r\n',
		'<li class="nav-item" id="mapnav_product"><a href="http://developer.baidu.com/map/lbs-cloud.htm">开发</a>',
		'<div id="homeTab1" class="homeTab"><dl><dt class="l">web开发</dt>',
		'<dd><a target="_blank" href="http://developer.baidu.com/map/jshome.htm">JavaScript API大众版</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/jsmobile.htm">JavaScript API极速版</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/webcomponents.htm">Web组件 API</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/library.htm">JavaScript API开源库</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/flash.htm">Flash API</a>',
		'<div class="clear"></div></dd></dl>',
		'<dl><dt class="l">APP开发</dt><dd>',
		'<a target="_blank" href="http://developer.baidu.com/map/sdk-android.htm">Android地图SDK</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/geosdk.htm">Android定位SDK</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/navsdk.htm">Android导航SDK</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/sdk-ios.htm">iOS地图SDK</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/sdk-nav-ios.htm">iOS导航SDK</a>',
		'<div class="clear"></div></dd></dl>',
		'<dl><dt class="l">服务接口</dt><dd>',
		'<a target="_blank" href="http://developer.baidu.com/map/lbs-cloud.htm">LBS云</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/webservice.htm">Web服务API</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/staticimg.htm">静态图API</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/carhome.htm">车联网API</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/uri.htm">URI API</a>',
		'<div class="clear"></div></dd></dl>',
		'<dl style="margin-bottom:0;">',
		'<dt class="l">工具支持</dt><dd>',
		'<a target="_blank" href="http://lbsyun.baidu.com/apiconsole/key">API控制台</a>',
		'<a target="_blank" href="http://lbsyun.baidu.com/datamanager/datamanage">LBS云可视化编辑器</a>',
		'<a target="_blank" href="http://api.map.baidu.com/lbsapi/getpoint/index.html">坐标拾取器</a>',
		'<a target="_blank" href="http://api.map.baidu.com/lbsapi/creatmap/index.html">地图生成器</a>',
		'<a target="_blank" href="http://api.map.baidu.com/mapCard">地图名片</a>',
		'<a target="_blank" href="http://api.map.baidu.com/lbsapi/tuan/index.html">团购插件</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/move.htm">零成本搬家工具</a>',
		'<a target="_blank" href="http://developer.baidu.com/map/img-editor.html">底图编辑工具</a>',
		'<div class="clear"></div></dd></dl></div></li>',
		'<li class="nav-item" id="mapnav_success"><a href="http://developer.baidu.com/map/openmap.htm">推广</a><div class="homeTab">',
		'<ul><li style="width:250px;"><a target="_blank" href="http://developer.baidu.com/map/openmap.htm">Openmap计划</a></li>',
		'<li style="width:250px;"><a target="_blank" href="http://developer.baidu.com/map/case.htm">行业解决方案</a></li>',
		'<li style="width:250px;"><a target="_blank" href="http://developer.baidu.com/map/case-more.htm">成功案例展示</a></li>',						
		'<li style="width:250px;"><a target="_blank" href="http://developer.baidu.com/map/baiduplan.htm">百度优先收录计划</a></li>',
		'<div class="clear"></div></ul></div></li>',
		'<li><a href="http://developer.baidu.com/map/cash.htm">变现</a></li>',
		'<li class="nav-item" id="mapnav_support"><a href="http://developer.baidu.com/map/help_index.html">社区</a><div  class="homeTab">',
		'<ul><li><a target="_blank" href="http://bbs.lbsyun.baidu.com">技术论坛</a></li>',
		'<li><a target="_blank" href="http://lbsyun.baidu.com/news">新闻动态</a></li>',
		'<li><a target="_blank" href="help_index.html">商务合作</a></li>',
		'<li><a target="_blank" href="http://bbs.lbsyun.baidu.com/">咨询反馈</a></li>',
		'<div class="clear"></div></ul></div></li>',
		'<li><a target="_blank" href="http://renqi.map.baidu.com/">人气</a></li>',
		'<li><a target="_blank" href="http://huiyan.baidu.com/">慧眼</a></li>',		'</ul>\r\n',
		'<div class="search"><a href="javascript:void(0);" class="searchBtn r" id="searchBtn"></a>',
		'<div class="inputbox">',
		'<input type="text" class="searchcontent" id="apisearchContent" /></div></div>',
		'</div>\r\n',
		'</div>\r\n',
		'<div class="clear"></div>\r\n',
		'<div id="headTop">\r\n',
		'<div id="headeTop_main">\r\n'
	].join('');

	var footer = [
		'</li>\r\n',
		'</ul>\r\n',		
		'</div>',
		'</div>'
	].join('');
	var htmlcontent = content + str1 + str2 + str4 + str3 + footer;
	header.innerHTML = htmlcontent;
	htmlBody.appendChild(header);
	var clear = document.createElement("div");
	clear.setAttribute("class", "clear");
	htmlBody.appendChild(clear);
	document.write("<script src='http://api.map.baidu.com/lbsapi/cloud/cms/js/login.js'><\/script>");
	if (ids) {
		if (ids.one_nav) {
			document.getElementById(ids.one_nav).className = " nav_on";
		}
		if (ids.two_nav) {
			document.getElementById(ids.two_nav).className += " Top_on";
		}
		switch (ids.one_nav) {
			case 'mapnav_product':
				document.getElementById('mapnav_product_two').style.display = 'block';
				break;
			case 'mapnav_tool':
				document.getElementById('mapnav_tool_two').style.display = 'block';
				break;
			case 'mapnav_support':
				document.getElementById('mapnav_support_two').style.display = 'block';
				break;
			case 'mapnav_success':
				document.getElementById('mapnav_success_two').style.display = 'block';
				break;
			case 'mapnav_news':
				document.getElementById('headTop').style.height = '1px';
				break;
		}
	}

	addSearch();

}

//add mapapi.class
function addLink(){
	var link = document.createElement('link');
	link.href = 'static/css/mapapi.css';
	link.setAttribute('rel','stylesheet');
	link.setAttribute('type','text/css');
	document.getElementsByTagName('head')[0].appendChild(link);	
}
addLink();


var baidu = baidu || {};
baidu.sort = {
	'lbscloud' : 'yun',
    'jspolular' : 'javascript',
	'jsextreme' : 'javascript',
	'flash' : 'flash',
	'androidsdk' : 'and',
	'android-locsdk' : 'and',
	'android-navsdk' : 'and',
	'iossdk' : 'ios',
	'ios-navsdk' : 'ios',
	'ios-panosdk' : 'ios',
	'car' : 'car',
	'uri' : 'uri'
};

baidu.getTitleRelationship = function(){
	var urlquery = location.search.substr(1);
	var arr = urlquery.split('&');
	var urlstring = '';

	for(var i=0,len=arr.length; i<len; i++){
		var group = arr[i].split('=');
		if(group[0] == 'title'){
			urlstring = group[1];
			break;
		}
	}
	if(!urlstring){
		return;
	}

	var shipArr = [];
	shipArr = urlstring.split('/');
	if(shipArr.length > 0){
		return shipArr;
	}else{
		return false;
	}	
}


function showcurrentproduct(){
	var shipArr = baidu.getTitleRelationship();
	if(!shipArr){
		return;
	}
	//显示小三角应该在哪个产品下面
	var product = shipArr[0];

	if(!baidu.sort[product]){
		mnav({
			one_nav : "mapnav_product"
		})	
		return;	
	}
	var nodeid = baidu.sort[product];	
	if(nodeid){
		mnav({
			one_nav : "mapnav_product",
			two_nav  : "mapnav_"+nodeid 
		})
	}else{
		mnav({
			one_nav : "mapnav_product"
		})	
	}

}
showcurrentproduct();


//加搜索框
function addSearch(){
	var content = document.getElementById('apisearchContent');
	if(!content){
		return;
	}
	
	function search(){
		var val = content.value;
		var searchBtn = document.getElementById('searchBtn');

		window.location.href = 'http://api.map.baidu.com/helper/search?q=' + val + '&s=1';
	}

	searchBtn.onclick = search;

	content.onkeydown = function(e){
		var e = e || event;
		if(e.keyCode == 13){
			search();
		}
	}	
}




//给当前页面加样式
function checkCurrentPage(){
	var shipArr = baidu.getTitleRelationship();
	if(!shipArr){
		return;
	}
	
    if(shipArr.length == 1 || shipArr.length == 2){	
		var content = $('#firstHeading').html();
		$('#n-'+content).addClass('firstCurrent');
		return;
	}
	if(shipArr.length == 3){
		if(shipArr[1] == 'guide'){
			
			$('#mw-panel h3').eq(0).addClass('firstCurrent');	
		}
		var content = $('#firstHeading').html();
		content = $.trim(content); 
		$('#n-'+content+' a').addClass('secondCurrent');
	}


}

//sidebar样式更改
function addSidebarHref(){	
	var sidebar = document.getElementById('mw-panel');
	if(!sidebar){
		return;
	}
	var titleList = sidebar.getElementsByTagName('h3');
	if(!titleList || titleList.length == 0){
		return;
	}
	//删除第一个h3空标签；
	titleList[0].parentNode.removeChild(titleList[0]);

	$('#n-概述').addClass('firstClass');
	$('#n-获取密钥').addClass('firstClass');
	$('#n-类参考').addClass('firstClass');
	$('#n-更新日志').addClass('firstClass');
	$('#n-常见问题').addClass('firstClass');
	$('#n-相关下载').addClass('firstClass');
	$('#n-示例DEMO').addClass('firstClass');
	$('#n-LBS云管理后台').addClass('firstClass');
	$('#n-成功案例').addClass('firstClass');

/*
	var nodelist = $('#mw-panel h3');
	nodelist[0].innerHTML = '<a href="javascript:void(0);">开发指南</a>'

	if(nodelist[2] && nodelist[2].innerHTML.indexOf('split') == -1){
		nodelist[2].innerHTML = '<a href="javascript:void(0);">接口说明</a>'
	}
	*/

}





function loadEvent(){
	changeTitle();
	addSidebarHref();
	checkCurrentPage();
	$('table').addClass('mlbstable');

	$('#headeTop_main .nav-item').dropdown({
        dropdownEl: '.homeTab',
        openclass: 'Top_on'
    });

	$("#mw-panel h3").each(function(){
		var str = $(this).html();
		if(str.indexOf('split') > -1){
			$(this).hide();
		}

	})

	//更改默认标题的内容;
	function changeTitle(){
		var title = document.getElementById('firstHeading');
		if(title){
			var content = title.innerHTML;
			title.parentNode.removeChild(title);
			var h1 = document.createElement('h1');
			h1.innerHTML = content;
			h1.id = 'firstHeading';
			var bodyContent = document.getElementById('bodyContent');
			bodyContent.parentNode.insertBefore(h1,bodyContent);
		}
	}

	(function($) {
	    $.fn.dropdown = function(settings) {
	        var defaults = {
	            dropdownEl: '.dropdown-menu',
	            open: 'Top_on',
	            delayTime: 100
	        }
	        var opts = $.extend(defaults, settings);
	        return this.each(function() {
	            var curObj = null;
	            var preObj = null;
	            var openedTimer = null;
	            var closedTimer = null;
	            $(this).hover(function() {
	                if (openedTimer)
	                    clearTimeout(openedTimer);
	                curObj = $(this);
	                openedTimer = setTimeout(function() {
	                    curObj.addClass(opts.open).find(opts.dropdownEl).show();
	                }, opts.delayTime);
	                preObj = curObj;
	            }, function() {
	                if (openedTimer)
	                    clearTimeout(openedTimer);
	                openedTimer = setTimeout(function() {
	                    preObj.removeClass(opts.open).find(opts.dropdownEl).hide();
	                }, opts.delayTime);
	            });
				
	        });
	    };
	})(jQuery);
}

window.onload = loadEvent;

