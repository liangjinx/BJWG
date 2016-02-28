<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
<meta property="qc:admins" content="50247363534751016602463757" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=0.5,minimum-scale=0.5,maximum-scale=0.5, user-scalable=no">
<title>八戒王国online</title>

<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>

</head>
<%
	String url = request.getRequestURL().toString();
	String code = request.getParameter("code");
	String state = request.getParameter("state");
 %>
<body>

<%-- <form action="<%=basePath %>wpnv/ixindex" id="index_form" method="post"> 
	<input type="hidden" name="code" value="<%=code%>" >
</form> --%>

 <form action="<%=basePath %>pc" id="index_form" method="post"> 
	<input type="hidden" name="code" value="<%=code%>" >
</form>

<script type="text/javascript">

$(document).ready(function(){
//	alert("JQuery的第一个入门案例");//加载HTML，不需等待，立即加载
 	$('#index_form').submit();
});
</script>
</body>
</html>