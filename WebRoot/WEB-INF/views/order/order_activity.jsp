<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>
<jsp:include page="../phone/is_phone.jsp"></jsp:include>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <title>活动订单</title>
        <style>
        	.or_top_nav li { width: 25%;}
        	.or_nothing { width: 100%; height: 40px; line-height: 40px; font-size: 1.6rem; color: #858386; text-align: center; background-color: #fff;}
        </style>
	</head>
	<body>
		<div class="head">
            <a href="<%=basePath%>index/storeMe" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
            <p>活动订单</p>
        </div>
        <div class="or_all_content">
	        <div class="or_topbox">
	        	<ul class="or_top_nav">
	        		<li class="or_active">活动</li>
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
		        			<div class="left_shop_name">
		        				${order.shopName}&nbsp;&gt;
		        			</div>
		        			<div class="right_operation">
		        				<c:if test="${order.orderStatus == -1 }">取消订单</c:if>
		        				<c:if test="${order.orderStatus == 1}">待付款</c:if>
		        				<c:if test="${order.orderStatus == 2 || order.orderStatus == 3 }">待服务</c:if>
		        				<c:if test="${order.orderStatus == 4}">已完成</c:if>
		        			</div>
		        		</div>
		        	</div>
		        	
			       <c:forEach items="${order.products}" var="pro">	 	
			        	<div class="or_content_content">
			        		<div class="or_container">
			        		
			        			<a href="<%=basePath%>order/orderDetails?orderId=${order.orderId}&actQR=PR">
			        				<div class="left_service_pic">
			        					<img src="${pro.path}" alt="服务名称" />
			        				</div>
			        			
			        			<div class="right_service_intro">
			        				<p class="r_service_name">${pro.name}</p>
			        				<div class="r_norm">
			        					<span>价格：<em>￥${pro.price}</em></span>
			        					<span class="r_norm_numer">数量：<em>${pro.salesNum}</em></span>
			        				</div>
			        			</div>
			        			
			        			</a>
			        			
			        		</div>
			        	 </div>
			        </c:forEach>
			        
			        <input type="hidden" id="orderId" name="orderId" value="">
			        
			        <input type="hidden" id="" name="actQR" value="PR">
			        
		        	<div class="or_content_bottom">
		        		<div class="or_botm_price">
		        			共计：￥${order.totalMoney}
		        		</div>
		        		<div class="or_botm_btn">
		        		
		        		<c:if test="${order.calOrder != 'can' && order.orderStatus != -1}">
	        				<input type="button" class="or_remove" value="取消订单" onclick="query('<%=basePath%>order/cancel','${order.orderId}')" /><!--点击‘全部’、‘待评价’、‘待付款’选项后的状态-->
	        			</c:if>
	        			
	        			<c:if test="${order.orderStatus == -1 }">
	        				<input type="button" class="or_remove" value="删除订单" onclick="query('<%=basePath%>order/del','${order.orderId}')" /><!--点击‘全部’、‘待评价’、‘待付款’选项后的状态-->
	        			</c:if>

	        			<c:if test="${order.orderStatus == 1 && order.actAcn != 'wfkOrder' }">
	        				<input type="button" class="or_pay" value="付款"  onclick="query('<%=basePath%>order/payment','${order.orderId}')" />
	        			</c:if>
						
						<c:if test="${ order.orderStatus == 2 || order.orderStatus == 3 }">
	        				<input type="button" class="or_pay" value="确认收货"  onclick="query('<%=basePath%>order/conService','${order.orderId}')" />
	        			</c:if>
	        				
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
//提交
function query(url,id){
	$("#orderId").val(id);
	$("#personalForm").attr("action",url).submit();
}

	$(".or_top_nav li").on("click",function(){
		$(this).addClass("or_active").siblings().removeClass("or_active");
	});
	$(".or_remove").on("click",function(){
		$(this).closest(".or_content").remove();
	});
</script>
        
	</body>
	<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>

