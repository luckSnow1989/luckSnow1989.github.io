//menu by zhangying 2012-11-01
function addClass_on(myId) {
	$(document.getElementById(myId)).addClass('on');
}

function addClass_on1(myId) {
	$(document.getElementById(myId)).addClass('on1');
}

function addClass_on2(myId) {
	$(document.getElementById(myId)).addClass('on2');
}

function addClass_on3(myId) {
	$(document.getElementById(myId)).addClass('on3');
}

//总类导航
function addMenu_main() {
	document.write('<ul>');
	document.write('<li id="mainmenu_1" class="mm1">');
	document.write('<a href ="http://developer.baidu.com/map/">首页</a>');
	document.write('</li>');
	document.write('<li id="mainmenu_2" class="mm2">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">地图API产品</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	document.write('<li id="mainmenu_21"><a href="jshome.htm">JavaScript API</a></li>');
	document.write('<li id="mainmenu_24"><a href="library.htm">JavaScript 开源库</a></li>');
	document.write('<li id="mainmenu_22"><a href="flash.htm">Flash API</a></li>');
	document.write('<li id="mainmenu_23"><a href="staticimg.htm">静态图 API</a></li>');
	document.write('<li id="mainmenu_25"><a href="sdk-android.htm">Android SDK<img src="static/img/new.png"/></a></li>');
	document.write('<li id="mainmenu_26"><a href="sdk-ios.htm">iOS SDK <img src="static/img/new.png"/></a></li>');
	document.write('<li id="mainmenu_27"><a href="geosdk.htm">定位 SDK</a></li>');
	document.write('<li id="mainmenu_28"><a href="webservice.htm">Web服务 API</a></li>');
	document.write('<li id="mainmenu_29"><a href="carhome.htm">车联网 API<img src="static/img/new.png"></a></li><li><a href="uri.htm">URI API </a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="mainmenu_3" class="mm3">');
	document.write('<a href ="lbs-cloud.htm">LBS.云<img src="static/img/new.png"></a>');
	document.write('</li>');
	document.write('<li id="mainmenu_4" class="mm4">');
	document.write('<a href ="tool.htm">插件与工具</a>');
	document.write('</li>');
	document.write('<li id="mainmenu_5" class="mm5">');
	document.write('<a href ="question.htm">常见问题</a>');
	document.write('</li>');
	document.write('<li id="mainmenu_6" class="mm6">');
	document.write('<a href ="case.htm">成功案例</a>');
	document.write('</li>');
	//增加开发资源, by wjp
	document.write('<li id="mainmenu_6_1" class="mm6_1">');
	document.write('<a href ="devRes.htm">开发资源</a>');
	document.write('</li>');
	document.write('<li id="mainmenu_7" class="mm7">');
	document.write('<a href ="news.htm">新闻动态</a>');
	document.write('</li>');
	//注释, by wjp
	//document.write('<li id="mainmenu_8" class="mm8">');	
	//document.write('<a href ="jschat.htm">API群&amp;微博</a>');
	//document.write('</li>');
	document.write('<li id="mainmenu_9" class="mm9">');
	document.write('<a target="_blank" href ="http://bbs.lbsyun.baidu.com/">API论坛</a>');
	document.write('</li>');
	document.write('<li id="mainmenu_10" class="mm10">');
	document.write('<a href ="contact.htm">联系我们</a>');
	document.write('</li>');
	document.write('</ul>');
}

//JS导航
function addMenu_js() {
	document.write('<ul>');
	document.write('<li id="jsmenu_0" class="mm14">');
	document.write('<a href ="jshome.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_7" class="mm14">');
	document.write('<a href="http://lbsyun.baidu.com/apiconsole/key?application=key" target="_blank">获取密钥</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_1" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	document.write('<li id="jsmenu_11"><a href="http://developer.baidu.com/map/wiki/index.php?title=jspopular/guide/introduction">简介</a></li>');
	document.write('<li id="jsmenu_12"><a href="http://developer.baidu.com/map/wiki/index.php?title=jspopular/guide/helloworld">Hello World</a></li>');
	document.write('<li id="jsmenu_13"><a href="http://developer.baidu.com/map/wiki/index.php?title=jspopular/guide/widget">控件</a></li>');
	document.write('<li id="jsmenu_14"><a href="http://developer.baidu.com/map/wiki/index.php?title=jspopular/guide/cover">覆盖物</a></li>');
	document.write('<li id="jsmenu_15"><a href="http://developer.baidu.com/map/wiki/index.php?title=jspopular/guide/event">事件</a></li>');
	document.write('<li id="jsmenu_16"><a href="http://developer.baidu.com/map/wiki/index.php?title=jspopular/guide/maplayer">地图图层</a></li>');
	document.write('<li id="jsmenu_17"><a href="http://developer.baidu.com/map/wiki/index.php?title=jspopular/guide/tool">工具</a></li>');
	document.write('<li id="jsmenu_18"><a href="http://developer.baidu.com/map/wiki/index.php?title=jspopular/guide/service">服务</a></li>');
	document.write('<li id="jsmenu_19"><a href="http://developer.baidu.com/map/wiki/index.php?title=jspopular/guide/datalayer">用户数据图层</a></li>');
	document.write('<li id="jsmenu_20"><a href="http://developer.baidu.com/map/wiki/index.php?title=jspopular/guide/panorama">全景图展现</a></li>');
	document.write('<li id="jsmenu_21"><a href="http://developer.baidu.com/map/wiki/index.php?title=jspopular/guide/custom">定制个性地图 <img src="static/img/new.png" width="25"/></a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="jsmenu_2" class="mm12">');
	document.write('<a href ="http://developer.baidu.com/map/reference/index.php?title=Class:%E6%80%BB%E7%B1%BB/%E6%A0%B8%E5%BF%83%E7%B1%BB" target="_blank">类参考V2.0</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_3" class="mm13">');
	document.write('<a href ="jsdemo.htm" target="_blank">示例DEMO</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_4" class="mm14">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=jspopular/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_5" class="mm14">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=jspopular/qa">常见问题</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_6" class="mm14 ">');
	document.write('<a href ="js-download.htm">相关下载</a>');
	document.write('</li>');
	document.write('<li class="mm14 mmanage">');
	document.write('<a href="jsmobile.htm" ><img src="static/img/outside-link-marker.png" /> JavaScript 极速版</a>');
	document.write('</li>');
	document.write('<li class="mm14 mmanage">');
	document.write('<a href="library.htm" target="_blank"><img src="static/img/outside-link-marker.png" /> JavaScript 开源库</a>');
	document.write('</li>');
	document.write('</ul>');
}

function addMenu_webpackage() {
	document.write('<ul>');
	document.write('<li id="webpackage" class="mm14">');
	document.write('<a href ="webcomponents.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_7" class="mm14">');
	document.write('<a href="http://lbsyun.baidu.com/apiconsole/key?application=key" target="_blank">获取密钥</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_1" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	document.write('<li id="jsmenu_12"><a href="http://developer.baidu.com/map/wiki/index.php?title=webcomponent/guide/helloworld">Hello World</a></li>');
	document.write('<li id="jsmenu_13"><a href="http://developer.baidu.com/map/wiki/index.php?title=webcomponent/guide/map">地图组件</a></li>');
	document.write('<li id="jsmenu_14"><a href="http://developer.baidu.com/map/wiki/index.php?title=webcomponent/guide/nearby">附近检索组件</a></li>');
	document.write('<li id="jsmenu_15"><a href="http://developer.baidu.com/map/wiki/index.php?title=webcomponent/guide/subway">地铁组件</a></li>');
	document.write('<li id="jsmenu_16"><a href="http://developer.baidu.com/map/wiki/index.php?title=webcomponent/guide/geo">定位组件</a></li>');
	document.write('<li id="jsmenu_17"><a href="http://developer.baidu.com/map/wiki/index.php?title=webcomponent/guide/nav">驾车组件</a></li>');
	document.write('<li id="jsmenu_18"><a href="http://developer.baidu.com/map/wiki/index.php?title=webcomponent/guide/transit">公交组件</a></li>');
	document.write('<li id="jsmenu_19"><a href="http://developer.baidu.com/map/wiki/index.php?title=webcomponent/guide/walk">步行组件</a></li>');
	document.write('<li id="jsmenu_20"><a href="http://developer.baidu.com/map/wiki/index.php?title=webcomponent/guide/weather">天气组件</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="jsmenu_2" class="mm12">');
	document.write('<a href ="http://developer.baidu.com/map/reference/index.php?title=Class:web%E7%BB%84%E4%BB%B6/%E5%9C%B0%E5%9B%BE%E7%BB%84%E4%BB%B6" target="_blank">类参考</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_3" class="mm13">');
	document.write('<a href ="http://developer.baidu.com/map/module-mobile.htm" target="_blank">示例DEMO</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_4" class="mm14">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=webcomponent/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_6" class="mm14 ">');
	document.write('<a href ="webcomponent-download.htm">相关下载</a>');
	document.write('</li>');
	document.write('</ul>');
}

//JS极速版导航
function addMenu_js_mobile() {
	document.write('<ul>');
	document.write('<li id="jsmobile_0" class="mm14">');
	document.write('<a href ="jsmobile.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="jsmobile_7" class="mm14">');
	document.write('<a href="http://lbsyun.baidu.com/apiconsole/key?application=key" target="_blank">获取密钥</a>');
	document.write('</li>');
	document.write('<li id="jsmobile_1" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	// document.write('<li id="jsmobile_11"><a href="jsguide-1.htm">简介</a></li>');
	document.write('<li id="jsmobile_gui1"><a href="http://developer.baidu.com/map/wiki/index.php?title=jsextreme/guide/helloworld">Hello World</a></li>');
	document.write('<li id="jsmobile_gui2"><a href="http://developer.baidu.com/map/wiki/index.php?title=jsextreme/guide/widget">控件</a></li>');
	document.write('<li id="jsmobile_gui3"><a href="http://developer.baidu.com/map/wiki/index.php?title=jsextreme/guide/cover">覆盖物</a></li>');
	document.write('<li id="jsmobile_gui4"><a href="http://developer.baidu.com/map/wiki/index.php?title=jsextreme/guide/event">事件</a></li>');
	document.write('<li id="jsmobile_gui5"><a href="http://developer.baidu.com/map/wiki/index.php?title=jsextreme/guide/maplayer">地图图层</a></li>');
	document.write('<li id="jsmobile_gui6"><a href="http://developer.baidu.com/map/wiki/index.php?title=jsextreme/guide/service">服务</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="jsmobile_2" class="mm12">');
	document.write('<a href ="http://developer.baidu.com/map/reference/index.php?title=Class:%E6%9E%81%E9%80%9F%E7%89%88JS%E6%80%BB%E7%B1%BB/%E6%9E%81%E9%80%9F%E7%89%88%E6%A0%B8%E5%BF%83%E7%B1%BB" target="_blank">类参考V1.0</a>');
	document.write('</li>');
	document.write('<li id="jsmobile_3" class="mm13">');
	document.write('<a href ="jsdemo-mobile.htm" target="_blank">示例DEMO</a>');
	document.write('</li>');
	document.write('<li id="jsmobile_4" class="mm14">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=jsextreme/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li id="jsmobile_6" class="mm14">');
	document.write('<a href ="jsmobile-download.htm">相关下载</a>');
	document.write('</li>');
	document.write('<li class="mm14 mmanage">');
	document.write('<a href="jshome.htm" ><img src="static/img/outside-link-marker.png" /> JavaScript 大众版</a>');
	document.write('</li>');
	document.write('<li class="mm14 mmanage">');
	document.write('<a href="library.htm" target="_blank"><img src="static/img/outside-link-marker.png" /> JavaScript 开源库</a>');
	document.write('</li>');
	document.write('</ul>');
}

//android SDK
function addMenu_and() {
	document.write('<ul>');
	document.write('<li id="andmenu_1" class="mm12">');
	document.write('<a href="sdk-android.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="andmenu_2" class="mm12">');
	document.write('<a href="android-mobile-apply-key.htm">获取密钥</a>');
	document.write('</li>');
	document.write('<li id="andmenu_3" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	document.write('<li id="andmenu_31"><a href="http://developer.baidu.com/map/wiki/index.php?title=androidsdk/guide/introduction">简介</a></li>');
	document.write('<li id="andmenu_40"><a href="http://developer.baidu.com/map/wiki/index.php?title=androidsdk/guide/key">申请密钥</a></li>');
	document.write('<li id="andmenu_32"><a href="http://developer.baidu.com/map/wiki/index.php?title=androidsdk/guide/hellobaidumap">Hello BaiduMap</a></li>');
	document.write('<li id="andmenu_32"><a href="http://developer.baidu.com/map/wiki/index.php?title=androidsdk/guide/basicmap">基础地图</a></li>');
	document.write('<li id="andmenu_32"><a href="http://developer.baidu.com/map/wiki/index.php?title=androidsdk/guide/offlinemap">离线地图</a></li>');
	document.write('<li id="andmenu_32"><a href="http://developer.baidu.com/map/wiki/index.php?title=androidsdk/guide/retrieval">检索功能</a></li>');
	document.write('<li id="andmenu_32"><a href="http://developer.baidu.com/map/wiki/index.php?title=androidsdk/guide/lbscloud">LBS云检索</a></li>');
	document.write('<li id="andmenu_32"><a href="http://developer.baidu.com/map/wiki/index.php?title=androidsdk/guide/tool">计算工具</a></li>');	
	document.write('<li id="andmenu_32"><a href="http://developer.baidu.com/map/wiki/index.php?title=androidsdk/guide/location">定位</a></li>');
	document.write('<li id="andmenu_32"><a href="http://developer.baidu.com/map/wiki/index.php?title=androidsdk/guide/listener">事件监听</a></li>');	
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="andmenu_4" class="mm12">');
	document.write('<a href ="android_refer/index.html" target="_blank">类参考</a>');
	document.write('</li>');
	document.write('<li id="andmenu_5" class="mm12">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=androidsdk/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li id="andmenu_6" class="mm12">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=androidsdk/qa">常见问题</a>');
	document.write('</li>');
	document.write('<li id="andmenu_7" class="mm12">');
	document.write('<a href ="sdkandev-download.htm">相关下载</a>');
	document.write('</li>');
	document.write('</ul>');
}
//IOS导航SDK
function addMenu_iosnav() {
	document.write('<ul>');
	document.write('<li id="iosmenu_1" class="mm12">');
	document.write('<a href="sdk-nav-ios.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="iosmenu_2" class="mm12">');
	document.write('<a href="http://lbsyun.baidu.com/apiconsole/key">获取密钥</a>');
	document.write('</li>');
	document.write('<li id="iosmenu_3" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	document.write('<li id="iosmenu_31"><a href="http://developer.baidu.com/map/wiki/index.php?title=ios-navsdk/guide/introduction">简介</a></li>');
	document.write('<li id="iosmenu_32"><a href="http://developer.baidu.com/map/wiki/index.php?title=ios-navsdk/guide/helloworld">Hello World</a></li>');
	document.write('<li id="iosmenu_33"><a href="http://developer.baidu.com/map/wiki/index.php?title=ios-navsdk/guide/voice">语音播报</a></li>');
	document.write('<li id="iosmenu_34"><a href="http://developer.baidu.com/map/wiki/index.php?title=ios-navsdk/guide/path">路径规划</a></li>');
	document.write('<li id="iosmenu_35"><a href="http://developer.baidu.com/map/wiki/index.php?title=ios-navsdk/guide/navigation">导航功能</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="iosmenu_4" class="mm12">');
	document.write('<a href ="ios_nav_refer/html/annotated.html" target="_blank">类参考</a>');
	document.write('</li>');
	document.write('<li id="iosmenu_5" class="mm12">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=ios-navsdk/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li id="iosmenu_7" class="mm12">');
	document.write('<a href ="sdkios-nav-download.htm">相关下载</a>');
	document.write('</li>');
	document.write('<li id="navand_7" class="mm14 new">');
	document.write('<a href="ios-fullnavsdk.htm">离线导航</a>');
	document.write('</li>');
	document.write('</ul>');
}


//IOS导航
function addMenu_ios() {
	document.write('<ul>');
	document.write('<li id="iosmenu_1" class="mm12">');
	document.write('<a href="sdk-ios.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="iosmenu_2" class="mm12">');
	document.write('<a href="http://lbsyun.baidu.com/apiconsole/key">获取密钥</a>');
	document.write('</li>');
	document.write('<li id="iosmenu_3" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	document.write('<li id="iosmenu_31"><a href="http://developer.baidu.com/map/wiki/index.php?title=iossdk/guide/introduction">简介</a></li>');
	document.write('<li id="iosmenu_30"><a href="http://developer.baidu.com/map/wiki/index.php?title=iossdk/guide/key">申请密钥</a></li>');
	document.write('<li id="iosmenu_33"><a href="http://developer.baidu.com/map/wiki/index.php?title=iossdk/guide/attention">注意事项</a></li>');
	document.write('<li id="iosmenu_32"><a href="http://developer.baidu.com/map/wiki/index.php?title=iossdk/guide/hellobaidumap">Hello BaiduMap</a></li>');
	document.write('<li id="iosmenu_39"><a href="http://developer.baidu.com/map/wiki/index.php?title=iossdk/guide/basicmap">基础地图</a></li>');
	document.write('<li id="iosmenu_34"><a href="http://developer.baidu.com/map/wiki/index.php?title=iossdk/guide/offlinemap">离线地图</a></li>');
	document.write('<li id="iosmenu_35"><a href="http://developer.baidu.com/map/wiki/index.php?title=iossdk/guide/retrieval">检索功能</a></li>');
	document.write('<li id="iosmenu_40"><a href="http://developer.baidu.com/map/wiki/index.php?title=iossdk/guide/lbscloud">LBS.云检索</a></li>');
	document.write('<li id="iosmenu_36"><a href="http://developer.baidu.com/map/wiki/index.php?title=iossdk/guide/tool">计算工具</a></li>');
	document.write('<li id="iosmenu_38"><a href="http://developer.baidu.com/map/wiki/index.php?title=iossdk/guide/location">定位功能</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="iosmenu_4" class="mm12">');
	document.write('<a href ="ios_refer/html/annotated.html" target="_blank">类参考</a>');
	document.write('</li>');
	document.write('<li id="iosmenu_5" class="mm12">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=iossdk/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li id="iosmenu_6" class="mm12">');
	document.write('<a href="http://developer.baidu.com/map/wiki/index.php?title=iossdk/qa">常见问题</a>');
	document.write('</li>');
	document.write('<li id="iosmenu_7" class="mm12">');
	document.write('<a href ="sdkiosdev-download.htm">相关下载</a>');
	document.write('</li>');
	document.write('</ul>');
}

//openmap导航
function addMenu_openmap() {
	document.write('<ul>');
	document.write('<li id="openmap-1" class="mm12">');
	document.write('<a href="openmap-1.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="openmap-list" class="mm12">');
	document.write('<a href="openmap-list.htm">使用流程</a>');
	document.write('</li>');
	document.write('<li id="openmap-question" class="mm12">');
	document.write('<a href="openmapquestion.htm">常见问题</a>');
	document.write('</li>');
	document.write('<li id="openmap-question" class="mm12">');
	document.write('<a href="http://lbsyun.baidu.com/openmap/admin" target="_blank">管理后台</a>');
	document.write('</li>');
	document.write('</ul>');
}


//定位塞班导航
function addMenu_geosdk_symbian() {
	document.write('<ul>');
	document.write('<li id="geosym_1" class="mm14">');
	document.write('<a href="geosdk-symbian.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="geosym_2" class="mm14">');
	document.write('<a href="geosdk-symbian-develop.htm">开发指南</a>');
	document.write('</li>');
	document.write('<li id="geosym_3" class="mm14">');
	document.write('<a href="geosdk-symbian-class.htm">类参考</a>');
	document.write('</li>');
	document.write('<li id="geosym_4" class="mm14">');
	document.write('<a href="geosdk-symbian-update.htm">更新日志</a>');
	document.write('</li>');
	document.write('<li id="geosym_5" class="mm14">');
	document.write('<a href="geosdk-symbian-qa.htm">常见问题</a>');
	document.write('</li>');
	document.write('<li id="geosym_6" class="mm14">');
	document.write('<a href="geosdk-symbian-download.htm">相关下载</a>');
	document.write('</li>');
	document.write('<li id="geosym_7" class="mm14 mnewgeosdk">');
	document.write('<a href="geosdk.htm"><img src="static/img/outside-link-marker.png" /> Android定位SDK</a>');
	document.write('</li>');
	document.write('</ul>');
}

//定位安卓导航
function addMenu_geosdk_android() {
	document.write('<ul>');
	document.write('<li id="geoand_1" class="mm14">');
	document.write('<a href ="geosdk.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="geoand_4" class="mm14">');
	document.write('<a target="_blank" href ="http://lbsyun.baidu.com/apiconsole/key">获取密钥</a>');
	document.write('</li>');
	document.write('<li id="geoand_2" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	document.write('<li id="geoand_28"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-locsdk/guide/key">申请密钥</a></li>');
	document.write('<li id="geoand_29"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-locsdk/guide/v4-2">V4.2</a></li>');
	document.write('<li id="geoand_27"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-locsdk/guide/v4-0">V4.0</a></li>');
	// document.write('<li id="geoand_20"><a href="geosdk-android-developv3.3.htm">V3.3</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="geoand_3" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu2\');">类参考</a>');
	document.write('<div class="msubmenu" id="msubmenu2" style="display:none;">');
	document.write('<ul>');
	document.write('<li id="geoand_38"><a href="loc_refer/index.html" target="_blank">V4.2</a></li>');
	document.write('<li id="geoand_37"><a href="geosdk-android-classv4.0.htm">V4.0</a></li>');
	// document.write('<li id="geoand_30"><a href="geosdk-android-classv3.3.htm">V3.3</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="geoand_7" class="mm14">');
	document.write('<a href="http://developer.baidu.com/map/wiki/index.php?title=android-locsdk/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li id="geoand_5" class="mm14">');
	document.write('<a href="http://developer.baidu.com/map/wiki/index.php?title=android-locsdk/qa">常见问题</a>');
	document.write('</li>');
	document.write('<li id="geoand_6" class="mm14">');
	document.write('<a href="geosdk-android-download.htm">相关下载</a>');
	document.write('</li>');
	// document.write('<li id="geoand_7" class="mm14 mnewgeosdk">');
	// document.write('<a href="geosdk-symbian.htm"><img src="static/img/outside-link-marker.png" /> Symbian定位SDK</a>');
	// document.write('</li>');
	document.write('</ul>');
}
//导航安卓SDK导航
function addMenu_navsdk_android() {
	document.write('<ul>');
	document.write('<li id="navand_1" class="mm14">');
	document.write('<a href ="navsdk.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="navand_2" class="mm14">');
	document.write('<a target="_blank" href ="http://lbsyun.baidu.com/apiconsole/key">获取密钥</a>');
	document.write('</li>');
	document.write('<li id="navand_3" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	document.write('<li id="andmenu_31"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-navsdk/guide/introduction">简介</a></li>');
	document.write('<li id="andmenu_32"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-navsdk/guide/key">申请密钥</a></li>');
	document.write('<li id="andmenu_33"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-navsdk/guide/helloworld">Hello World</a></li>');
	document.write('<li id="andmenu_34"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-navsdk/guide/voice">语音播报</a></li>');
	document.write('<li id="andmenu_35"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-navsdk/guide/path">路径规划</a></li>');
	document.write('<li id="andmenu_36"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-navsdk/guide/navigation">导航功能</a></li>');
	// document.write('<li id="geoand_20"><a href="geosdk-android-developv3.3.htm">V3.3</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="navand_4" class="mm14">');
	document.write('<a href ="nav_ref/index.html" target="_blank" >类参考</a>');
	document.write('</li>');
	document.write('<li id="navand_5" class="mm14">');
	document.write('<a href="http://developer.baidu.com/map/wiki/index.php?title=android-navsdk/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li id="navand_6" class="mm14">');
	document.write('<a href="navsdk-android-download.htm">相关下载</a>');
	document.write('</li>');
	document.write('<li id="navand_7" class="mm14 new">');
	document.write('<a href="android-fullnavsdk.htm">离线导航</a>');
	document.write('</li>');
	// document.write('<li id="geoand_7" class="mm14 mnewgeosdk">');
	// document.write('<a href="geosdk-symbian.htm"><img src="static/img/outside-link-marker.png" /> Symbian定位SDK</a>');
	// document.write('</li>');
	document.write('</ul>');
}

//IOS全景SDK
function addMenu_iospanonav() {
	document.write('<ul>');
	document.write('<li id="iosmenu_1" class="mm12">');
	document.write('<a href="sdk-pano-ios.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="iosmenu_2" class="mm12">');
	document.write('<a href="http://lbsyun.baidu.com/apiconsole/key" onClick="addClass_on3(\'iosmenu_2\')";>获取密钥</a>');
	document.write('</li>');
	document.write('<li id="iosmenu_3" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	document.write('<li id="iosmenu_31"><a href="http://developer.baidu.com/map/wiki/index.php?title=ios-panosdk/guide/introduction">简介</a></li>');
	document.write('<li id="iosmenu_33"><a href="http://developer.baidu.com/map/wiki/index.php?title=ios-panosdk/guide/helloworld">Hello World</a></li>');
	document.write('<li id="iosmenu_34"><a href="http://developer.baidu.com/map/wiki/index.php?title=ios-panosdk/guide/show">展示全景图</a></li>');
	document.write('<li id="iosmenu_35"><a href="http://developer.baidu.com/map/wiki/index.php?title=ios-panosdk/guide/control">全景图控制</a></li>');
	document.write('<li id="iosmenu_36"><a href="http://developer.baidu.com/map/wiki/index.php?title=ios-panosdk/guide/panodata">获取全景数据</a></li>');
	document.write('<li id="iosmenu_36"><a href="http://developer.baidu.com/map/wiki/index.php?title=ios-panosdk/guide/cover">全景图覆盖物</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="iosmenu_4" class="mm12">');
	document.write('<a href ="ios_pano_refer/html/index.html" target="_blank">类参考</a>');
	document.write('</li>');
	document.write('<li id="iosmenu_5" class="mm12">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=ios-panosdk/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li id="iosmenu_6" class="mm12">');
	document.write('<a href ="sdkios-pano-download.htm">相关下载</a>');
	document.write('</li>');
	document.write('</ul>');
}


//安卓全景导航
function addMenu_navsdk_andreview() {
	document.write('<ul>');
	document.write('<li id="review_1" class="mm14">');
	document.write('<a href ="andsdk_review.html">概述</a>');
	document.write('</li>');
	document.write('<li id="review_2" class="mm14">');
	document.write('<a target="_blank" href ="http://lbsyun.baidu.com/apiconsole/key">获取密钥</a>');
	document.write('</li>');
	document.write('<li id="review_3" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	document.write('<li id="review_31"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-panosdk/guide/introduction">简介</a></li>');
	document.write('<li id="review_32"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-panosdk/guide/helloworld">Hello World</a></li>');
	document.write('<li id="review_33"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-panosdk/guide/show">展示全景图</a></li>');
	document.write('<li id="review_34"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-panosdk/guide/control">全景图控制</a></li>');
	document.write('<li id="review_35"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-panosdk/guide/cover">全景图覆盖物</a></li>');
	document.write('<li id="review_33"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-panosdk/guide/album">内景相册</a></li>');
	document.write('<li id="review_34"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-panosdk/guide/interinfo">内景描述信息</a></li>');
	document.write('<li id="review_35"><a href="http://developer.baidu.com/map/wiki/index.php?title=android-panosdk/guide/monitor">事件监听</a></li>');
	// document.write('<li id="geoand_20"><a href="geosdk-android-developv3.3.htm">V3.3</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="review_4" class="mm14">');
	document.write('<a href ="android_review_refer/index.html" target="_blank" >类参考</a>');
	document.write('</li>');
	document.write('<li id="review_5" class="mm14">');
	document.write('<a href="http://developer.baidu.com/map/wiki/index.php?title=android-panosdk/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li id="review_6" class="mm14">');
	document.write('<a href="navsdkandreview-download.html">相关下载</a>');
	document.write('</li>');
	// document.write('<li id="geoand_7" class="mm14 mnewgeosdk">');
	// document.write('<a href="geosdk-symbian.htm"><img src="static/img/outside-link-marker.png" /> Symbian定位SDK</a>');
	// document.write('</li>');
	document.write('</ul>');
}
//安卓全景（离线）
function addMenu_androidfullnavsdk() {
	document.write('<ul>');
	document.write('<li id="fullnavsdk" class="mm13">');
	document.write('<a href ="android-fullnavsdk.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="webmenu_3" class="mm14">');
	document.write('<a href="http://developer.baidu.com/map/wiki/index.php?title=android-navsdk/fullnavsdk/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('</ul>');
}
//IOS全景（离线）
function addMenu_iosfullnavsdk() {
	document.write('<ul>');
	document.write('<li id="fullnavsdk" class="mm13">');
	document.write('<a href ="ios-fullnavsdk.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="webmenu_3" class="mm14">');
	document.write('<a href="http://developer.baidu.com/map/wiki/index.php?title=ios-navsdk/fullnavsdk/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('</ul>');
}
//webservicev1导航
function addMenu_webv1() {
	document.write('<ul>');
	document.write('<li id="webmenu_1" class="mm12">');
	document.write('<a href ="apply-key.htm">获取密钥</a>');
	document.write('</li>');
	document.write('<li id="webmenu_2" class="mm13">');
	document.write('<a href ="place-api.htm">Place API</a>');
	document.write('</li>');
	document.write('<li id="webmenu_3" class="mm14">');
	document.write('<a href ="geocoding-api.htm">Geocoding API</a>');
	document.write('</li>');
	document.write('</ul>');
}

//webservicev2导航
function addMenu_web() {
	document.write('<ul>');
	document.write('<li id="webmenu_6" class="mm16">');
	document.write('<a href ="webservice.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="webmenu_1" class="mm12">');
	document.write('<a href ="http://lbsyun.baidu.com/apiconsole/key?application=key" target="_blank">获取密钥</a>');
	document.write('</li>');
	document.write('<li id="webmenu_2" class="mm13">');
	document.write('<a href ="webservice-placeapi.htm">Place API</a>');
	document.write('</li>');
	document.write('<li id="webmenu_8" class="mm18">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=webapi/place-suggestion-api">Place suggestion API</a>');
	document.write('</li>');
	document.write('<li id="webmenu_3" class="mm14">');
	document.write('<a href ="webservice-geocoding.htm">Geocoding API</a>');
	document.write('</li>');
	document.write('<li id="webmenu_4" class="mm15">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=webapi/direction-api">Direction API</a>');
	document.write('</li>');
	document.write('<li id="webmenu_9" class="mm17">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=webapi/route-matrix-api">Route Matrix API</a>');
	document.write('</li>');
	document.write('<li id="webmenu_7" class="mm17">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=webapi/ip-api">IP定位 API</a>');
	document.write('</li>');
	document.write('<li id="webmenu_10" class="mm17">');
	document.write('<a href ="changeposition.htm">坐标转换 API<img src="static/img/new.png"/></a>');
	document.write('</li>');
	document.write('<li id="webmenu_5" class="mm16">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=webapi/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('</ul>');
}

//FLASH导航
function addMenu_flash() {
	document.write('<ul>');
	document.write('<li id="flashmenu_1" class="mm12">');
	document.write('<a href="flash.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="flashmenu_2" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	document.write('<li id="flashmenu_21"><a href="http://developer.baidu.com/map/wiki/index.php?title=flash/guide/introduction">简介</a></li>');
	document.write('<li id="flashmenu_22"><a href="http://developer.baidu.com/map/wiki/index.php?title=flash/guide/basic">基础知识</a></li>');
	document.write('<li id="flashmenu_23"><a href="http://developer.baidu.com/map/wiki/index.php?title=flash/guide/widget">控件</a></li>');
	document.write('<li id="flashmenu_24"><a href="http://developer.baidu.com/map/wiki/index.php?title=flash/guide/cover">覆盖物</a></li>');
	document.write('<li id="flashmenu_25"><a href="http://developer.baidu.com/map/wiki/index.php?title=flash/guide/event">事件</a></li>');
	document.write('<li id="flashmenu_26"><a href="http://developer.baidu.com/map/wiki/index.php?title=flash/guide/maplayer">地图图层</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="flashmenu_3" class="mm12">');
	document.write('<a href ="http://developer.baidu.com/map/reference/index.php?title=Class:flash%E6%80%BB%E7%B1%BB/flash%E6%A0%B8%E5%BF%83%E7%B1%BB" target="_blank">类参考</a>');
	document.write('</li>');
	document.write('<li id="flashmenu_4" class="mm14">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=flash/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li id="flashmenu_5" class="mm14">');
	document.write('<a href ="fdownload.htm">相关下载</a>');
	document.write('</li>');
	document.write('</ul>');
}
//URI导航
function addMenu_uri() {
	document.write('<ul>');
	document.write('<li id="urimenu_1" class="mm14">');
	document.write('<a href="uri.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="urimenu_2" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	document.write('<li id="urimenu_21"><a href="http://developer.baidu.com/map/wiki/index.php?title=uri/guide/introduction">简介</a></li>');
	document.write('<li id="urimenu_22"><a href="uri-example.htm">Hello World</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="flashmenu_2" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu1\');">接口说明</a>');
	document.write('<div class="msubmenu" id="msubmenu1" style="display:none;">');
	document.write('<ul>');
	document.write('<li id="flashmenu_21"><a href="http://developer.baidu.com/map/wiki/index.php?title=uri/api/web">web端</a></li>');
	document.write('<li id="flashmenu_22"><a href="http://developer.baidu.com/map/wiki/index.php?title=uri/api/android">android端</a></li>');
	document.write('<li id="flashmenu_23"><a href="http://developer.baidu.com/map/wiki/index.php?title=uri/api/ios">iOS端</a></li>');
	document.write('<li id="flashmenu_33"><a href="http://developer.baidu.com/map/wiki/index.php?title=uri/api/appendix">附录</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');

	document.write('<li id="urimenu_3" class="mm14">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=uri/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li id="urimenu_4" class="mm14">');
	document.write('<a href ="uri-download.htm">相关下载</a>');
	document.write('</li>');
	document.write('</ul>');
}
//云平台导航
function addMenu_lbs() {
	document.write('<ul>');
	document.write('<li class="mm12" id="lbsmenu_1">');
	document.write('<a href="lbs-cloud.htm">概述</a>');
	document.write('</li>');
	document.write('<li class="mm12">');
	document.write('<a href="http://lbsyun.baidu.com/apiconsole/key" target="_blank">获取密钥</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_1" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu1\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu1" style="display:none;">');
	document.write('<ul>');
	document.write('<li id="jsmenu_11"><a href="http://developer.baidu.com/map/wiki/index.php?title=lbscloud/guide/introduction">简介</a></li>');
	document.write('<li id="jsmenu_12"><a href="http://developer.baidu.com/map/wiki/index.php?title=lbscloud/guide/explanation">名称解释</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li class="mm11" id="lbsmenu_2">');
	document.write('<a href ="#" onClick="Contextdisplay(\'msubmenu\');">接口说明</a>');
	document.write('<div class="msubmenu" id="msubmenu" style="display:none;">');
	document.write('<ul>');
	document.write('<li id="lbsmenu_2_1"><a href="http://developer.baidu.com/map/wiki/index.php?title=lbscloud/api/geodata">LBS云存储</a></li>');
	document.write('<li id="lbsmenu_2_2"><a href="http://developer.baidu.com/map/wiki/index.php?title=lbscloud/api/geosearch">LBS云检索</a></li>');
	document.write('<li id="lbsmenu_2_3"><a href="http://developer.baidu.com/map/wiki/index.php?title=lbscloud/api/appendix">附录</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li class="mm14" id="lbsmenu_3">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=lbscloud/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li class="mm14" id="lbsmenu_5">');
	document.write('<a href ="lbs-demo.htm">示例DEMO</a>');
	document.write('</li>');
	document.write('<li class="mm14" id="lbsmenu_4">');
	document.write('<a href ="lbs-download.htm">相关下载</a>');
	document.write('</li>');
	document.write('<li class="mm14 mmanage">');
	document.write('<a href="http://lbsyun.baidu.com/datamanager/datamanage" target="_blank"><img src="static/img/outside-link-marker.png" /> LBS云管理后台</a>');
	document.write('</li>');
	document.write('</ul>');
}


//车联网导航
function addMenu_car() {
	document.write('<ul>');
	document.write('<li id="jsmenu_0" class="mm14">');
	document.write('<a href ="carhome.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_11" class="mm14"><a href="http://lbsyun.baidu.com/apiconsole/key?application=key" target="_blank">获取密钥</a></li>');
	document.write('<li id="jsmenu_1" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'msubmenu\');">开发指南</a>');
	document.write('<div class="msubmenu" id="msubmenu">');
	document.write('<ul>');
	document.write('<li id="jsmenu_11"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/guide/introduction">简介</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="carapimenu_1" class="mm11">');
	document.write('<a href ="javascript:void(0);" onClick="Contextdisplay(\'car_api_menu\');">接口说明</a>');
	document.write('<div class="msubmenu" id="car_api_menu">');
	document.write('<ul>');
	document.write('<li id="carapimenu_111"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/tocar">发送到车</a></li>');
	document.write('<li id="carapimenu_11"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/geocoding">Geocoding</a></li>');
	document.write('<li id="carapimenu_12"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/anti-geocoding">反Geocoding</a></li>');
	document.write('<li id="carapimenu_13"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/interest">兴趣点检索</a></li>');
	document.write('<li id="carapimenu_14"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/surrounding">周边检索</a></li>');
	document.write('<li id="carapimenu_15"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/driving">驾车检索</a></li>');
	document.write('<li id="carapimenu_16"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/distance">测距</a></li>');
	document.write('<li id="carapimenu_17"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/weather">天气查询</a></li>');
	document.write('<li id="carapimenu_18"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/traffic">交通事件查询</a></li>');
	document.write('<li id="carapimenu_19"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/road">途径路段查询</a></li>');
	document.write('<li id="carapimenu_112"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/tourism">旅游线路查询</a></li>');
	document.write('<li id="carapimenu_113"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/scenic">景点详情</a></li>');
	document.write('<li id="carapimenu_114"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/movie">热映影片</a></li>');
	document.write('<li id="carapimenu_115"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/movieinfo">影片影讯检索</a></li>');
	document.write('<li id="carapimenu_116"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/cinemainfo">影院影讯检索</a></li>');
	document.write('<li id="carapimenu_117"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/near-cinema">周边影院检索</a></li>');
	document.write('<li id="carapimenu_110"><a href="http://developer.baidu.com/map/wiki/index.php?title=car/api/appendix">附录</a></li>');
	document.write('</ul>');
	document.write('</div>');
	document.write('</li>');
	document.write('<li id="jsmenu_4" class="mm14">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=car/theupdatelog">更新日志</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_12" class="mm14">');
	document.write('<a href ="car-success.htm">成功案例</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_6" class="mm14">');
	document.write('<a href ="car-download.htm">相关下载</a>');
	document.write('</li>');
	document.write('</ul>');
}



//静态图导航
function addMenu_static(source) {
	document.write('<ul>');
	document.write('<li id="jsmenu_0" class="mm14">');
	document.write('<a href ="staticimg.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_1" class="mm14">');
	document.write('<a href ="static-1.htm">接口说明</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_2" class="mm14">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=static/theupdatelog">更新日志</a>');
	document.write('</li>');
	if(source == 'static'){
		document.write('<li class="mm14 mmanage">');
		document.write('<a href="viewstatic.htm" ><img src="static/img/outside-link-marker.png" /> 全景静态图API</a>');
		document.write('</li>');
	}else if (source == 'viewstatic'){
		document.write('<li class="mm14 mmanage">');
		document.write('<a href="staticimg.htm" ><img src="static/img/outside-link-marker.png" /> 静态图API</a>');
		document.write('</li>');
	}
	document.write('</ul>');
}

//全景静态图导航
function addMenu_viewstatic(source) {
	document.write('<ul>');
	document.write('<li id="jsmenu_0" class="mm14">');
	document.write('<a href ="viewstatic.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_1" class="mm14">');

	document.write('<a href ="http://developer.baidu.com/map/viewstatic-1.htm">接口说明</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_2" class="mm14">');
	document.write('<a href ="http://developer.baidu.com/map/wiki/index.php?title=viewstatic/theupdatelog">更新日志</a>');
	document.write('</li>');
	if(source == 'static'){
		document.write('<li class="mm14 mmanage">');
		document.write('<a href="viewstatic.htm" ><img src="static/img/outside-link-marker.png" /> 全景静态图API</a>');
		document.write('</li>');
	}else if (source == 'viewstatic'){
		document.write('<li class="mm14 mmanage">');
		document.write('<a href="staticimg.htm" ><img src="static/img/outside-link-marker.png" /> 静态图API</a>');
		document.write('</li>');
	}
	document.write('</ul>');
}


//定位SDK
function addMenu_geosdk() {
	document.write('<ul>');
	document.write('<li id="jsmenu_0" class="mm14">');
	document.write('<a href ="geosdk.htm">概述</a>');
	document.write('</li>');
	document.write('<li id="jsmenu_1" class="mm14">');
	document.write('<a href ="geosdk.htm">Android定位SDK</a>');
	document.write('</li>');
	// document.write('<li id="jsmenu_2" class="mm14">');
	// document.write('<a href ="geosdk-symbian.htm">Symbian定位SDK</a>');
	// document.write('</li>');
	document.write('</ul>');
}