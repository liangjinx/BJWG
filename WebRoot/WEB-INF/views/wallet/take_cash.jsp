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
	<style type="text/css">
		/*限额说明*/
		.quota_information { position: absolute; top: 50%; left: 50%; display: none; width: 94%; height: 130px; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; background-color: #fff; transform: translate(-50%,-50%); -webkit-transform: translate(-50%,-50%); -moz-transform: translate(-50%,-50%); -ms-transform: translate(-50%,-50%); z-index: 100;}
		.quota_tips { position: relative; width: 100%; height: 40px; line-height: 40px; border-bottom: 1px solid #dedede; background-color: white;}
		.quota_tips em { position: absolute; top: 0; left: 15px; font-size: 1.6rem;}
		.closes { position: absolute; top: 14px; right: 15px; width: 12px;}
		.quota_information p { width: 92%; margin: 20px auto 0; font-size: 1.5rem; color: #615868; text-align: left;}
		
		.mark { position: absolute; left: 0; right: 0; top: 0; bottom: 0; display: none; width: 100%; height: 100%; background: rgba(0,0,0,.1); z-index: 99;}
		.f_r { float: right;}
	</style>
	<title> 我的银行卡-提现 </title>
</head>
<body class="bg-gray">
	<form method="post" action="<%=basePath %>wpv/wltakeCashSave" id="allProjectForm" name="allProjectForm">
		<input type="hidden" name="cardId" id="cardId" value="${bankCard.cardId}">
		<div class="myBankCard">
			<ul class="list-panel user-bank-card-info">
				<li class="info-area tc">
					<div class="bank-card-info">
						<h2 class="user-name">${bankCard.accountName }</h2>
						<p class="card-num">${fn:substring(bankCard.cardNo,0,4)}********${fn:substring(bankCard.cardNo,fn:length(bankCard.cardNo)-4,fn:length(bankCard.cardNo))}</p>
						<p class="bank-info"><img width="28" height="28" src="<%=basePath %>resources/images/bank-${bankCard.bankCode }.png" alt="" />${bankCard.bank }</p>
					</div>
				</li>
				<li>
					<div class="card-money block-panel">
						<label for="">金额</label>
						<input class="inp-money" type="text" name="money" id="money" maxlength="9" maxMoney="${wallet.money }" placeholder="请输入提现金额">
					</div>
				</li>
			</ul>
			<p class="bank-info-tips">
				<a href="javascript:void(0);" class="limit-explain c-highlight z_limit_description">限额说明</a>
				<span class="c-gray">您的钱包本次可提现<ins>${wallet.money }</ins>元</span>
			</p>
			<div class="btn-container mt25">
				<a href="javascript:showPayPwd()" class="btn full-btn btn-default">提现</a>
			</div>
		</div>
		
		<!-- 限额说明 -->
		<div class="quota_information">
			<div class="quota_tips">
				<em>限额说明</em>
				<img class="closes" src="<%=basePath %>resources/images/layer-close.png" alt="关闭" />
			</div>
			<p>为保证账户资金安全，本次提取上限为${wallet.money }元。</p>
		</div>
		
		<jsp:include page="../wallet/input_pay_password.jsp">
			<jsp:param value="save" name="confirmFunc"/>
		</jsp:include>
	</form>
</body>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
<jsp:include page="../back.jsp">
	<jsp:param value="wpv/wlbankCardList?s_type=2" name="backUrl"/>
</jsp:include>
</html>
<script type="text/javascript">
<!--
function save(){
	var money = $("#money").val();
	var maxMoney = parseFloat($("#money").attr("maxMoney"));
	var payPassword = $("#password").val();
	if(money == '' || isNaN(money)){
		alert("请输入有效的提现金额");
		return ;
	}
	if(parseFloat(money) > maxMoney){
		alert("您最多只能提现"+maxMoney+"元");
		return ;
	}
	if(payPassword == '' || payPassword.length<6){
		alert("请输入6位密码");
		return ;
	}
	$("#allProjectForm").submit();
}
$(function(){
	//限额说明
	$(".z_limit_description").on("click",function(){
		$(".quota_information, .mark").show();
	});
	$(".mark, .closes").on("click",function(){
		$(".quota_information, .mark").hide();
	});
});
//-->
</script>

