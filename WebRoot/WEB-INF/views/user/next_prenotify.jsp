<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>成长状态</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<div class="z_next_issue_bg time_reduce"  data-countdown="${projectMap.leftTime == null ? 0 : projectMap.leftTime}">
			<h4 class="z_next_issue_title">成长状态</h4>
			<div class="z_next_issue_inset">
				<img src="<%=basePath %>resources/images/next-iussue-1.png" alt="下期预告" />
			</div>
			<c:choose>
				<c:when test="${projectMap.type eq 'next'}">
					<!-- 抢购时间未到提示语-->
					<p class="z_next_issue_time">每周一、三、五上午10:00准时开放</p>
					<p class="z_next_issue_wait">请耐心等待下期...</p>
					<a class="z_count_down d_count_down"></a>
				</c:when>
				<c:when test="${projectMap.type eq 'current'}">
					<!-- 抢购时间到的提示语-->
					<p class="z_next_issue_time">快来给你的猪场添加可爱的猪仔吧</p>
					<a href="<%=basePath %>wpnv/ixPanicutBuyInit?queryProjectId=${projectMap.project.paincbuyProjectId}" class="z_count_down">立即购买</a>
				</c:when>
			</c:choose>
			
		</div>
	</body>
	<jsp:include page="../common/commonTip.jsp"></jsp:include>
</html>
<script type="text/javascript" src="<%=basePath %>resources/js/time.js"></script>


<%--<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>猪仔总数</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
	</head>
	<body>
		<div class="z_next_issue_bg">
			<h4 class="z_next_issue_title">下期预告</h4>
			<div class="z_next_issue_inset">
				<img src="<%=basePath %>resources/images/next-iussue-1.png" alt="下期预告" />
			</div>
			<p class="z_next_issue_time">${projectMap.nextProjectDescription }</p>
			<p class="z_next_issue_wait">请耐心等待下期...</p>
			<c:choose>
				<c:when test="${projectMap.type eq 'next'}">
					倒计时:${projectMap.leftTime}
				</c:when>
				<c:when test="${projectMap.type eq 'current'}">
					<input type="button" value="立即购买" />
				</c:when>
			</c:choose>
		</div>
	</body>
</html>
--%>