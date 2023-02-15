// gis.js

var map = null;
/**
 * 初始化地图
 * @param id	展示地图所在元素的id
 * @param city	地图中心的国家、城市等的中文名称
 */
function initMap(id, city) {
	try {
		//初始化地图信息
		if (map == null) {
			map = new BMap.Map(id);
			map.addControl(new BMap.NavigationControl());
			map.addControl(new BMap.ScaleControl());
			map.addControl(new BMap.OverviewMapControl());
			map.enableScrollWheelZoom(true); // 启用地图滚轮放大缩小
			map.addControl(new BMap.MapTypeControl());
		}
		// 百度地图支持使用地名如北京，中国，时间等作为坐标的代替使用
		if (city == "世界") {
			var point = new BMap.Point(0, 30);
			map.centerAndZoom(point, 1);
			map.setMapType(BMAP_HYBRID_MAP);
			// map.setZoom(1);
		} else if (city == "中国") {
			map.centerAndZoom(city, 5);
		} else {
			map.centerAndZoom(city, 11);
		}
	} catch (e) {
		map = null;
	}

}
/**
 * 2. 清除所有覆盖物
 */
function clearMap() {
	if (map != null) 
		map.clearOverlays();
}

/**
 * 3. 绘制地图上的标注
 * @param name  信息框的标题
 * @param point	百度地图api的坐标对象
 * @param title	标题，html的属性
 * @param desp	信息框的内容
 * @param value	显示在标注上的文字
 * @param index	环境等级
 * @param labelFlag	
 * @param markerFlag 是否对信息框添加触发事件
 */
function addPointAuto(name, point, title, desp, value, index, labelFlag, markerFlag) {

	var maplevel = map.getZoom();
	if (maplevel < 8) {
		//这个是使用图片作为标注的覆盖物
		/*icon = getIconByIndex(index);//根据环境质量等级获得对应的图标所在路径
		var myIcon = new BMap.Icon(icon, new BMap.Size(12, 12));//创建图标
		var len = name.length;//获得显示名称标题的长度
		var offset = new BMap.Size(-4 * len, -20);// 指定定位位置
		var label = new BMap.Label(name);
		label.setOffset(offset);
		var marker = new BMap.Marker(point, {
			icon : myIcon
		});
		if (labelFlag)
			marker.setLabel(label);

		marker.setTitle(title);
		map.addOverlay(marker);

		if (markerFlag == true) {
			marker.addEventListener("mouseover", function() {
				var searchInfoWindow = new BMapLib.SearchInfoWindow(map, desp,
						{
							title : '<sapn style="font-size:14px">' + name + '</span>', // 标题
							width : 315, // 宽度
							height : 115, // 高度
							enableAutoPan : true, // 自动平移
							searchTypes : []
						});
				searchInfoWindow.open(point);
			});
		}*/
		//使用百度提供方法，绘制覆盖物
//		color = getColorByIndex(index);
		var opts = {
			position : point, // 指定文本标注所在的地理位置
			offset : new BMap.Size(0, 0)// 设置文本偏移量
		}
		var label = new BMap.Label("", opts); // 创建文本标注对象
		
		label.setStyle({
			color : "white",
			backgroundColor : getColorByIndex(index),
			border : '1',
			minWidth : "12px",
			textAlign : "center",
			height : "12px",
			lineHeight : "12px",
			borderRadius : "6px",
			cursor: "pointer"
		});
//		label.setTitle(title);//title就是和html中的那个普通的属性
		map.addOverlay(label);
		label.addEventListener("mouseover", function() {
			var searchInfoWindow = new BMapLib.SearchInfoWindow(map, desp,
				{
					title : '<sapn style="font-size:14px">' + name + '</span>', // 标题
					width : 260, // 宽度
					height : 115, // 高度
					enableAutoPan : true, // 自动平移
					searchTypes : []
				});
			searchInfoWindow.open(point);
		});
	} else {
//		color = getColorByIndex(index);
		var opts = {
			position : point, // 指定文本标注所在的地理位置
			offset : new BMap.Size(0, 0)// 设置文本偏移量
		}
		var label = new BMap.Label(value, opts); // 创建文本标注对象
		label.setStyle({
			color : "white",
			backgroundColor : getColorByIndex(index),
			fontSize : "13px",
			border : '',
			minWidth : "32px",
			textAlign : "center",
			height : "20px",
			lineHeight : "20px"
		});
//		label.setTitle(title);
		map.addOverlay(label);
		label.addEventListener("mouseover", function() {
			var searchInfoWindow = new BMapLib.SearchInfoWindow(map, desp,
				{
					title : '<sapn style="font-size:14px">' + name + '</span>', // 标题
					width : 260, // 宽度
					height : 115, // 高度
					enableAutoPan : true, // 自动平移
					searchTypes : []
				});
			searchInfoWindow.open(point);
		});
	}
}