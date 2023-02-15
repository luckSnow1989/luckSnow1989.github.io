var Vcity = {};
Vcity._m = {
	$ : function(arg, context) {
		var tagAll, n, eles = [], i, sub = arg.substring(1);
		context = context || document;
		if (typeof arg == "string") {
			switch (arg.charAt(0)) {
			case "#":
				return document.getElementById(sub);
				break;
			case ".":
				if (context.getElementsByClassName) {
					return context.getElementsByClassName(sub)
				}
				tagAll = Vcity._m.$("*", context);
				n = tagAll.length;
				for (i = 0; i < n; i++) {
					if (tagAll[i].className.indexOf(sub) > -1) {
						eles.push(tagAll[i])
					}
				}
				return eles;
				break;
			default:
				return context.getElementsByTagName(arg);
				break
			}
		}
	},
	on : function(node, type, handler) {
		node.addEventListener ? node.addEventListener(type, handler, false)
				: node.attachEvent("on" + type, handler)
	},
	getEvent : function(event) {
		return event || window.event
	},
	getTarget : function(event) {
		return event.target || event.srcElement
	},
	getPos : function(node) {
		var scrollx = document.documentElement.scrollLeft
				|| document.body.scrollLeft, scrollt = document.documentElement.scrollTop
				|| document.body.scrollTop;
		var pos = node.getBoundingClientRect();
		return {
			top : pos.top + scrollt,
			right : pos.right + scrollx,
			bottom : pos.bottom + scrollt,
			left : pos.left + scrollx
		}
	},
	addClass : function(c, node) {
		if (!node) {
			return
		}
		node.className = Vcity._m.hasClass(c, node) ? node.className
				: node.className + " " + c
	},
	removeClass : function(c, node) {
		var reg = new RegExp("(^|\\s+)" + c + "(\\s+|$)", "g");
		if (!Vcity._m.hasClass(c, node)) {
			return
		}
		node.className = reg.test(node.className) ? node.className.replace(reg,
				"") : node.className
	},
	hasClass : function(c, node) {
		if (!node || !node.className) {
			return false
		}
		return node.className.indexOf(c) > -1
	},
	stopPropagation : function(event) {
		event = event || window.event;
		event.stopPropagation ? event.stopPropagation()
				: event.cancelBubble = true
	},
	trim : function(str) {
		return str.replace(/^\s+|\s+$/g, "")
	}
};
//全国所有的城市，不包括香港、澳门、台湾三个地区的数据
Vcity.allCity = [ "北京|beijing|bj", "上海|shanghai|sh", "重庆|chongqing|cq",
	          		"深圳|shenzhen|sz", "广州|guangzhou|gz", "南京|nanjing|nj", "杭州|hangzhou|hz",
	          		"苏州|shuzhou|sz", "天津|tianjin|tj", "成都|chengdu|cd", "南昌|nanchang|nc",
	          		"三亚|sanya|sy", "青岛|qingdao|qd", "厦门|xiamen|xm", "西安|xian|xa",
	          		"长沙|changsha|cs", "合肥|hefei|hf", "昆明|kunming|km", "济南|jinan|jn",
	          		"拉萨|lasa|ls", "沈阳|shenyang|sy", "长春|changchun|cc", "兰州|lanzhou|lz",
	          		"郑州|zhengzhou|zz", "贵阳|guiyang|gy", "亳州|bozhou|bz", "福州|fuzhou|fz",
	          		"富阳|fuyang|fy", "伊春|yichun|yc", "玉林|yulin|yl",
	          		"阿坝|aba|ab", "安康|ankang|ak", "阿克苏|akesu|aks", "阿里|ali|al",
	          		"阿拉善盟|alashanmeng|alsm", "阿勒泰|aletai|alt", "安庆|anqing|aq",
	          		"鞍山|anshan|as", "安顺|anshun|as", "阿图什|atushi|ats", "安阳|anyang|ay",
	          		"蚌埠|bangbu|bb", "白城|baicheng|bc", "保定|baoding|bd", "北海|beihai|bh",
	          		"宝鸡|baoji|bj", "毕节|bijie|bj", "博乐|bole|bl", "百色|baise|bs",
	          		"保山|baoshan|bs", "白山|baishan|bs", "包头|baotou|bt", "本溪|benxi|bx",
	          		"巴彦|bayan|by", "白银|baiyin|by", "巴中|bazhong|bz", "滨州|binzhou|bz",
	          		"承德|chengde|cd", "常德|changde|cd", "昌都|changdu|cd", "赤峰|chifeng|cf",
	          		"昌吉|changji|cj", "常熟|changshu|cs", "楚雄|chuxiong|cx",
	          		"朝阳|chaoyang|cy", "崇左|chongzuo|cz", "滁州|chuzhou|cz", "池州|chizhou|cz",
	          		"沧州|cangzhou|cz", "长治|changzhi|cz", "常州|changzhou|cz",
	          		"潮州|chaozhou|cz", "郴州|chenzhou|cz", "丹东|dandong|dd", "东莞|dongguan|dg",
	          		"德宏|dehong|dh", "大理|dali|dl", "大连|dalian|dl", "大庆|daqing|dq",
	          		"大同|datong|dt", "定西|dingxi|dx", "大兴安岭|daxinganling|dxal",
	          		"东营|dongying|dy", "都匀|duyun|dy", "德阳|deyang|dy", "德州|dezhou|dz",
	          		"达州|dazhou|dz", "鄂尔多斯|eerduosi|eeds", "恩施|enshi|es", "鄂州|ezhou|ez",
	          		"防城港|fangchenggang|fcg", "佛山|foshan|fs", "抚顺|fushun|fs", "阜新|fuxin|fx",
	          		"阜阳|fuyang|fy", "抚州|fuzhou|fz", "广安|guangan|ga", "贵港|guigang|gg",
	          		"果洛|guoluo|gl", "桂林|guilin|gl", "甘南|gannan|gn", "固原|guyuan|gy",
	          		"广元|guangyuan|gy", "甘孜|ganzi|gz", "赣州|ganzhou|gz", "淮安|huaian|ha",
	          		"鹤壁|hebi|hb", "淮北|huaibei|hb", "海北|haibei|hb", "河池|hechi|hc",
	          		"邯郸|handan|hd", "海东|haidong|hd", "哈尔滨|haerbin|heb", "黄冈|huanggang|hg",
	          		"鹤岗|hegang|hg", "怀化|huaihua|hh", "红河|honghe|hh", "黑河|heihe|hh",
	          		"呼和浩特|huhehaote|hhht", "海口|haikou|hk", "呼伦贝尔|hulunbeier|hlbe",
	          		"葫芦岛|huludao|hld", "海门|haimen|hm", "哈密|hami|hm", "黄南|huangnan|hn",
	          		"淮南|huainan|hn", "海南|hainan|hn", "黄石|huangshi|hs", "衡水|hengshui|hs",
	          		"黄山|huangshan|hs", "和田|hetian|ht", "海西|haixi|hx", "河源|heyuan|hy",
	          		"衡阳|hengyang|hy", "惠州|huizhou|hz", "贺州|hezhou|hz", "湖州|huzhou|hz",
	          		"汉中|hanzhong|hz", "菏泽|heze|hz", "吉安|jian|ja", "金昌|jinchang|jc",
	          		"晋城|jincheng|jc", "景德镇|jingdezhen|jdz", "金华|jinhua|jh",
	          		"景洪|jinghong|jh", "九江|jiujiang|jj", "吉林|jilin|jl", "荆门|jingmen|jm",
	          		"江门|jiangmen|jm", "即墨|jimo|jm", "佳木斯|jiamusi|jms", "济宁|jining|jn",
	          		"胶南|jiaonan|jn", "酒泉|jiuquan|jq", "句容|jurong|jr", "吉首|jishou|js",
	          		"金坛|jintan|jt", "鸡西|jixi|jx", "嘉兴|jiaxing|jx", "揭阳|jieyang|jy",
	          		"江阴|jiangyin|jy", "嘉峪关|jiayuguan|jyg", "胶州|jiaozhou|jz",
	          		"荆州|jingzhou|jz", "锦州|jinzhou|jz", "晋中|jinzhong|jz", "焦作|jiaozuo|jz",
	          		"库尔勒|kuerle|kel", "开封|kaifeng|kf", "凯里|kaili|kl", "克拉玛依|kelamayi|klmy",
	          		"喀什|kashi|ks", "昆山|kunshan|ks", "临安|linan|la", "六安|liuan|la",
	          		"来宾|laibin|lb", "聊城|liaocheng|lc", "临沧|lincang|lc", "娄底|loudi|ld",
	          		"临汾|linfen|lf", "廊坊|langfang|lf", "漯河|luohe|lh", "丽江|lijiang|lj",
	          		"吕梁|lvliang|ll", "陇南|longnan|ln", "六盘水|liupanshui|lps", "丽水|lishui|ls",
	          		"凉山|liangshan|ls", "乐山|leshan|ls", "莱芜|laiwu|lw", "临夏|linxia|lx",
	          		"莱西|laixi|lx", "洛阳|luoyang|ly", "龙岩|longyan|ly", "辽阳|liaoyang|ly",
	          		"临沂|linyi|ly", "溧阳|liyang|ly", "辽源|liaoyuan|ly", "连云港|lianyungang|lyg",
	          		"柳州|liuzhou|lz", "林芝|linzhi|lz", "泸州|luzhou|lz", "莱州|laizhou|lz",
	          		"马鞍山|maanshan|mas", "牡丹江|mudanjiang|mdj", "茂名|maoming|mm",
	          		"眉山|meishan|ms", "绵阳|mianyang|my", "梅州|meizhou|mz", "宁波|ningbo|nb",
	          		"南充|nanchong|nc", "宁德|ningde|nd", "内江|neijiang|nj", "怒江|nujiang|nj",
	          		"南宁|nanning|nn", "南平|nanping|np", "那曲|naqu|nq", "南通|nantong|nt",
	          		"南阳|nanyang|ny", "平度|pingdu|pd", "平顶山|pingdingshan|pds", "普洱|puer|pe",
	          		"盘锦|panjin|pj", "平凉|pingliang|pl", "蓬莱|penglai|pl", "莆田|putian|pt",
	          		"萍乡|pingxiang|px", "濮阳|puyang|py", "攀枝花|panzhihua|pzh",
	          		"秦皇岛|qinhuangdao|qhd", "曲靖|qujing|qj", "齐齐哈尔|qiqihaer|qqhe",
	          		"七台河|qitaihe|qth", "黔西|qianxi|qx", "庆阳|qingyang|qy", "清远|qingyuan|qy",
	          		"衢州|quzhou|qz", "钦州|qinzhou|qz", "泉州|quanzhou|qz", "荣成|rongcheng|rc",
	          		"日喀则|rikaze|rkz", "乳山|rushan|rs", "日照|rizhao|rz", "寿光|shouguang|sg",
	          		"韶关|shaoguan|sg", "绥化|suihua|sh", "石河子|shihezi|shz",
	          		"石家庄|shijiazhuang|sjz", "商洛|shangluo|sl", "三明|sanming|sm",
	          		"三门峡|sanmenxia|smx", "山南|shannan|sn", "遂宁|suining|sn", "四平|siping|sp",
	          		"宿迁|suqian|sq", "商丘|shangqiu|sq", "上饶|shangrao|sr", "汕头|shantou|st",
	          		"汕尾|shanwei|sw", "绍兴|shaoxing|sx", "松原|songyuan|sy", "邵阳|shaoyang|sy",
	          		"十堰|shiyan|sy", "双鸭山|shuangyashan|sys", "朔州|shuozhou|sz",
	          		"随州|suizhou|sz", "宿州|suzhou|sz", "石嘴山|shizuishan|szs", "泰安|taian|ta",
	          		"铜川|tongchuan|tc", "塔城|tacheng|tc", "太仓|taicang|tc", "通化|tonghua|th",
	          		"铜陵|tongling|tl", "通辽|tongliao|tl", "铁岭|tieling|tl", "吐鲁番|tulufan|tlf",
	          		"铜仁|tongren|tr", "天水|tianshui|ts", "唐山|tangshan|ts", "太原|taiyuan|ty",
	          		"泰州|taizhou|tz", "台州|taizhou|tz", "文登|wendeng|wd", "潍坊|weifang|wf",
	          		"瓦房店|wafangdian|wfd", "武汉|wuhan|wh", "芜湖|wuhu|wh", "乌海|wuhai|wh",
	          		"威海|weihai|wh", "吴江|wujiang|wj", "乌兰|wulan|wl", "乌鲁木齐|wulumuqi|wlmq",
	          		"渭南|weinan|wn", "文山|wenshan|ws", "武威|wuwei|ww", "无锡|wuxi|wx",
	          		"吴忠|wuzhong|wz", "温州|wenzhou|wz", "梧州|wuzhou|wz", "兴安|xingan|xa",
	          		"宣城|xuancheng|xc", "许昌|xuchang|xc", "襄樊|xiangfan|xf", "孝感|xiaogan|xg",
	          		"香格里拉|xianggelila|xgll", "锡林浩特|xilinhaote|xlht", "西宁|xining|xn",
	          		"咸宁|xianning|xn", "湘潭|xiangtan|xt", "邢台|xingtai|xt", "新乡|xinxiang|xx",
	          		"咸阳|xianyang|xy", "信阳|xinyang|xy", "新余|xinyu|xy", "徐州|xuzhou|xz",
	          		"忻州|xinzhou|xz", "延安|yanan|ya", "雅安|yaan|ya", "延边|yanbian|yb",
	          		"宜宾|yibin|yb", "银川|yinchuan|yc", "盐城|yancheng|yc", "运城|yuncheng|yc",
	          		"宜春|yichun|yc", "宜昌|yichang|yc", "云浮|yunfu|yf", "阳江|yangjiang|yj",
	          		"营口|yingkou|yk", "榆林|yulin|yl", "伊宁|yining|yn", "阳泉|yangquan|yq",
	          		"玉树|yushu|ys", "鹰潭|yingtan|yt", "烟台|yantai|yt", "义乌|yiwu|yw",
	          		"宜兴|yixing|yx", "玉溪|yuxi|yx", "益阳|yiyang|yy", "岳阳|yueyang|yy",
	          		"永州|yongzhou|yz", "扬州|yangzhou|yz", "淄博|zibo|zb", "自贡|zigong|zg",
	          		"珠海|zhuhai|zh", "诸暨|zhuji|zj", "镇江|zhenjiang|zj", "湛江|zhanjiang|zj",
	          		"张家港|zhangjiagang|zjg", "张家界|zhangjiajie|zjj", "张家口|zhangjiakou|zjk",
	          		"周口|zhoukou|zk", "驻马店|zhumadian|zmd", "肇庆|zhaoqing|zq",
	          		"章丘|zhangqiu|zq", "舟山|zhoushan|zs", "中山|zhongshan|zs",
	          		"昭通|zhaotong|zt", "中卫|zhongwei|zw", "资阳|ziyang|zy", "张掖|zhangye|zy",
	          		"招远|zhaoyuan|zy", "遵义|zunyi|zy", "株洲|zhuzhou|zz", "漳州|zhangzhou|zz",
	          		"枣庄|zaozhuang|zz" ];;
	
