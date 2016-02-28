<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<meta name="keywords" content="八戒王国">
<meta name="description" content="八戒王国">
<meta http-equiv="Pragma" content="no-cache" />
<title>订单详情</title>

<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/enter.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css"/>
</head>
<body>
	<form action="" id="allProjectForm" name="allProjectForm"  method="post">   
		<input type="hidden" name="orderId" id="orderId" value="${order.orderId}">
		
		<c:choose>
			<c:when test="${order.type eq  1}">
				<div class="bodyheight"><!--bodyheight -->
					<p class="p_top">&nbsp;</p>
					<p class="order_tit">订单状态：
						<span>
							<c:choose>
			  					<c:when test="${order.status == -1 }">取消</c:when>
			  					<c:when test="${order.status == 1 }">待付款</c:when>
			  					<c:when test="${order.status == 2 }">付款中</c:when>
			  					<c:when test="${order.status == 3 }">已付款</c:when>
			  					<c:when test="${order.status == 4 }">待发货</c:when>
			  					<c:when test="${order.status == 5 }">已确认收货</c:when>
			  				</c:choose>
						</span>
					</p>
					<p class="order_tit">订单号：${order.orderCode }</p>
					<c:if test="${order.status <= 1 }">
						<p class="order_ts time_reduce" data-countdown="${overTime == null ? 0 : overTime}">您的订单已提交，请在<span class="d_count_down"></span>内完成支付,超时订单自动取消</p>
					</c:if>
					
					<div class="order_main_box mt10"><!--order_box -->
						<div class="center80">
					    	<div class="sp_tit_box b_bottom">商品清单</div>
					        <div class="sp_order_box"><!--sp_order_box -->
					        	<div class="img_box"><img src="${order.productImg}" alt=""/></div>
					            <div class="order_p">${order.productName}</div>
					            <div class="order_p">单价：￥${order.price} &nbsp;X${order.num}</div>
					            <div class="order_p order_sy"></div>
					            <div class="clear"></div>
					        </div><!--sp_order_box -->
					         <div class="clear"></div>
					    </div>        
					</div><!--order_box -->
					
					
					<div class="center80">
						<p class="order_sum">应付总额：<span>￥${order.totalMoney}</span></p>
					    <p class="order_time">下单时间：<fmt:formatDate value="${order.ctime}" pattern='yyyy-MM-dd HH:mm:ss' /></p>
					</div>
					 
					
					<div class="center80 order_but_box">
						<div class="clear"></div>
						<!-- 未付款 ok  -->
						<c:if test="${order.status == 1}">
							<input type="button" class="but but2" onclick="submitOrder('<%=basePath %>wpv/orchoosePay','${order.orderId}')" value="立即付款"   />
						</c:if>
						<!-- 未付款 的抢购和屠宰配送单  -->
						<c:if test="${order.status == 1 && (order.type == 1 || order.type == 2)}">
							<input type="button" class="but but1" onclick="submitOrder('<%=basePath %>wpv/orcancel','${order.orderId}')" value="取消订单"></input>
						</c:if>
						<!-- 待确认收货的领活猪订单  -->
						<c:if test="${order.status == 4 && order.type == 3}">
							<input type="button" class="but but1" onclick="submitOrder('<%=basePath %>wpv/orcancel','${order.orderId}')" value="取消订单"></input>
						</c:if>
						<!-- 取消状态 ok + 确认发货ok -->
						<c:if test="${order.status == -1 || order.status == 5 }">
							<input type="button" class="but but1" onclick="submitOrder('<%=basePath %>wpv/ordelete','${order.orderId}')" value="删除订单"></input>
	        			</c:if>
	        			<!-- 待收货ok -->
						<c:if test="${order.status == 4}">
							<input type="button" class="but but2" onclick="submitOrder('<%=basePath%>wpv/orConfirm','${order.orderId}')" value="确认收货"   />
	        			</c:if>
						<div class="clear"></div>
					</div>
				</div><!--bodyheight -->
			</c:when>
			<c:otherwise>
				<div class="z_order_datail">
					<div class="order_number_status">
						<div class="z_order_detail_status">订单状态：<span>
							<c:choose>
			  					<c:when test="${order.status == -1 }">取消</c:when>
			  					<c:when test="${order.status == 1 }">待付款</c:when>
			  					<c:when test="${order.status == 2 }">付款中</c:when>
			  					<c:when test="${order.status == 3 }">已付款</c:when>
			  					<c:when test="${order.status == 4 }">待发货</c:when>
			  					<c:when test="${order.status == 5 }">已确认收货</c:when>
			  				</c:choose></span></div>
						<div class="z_order_detail_number mb20">订单号：${order.orderCode }</div>
					</div>
					<div class="order_info mb5">
						<div class="order_detail_way"><c:choose><c:when test="${order.type eq 2 }">委托深圳润民屠宰配送</c:when><c:otherwise>领取活猪</c:otherwise></c:choose></div>
						<div class="order_pig_number mb15">生猪数量：${order.num }只</div>
					</div>
					<c:if test="${orderExtFee != null }">
						<div class="order_detail_parameter">
							<div class="detail_settle_accounts">结算</div>
							<div class="z_segmentation">
								<p class="segmentation_1 f_l">分割费用（精细分割）</p>
								<p class="segmentation_2 f_r">￥${orderExtFee.divisionFee * orderExtFee.num }</p>
							</div>
							<div class="z_freight">
								<p class="freight_1 f_l">运费</p>
								<p class="freight_2 f_r">￥${orderExtFee.slaughterFee * orderExtFee.num }</p>
							</div>
							<div class="z_vacuum_package">
								<p class="vacuum_package_1 f_l">真空包装</p>
								<p class="vacuum_package_2 f_r">￥${orderExtFee.packageFee * orderExtFee.num }</p>
							</div>
						</div>
					</c:if>
					<div class="order_price_time">
						<c:if test="${order.type eq 2 }">
							<div class="z_amount_payable">
								应付总额：
								<span>￥${orderExtFee == null ? order.totalMoney : orderExtFee.payMoney * orderExtFee.num }</span>
							</div>
						</c:if>
						<div class="z_order_time mb20">下单时间：<fmt:formatDate value="${order.ctime}" pattern='yyyy-MM-dd HH:mm:ss' /></div>
						<div class="z_order_bton_status">
							<!-- 未付款 ok  -->
							<c:if test="${order.status == 1}">
								<input type="button" class="but but2 z_queding" onclick="submitOrder('<%=basePath %>wpv/orchoosePay','${order.orderId}')" value="立即付款"   />
							</c:if>
							<!-- 未付款 的抢购和屠宰配送单  -->
							<c:if test="${order.status == 1 && (order.type == 1 || order.type == 2)}">
								<input type="button" class="but but1 z_quxiao" onclick="submitOrder('<%=basePath %>wpv/orcancel','${order.orderId}')" value="取消订单"></input>
							</c:if>
							<!-- 待确认收货的领活猪订单  -->
							<c:if test="${order.status == 4 && order.type == 3}">
								<input type="button" class="but but1 z_quxiao" onclick="submitOrder('<%=basePath %>wpv/orcancel','${order.orderId}')" value="取消订单"></input>
							</c:if>
							<!-- 取消状态 ok + 确认发货ok -->
							<c:if test="${order.status == -1 || order.status == 5 }">
								<input type="button" class="but but1 z_quxiao" onclick="submitOrder('<%=basePath %>wpv/ordelete','${order.orderId}')" value="删除订单"></input>
		        			</c:if>
		        			<!-- 待收货ok -->
							<c:if test="${order.status == 4}">
								<input type="button" class="but but2 z_queding" onclick="submitOrder('<%=basePath%>wpv/orConfirm','${order.orderId}')" value="确认收货"   />
		        			</c:if>
		        		</div>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		
		
		
	</form>
</body>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
<jsp:include page="../back.jsp">
	<jsp:param value="wpv/orderList" name="backUrl"/>
</jsp:include>
</html>
<script type="text/javascript" src="<%=basePath %>resources/js/time.js"></script>
<script type="text/javascript">
<!--
	//提交
	function submitOrder(url,id){
		$("#orderId").val(id);
		$("#allProjectForm").attr("action",url).submit();
	}
//-->
</script>
