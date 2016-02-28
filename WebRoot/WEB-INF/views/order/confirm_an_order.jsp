<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>

<!doctype html>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <title>确认订单</title>
		<style>
			.bton_submitbox { padding-top: 7px;}
		</style>
    </head>
    
    <body>
    	<div class="head">
            <a href="javascript:history.back(-1)" class="head_back">
            	<img src="<%=basePath %>resources/images/back.png" alt="返回">
            </a>
            <p>确认订单</p>
        </div>
        <form action="" id="orderForm" method="post">
        	<jsp:include page="../address/wxAddress.jsp"></jsp:include>	
        	<div class="ord_content">
        		<div class="customer_info">        			
	            	<div class="info_top">
	            		<img src="<%=basePath %>resources/images/cart/shopping_8.png" />
	            		<span>买家信息</span>
	            	</div>
	            	
	            	<c:if test="${address != null }">
	            		<%-- 新加的标识 是否有收货地址，提交表单时检测需要 --%>
			    		<input type="hidden" name="hasAddress" id="hasAddress" value="yes">
	            		<input type="hidden" name="addressId"  value="${address.addressId}">
		            	<a href="<%=basePath%>userAddress/visit" id="a_wxAddress" page="shopping">
			            	<div class="info_content">
			            		<h4>${address.contactMan}<span>${address.contactPhone}</span></h4>
			            		<div class="concreteness_adres">
			            			${provinceName}${cityName}${address.address}
			            		</div>
				            	<div class="news_adres">
				            		<img src="<%=basePath %>resources/images/cart/shopping_9.png" alt="点击添加/更换地址" />
				            	</div>
			            	</div>
		            	</a>
	            	</c:if>
	            	
	            	<c:if test="${address == null }">
	            		<input type="hidden" name="hasAddress" id="hasAddress" value="no">
		            	<a href="<%=basePath%>userAddress/visit" id="a_wxAddress" page="shopping">
				            <div class="info_content">
				            	<div class="adres_empty">您未填写上门服务的地址！</div>
			            		<div class="news_adres2">
				            		<img src="<%=basePath %>resources/images/cart/shopping_9.png" alt="点击添加/更换地址" />
				            	</div>
				            </div>
				        </a>
			        </c:if>
        		</div>

        		<div class="commodity_info">
	        		<c:forEach items="${shoppingTrolley}" var="trolley">
	        			
	        			<input type="hidden" name="serviceId" value="${trolley.serviceId}" />
	        			<input type="hidden" name="purchaseNum" value="${trolley.purchaseNum}" />
	        			<input type="hidden" name="shopId" value="${trolley.shopId}" />
	        			
	        			<input type="hidden" name="shopName" value="${shopName}" />
	        			
	        			<div class="info_top2">
	        				<span>${trolley.name}</span>
	        			</div>
	        			<div class="info_content2">
	        				<div class="l_img_box">
	        					<img src="${trolley.path}" alt="商品图片" />
	        				</div>
	        				<div class="r_font_box">
	        					<p class="miaoshu">${trolley.summary}</p>
	        					<p class="jiage">￥${trolley.price}</p>
	        				</div>
	        				<div class="num_1">×${trolley.purchaseNum}</div>
	        			</div>
	        		</c:forEach>
        			<div class="Leave_a_message">
        				<input type="text" name="remark" class="message_1" placeholder="给卖家留言" />
        			</div>
        		</div>
        		
    			<div class="sum_to">
    				<span>数量${total},</span>
    				<span class="num_2">合计：<em class="money_2">￥${totalAmount}</em></span>
    			</div>
        	</div>
            <div class="submit_box">
            	<div class="number_box">
            		<span>数量</span>
            		<em>${total}</em>
            	</div>
            	<div class="sum_box">
            		<span class="momey_font">总金额</span>
            		<span class="momey_red">￥${totalAmount}</span>
            		<input type="hidden" name="totalAmount" value="${totalAmount}">
            	</div>
            	<div class="bton_submitbox">
            		<input type="button" class="confirm_bton" value="提交订单" onclick="query('<%=basePath%>order/fwOrder')"/>
            	</div>
<!--            	<div class="bton_submitbox2">-->
<!--            		<div class="confirm_bton2">您尚未选择收货地址</div>-->
<!--            	</div>-->
            </div>
        </form>
<script type="text/javascript">
function query(url){
	//var address = '${address}';
//	alert(address);
	var address = $("#hasAddress").val();
	if(address == 'no'){
		alert("您尚未选择收货地址");
		return false;
	}else{
		$("#orderForm").attr("action",url).submit();
	}
}

</script>	
        
    </body>
    <jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>

