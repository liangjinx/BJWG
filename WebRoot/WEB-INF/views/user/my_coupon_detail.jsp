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
        <title>我的猪肉券详情</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<div class="pic_ticket_detail">
			<div class="ticket_detail_top">
				<div class="ticket_remaining_sum f_l">余额：<span>${myCoupon.canUseMoney }</span>元</div>
				<a href="<%=basePath %>wpv/urmyCouponUse?queryCouponId=${myCoupon.myCouponId}">
					<div class="ticket_expense_calendar f_r">消费记录</div>
				</a>
			</div>
			<div class="ticket_detail_content">
				<div class="ticket_number">电子券号码：<span>${myCoupon.couponCode }</span></div>
				<div class="ticket_valid_time">使用有效期：<span><fmt:formatDate value="${myCoupon.beginTime}" pattern="yyyy-MM-dd"/></span>~<span><fmt:formatDate value="${myCoupon.endTime}" pattern="yyyy-MM-dd"/></span></div>
				<div class="ticket_erweima">
					<img src="${couponImg }" alt="" />
					<p>通过二维码支付</p>
				</div>
			</div>
			<a href="<%=basePath %>wpv/urmyFriends?operate=sendPigCoupon&pageSource=60001&queryCouponId=${myCoupon.myCouponId}&leftMoney=${myCoupon.canUseMoney}" class="ticket_detail_bottom">馈赠猪肉券</a>
		</div>
		<jsp:include page="../common/commonTip.jsp"></jsp:include>
		<jsp:include page="../back.jsp">
			<jsp:param value="wpv/urmyCoupon" name="backUrl"/>
		</jsp:include>
	</body>
</html>