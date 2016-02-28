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
<title>钱包管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<meta name="keywords" content="八戒王国online">
<meta name="description" content="八戒王国online">
<meta http-equiv="Pragma" content="no-cache" />

<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/enter.css"/>
<style>
	.manage_box .p_16_tit { width: 100%; margin: 0; margin-left: 0;  padding: 16px 0; padding-left: 10%;}
</style>
</head>
<body>
<p class="p_top">&nbsp;</p>
<div class="manage_box">
	<c:choose>
  		<c:when test="${isSetPw eq 'yes'}">
			<a href="<%=basePath %>wpv/wlpayPasswordModify1" class="p_16_tit">修改支付密码</a>
  		</c:when>
  		<c:otherwise>
			<a href="<%=basePath %>wpv/wlsetPayPasswordPage" class="p_16_tit">设置支付密码</a>
  		</c:otherwise>
  	</c:choose>
  	<div class="mannage_b"></div>
    <a href="<%=basePath %>wpv/wlpayPasswordForget" class="p_16_tit">忘记支付密码</a>
    <div class="clear"></div>
</div>
</body>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
<jsp:include page="../back.jsp">
	<jsp:param value="wpv/wlmyWallet" name="backUrl"/>
</jsp:include>
</html>

