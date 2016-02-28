<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta name="keywords" content="八戒王国online">
	<meta name="description" content="八戒王国online">
	<meta http-equiv="Pragma" content="no-cache" />
	<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
	<link rel="stylesheet" href="<%=basePath %>resources/css/mybankcard.css"/>
	<title> 我的银行卡-钱包明细 </title>
	<style>
		.nothing_detail { width: 100%; height: 55px; line-height: 55px; font-size: 18px; color: #615868; text-align: center; background-color: #fff;}
	</style>
</head>
<body class="bg-gray">
	<div class="myBankCard">
		<c:choose>
			<c:when test="${fn:length(list) > 0}">
				<c:forEach items="${list }" var="l" varStatus="status">
					<ul class="profit-detail">
						<li>
							<p class="inline-blk">
								<span class="time"><fmt:formatDate value="${l.changeTime}" pattern="yyyy-MM-dd HH:mm"/></span>
								<c:choose>
									<c:when test="${l.changeType == 2 || l.changeType == 4 || l.changeType == 5}">
										<span class="handle-type">收入</span>
									</c:when>
									<c:otherwise>
										<span class="handle-type">支出</span>
									</c:otherwise>
								</c:choose>
							</p>
							<p class="inline-blk mt15">
								<c:choose>
									<c:when test="${l.changeType == 2 || l.changeType == 4 || l.changeType == 5}">
										<span class="profit profit-down">+${l.changeMoney }</span>
									</c:when>
									<c:otherwise>
										<span class="profit profit-up">-${l.changeMoney }</span>
									</c:otherwise>
								</c:choose>
								<span class="c-gray">余额：${l.afterMoney }</span>
							</p>
						</li>
					</ul>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="z_no_wallet_change">还没有消费记录哦.</div>
			</c:otherwise>
		</c:choose>	
	</div>
</body>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
<jsp:include page="../back.jsp">
	<jsp:param value="wpv/wlmyWallet" name="backUrl"/>
</jsp:include>
</html>
