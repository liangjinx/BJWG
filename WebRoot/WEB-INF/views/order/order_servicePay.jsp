<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<jsp:include page="../head/head.jsp"></jsp:include>
<!-- 导入 -->
<jsp:include page="../phone/is_phone.jsp"></jsp:include>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <title>全部订单</title>
        <style>
        	.or_top_nav li { width: 20%;}
        	.or_nothing { width: 100%; height: 40px; line-height: 40px; font-size: 1.6rem; color: #858386; text-align: center; background-color: #fff;}
        	/*refund reason in list*/
			.refund_reasonshow span, .refund_reasonshow em { font-size: 1.6rem; color: #322c2c;}
			.refund_reasonshow, .or_container { padding: 5px 0;}
			.refund_reasonshow { width: 100%; border-top: 1px solid #dedede;}
			.or_content_title { height: auto; margin: 8px auto; padding: 0;}
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
	        		<a 
	        			<c:choose>
							<c:when test="${isPhone }">
								<c:choose>
									<c:when test="${isIosPhone }">
										href="OC://tag=32"
									</c:when>
									<c:otherwise>
										href="javascript:window.xxxx;"
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
										href="<%=basePath%>order/orderPersonal?orderStatus=0"
							</c:otherwise>
						</c:choose>
	        		><li >全部</li></a>
	        		<a 
	        			<c:choose>
							<c:when test="${isPhone }">
								<c:choose>
									<c:when test="${isIosPhone }">
										href="OC://tag=32"
									</c:when>
									<c:otherwise>
										href="javascript:window.xxxx;"
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
										href="<%=basePath%>order/orderPersonal?orderStatus=1"
							</c:otherwise>
						</c:choose>
	        		><li>待付款</li></a>
	        		<li class="or_active" >待服务</li>
	        		<a 
	        			<c:choose>
							<c:when test="${isPhone }">
								<c:choose>
									<c:when test="${isIosPhone }">
										href="OC://tag=32"
									</c:when>
									<c:otherwise>
										href="javascript:window.xxxx;"
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
										href="<%=basePath%>order/orderPersonal?orderStatus=4"
							</c:otherwise>
						</c:choose>
	        		><li>待评价</li></a>
	        		<a href="<%=basePath%>order/orderPersonal?orderStatus=5"><li>退&nbsp;款</li></a>
	        	</ul>
	        </div>
	        
	        <c:choose>
  		<c:when test="${fn:length(orders)>0}">
  		
<form action="" id="personalForm" name="personalForm" method="post">	

	<input type="hidden" id="orderStatus" name="orderStatus" value="2">  
	      
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
		        				<c:if test="${order.orderStatus == 4}">待评价</c:if>
		        				<c:if test="${order.orderStatus == 5}">已评价</c:if>
		        				<c:if test="${order.orderStatus == 6}">
		        					<c:choose>
	        							<c:when test="${order.refundApplyStatus eq 1 || order.refundApplyStatus eq 2 || order.refundApplyStatus eq 6 || order.refundApplyStatus eq 8}">
	        								退款中
	        							</c:when>
	        							<c:when test="${order.refundApplyStatus eq 3}">
	        								商家不同意退款
	        							</c:when>
	        							<c:when test="${order.refundApplyStatus eq 4}">
	        								平台介入中
	        							</c:when>
	        							<c:when test="${order.refundApplyStatus eq 5}">
	        								平台不同意退款
	        							</c:when>
	        							<c:when test="${order.refundApplyStatus eq 7}">
	        								取消退款
	        							</c:when>
	        						</c:choose>
		        				</c:if>
		        				<c:if test="${order.orderStatus == 7}">退款成功</c:if>
		        			</div>
		        		</div>
		        		<c:if test="${order.orderStatus == 6 || order.orderStatus == 7}">
			        		<div class="refund_reasonshow">
			        			<span>退款原因：</span>
			        			<em>
			        				<c:set var="rr" value="${order.refundReason}"></c:set>
		        					<c:if test="${fn:length(order.refundReason) > 11 }">
				        				<c:set var="rr" value="${fn:substring(order.refundReason, 0 , 11)}..."></c:set>
		        					</c:if>
			        				${rr}
			        			</em>
			        		</div>
		        		</c:if>
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
													href="<%=basePath%>order/orderDetails?orderId=${order.orderId}&queryOrderStatus=${queryOrderStatus }"
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
		        		
		        		<c:if test="${ order.orderStatus == 2 && order.orderType != 'SP'}" >
		        			<a href="tel:${order.shopTel}" > 
		        				<input type="button" class="or_remove" value="催单" />
		        			</a>
		        		</c:if>	
	        			<%-- 未付款 ok + （ok）--%>
	        			<c:if test="${order.orderStatus != -1 && order.payStatus == 0}">
	        				<input type="button" class="or_remove" value="取消订单" onclick="query('<%=basePath%>order/cancel','${order.orderId}')" />
	        			</c:if>
	        			<%-- 已付款的服务订单（超过24小时付款） 商家未服务或去服务中 ok --%>
	        			<c:if test="${order.refundApplyStatus == -1 && order.payStatus == 2 && cancelMap[order.orderId] eq 'Y' && order.orderType == 'FW' && (order.orderStatus == 2 || order.orderStatus == 3) }">
	        				<input type="button" class="or_pay refund_btn" value="申请退款" onclick="refund('${order.orderId}','<%=basePath%>order/cancel')" />
	        			</c:if>
		        		<%-- 已评价状态ok--%>
		        		<c:if test="${order.orderStatus == -1 || order.orderStatus == 5 || (order.orderStatus == 4 && order.orderType eq 'SP')}">
	        				<input type="button" class="or_remove" value="删除订单" onclick="query('<%=basePath%>order/del','${order.orderId}')" /><!--点击‘全部’、‘待评价’、‘待付款’选项后的状态-->
	        			</c:if>
        				<c:if test="${order.orderStatus == 5}">
	        				<input type="button" class="or_pay" value="查看评价" onclick="query('<%=basePath%>index/goodsDetailComment?id=${order.shopId}')" />
        				</c:if>
		        		<c:if test="${ order.orderStatus == 3 && order.orderType eq 'FW'}">
		        			<input type="button" class="or_pay" value="确认服务" onclick="query('<%=basePath%>order/conService','${order.orderId}')" />
		        		</c:if>
		        		
		        		</div>
		        	</div>
        		</div>
        		
        		
        	</c:forEach>
        	
        	<jsp:include page="../order/refund_reason.jsp"></jsp:include>
		</form>        	
		
		</c:when>
            <c:otherwise>
            	<div class="or_nothing">暂无记录，赶紧去抢购吧！</div>
            </c:otherwise>
        </c:choose>    
        
        </div>
       
<script type="text/javascript">

function reminder(url,shopId){
	if(confirm('您将联系该店铺，确认拨打吗？')){
 		$.ajax({
			   type: "POST",
			   url: url,
			   data:{"shop_id":shopId},
			   success: function(data)
			   {
			   	   alert(data);
				   $("#phoneTel_"+shopId).attr('href','tel:'+ data);
				   $("#phoneTel_"+shopId)[0].click(); 
		       },
		       error: function() {
		       		alert('error');
		       }
		});
	}
}
//提交
function query(url,id){
	$("#orderId").val(id);
	$("#personalForm").attr("action",url).submit();
}

	$(".or_top_nav li").on("click",function(){
		$(this).addClass("or_active").siblings().removeClass("or_active");
	});
	/*$(".or_remove").on("click",function(){
		$(this).closest(".or_content").remove();
	});*/
$(document).ready(function(){
	var messsageCode = '${requestScope.messageCode}';
	var messsage = '${requestScope.message}';
	if(messsage != ''){
		alert(messsage);
	}
});
</script>
        
	</body>
	<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>
