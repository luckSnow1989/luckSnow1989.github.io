   
	//建立xmlHttp对象,先判断是什么浏览器;使其支持ie,等浏览器
	function createRequestObject() {
		var ro;
		var browser = navigator.appName;
		if(browser == "Microsoft Internet Explorer"){
			ro = new ActiveXObject("Microsoft.XMLHTTP");
		}else{
			ro = new XMLHttpRequest();
		}

		return ro;
	}

	var http = createRequestObject();

	/* 调用查询 action -start */
	function sndReqFind(cnname,curl) {
		//发送数据
		var paras;
//		paras  = "cnname=" + encodeURI(encodeURI(cnname));	//提交中文时转码 struts1
//		paras += "&curl=" + encodeURI(encodeURI(curl));
		paras  = "cnname=" + encodeURI(cnname);				//提交中文时转码 struts2
		paras += "&curl=" + curl;
//		alert(paras);
		http.open('post', '../common/fastMenuAction_save?'+paras);
		http.onreadystatechange = handleResponseFind;
		http.send(null);
	}

	function handleResponseFind() {
		if(http.readyState == 4){
			var response = http.responseText;
			//document.getElementById("div_ErrorInfo").innerHTML = response;
		}
	}
	/* 调用查询 action -end */

	/* 提交action，获取fastMenu html片段 */
	function getFastMenu(){
		http.open('post', '/common/fastMenuAction_show');
		http.onreadystatechange = htmlFastMenu;
		http.send(null);
	}

	/* 显示html片段 */
	function htmlFastMenu() {
		if(http.readyState == 4){
			var response = http.responseText;
			document.getElementById("fastMenu").innerHTML = response;
		}
	}

	