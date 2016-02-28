<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>


<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>忘记支付密码</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
	</head>
	<body>
		<p class="z_h20">&nbsp;</p>
		<div class="z_lost_info">
        	<p class="mb5">温馨提示</p>
        	<p>忘记支付密码请联系客服，进行密码找回!</p>
        </div>
        <a href="tel:${phone }">
	        <div class="z_contanc_phone">
	        	<span class="z_contact_number">客服热线：${phone }</span>
	        	<img class="z_phone_icon" src="<%=basePath %>resources/images/lost-pay-img.png" alt="联系电话" />
	        </div>
	    </a>
	</body>
	<jsp:include page="../back.jsp">
		<jsp:param value="wpv/wlpayPasswordManage" name="backUrl"/>
	</jsp:include>
</html>