Vcity.regEx = /^([\u4E00-\u9FA5\uf900-\ufa2d]+)\|(\w+)\|(\w)\w*$/i;
Vcity.regExChiese = /([\u4E00-\u9FA5\uf900-\ufa2d]+)/;
(function() {
	var citys = Vcity.allCity, match, letter, regEx = Vcity.regEx, reg2 = /^[a-f]$/i, reg3 = /^[g-k]$/i, reg4 = /^[l-p]$/i, reg5 = /^[q-u]$/i, reg6 = /^[v-z]$/i;
	if (!Vcity.oCity) {
		Vcity.oCity = {
			hot : {},
			ABCDEF : {},
			GHIJK : {},
			LMNOP : {},
			QRSTU : {},
			VWXYZ : {}
		};
		for (var i = 0, n = citys.length; i < n; i++) {
			match = regEx.exec(citys[i]);
			letter = match[3].toUpperCase();
			if (reg2.test(letter)) {
				if (!Vcity.oCity.ABCDEF[letter]) {
					Vcity.oCity.ABCDEF[letter] = []
				}
				Vcity.oCity.ABCDEF[letter].push(match[1])
			} else {
				if (reg3.test(letter)) {
					if (!Vcity.oCity.GHIJK[letter]) {
						Vcity.oCity.GHIJK[letter] = []
					}
					Vcity.oCity.GHIJK[letter].push(match[1])
				} else {
					if (reg4.test(letter)) {
						if (!Vcity.oCity.LMNOP[letter]) {
							Vcity.oCity.LMNOP[letter] = []
						}
						Vcity.oCity.LMNOP[letter].push(match[1])
					} else {
						if (reg5.test(letter)) {
							if (!Vcity.oCity.QRSTU[letter]) {
								Vcity.oCity.QRSTU[letter] = []
							}
							Vcity.oCity.QRSTU[letter].push(match[1])
						} else {
							if (reg6.test(letter)) {
								if (!Vcity.oCity.VWXYZ[letter]) {
									Vcity.oCity.VWXYZ[letter] = []
								}
								Vcity.oCity.VWXYZ[letter].push(match[1])
							}
						}
					}
				}
			}
			if (i < 25) {
				if (!Vcity.oCity.hot["hot"]) {
					Vcity.oCity.hot["hot"] = []
				}
				Vcity.oCity.hot["hot"].push(match[1])
			}
		}
	}
})();
Vcity._template = [ '<p class="tip">拼音支持首字母输入</p>', "<ul>","<div style='height:8px;'></div>",
		'<li class="on">热门城市</li>', "<li>ABCDEF</li>", "<li>GHIJK</li>",
		"<li>LMNOP</li>", "<li>QRSTU</li>", "<li>VWXYZ</li>", "</ul>" ];
