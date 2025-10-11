//var color_gray = "#999";// 没有
//var color_green = "#43ce17";// 优
//var color_yellow = "#efdc31";// 良
//var color_orange = "#fa0";// 轻度污染
//var color_red = "#ff401a";// 中度污染
//var color_brown = "#d20040";// 重度污染
//var color_purple = "#9c0a4e";// 严重污染'
//var aqiStandard = [0,50,100,150,200,300];
//var pm25Standard = [0,35,75,115,150,250];
//var pm10tandard = [0,50,150,250,350,420];
//var no2Standard = [0,100,200,700,1200,2430];
//var coStandard = [0,5,10,35,60,90];
//var o3Standard = [0,160,200,300,400,800];
//var so2Standard = [0,150,500,650,800];
var aqiStandard ;
var pm25Standard ;
var pm10Standard ;
var no2Standard;
var coStandard ;
var o3Standard ;
var so2Standard ;
/*
 * 空气质量标准 	AQI指数 	等级 	注意事项
 * 0-50 		1级		 优 		参加户外活动呼吸清新空气 
 * 50-100 		2级 		良 		可以正常进行室外活动 
 * 101-150 		3级 		轻度 	敏感人群减少体力消耗大的户外活动 
 * 151-200 		4级 		中度 	对敏感人群影响较大 
 * 201-300 		5级 		重度		所有人应适当减少室外活动 
 * >300 		6级 		严重 	尽量不要留在室外
 */
/**
 * 根据aqi的等级aqiValue，获得与之对应的等级颜色
 * @param aqiValue
 * @returns {String}
 */
/*function formatAQI(aqiValue) {
	var span = null;
	if (val <= 0) {
		span = '<span style="color:"#999" >' + aqiValue + '</span>';
	} else if (val <= 50) {
		span = '<span style="color:#43ce17" >' + aqiValue + '</span>';
	} else if (val <= 100) {
		span = '<span style="color:#efdc31" >' + aqiValue + '</span>';
	} else if (val <= 150) {
		span = '<span style="color:#fa0" >' + aqiValue + '</span>';
	} else if (val <= 200) {
		span = '<span style="color:#ff401a" >' + aqiValue + '</span>';
	} else if (val <= 300) {
		span = '<span style="color:#d20040" >' + aqiValue + '</span>';
	} else {
		span = '<span style="color:#9c0a4e" >' + aqiValue + '</span>';
	}
	return span;
}*/
/**
 * 根据等级1~6，获得对应的汉语
 * @param val
 * @returns {String}
 */
function getLevel(aqiGrade) {
	var value = null;
	switch (aqiGrade) {
	case '1': value = '优'; break;
	case '2': value = '良'; break;
	case '3': value = '轻度污染'; break;
	case '4': value = '中度污染'; break;
	case '5': value = '重度污染'; break;
	case '6': value = '严重污染'; break;
	default: value = '无'; break;
	}
	return value;
}
/**
 * 根据环境质量等级获得对应的图标所在路径
 */
function getIconByIndex(index) {
	var icon;
	switch (index) {
	case 0: icon = "js/map/img/gray.png"; break;
	case 1: icon = "js/map/img/green.png"; break;
	case 2: icon = "js/map/img/yellow.png"; break;
	case 3: icon = "js/map/img/orange.png"; break;
	case 4: icon = "js/map/img/red.png"; break;
	case 5: icon = "js/map/img/brown.png"; break;
	case 6: icon = "js/map/img/purple.png"; break;
	}
	return icon;
}
/**
 * 根据等级分配颜色
 * @param index
 * @returns {String}
 */
function getColorByIndex(index) {
	var color;
	switch (index) {
	case 0: color = '#999'; break;
	case 1: color = '#43ce17'; break;
	case 2: color = '#efdc31'; break;
	case 3: color = '#fa0'; break;
	case 4: color = '#ff401a'; break;
	case 5: color = '#d20040'; break;
	case 6: color = '#9c0a4e'; break;
	}
	return color;
}
/**
 * 根据值，与指标的阈值判断等级
 * @param array
 * @param value
 * @returns {Number}
 */
function getLevelIdex(array,value){
	var level;
	if (value == array[0]) {
		level = 0;
	} else if (value <= array[1]) {
		level = 1;
	} else if (value <= array[2]) {
		level = 2;
	} else if (value <= array[3]) {
		level = 3;
	} else if (value <= array[4]) {
		level = 4;
	} else if (array.length == 5) {
		level = 5;
	} else if (array.length == 6) {
		if (value <= array[5]) {
			level = 5;
		} else {
			level = 6;
		}
	}
	return level;
}
/**
 * 根据值判断等级
 * @param aqi aqi基本数值
 * @returns {Number}
 */
