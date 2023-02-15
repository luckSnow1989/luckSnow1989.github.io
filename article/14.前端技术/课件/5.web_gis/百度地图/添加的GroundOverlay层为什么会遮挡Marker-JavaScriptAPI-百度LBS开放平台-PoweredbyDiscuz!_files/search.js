function addSearch() {

	var Id = function(id) {
		return document.getElementById(id);
	}

	/*
	 * 搜索页面不展示当前模块 var searchArea = Id("searchArea");
	 * if(location.pathname.indexOf("index.php") == -1){
	 * searchArea.style.display = "none"; return }
	 */
	var searchType = Id("search_type");
	var searchSubmit = Id("searchBtn");
	var searchInput = Id("searchInput");
	var searchForm = Id("scbar_form")
	searchInput.value = "";

	/* auto focus */
	searchInput.focus();
	searchForm.onkeydown = function(e) {
		var e = e || window.event;
		if (e.keycode == 13) {
			return false;
		}

	}

	/* search Event */
	var submitInfo = function() {
		if (!searchInput.value) {
			return;
		}

		// 百度一下
		if (searchType.value == 2) {
			setTimeout(function() {
				window.open("http://www.baidu.com/s?wd=" + searchInput.value,
						"newwindow");
			}, 0)
		} else {
//alert("nihao");
            searchForm.submit();
		}

	}
	function stopBubble(e) {
		if (e && e.stopPropagation) {
			e.stopPropagation()
		} else {
			window.event.cancelBubble = true
		}
	}

	// add click event
	searchSubmit.onclick = function() {
		submitInfo();
	}

	searchSubmit.onmouseover = function() {
		searchSubmit.className = "btn_over";
	}
	searchSubmit.onmouseout = function() {
		searchSubmit.className = "btn_out";
	}
	// add enter event
	searchInput.onkeydown = function(event) {
		stopBubble(event);
		var e = event || window.event;
		var keyNum = e.keyCode || e.which;

		if (keyNum == 13) {
			submitInfo();
		}
	}
}
