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
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta name="keywords" content="八戒王国online">
	<meta name="description" content="八戒王国online">
	<meta http-equiv="Pragma" content="no-cache" />
	<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
	<link rel="stylesheet" href="<%=basePath %>resources/css/mybankcard.css"/>
	<title> 我的银行卡-提现成功 </title>
</head>
<body class="bg-gray">
	<div class="myBankCard">
		<ul class="list-panel user-bank-card-info">
			<li class="info-area tc">
				<p class="with-draw-success tc">提现记录已提交，24小时内到账</p>
			</li>
			<li>
				<div class="block-panel">
					<span class="fr">${walletAndBankCard.bank }&nbsp;&nbsp;尾号${fn:substring(walletAndBankCard.cardNo,fn:length(walletAndBankCard.cardNo)-4,fn:length(walletAndBankCard.cardNo))}</span>
					<span>银行卡</span>
				</div>
				<div class="block-panel">
					<span class="fr">&yen;${money }</span>
					<span>提现金额</span>
				</div>
			</li>
		</ul>

		<div class="btn-container mt25">
			<a href="<%=basePath %>wpv/wlmyWallet" class="btn full-btn btn-default">完成</a>
		</div>
	</div>
</body>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
</html>