function getAQILevelIndex(aqi) {
	return getLevelIdex(aqiStandard,aqi);
}
/**
 * 
 * @param pm2_5
 * @returns {Number}
 */
function getPM25LevelIndex(pm2_5) {
	return getLevelIdex(pm25Standard,pm2_5);
}
/**
 * 
 * @param pm10
 * @returns {Number}
 */
function getPM10LevelIndex(pm10) {
	return getLevelIdex(pm10Standard,pm10);
}
/**
 * 
 * @param so2
 * @returns {Number}
 */
function getSO2LevelIndex(so2) {
	return getLevelIdex(so2Standard,so2);
}
/**
 * 
 * @param no2
 * @returns {Number}
 */
function getNO2LevelIndex(no2) {
	return getLevelIdex(no2Standard,no2);
}
/**
 * 
 * @param o3
 * @returns {Number}
 */
function getO3LevelIndex(o3) {
	return getLevelIdex(o3Standard,o3);
}
/**
 * 
 * @param co
 * @returns {Number}
 */
function getCOLevelIndex(co) {
	return getLevelIdex(coStandard,co);
}
/**
 * getmap 创建map集合
 */
function getMap() {
	var map_ = new Object();
	// 方法，向map中添加键值对
	map_.put = function(key, value) {
		map_[key + '_'] = value;
	};
	// 方法，根据key值取value
	map_.get = function(key) {
		return map_[key + '_'];
	};
	// 方法，根据key删除value
	map_.remove = function(key) {
		delete map_[key + '_'];
	};
	// 方法，取所有的key值，目前key值只支持字符串，取回的key的结构是：[k1,k2,k3]
	map_.keyset = function() {
		var ret = "";
		for ( var p in map_) {
			if (typeof p == 'string' && p.substring(p.length - 1) == "_") {
				ret += ",";
				ret += p.substring(0, p.length - 1);
			}
		}
		if (ret == "") {
			return ret.split(",");
		} else {
			return ret.substring(1).split(",");
		}
	};
	return map_;
}

// 获取字符串长度 区分中英文, 中文两个字节
String.prototype.getBytes = function() {
	var cArr = this.match(/[^\x00-\xff]/ig);
	return this.length + (cArr == null ? 0 : cArr.length);
};
// 截取字符串长度 区分中英文, 中文两个字节. 超出部分中指定字符串代替 需引用 String.prototype.getBytes
String.prototype.cutBytes = function(strLen, replaceStr) {
	var str = this.toString();
	if (str.getBytes() <= strLen)
		return str;
	var returnStr = "";
	var tempLen = 0;
	for (var i = 0; i < str.length; i++) {
		var tempChar = str[i].match(/[^\x00-\xff]/ig);
		returnStr += str[i];
		tempLen += tempChar == null ? 1 : 2;
		if (tempLen >= strLen) {
			return i + 1 < str.length ? returnStr + replaceStr : returnStr;
		}
	}
	return "";
};

/**
 * <br>
 * 对Date的扩展，将 Date 转化为指定格式的String <br>
 * 月(M)、日(d)、12小时(h)、24小时(H)、分(m)、秒(s)、周(E)、季度(q) 可以用 1-2 个占位符 <br>
 * 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) <br>
 * eg: <br>
 * (new Date()).pattern("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
 * <br>
 * (new Date()).pattern("yyyy-MM-dd E HH:mm:ss") ==> 2009-03-10 二 20:09:04 <br>
 * (new Date()).pattern("yyyy-MM-dd EE hh:mm:ss") ==> 2009-03-10 周二 08:09:04
 * <br>
 * (new Date()).pattern("yyyy-MM-dd EEE hh:mm:ss") ==> 2009-03-10 星期二 08:09:04
 * <br>
 * (new Date()).pattern("yyyy-M-d h:m:s.S") ==> 2006-7-2 8:9:4.18 <br>
 */
