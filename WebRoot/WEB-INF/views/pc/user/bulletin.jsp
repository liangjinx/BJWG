<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>猪场公告</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta name="keywords" content="keyword1,keyword2,keyword3">
	<meta name="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <h3>猪场公告</h3>
    <div>
    	<c:forEach items="${bulletinList}" var="bulletin">
    		<div>id: ${bulletin.bulletinId}</div>
    		<div>time: <fmt:formatDate value="${bulletin.ctime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
    		<div>status: ${bulletin.status }</div>
    		<div>status: ${bulletin.title }</div>
    		<div>content: ${bulletin.content}</div>
    		<hr>
    	</c:forEach>
    </div>
  </body>
</html>
