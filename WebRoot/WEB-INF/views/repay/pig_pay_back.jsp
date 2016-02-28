<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>选择回报方式</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<div class="z_bg">
			<p class="z_h40">&nbsp;</p>
			<div class="z_pig_payback">
				<c:set var="type1" value="false"></c:set>
				<c:set var="type2" value="false"></c:set>
				<c:set var="type3" value="false"></c:set>
				<c:set var="type4" value="false"></c:set>
				<c:set var="couponMoney" value="0"></c:set>
				<c:forEach items="${configList }" var="l">
					<c:choose>
						<c:when test="${l.code eq 'SYS_CONFIG.PIG_COUPON_MONEY' }">
							<c:set var="couponMoney" value="${l.value }"></c:set>
						</c:when>
						<c:when test="${l.code eq 'SYS_CONFIG.PIG_COUPON_MONEY' }">
							<c:set var="couponMoney" value="${l.value }"></c:set>
						</c:when>
						<c:when test="${l.code eq 'PAY_CONFIG.REPAY_TYPE' }">
							<c:if test="${l.value.indexOf('1')> -1 }">
								<c:set var="type1" value="true"></c:set>
								<c:set var="total" value="${total+1 }"></c:set>
							</c:if>
							<c:if test="${l.value.indexOf('2')> -1 }">
								<c:set var="type2" value="true"></c:set>
							</c:if>
							<c:if test="${l.value.indexOf('3')> -1 }">
								<c:set var="type3" value="true"></c:set>
							</c:if>
							<c:if test="${l.value.indexOf('4')> -1 }">
								<c:set var="type4" value="true"></c:set>
							</c:if>
						</c:when>
					</c:choose>
				</c:forEach>
				
				<c:set var="count" value="0"></c:set>
				<c:if test="${type1 }">
					<a href="<%=basePath %>wpv/orchooseRepayType?repayTypeId=1&queryProjectId=${queryProjectId}&endModifyTime=${ endModifyTime}">
						<c:set var="count" value="${count+1 }"></c:set>
						<div class="pig_payback mb20 position_r">
							<div class="payback_title">选择回报方式</div>
							<div class="payback_middle">
								<div class="z_way">
									<span>方式</span>
									<em>${count }</em>
								</div>
								<div class="z_way_detail">[委托深圳润民销售，获得利益]</div>
							</div>
							<div class="payback_bottom">请截止至${endModifyTime }前选择</div>
							<!-- star 已选的红色圆圈 -->
							<div class="z_check">已选</div>
							<!--end 已选的红色圆圈 -->
						</div>
					</a>
				</c:if>
				<c:if test="${type2 }">
					<c:set var="count" value="${count+1 }"></c:set>
					<a href="<%=basePath %>wpv/orchooseRepayType?repayTypeId=2&queryProjectId=${queryProjectId}&endModifyTime=${ endModifyTime}">
						<div class="pig_payback mb20 position_r">
							<div class="payback_title">选择回报方式</div>
							<div class="payback_middle">
								<div class="z_way">
									<span>方式</span>
									<em>${count }</em>
								</div>
								<div class="z_way_detail">[委托深圳润民进行屠宰配送]</div>
							</div>
							<div class="payback_bottom">请截止至${endModifyTime }前选择</div>
							<!-- star 已选的红色圆圈 -->
							<div class="z_check">已选</div>
							<!--end 已选的红色圆圈 -->
						</div>
					</a>
				</c:if>
				<c:if test="${type3 }">
					<c:set var="count" value="${count+1 }"></c:set>
					<a href="<%=basePath %>wpv/orchooseRepayType?repayTypeId=3&queryProjectId=${queryProjectId}&endModifyTime=${ endModifyTime}">
						<div class="pig_payback mb20 position_r">
							<div class="payback_title">选择回报方式</div>
							<div class="payback_middle">
								<div class="z_way">
									<span>方式</span>
									<em>${count }</em>
								</div>
								<div class="z_way_detail">[到养猪场领取活猪]</div>
							</div>
							<div class="payback_bottom">请截止至${endModifyTime }前选择</div>
							<!-- star 已选的红色圆圈 -->
							<div class="z_check">已选</div>
							<!--end 已选的红色圆圈 -->
						</div>
					</a>
				</c:if>	
				<c:if test="${type4 }">
					<c:set var="count" value="${count+1 }"></c:set>
					<a href="<%=basePath %>wpv/orchooseRepayType?repayTypeId=4&queryProjectId=${queryProjectId}&endModifyTime=${ endModifyTime}">
						<div class="pig_payback mb20 position_r">
							<div class="payback_title">选择回报方式</div>
							<div class="payback_middle">
								<div class="z_way">
									<span>方式</span>
									<em>${count }</em>
								</div>
								<div class="z_way_detail">[领取${couponMoney }元/头的猪肉券]</div>
								<c:if test="${limitCity != null }"><em class="z_sz_use">仅限${limitCity }地区</em></c:if>
							</div>
							<div class="payback_bottom">请截止至${endModifyTime }前选择</div>
							<!-- star 已选的红色圆圈 -->
							<div class="z_check">已选</div>
							<!--end 已选的红色圆圈 -->
						</div>
					</a>
				</c:if>
			</div>
		</div>
	</body>
	<jsp:include page="../common/commonTip.jsp"></jsp:include>
	<jsp:include page="../back.jsp">
		<jsp:param value="wpnv/ixpigGrow?queryProjectId=${queryProjectId}" name="backUrl"/>
	</jsp:include>
</html>
<script>
	$(function(){
		$(".z_check").hide();
		if(null != '${myEarnings}' && ${myEarnings.dealType} > 0){
			var i = parseInt(${myEarnings.dealType})-1;
			$($(".z_check")[i]).show();
		}
	});
</script>
