<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>查看纠错</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
<style>
	.content{ width: 100%; background-color: white; overflow: hidden;}
	.content li{ width: 100%; height: 50px; line-height: 50px; border-bottom: 1px solid #dedede;}
	.content .errorbox{ width: 90%; margin: 0 auto; overflow: hidden;}
	.content .reason{ float: left; font-size: 1.6rem; color: #322c2c;}
	.content .number{ float: right; font-size: 1.6rem;}
	.content .number em{ padding-right: 5px; color: #ffb402;}
</style>
</head>

<body>
		<div class="head">
            <a href="javascript:history.back(-1)" class="head_back">
            	<img src="<%=basePath %>resources/images/back.png" alt="返回" />
            </a>
            <p>查看纠错</p>
        </div>
        <ul class="content">
	    	<li><div class="errorbox"><p class="reason">电话无人接听</p><p class="number"><em>${phoneCount}</em>人纠错</p></div></li>
	        <li><div class="errorbox"><p class="reason">电话号码错误</p><p class="number"><em>${phoneError}</em>人纠错</p></div></li>
	        <li><div class="errorbox"><p class="reason">商家信息错误</p><p class="number"><em>${shopCount}</em>人纠错</p></div></li>
	    </ul>
</body>
<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>

