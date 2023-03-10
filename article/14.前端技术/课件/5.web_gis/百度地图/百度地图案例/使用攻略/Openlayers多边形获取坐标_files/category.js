
$(function()
{
   
        var aCategory = $(".category_r label"),
            aClose = $(".category_r").find(".J_close");
        aCategory.click(function () {
            if ($(this).find(".subItem").is(":hidden")) {
                //close all
                var thisClickText = $(this).attr("onclick");

                $.each(aCategory, function (i) {
                    var thisCategory = $(aCategory[i]);
                    var thisCategoryText = thisCategory.attr("onclick");
                   
                    if (thisCategoryText != thisClickText)
                    {
                        if (!thisCategory.find(".subItem").is(":hidden")) {
                            thisCategory.find(".arrow-up").hide().end()
                                .find(".arrow-down").show();
                            thisCategory.find(".subItem").hide();
                        }
                    }
                });

                $(this).find(".arrow-up").show().end()
                        .find(".arrow-down").hide();
                $(this).find(".subItem").show();

                $("#body").css("overflow", "visible");
                $("#main").css("overflow", "visible");
            }
            else {
                $(this).find(".arrow-up").hide().end()
                       .find(".arrow-down").show();
                $(this).find(".subItem").hide();

                $("#body").css("overflow", "hidden");
                $("#main").css("overflow", "hidden");
            }
        });
        aClose.click(function () {
            $(this).parents(".subItem").hide()
                    .siblings(".arrow-up").hide()
                    .siblings(".arrow-down").show();
            return false;
        });

     $(".similar_c_t label span").click(function () {         
         $(".similar_cur").removeClass("similar_cur");
         $(this).parent().addClass("similar_cur");
     });
})

function GetCategoryArticles(id,username,type,aid)
{
	var url="/"+username+"/svc/GetCategoryArticleList?id="+id+"&r="+Math.random();
	//url="http://dev.blog.csdn.net:5391"+url;
	$.get(url, function (res) {
	    var topid = "top_" + id;	   

	    if (type == "top")
	    {
	        var objtop = $("#" + topid);
	        objtop.html("");	       
	        $(res).each(function (i) {
	            var obj = res[i];
	            if (aid != obj.articleid) {	             
	                var articleurl = "http://blog.csdn.net/" + username + "/article/details/" + obj.articleid;
	                var aritcleid = "top_aritcle_" + obj.articleid + Math.random().toString().replace("0.");
	                objtop.append("<li class=\"tracking-ad\" data-mod=\"popu_140\"><em>•</em><a href='" + articleurl + "'  id='" + aritcleid + "'></a></li> ");
	                $("#" + aritcleid).text(obj.title);
	                $("#" + aritcleid).attr("title",obj.title);
	            }
	        });

	    }
	    else if (type == "foot")
	    {	       	       
	        var objfootleft = $(".similar_list.fl");
	        var objfootright = $(".similar_list.fr");

	        objfootleft.html("");
	        objfootright.html("");

	        var j = 0;

	        $.each(res, function (i) {	            
	            var obj = res[i];
	            if (aid != obj.articleid) {
	                var articleurl = "http://blog.csdn.net/" + username + "/article/details/" + obj.articleid;
	                var aritcleid = "foot_aritcle_" + obj.articleid + Math.random().toString().replace("0.");

	                var html = "<li class=\"tracking-ad\" data-mod=\"popu_141\"><em>•</em><a href='" + articleurl + "'  id='" + aritcleid + "'></a></li> ";
	                if (j % 2 == 1) {
	                    objfootright.append(html);
	                }
	                else {
	                    objfootleft.append(html);
	                }
	                $("#" + aritcleid).text(obj.title);
	                $("#" + aritcleid).attr("title",obj.title);
	                j++;

	                $(".similar_article").show();
	            }
	        });	       
	    }
	});
}