Date.prototype.pattern = function(fmt) {
	var o = {
		"M+" : this.getMonth() + 1, // 月份
		"d+" : this.getDate(), // 日
		"h+" : this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, // 小时
		"H+" : this.getHours(), // 小时
		"m+" : this.getMinutes(), // 分
		"s+" : this.getSeconds(), // 秒
		"q+" : Math.floor((this.getMonth() + 3) / 3), // 季度
		"S" : this.getMilliseconds()
	// 毫秒
	};
	var week = {
		"0" : "\u65e5",
		"1" : "\u4e00",
		"2" : "\u4e8c",
		"3" : "\u4e09",
		"4" : "\u56db",
		"5" : "\u4e94",
		"6" : "\u516d"
	};
	if (/(y+)/.test(fmt)) {
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}
	if (/(E+)/.test(fmt)) {
		fmt = fmt
				.replace(
						RegExp.$1,
						((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "\u661f\u671f"
								: "\u5468")
								: "")
								+ week[this.getDay() + ""]);
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(fmt)) {
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
		}
	}
	return fmt;
};


function myformatter(date) {
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	var d = date.getDate();
	return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
}
function myparser(s) {
	if (!s)
		return new Date();
	var ss = (s.split('-'));
	var y = parseInt(ss[0], 10);
	var m = parseInt(ss[1], 10);
	var d = parseInt(ss[2], 10);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
		return new Date(y, m - 1, d);
	} else {
		return new Date();
	}
}

// 替换
function myreplace(str, a, b) {
	var reg = new RegExp(a, "g"); // 创建正则RegExp对象

	var newstr = str.replace(reg, b);
	return newstr;
}

// 字符串查找
function inarray(obj, arr) {
	for ( var i in arr) {
		if (arr[i] == obj) {
			return true;
		}
	}
	return false;
}

// convert time format for Firefox and IE
function converTimeFormat(time) {
	if (time != null) {
		time = time.replace("-", "/");
		time = time.replace("-", "/");
		return new Date(time);
	}
	return null;
}

// calculate the time difference (second)
function calTimeDiff(time) {
	var time1 = converTimeFormat(time);
	var time2 = new Date();
	var timediff = (time2.getTime() - time1.getTime()) / 1000;
	return timediff;
}

// show message
function showMessage(type, message) {
	if (type) {
		$('#img-logo').src = "js/map/img/sucess.png";
		msg = "<table><tr><td valign='middle'><img id='img-logo' src='js/map/img/sucess.png'/></td><td valign='middle'><div id='msgdiv' style='font-size:13px'>"
				+ message + "</div></td></tr></table>";
	} else {
		msg = "<table><tr><td valign='middle'><img id='img-logo' src='js/map/img/failure.png'/></td><td valign='middle'><div id='msgdiv' style='font-size:13px'>"
				+ message + "</div></td></tr></table>";
	}
	$.messager.show({
		title : '系统提示',
		msg : msg
	});
}

// show tip
function showTip(id, message) {
	var v = document.getElementById(id);
	$(
			"<div id='"
					+ id
					+ "_mask' class=\"datagrid-mask\" style=\"display:block\"></div>")
			.appendTo(v);
	var msg = $(
			"<div id='"
					+ id
					+ "_mask_msg' class=\"datagrid-mask-msg\" style=\"display:block;left:50%\"></div>")
			.html(message).appendTo(v);
	msg.css("marginLeft", -msg.outerWidth() / 2);
}

// clear tip
function clearTip(id) {
	var idmask = id + "_mask";
	var idmaskmsg = id + "_mask_msg";
	$("#" + idmask).remove();
	$("#" + idmaskmsg).remove();
}

// date format check
function dateFormatCheck(date) {
	var result = date.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);

	if (result == null)
		return false;
	var d = new Date(result[1], result[3] - 1, result[4]);
	return (d.getFullYear() == result[1] && (d.getMonth() + 1) == result[3] && d
			.getDate() == result[4]);
}

function formatValue(val, row) {
	if (val != null) {
		var subval = getFloatStr(val);
		return subval;
	} else {
		return val;
	}
}

function formattip(val, row) {
	var subval = val;
	if (val != null) {
		if (val.length > 20) {
			subval = val.substring(0, 20) + "...";
		}
		var content = '<p title="' + val + '" style="margin:0">' + subval
				+ '</p>';
		return content;
	}
}
var getFloatStr = function(num) {
	num += '';
	num = num.replace(/[^0-9|\.-]/g, ''); // 清除字符串中的非数字非.字符

	if (/^0+/) // 清除字符串开头的0
		num = num.replace(/^0+/, '');
	if (!/\./.test(num)) // 为整数字符串在末尾添加.00
		num += '.00';
	if (/^\./.test(num)) // 字符以.开头时,在开头添加0
		num = '0' + num;
	num += '00'; // 在字符串末尾补零
	num = num.match(/-?\d+\.\d{2}/)[0];
	return num;
};

