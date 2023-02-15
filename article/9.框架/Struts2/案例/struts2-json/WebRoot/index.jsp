<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="js/jquery-1.9.1.min.js"></script>
	<script>
	    $(function(){
	    
	       $('#username').blur(function(){
	       
	           var username = $(this).val();  
	       
	           $.getJSON('UserAction!findUser',{"username":username},function(data){
	           
	               var objs = data.list;
	               
	               
	               var str = '';
	               for(var i=0;i<objs.length;i++){
	               
	                  str = str+"<tr><td>"+objs[i].id+"</td><td>"+objs[i].name+"</td><td>"+objs[i].age+"</td></tr>";
	               }
	              
	              
	                $('#result').html(str);
	           
	           });
	       
	       });
	    
	    });
	
	</script>
	
  </head>
  
  <body>
      <h1>根据用户名查用户：发异步请求，数据直接现在在当前页面上</h1>
  
      username:<input type="text" name="username" id="username" />
      
      <table width="500px">
         <thead>
            <tr>
               <td>ID</td>
               <td>NAME</td>
               <td>AGE</td>
            </tr>
         </thead>
         
         <tbody id="result">
         
         </tbody>
      </table>
  </body>
</html>
