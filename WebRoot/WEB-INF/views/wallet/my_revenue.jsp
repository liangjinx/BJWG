<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>我的收益</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<meta name="keywords" content="八戒王国online">
<meta name="description" content="八戒王国online">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/enter.css"/>
<style>
	.z_no_revenue { width: 100%; height: 45px; line-height: 45px; font-size: 16px; color: #615868; text-align: center}
</style>
</head>
<body>
<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
<div class="bodyheight earning_bg"><!--bodyheight -->	
    <div class="revenue_box">
    	<p class="p_top">&nbsp;</p>
        <p class="revenue_box_tit mt15"><span>9.6%</span></p>
        <p class="revenue_box_tit p_14">往期平均年化收益</p>
        <div class="clear"></div>
    </div>
    <div class="center80">
    	<c:choose>
    		<c:when test="${list != null }">
    			<ul class="revenue_ul">
    				<c:forEach items="${list }" var="l">
			    		<li>
			            	<div class="revenue_p_box">
			                	<span class="f_lt">${l.paincbuyProjectName }</span><span class="f_rt"><span class="percent">${l.rate }</span>%</span>
			                    <div class="clear"></div>
			                </div>
			                <div class="pmgress_bar"></div>
			            </li>
    				</c:forEach>
		        </ul>
    		</c:when>
    		<c:otherwise>
    			<div class="z_no_revenue">您暂时还没有历史收益记录</div>
    		</c:otherwise>
    	</c:choose>
        <div class="clear"></div>
    </div>
	<div class="clear"></div>
</div><!--bodyheight -->
</body>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
<script>

$(function(){
	var per;//百分比
	 $(".revenue_ul li").each(function(){ 
	 	per = $(this).find('.percent').text();
	 	$(this).find('.pmgress_bar').animate({width: (per+'%')}, "slow");
	  });
	})

</script>
</html>



<%--

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
		</c:choose>	
	</div>
</body>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
</html>
--%>