$.extend($.fn.combo.methods, {
	/**
	 * 激活点击文本框也显示下拉面板的功能
	 * 
	 * @param {Object}
	 *            jq
	 */
	activeTextArrow : function(jq) {
		return jq.each(function() {
			var textbox = $(this).combo("textbox");
			var that = this;
			var panel = $(this).combo("panel");
			textbox.bind('click.mycombo', function() {
				if (panel.is(":visible")) {
					$(that).combo('hidePanel');
				} else {
					$("div.combo-panel").panel("close");
					$(that).combo('showPanel');
				}
			});
		});
	},
	/**
	 * 取消点击文本框也显示下拉面板的功能
	 * 
	 * @param {Object}
	 *            jq
	 */
	inactiveTextArrow : function(jq) {
		return jq.each(function() {
			var textbox = $(this).combo("textbox");
			textbox.unbind('click.mycombo');
		});
	}
});

function countCharacters(str) {
	var totalCount = 0;
	for (var i = 0; i < str.length; i++) {
		var c = str.charCodeAt(i);
		if ((c >= 0x0001 && c <= 0x007e) || (0xff60 <= c && c <= 0xff9f)) {
			totalCount++;
		} else {
			totalCount += 2;
		}
	}
	// alert(totalCount);
	return totalCount;
}

function decrypt_result(data, key) {
	var b = new Base64();
	result = b.decode(data);
	return b.decode(result.substr(0, result.length - key.length));
}

function encrypt_parameter(param) {
	var b = new Base64();
	return b.encode(param);
}

function Base64() {
	// private property
	_keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

	// 公共方法，utf-8编码
	this.encode = function(input) {
		var output = "";
		var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
		var i = 0;
		input = _utf8_encode(input);
		while (i < input.length) {
			chr1 = input.charCodeAt(i++);
			chr2 = input.charCodeAt(i++);
			chr3 = input.charCodeAt(i++);
			enc1 = chr1 >> 2;
			enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
			enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
			enc4 = chr3 & 63;
			if (isNaN(chr2)) {
				enc3 = enc4 = 64;
			} else if (isNaN(chr3)) {
				enc4 = 64;
			}
			output = output + _keyStr.charAt(enc1) + _keyStr.charAt(enc2)
					+ _keyStr.charAt(enc3) + _keyStr.charAt(enc4);
		}
		return output;
	}

	// 公共方法，utf-8解码
	this.decode = function(input) {
		var output = "";
		var chr1, chr2, chr3;
		var enc1, enc2, enc3, enc4;
		var i = 0;
		input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
		while (i < input.length) {
			enc1 = _keyStr.indexOf(input.charAt(i++));
			enc2 = _keyStr.indexOf(input.charAt(i++));
			enc3 = _keyStr.indexOf(input.charAt(i++));
			enc4 = _keyStr.indexOf(input.charAt(i++));
			chr1 = (enc1 << 2) | (enc2 >> 4);
			chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
			chr3 = ((enc3 & 3) << 6) | enc4;
			output = output + String.fromCharCode(chr1);
			if (enc3 != 64) {
				output = output + String.fromCharCode(chr2);
			}
			if (enc4 != 64) {
				output = output + String.fromCharCode(chr3);
			}
		}
		output = _utf8_decode(output);
		return output;
	}
	// 私有UTF-8编码方法
	_utf8_encode = function(string) {
		string = string.replace(/\r\n/g, "\n");
		var utftext = "";
		for (var n = 0; n < string.length; n++) {
			var c = string.charCodeAt(n);
			if (c < 128) {
				utftext += String.fromCharCode(c);
			} else if ((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			} else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}

		}
		return utftext;
	}

	// 私有UTF-8解码方法
	_utf8_decode = function(utftext) {
		var string = "";
		var i = 0;
		var c = c1 = c2 = 0;
		while (i < utftext.length) {
			c = utftext.charCodeAt(i);
			if (c < 128) {
				string += String.fromCharCode(c);
				i++;
			} else if ((c > 191) && (c < 224)) {
				c2 = utftext.charCodeAt(i + 1);
				string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
				i += 2;
			} else {
				c2 = utftext.charCodeAt(i + 1);
				c3 = utftext.charCodeAt(i + 2);
				string += String.fromCharCode(((c & 15) << 12)
						| ((c2 & 63) << 6) | (c3 & 63));
				i += 3;
			}
		}
		return string;
	}
}
