<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>我的猪场</title>
    
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
  	<h3>我的猪场</h3>
    <a href="pv/user/personalSetting">基本设置</a>
    <div></div>
    <a href="pv/address/addressManage">地址管理</a>
    <div></div>
    <a href="pv/user/msg">站内信</a>
    <div></div>
    <a href="pv/user/ticket">猪肉券</a>
    <div></div>
    <a href="pv/user/friend">我的好友</a>
    <div></div>
    <a href="pv/order/list">我的订单</a>
    <div></div>
    <a href="pv/wallet/home">账户总览</a>
    <div></div>
    <a href="pv/user/farm">我的猪场</a>
  </body>
</html>
