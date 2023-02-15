<%@ page language="java" pageEncoding="utf-8"%>
<html>
<body>
	<script type="text/javascript">
		function formSubmit( url ){
			document.forms[0].action = url;
			document.forms[0].submit();
		}
	</script>

<form method="post">

    This is my JSP page. <br>
<table>
<tr>
	<td>名称：</td>
	<td><input type="text" name="name" value="struts2"/></td>
</tr>
<tr>
	<td>创建时间：</td>
	<td><input type="text" name="createTime" value="2013-05-01"/></td>
</tr>
<tr>
	<td>备注：</td>
	<td><input type="text" name="remark" value="struts2备注"/></td>
</tr>
<tr>
	<td><input type="button" name="ok" value="保存" onclick="formSubmit('/test/testTableAction_create');"/></td>
</tr>
</table>

</form>
</body>
</html>