Vcity.CitySelector = function() {
	this.initialize.apply(this, arguments)
};
Vcity.CitySelector.prototype = {
	constructor : Vcity.CitySelector,
	initialize : function(options) {
		var input = options.input;
		this.input = Vcity._m.$("#" + input);
		this.inputEvent()
	},
	createWarp : function() {
		var inputPos = Vcity._m.getPos(this.input);
		var div = this.rootDiv = document.createElement("div");
		var that = this;
		Vcity._m.on(this.rootDiv, "click", function(event) {
			Vcity._m.stopPropagation(event)
		});
		Vcity._m.on(document, "click", function(event) {
			event = Vcity._m.getEvent(event);
			var target = Vcity._m.getTarget(event);
			if (target == that.input) {
				return false
			}
			if (that.cityBox) {
				Vcity._m.addClass("hide", that.cityBox)
			}
			if (that.ul) {
				Vcity._m.addClass("hide", that.ul)
			}
			if (that.myIframe) {
				Vcity._m.addClass("hide", that.myIframe)
			}
		});
		div.className = "citySelector";
		div.style.position = "absolute";
		div.style.left = inputPos.left + "px";
		div.style.top = inputPos.bottom + "px";
		div.style.zIndex = 999999;
		var isIe = (document.all) ? true : false;
		var isIE6 = this.isIE6 = isIe && !window.XMLHttpRequest;
		if (isIE6) {
			var myIframe = this.myIframe = document.createElement("iframe");
			myIframe.frameborder = "0";
			myIframe.src = "about:blank";
			myIframe.style.position = "absolute";
			myIframe.style.zIndex = "-1";
			this.rootDiv.appendChild(this.myIframe)
		}
		var childdiv = this.cityBox = document.createElement("div");
		childdiv.className = "cityBox";
		childdiv.id = "cityBox";
		childdiv.innerHTML = Vcity._template.join("");
		var hotCity = this.hotCity = document.createElement("div");
		hotCity.className = "hotCity";
		childdiv.appendChild(hotCity);
		div.appendChild(childdiv);
		this.createHotCity()
	},
	createHotCity : function() {
		var odiv, odl, odt, odd, odda = [], str, key, ckey, sortKey, regEx = Vcity.regEx, oCity = Vcity.oCity;
		for (key in oCity) {
			odiv = this[key] = document.createElement("div");
			odiv.className = key + " " + "cityTab hide";
			sortKey = [];
			for (ckey in oCity[key]) {
				sortKey.push(ckey);
				sortKey.sort()
			}
			for (var j = 0, k = sortKey.length; j < k; j++) {
				odl = document.createElement("dl");
				odt = document.createElement("dt");
				odd = document.createElement("dd");
				odt.innerHTML = sortKey[j] == "hot" ? "&nbsp;" : sortKey[j];
				odda = [];
				for (var i = 0, n = oCity[key][sortKey[j]].length; i < n; i++) {
					str = '<a href="javascript:">' + oCity[key][sortKey[j]][i]
							+ "</a>";
					odda.push(str)
				}
				odd.innerHTML = odda.join("");
				odl.appendChild(odt);
				odl.appendChild(odd);
				odiv.appendChild(odl)
			}
			Vcity._m.removeClass("hide", this.hot);
			this.hotCity.appendChild(odiv)
		}
		document.body.appendChild(this.rootDiv);
		this.changeIframe();
		this.tabChange();
		this.linkEvent()
	},
	tabChange : function() {
		var lis = Vcity._m.$("li", this.cityBox);
		var divs = Vcity._m.$("div", this.hotCity);
		var that = this;
		for (var i = 0, n = lis.length; i < n; i++) {
			lis[i].index = i;
			//鼠标点击的时候切换城市列表
/*			lis[i].onclick = function() {
				for (var j = 0; j < n; j++) {
					Vcity._m.removeClass("on", lis[j]);
					Vcity._m.addClass("hide", divs[j])
				}
				Vcity._m.addClass("on", this);
				Vcity._m.removeClass("hide", divs[this.index]);
				that.changeIframe()
			}*/
			//鼠标悬浮的时候切换城市列表
			lis[i].onmouseover = function() {
				for (var j = 0; j < n; j++) {
					Vcity._m.removeClass("on", lis[j]);
					Vcity._m.addClass("hide", divs[j])
				}
				Vcity._m.addClass("on", this);
				Vcity._m.removeClass("hide", divs[this.index]);
				that.changeIframe()
			}
		}
	},
	linkEvent : function() {
		var links = Vcity._m.$("a", this.hotCity);
		var that = this;
		for (var i = 0, n = links.length; i < n; i++) {
			links[i].onclick = function() {
				that.input.value = this.innerHTML;
				Vcity._m.addClass("hide", that.cityBox);
				Vcity._m.addClass("hide", that.myIframe);
//				getData()
			}
		}
	},
	inputEvent : function() {
		var that = this;
		Vcity._m.on(this.input, "click",
				function(event) {
					event = event || window.event;
					if (!that.cityBox) {
						that.createWarp()
					} else {
						if (!!that.cityBox
								&& Vcity._m.hasClass("hide", that.cityBox)) {
							if (!that.ul
									|| (that.ul && Vcity._m.hasClass("hide",
											that.ul))) {
								Vcity._m.removeClass("hide", that.cityBox);
								Vcity._m.removeClass("hide", that.myIframe);
								that.changeIframe()
							}
						}
					}
				});
		Vcity._m.on(this.input, "focus", function() {
			that.input.select();
			if (that.input.value == "城市名") {
				that.input.value = ""
			}
		});
		Vcity._m.on(this.input, "blur", function() {
			if (that.input.value == "") {
				that.input.value = "城市名"
			}
		});
		Vcity._m.on(this.input, "keyup",
				function(event) {
					event = event || window.event;
					var keycode = event.keyCode;
					Vcity._m.addClass("hide", that.cityBox);
					that.createUl();
					Vcity._m.removeClass("hide", that.myIframe);
					if (that.ul && !Vcity._m.hasClass("hide", that.ul)
							&& !that.isEmpty) {
						that.KeyboardEvent(event, keycode)
					}
				})
	},
	createUl : function() {
		var str;
		var value = Vcity._m.trim(this.input.value);
		if (value !== "") {
			var reg = new RegExp("^" + value + "|\\|" + value, "gi");
			var searchResult = [];
			for (var i = 0, n = Vcity.allCity.length; i < n; i++) {
				if (reg.test(Vcity.allCity[i])) {
					var match = Vcity.regEx.exec(Vcity.allCity[i]);
					if (searchResult.length !== 0) {
						str = '<li><b class="cityname">' + match[1]
								+ '</b><b class="cityspell">' + match[2]
								+ "</b></li>"
					} else {
						str = '<li class="on"><b class="cityname">' + match[1]
								+ '</b><b class="cityspell">' + match[2]
								+ "</b></li>"
					}
					searchResult.push(str)
				}
			}
			this.isEmpty = false;
			if (searchResult.length == 0) {
				this.isEmpty = true;
				str = '<li class="empty">对不起，没有找到数据 "<em>' + value
						+ '</em>"</li>';
				searchResult.push(str)
			}
			if (!this.ul) {
				var ul = this.ul = document.createElement("ul");
				ul.className = "cityslide";
				this.rootDiv && this.rootDiv.appendChild(ul);
				this.count = 0
			} else {
				if (this.ul && Vcity._m.hasClass("hide", this.ul)) {
					this.count = 0;
					Vcity._m.removeClass("hide", this.ul)
				}
			}
			this.ul.innerHTML = searchResult.join("");
			this.changeIframe();
			this.liEvent()
		} else {
			Vcity._m.addClass("hide", this.ul);
			Vcity._m.removeClass("hide", this.cityBox);
			Vcity._m.removeClass("hide", this.myIframe);
			this.changeIframe()
		}
	},
	changeIframe : function() {
		if (!this.isIE6) {
			return
		}
		this.myIframe.style.width = this.rootDiv.offsetWidth + "px";
		this.myIframe.style.height = this.rootDiv.offsetHeight + "px"
	},
	KeyboardEvent : function(event, keycode) {
		var lis = Vcity._m.$("li", this.ul);
		var len = lis.length;
		switch (keycode) {
		case 40:
			this.count++;
			if (this.count > len - 1) {
				this.count = 0
			}
			for (var i = 0; i < len; i++) {
				Vcity._m.removeClass("on", lis[i])
			}
			Vcity._m.addClass("on", lis[this.count]);
			break;
		case 38:
			this.count--;
			if (this.count < 0) {
				this.count = len - 1
			}
			for (i = 0; i < len; i++) {
				Vcity._m.removeClass("on", lis[i])
			}
			Vcity._m.addClass("on", lis[this.count]);
			break;
		case 13:
			this.input.value = Vcity.regExChiese
					.exec(lis[this.count].innerHTML)[0];
			Vcity._m.addClass("hide", this.ul);
			Vcity._m.addClass("hide", this.ul);
			Vcity._m.addClass("hide", this.myIframe);
//			getData();
			break;
		default:
			break
		}
	},
	liEvent : function() {
		var that = this;
		var lis = Vcity._m.$("li", this.ul);
		for (var i = 0, n = lis.length; i < n; i++) {
			Vcity._m.on(lis[i], "click", function(event) {
				event = Vcity._m.getEvent(event);
				var target = Vcity._m.getTarget(event);
				that.input.value = Vcity.regExChiese.exec(target.innerHTML)[0];
				Vcity._m.addClass("hide", that.ul);
				Vcity._m.addClass("hide", that.myIframe)
			});
			Vcity._m.on(lis[i], "mouseover", function(event) {
				event = Vcity._m.getEvent(event);
				var target = Vcity._m.getTarget(event);
				Vcity._m.addClass("on", target)
			});
			Vcity._m.on(lis[i], "mouseout", function(event) {
				event = Vcity._m.getEvent(event);
				var target = Vcity._m.getTarget(event);
				Vcity._m.removeClass("on", target)
			})
		}
	}
};