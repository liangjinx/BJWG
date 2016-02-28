<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 

	String ua = request.getHeader("user-agent").toLowerCase();
	System.out.println(ua);
	// 是微信浏览器
	if(ua.indexOf("micromessenger") > 0) {
		request.setAttribute("isWeixin" , "yes");
	}
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>确认订单</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<meta name="keywords" content="八戒王国online">
<meta name="description" content="八戒王国online">
<meta http-equiv="Pragma" content="no-cache" />

<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/enter.css"/>
<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
</head>
<body>
	<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
	<form action="<%=basePath %>wpv/orwxPay" name="allProjectForm" id="allProjectForm" method="post" onsubmit="">
		<input type="hidden" name="orderId" id="orderId" value="${order.orderId }">
		<div class="bodyheight"><!--bodyheight -->
			<p class="p_top">&nbsp;</p>
			<div class="order_main_box order_cf_box"><!--order_box -->
				<div class="center80">
			    	<p>订单编号：${order.orderCode }</p>
			        <div class="b_bottom"></div>
			        <p>订单时间：<fmt:formatDate value="${order.ctime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
			    </div>
			</div><!--order_box -->
			
			<div class="order_main_box mt5"><!--order_box -->
				<div class="center80">
			    	<div class="sp_tit_box b_bottom">商品清单</div>
			        <div class="sp_order_box"><!--sp_order_box -->
			        	<div class="img_box"><img src="${order.productImg }" alt=""/></div>
			            <div class="order_p">${order.productName}</div>
			            <div class="order_p">单价：${order.price } &nbsp;X${order.num }</div>
			            <div class="clear"></div>
			        </div><!--sp_order_box -->
			         <div class="clear"></div>
			    </div>        
			</div><!--order_box -->
			
			<div class="center80">
				<p class="order_sum">应付总额：<span>￥${order.totalMoney }</span></p>    
			</div>
			 
			<div class="center80 cf_but_box">
			<c:choose>
				<c:when test="${requestScope.isWeixin=='yes' }">
					<input type="button" class="but" id="btnWxpay"  value="微信支付">
				</c:when>
				<c:otherwise>
					<input type="button" class="but" id="btnAlipay" value="支付宝支付">
				</c:otherwise>
			</c:choose>
				<%--
				<a href="<%=basePath %>wpv/ortestPay?orderId=${order.orderId}">测试完成支付</a>
			--%></div>
		</div><!--bodyheight -->
	</form>
	<script>
		$(function(){
			$('#btnAlipay').click(function(){
				$('.but').attr('disabled','disabled');
				$('#allProjectForm').attr('action','<%=basePath %>wpv/oralipayPay').submit();
			})
			$('#btnWxpay').click(function(){
				$('.but').attr('disabled','disabled');
				$('#allProjectForm').attr('action','<%=basePath %>wpv/orwxPay').submit();
			})
		})
	</script>
</body>

<jsp:include page="../common/commonTip.jsp"></jsp:include>
<jsp:include page="../back.jsp">
	<jsp:param value="wpnv/ixPanicutBuyInit?queryProjectId=${order.relationId }" name="backUrl"/>
</jsp:include>
</html>
