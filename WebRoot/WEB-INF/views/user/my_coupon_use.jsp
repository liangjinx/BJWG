<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        <title>我的猪肉券-消费记录</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<div class="my_expense_calendar mb20">
		<c:choose>
			<c:when test="${fn:length(list) > 0}">
				<c:forEach items="${list}" var="rd">
					<div class="expense_calendar_box">
						<div class="expense_calendar_top">
							<p class="expense_calendar_monry f_l">
								消费金额：<span>￥${rd.useMoney}</span>
							</p>
							<p class="expense_calendar_address f_r">${rd.useAddress}</p>
						</div>
						<div class="expense_calendar_time">使用时间：<fmt:formatDate value='${rd.useTime}' pattern='yyyy-MM-dd HH:mm:ss' /></div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="z_no_coupon_use">还没有使用猪肉券的记录哦.</div>
			</c:otherwise>
		</c:choose>
		</div>
		<jsp:include page="../back.jsp">
			<jsp:param value="wpv/urmyCouponDetail?queryCouponId=${queryCouponId }" name="backUrl"/>
		</jsp:include>
	</body>
</html>

