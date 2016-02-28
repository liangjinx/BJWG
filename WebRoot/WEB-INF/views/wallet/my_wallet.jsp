<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html>
<html>
<head>
<title>我的钱包</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<meta name="keywords" content="八戒王国online">
<meta name="description" content="八戒王国online">
<meta http-equiv="Pragma" content="no-cache" />

<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/enter.css"/>
</head>
<body>
	<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
	<form action="<%=basePath %>wpv/wlbankCardList?s_type=2" id="allProjectForm" name="allProjectForm" method="post" onsubmit="return takeCash();">
		<p class="p_top">&nbsp;</p>
		<div class="wallet_box"><!--wallet_box -->
			<div class="center80"><p class="p_16_tit">总金额（元）</p><div class="clear"></div></div>
		    <div class="center80 amount_box">
		    	<span class="amount_p">${wallet.money == null ? 0 : wallet.money}</span>
		        <a href="<%=basePath %>wpv/wlwalletChange"><img src="<%=basePath %>resources/images/amount_but.png" alt="" class="amount_but"/></a>
		        <div class="clear"></div>
		    </div>
		</div><!--wallet_box -->
		
		<a href="<%=basePath %>wpv/wlbankCardList?s_type=1">
			<div class="wallet_box bank_card">
				<div class="center80">
			    	<p class="p_16_tit">银行卡</p>
			        <span class="p_16_tit count_card">${bankNumber == null ? 0 : bankNumber}张</span>
			        <div class="clear"></div>
			    </div>
			</div>
		</a>
		
		<div class="center80 register_but_box">
		 	<button>提 现</button>
		</div>
		<div class="center80 wallet_p">
			<a href="<%=basePath %>wpv/wlpayPasswordManage">钱包管理</a>
		</div>
	</form>
</body>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
<jsp:include page="../back.jsp">
	<jsp:param value="wpv/urstoreMe" name="backUrl"/>
</jsp:include>
</html>
<script type="text/javascript">
<!--
	function takeCash(){
		if(${wallet.money == null || wallet.money <= 0}){
			alert("您的余额不足，无法提现");
			return false;
		}
		
		return true;
	}
//-->
</script>

