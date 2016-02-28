<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>我的订单</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/compilations_pz.css">
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<div class="z_my_order">
			<div id="my_order_t">
				<c:set var="item1" value="false"></c:set>
        		<c:set var="item2" value="false"></c:set>
        		<c:set var="item3" value="false"></c:set>
        		<c:choose>
	        		<c:when test="${queryStatus ==null || queryStatus == 0}">
	        			<c:set var="item1" value="true"></c:set>
	        		</c:when>
	        		<c:when test="${queryStatus == 1}">
	        			<c:set var="item2" value="true"></c:set>
	        		</c:when>
	        		<c:otherwise>
	        			<c:set var="item3" value="true"></c:set>
	        		</c:otherwise>
	        	</c:choose>
				<h3 <c:if test="${item1}">class="z_active"</c:if>><span><a href="<%=basePath %>wpv/orderList?queryStatus=0">全部</a></span></h3>
				<h3 <c:if test="${item2}">class="z_active"</c:if>><span><a href="<%=basePath %>wpv/orderList?queryStatus=1">待付款</span></a></h3>
				<h3 <c:if test="${item3}">class="z_active"</c:if>><span><a href="<%=basePath %>wpv/orderList?queryStatus=4">待收货</span></a></h3>
				
				<form action="" id="allProjectForm" name="allProjectForm" method="post">	
					<input type="hidden" id="queryStatus" name="queryStatus" value="${queryStatus}">  
				    <input type="hidden" id="orderId" name="orderId" value="">
					<p class="z_h10 f_l bg_ebebeb"></p>
					<c:choose>
  						<c:when test="${fn:length(list)>0}">
  							<c:forEach items="${list}" var="order">
								<div class="my_order_content f_l" style="display: block">
									<div class="order_top_content">
										<div class="order_top_border_botm">
											<div class="left_order_time"><fmt:formatDate value="${order.ctime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
											<div class="right_order_status">
												<c:choose>
						        					<c:when test="${order.status == -1 }">交易关闭</c:when>
						        					<c:when test="${order.status == 1 }">待付款</c:when>
						        					<c:when test="${order.status == 2 }">付款中</c:when>
						        					<c:when test="${order.status == 3 }">已付款</c:when>
						        					<c:when test="${order.status == 4 }">待发货</c:when>
						        					<c:when test="${order.status == 5 }">已确认收货</c:when>
						        				</c:choose>
											</div>
										</div>
									</div>
									<a href="<%=basePath %>wpv/ororderDetail?orderId=${order.orderId}&queryStatus=${queryStatus }">
										<div class="order_middle_content">
											<div class="left_order_good_img f_l">
												<img src="${order.productImg}" alt="" />
											</div>
											<div class="right_order_good_info f_l">
												<p class="order_date mt50">${order.relationName}</p>
												<p class="order_parameter mt5">单价：￥${order.price}<em class="f_r">X&nbsp;${order.num}</em></p>
											</div>
											
										</div>
									</a>
									<div class="order_bottom_content">
										<div class="order_total_prices">
											<div class="order_total_prices_l f_l">
												<c:choose>
													<c:when test="${order.type eq 2 }">
														<a>屠宰配送</a>
													</c:when>
													<c:when test="${order.type eq 3 }">
														<a>领取活猪</a>
													</c:when>
												</c:choose>
											</div>
											<div class="order_total_prices_r f_r">
												<c:choose>
													<c:when test="${order.type eq 3 }">
													</c:when>
													<c:otherwise>
														实付:<em class="total_prices_2">￥${order.totalMoney}</em>
													</c:otherwise>
												</c:choose>
											</div>
										</div>	
										<!-- 未付款 ok  -->
										<c:if test="${order.status == 1 || order.status == 2}">
											<div class="order_operation_option"><a href="javascript:submitOrder('<%=basePath %>wpv/orchoosePay','${order.orderId}')">立即付款</a></div>
										</c:if>
										
										<!-- 未付款 的抢购和屠宰配送单  -->
										<c:if test="${order.status == 1 && (order.type == 1 || order.type == 2)}">
											<div class="order_operation_option"><a href="javascript:submitOrder('<%=basePath %>wpv/orcancel','${order.orderId}')">取消订单</a></div>
										</c:if>
										<!-- 待确认收货的领活猪订单  -->
										<c:if test="${order.status == 4 && order.type == 3}">
											<div class="order_operation_option"><a href="javascript:submitOrder('<%=basePath %>wpv/orcancel','${order.orderId}')">取消订单</a></div>
										</c:if>
										<!-- 取消状态 ok + 确认发货ok -->
										<c:if test="${order.status == -1 || order.status == 5 }">
											<div class="order_operation_option"><a href="javascript:submitOrder('<%=basePath %>wpv/ordelete','${order.orderId}')">删除订单</a></div>
					        			</c:if>
					        			<!-- 待收货ok -->
										<c:if test="${order.status == 4}">
											<div class="order_operation_option"><a href="javascript:submitOrder('<%=basePath %>wpv/orConfirm','${order.orderId}')">确认收货</a></div>
					        			</c:if>
									</div>
								</div>
							</c:forEach>
  						</c:when>
  						<c:otherwise>
  							<div class="z_no_orders">暂无记录，赶紧去抢购吧！</div>
  						</c:otherwise>
  					</c:choose>
				</form>
			</div>
		</div>
	</body>
	<%-- --%>
	<jsp:include page="../back.jsp">
		<jsp:param value="wpv/urstoreMe" name="backUrl"/>
	</jsp:include>
	<jsp:include page="../common/commonTip.jsp"></jsp:include>
</html>
<script>
	//提交
	function submitOrder(url,id){
		$("#orderId").val(id);
		$("#allProjectForm").attr("action",url).submit();
	}
	
</script>

</body>
</html>
