<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>
<jsp:include page="../phone/is_phone.jsp"></jsp:include>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <title>全部订单</title>
        <style>
        	.or_top_nav li { width: 25%;}
        	.or_nothing { width: 100%; height: 40px; line-height: 40px; font-size: 1.6rem; color: #858386; text-align: center; background-color: #fff;}
        	.z_reminder { float: right; display: block; margin-left: 20px;}
        	.left_shop_name { font-size: 1.6rem; color: #322c2c;}
        </style>
	</head>
	<body>
		<div class="head">
            <a href="<%=basePath%>index/storeMe" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
            <p>全部订单</p>
        </div>
        <div class="or_all_content">
	        <div class="or_topbox">
	        	<ul class="or_top_nav">
	        		<li class="or_active">全部</li>
	        		<a href="<%=basePath%>order/orderPersonal?orderStatus=1"><li>待付款</li></a>
	        		<a href="<%=basePath%>order/orderPersonal?orderStatus=2"><li>待服务</li></a>
	        		<a href="<%=basePath%>order/orderPersonal?orderStatus=4"><li>待评价</li></a>
	        	</ul>
	        </div>

	<c:choose>
  		<c:when test="${fn:length(orders)>0}">	
  		     
<form action="" id="personalForm" method="post">	
	<input type="hidden" id="orderStatus" name="orderStatus" >  
	      
        	<!--  订单状态  -->
        	<c:forEach items="${orders}" var="order">
	        	<div class="or_content">
		        	<div class="or_content_title">	
		        		<div class="or_container">
		        			<a href="<%=basePath%>index/goodsDetailShop?id=${order.shopId}&type=6">
			        			<div class="left_shop_name">
			        				${order.shopName}&nbsp;&gt;
			        			</div>
		        			</a>
		        			<div class="right_operation">
		        				<c:if test="${order.orderStatus == -1 }">取消订单</c:if>
		        				<c:if test="${order.orderStatus == 1}">待付款</c:if>
		        				<c:if test="${(order.orderStatus == 2 || order.orderStatus == 3) && order.orderType == 'FW' }">待服务</c:if>
		        				<c:if test="${order.orderStatus == 4}">
		        					<c:choose>
		        						<c:when test="${order.orderType == 'FW' }">
				        					待评价
		        						</c:when>
		        						<c:otherwise>
				        					已完成
		        						</c:otherwise>
		        					</c:choose>
		        				</c:if>
		        				<c:if test="${order.orderStatus == 5}">已评价</c:if>
		        				<!--点击‘全部’选项后的状态-->
		        				<!--待付款	点击‘待付款’选项后的状态-->
		        				<!--待服务	点击‘待服务’选项后的状态-->
		        				<!--待评价	点击‘待评价’选项后的状态-->
		        			</div>
		        		</div>
		        	</div>
		        	
			       <c:forEach items="${order.services}" var="service">	 	
			        	<div class="or_content_content">
			        		<div class="or_container">
			        		
			        			<a 
			        				<c:choose>
										<c:when test="${isPhone }">
											<c:choose>
												<c:when test="${isIosPhone }">
													href="OC://tag=36"
												</c:when>
												<c:otherwise>
													href="javascript:window.xxxx;"
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
													href="<%=basePath%>order/orderDetails?orderId=${order.orderId}"
										</c:otherwise>
									</c:choose>
			        			>
			        				<div class="left_service_pic">
			        					<img src="${service.path}" alt="服务名称" />
			        				</div>
			        			
			        			<div class="right_service_intro">
			        				<p class="r_service_name">${service.name}</p>
			        				<div class="r_norm">
			        					<span>价格：<em>￥${service.price}</em></span>
			        					<span class="r_norm_numer">数量：<em>${service.salesNum}</em></span>
			        				</div>
			        			</div>
			        			
			        			</a>
			        			
			        		</div>
			        	 </div>
			        </c:forEach>
			        
			        <input type="hidden" id="orderId" name="orderId" value="">
			        <input type="hidden" id="shopId" name="shopId" value="">
		        	<div class="or_content_bottom">
		        		<span class="orders_time"><fmt:formatDate value="${order.ctime}" pattern="yyyy.MM.dd"/></span>
		        		<div class="or_botm_price">
		        			共计：￥${order.totalMoney}
		        		</div>
		        		<div class="or_botm_btn">
		        			<%-- 未付款 ok + （已付款的服务订单（超过24小时付款）ok）--%>
		        			<c:if test="${order.orderStatus != -1 && (order.payStatus == 0 || (order.payStatus == 2 && cancelMap[order.orderId] eq 'Y' && order.orderType == 'FW' && (order.orderStatus == 1 || order.orderStatus == 2))) }">
		        				<input type="button" class="or_remove" value="取消订单" onclick="query('<%=basePath%>order/cancel','${order.orderId}')" /><!--点击‘全部’、‘待评价’、‘待付款’选项后的状态-->
		        			</c:if>
		        			<%-- 取消状态 ok + 已评价状态ok + （已完成状态的活动订单）ok--%>
		        			<c:if test="${order.orderStatus == -1 || order.orderStatus == 5 || (order.orderStatus == 4 && order.orderType eq 'SP')}">
		        				<input type="button" class="or_remove" value="删除订单" onclick="query('<%=basePath%>order/del','${order.orderId}')" /><!--点击‘全部’、‘待评价’、‘待付款’选项后的状态-->
		        				<c:if test="${order.orderStatus == 5}">
			        				<input type="button" class="or_pay" value="查看评价" onclick="query('<%=basePath%>index/goodsDetailComment?id=${order.shopId}')" />
		        				</c:if>
		        			</c:if>
		        			<%-- 新增状态 的服务订单ok + 新增状态的活动未结束的活动订单ok--%>
		        			<c:if test="${order.orderStatus == 1 && order.actAcn != 'wfkOrder'}">
		        				<input type="button" class="or_pay" value="付款"  onclick="query('<%=basePath%>order/payment','${order.orderId}')" />
		        			</c:if>
		        			
		        			<%-- 已付款未去服务的订单ok--%>
		        			<c:if test="${order.orderStatus == 2 }">
		        				<c:choose>
		        					<c:when test="${order.orderType eq 'SP'}">
					        			<a href="tel:4006801888" class="or_remove z_reminder" >联系卖家</a>
		        					</c:when>
		        					<c:otherwise>
					        			<a href="tel:${order.shopTel}" class="or_remove z_reminder" >催单</a>
		        					</c:otherwise>
		        				</c:choose>
		                    </c:if>
		        			
		        			<%-- 待评论的服务订单ok--%>
		        			<c:if test="${order.orderStatus == 4 && order.orderType == 'FW'}">
		        				<input type="button" class="or_pay" value="评论订单" onclick="evaluateOrder('<%=basePath%>order/evaluate','${order.orderId}','${order.shopId}')" />
		        			</c:if>
		        			<!--<input type="button" class="or_pay" value="评价订单" />--><!--点击‘待评价’选项后的状态-->
		        			<!--<input type="button" class="or_remove" value="联系商家" />--><!--点击‘待服务’选项后的状态-->
		        			
		        			<c:choose>
		        				<c:when test="${order.orderStatus == 3 && order.orderType eq 'SP'}">
				        			<%-- 待服务的活动订单ok--%>
				        			<input type="hidden" id="" name="actQR" value="PR">
				        			<input type="button" class="or_pay" value="确认收货" onclick="query('<%=basePath%>order/conService','${order.orderId}')" />
		        				</c:when>
		        				<c:when test="${ order.orderStatus == 3 && order.orderType eq 'FW'}">
				        			<%-- 待服务且商家去服务后的服务订单ok--%>
			        				<input type="button" class="or_pay" value="确认服务" onclick="query('<%=basePath%>order/conService','${order.orderId}')"  /><!--点击‘待服务’选项后的状态-->
			        			</c:when>
		        			</c:choose>
		        		</div>
		        	</div>
        		</div>
        	</c:forEach>
</form> 
	
		</c:when>
            <c:otherwise>
            	<div class="or_nothing">暂无记录，赶紧去抢购吧！</div>
            </c:otherwise>
        </c:choose>    
			        
		
       	
        </div>
       
<script type="text/javascript">

$(function(){
	var message = '${message}';
	if(null != message && '' != message){
		alert(message);
	}
});
//tab点击跳转
function queryPay(url,pay){
//	alert(index);
	$("#orderStatus").val(pay);
   	$("#personalForm").attr("action",url).submit();
}
//提交
function query(url,id){
	$("#orderId").val(id);
	$("#personalForm").attr("action",url).submit();
}
//提交
function evaluateOrder(url,id,shopId){
	$("#orderId").val(id);
	$("#shopId").val(shopId);
	$("#personalForm").attr("action",url).submit();
}

$(".or_top_nav li").on("click",function(){
	$(this).addClass("or_active").siblings().removeClass("or_active");
});
$(".or_remove").on("click",function(){
	//$(this).closest(".or_content").remove();
});
</script>
        
	</body>
	<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>
