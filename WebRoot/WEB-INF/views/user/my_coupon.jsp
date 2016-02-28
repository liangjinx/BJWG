<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>我的猪肉券</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<div class="z_bg">
			<!--<p class="z_h20">&nbsp;</p>-->
			<p class="z_nearby_storefront">
				猪肉券仅限${limitCity }地区使用
				<a href="<%=basePath %>wpv/urnearShop">
					<span class="z_examine f_r">附近八戒王国</span>
				</a>
			</p>
			<div class="z_pig_ticket">
				<c:choose>
					<c:when test="${fn:length(list) > 0}">
						<c:forEach items="${list}" var="l">
							<a href="<%=basePath %>wpv/urmyCouponDetail?queryCouponId=${l.myCouponId}">
								<div class="pig_ticket mb20 position_r">
									<div class="pig_ticket_title">电子券号码：<span>${l.couponCode }</span></div>
									<div class="pig_ticket_middle">
										<span>￥</span>
										<span class="pig_ticket_num">${l.canUseMoney }</span>
									</div>
									<div class="pig_ticket_bottom">请截止至<fmt:formatDate value='${l.endTime}' pattern='yyyy-MM-dd' />前选择</div>
								</div>
							</a>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="z_no_coupon">还没有猪肉券哦.</div>
					</c:otherwise>		
				</c:choose>			
			</div>
		</div>
		<jsp:include page="../common/commonTip.jsp"></jsp:include>
		<jsp:include page="../back.jsp">
			<jsp:param value="wpv/urstoreMe" name="backUrl"/>
		</jsp:include>
	</body>
</html>





