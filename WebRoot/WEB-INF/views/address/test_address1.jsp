<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>
<jsp:include page="../head/hideHead.jsp"></jsp:include>	

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
		<title>填写订单</title>
		<style type="text/css">
		<style>
			/*content*/
        	h1,h2,h3,h4,h5,h6{
				font-weight:normal;
				font-size:1.4rem;
			}
			html,body{
				width:100%;
				height:100%;
				overflow:hidden;
			}
			*{
				box-sizing: border-box;
				-webkit-box-sizing: border-box;
				-moz-box-sizing: border-box;
			}
			.d_content{bottom:0;background:#ededed;}
			.d_content_1{ padding:0px;bottom:0;background:#ededed;}
			.d_head_right{position:absolute;display:block;top:0;right:15px;color:#fff;line-height:60px;}
			.d_submit a{display:block;height:40px;line-height:40px;border-radius:4px;width:90%;text-align:center;background:#ffb200;color:#fff;margin:15px auto 0;}
			.order_group_info{position:relative;}
			.group_address{background:#fff;font-size:1.6rem;color:#000000;}
			.group_address .buyer_title{height:30px;line-height:30px;border-bottom:1px solid #e7e7e7;padding:0 15px;}
			.group_address .buyer_title img{width:19px;line-height:19px;margin-right:7px;}
			.group_address .buyer_intro{position:relative;display:block;font-size:1.4rem;padding:0 54px 20px 15px;border-bottom:1px solid #e7e7e7;margin-bottom:10px;}
			.group_address .buyer_intro:after{
				content:'';
				display:block;
				position:absolute;
				height:100%;
				width:11px;
				background:url(images/down.png) no-repeat center center;
				right:10px;
				transform:rotate(270deg);
				background-size:11px auto;
				top:0;
			}
			.group_address .buyer_name{height:40px;line-height:40px;font-size:1.4rem;color:#858386;}
			.group_address .buyer_addr{color:#a6a6a6;}
			.order_group_info .group_count{height:50px;line-height:50px;overflow:hidden;padding:0 15px;background:#fff;border-bottom:1px solid #e7e7e7;border-top:1px solid #e7e7e7;}
			.order_group_info .group_count label{display:inline-block;}
			.order_group_info .count_input{display:inline-block;float:right;margin-right:30px;height:21px;margin-top:14px;}
			.order_group_info .count_input span{display:block;float:left;height:21px;line-height:17px;text-align:center;cursor:pointer;}
			.order_group_info .count_input .count_s1{width:18px;border:1px solid #adadad;height:21px;color:#b5b5b5;font-size:1.6rem;}
			.order_group_info .count_input .count_in{border-top:1px solid #adadad;border-bottom:1px solid #adadad;}
			.order_group_info .count_input input{width:54px;line-height:19px;height:19px;border:none;vertical-align: top;text-align:center;}
			.order_group_info .group_price{height:50px;line-height:50px;text-align:right;padding-right:30px;width:100%;}
			.order_group_info .group_price span{color:#ffb200;}
		</style>
	</head>
	<body class="activity">
		
		<div class="head d_head d_header d_header">
            <a href="<%=basePath%>activity/productDetails?activityId=${product.activityId}" class="head_back"></a>
            <p>填写订单</p>
        </div>
		
		<div class="content d_content order_group_content" id="w_div">
	
			<form id="payOrder" action="<%=basePath%>userAddress/editAndGetWXAddress?type=3" method="post">
				
				<%-- 微信收货地址，选择收货地址，提交表单后检测当前用户是否有该收货地址记录，没有则添加。 --%>
				<jsp:include page="../address/wxAddress.jsp"></jsp:include>	
			
				<input type="hidden" name="actOrder" value="actOrder" >
		  		<input type="hidden" name="activityId" value="${product.activityId}" >
		  		
	  			<input type="hidden" name="totalAmount" id="totalAmount" value="${ orderProduct.salesNum == null ? product.price : orderProduct.salesNum*product.price }">
	  			
    			<input type="hidden" name="productId" value="${product.productId}" >
    			<input type="hidden" name="priceAct" value="${product.price}">
    			
    			<input type="hidden" name="actName" value="${activity.name}">
   				<input type="hidden" name="orderId"  value="${orderId}">
   				
    			
				<div class="order_group_info">
					<div class="group_address">
						<p class="buyer_title"><img src="<%=basePath %>resources/images/car.png"/>买家信息</p>
						
						<c:if test="${address != null }">
							
			    			<%-- 新加的 --%>
			    			<input type="text" name="hasAddress" id="hasAddress" value="yes">
			   				<input type="hidden" name="addressId"  value="${address.addressId}">
							<a href="javascript:payAddress('<%=basePath%>userAddress/visit');" class="buyer_intro" id="a_wxAddress">
								<p class="buyer_name" id="wxAddress_contactMan">${address.contactMan}<span id="wxAddress_contactPhone">${address.contactPhone }</span></p>
								<p class="buyer_addr" id="wxAddress_detailAddress">${provinceName}${address.address}</p>
							</a>
						</c:if>
	            	
	            		<c:if test="${address == null }">
	            			<%-- 新加的 --%>
			    			<input type="text" name="hasAddress" id="hasAddress" value="no">
	            			<a href="javascript:payAddress('<%=basePath%>userAddress/visit');" id="a_wxAddress">
					            <div class="info_content">
					            	<div class="adres_empty">您未填写上门服务的地址！</div>
				            		<div class="news_adres2">
					            		<img src="<%=basePath %>resources/images/cart/shopping_9.png" alt="点击添加/更换地址" />
					            	</div>
					            </div>
					        </a>
				        </c:if>
	            	
					</div>
					<div class="group_count">
						<label for="group_num">购买数量</label>
						<div class="count_input">
							<span class="count_sub count_s1" >-</span>
							<span class="count_in">
								<input type="text" name="purchaseNum" id="group_num" onchange="price(this);" class="group_num" value="${orderProduct.salesNum == null ? 1 : orderProduct.salesNum}" />
							</span>
							<span class="count_add count_s1" >+</span>
						</div>
					</div>
					<div class="group_price">共计：￥<span id="total">
						<c:if test="${orderProduct.salesNum != null }">
							${orderProduct.salesNum *product.price  }
						</c:if>
						<c:if test="${orderProduct.salesNum == null }">
							${product.price}
						</c:if>
					</span></div>
					<div class="order_group_submit d_submit">
						<a href="javascript:payOrder();">提交订单</a>
					</div>
				</div>
				
			</form>
			
		</div>
		
	</body>
<script src="<%=basePath %>resources/js/zepto.min.js"></script>
<script>

function payAddress(url){
	$("#payOrder").attr("action",url).submit();
}

$(function(){
	$('.count_sub').on('tap', function(){
		var $num = $('#group_num');
		var num = parseInt($num.val());
		num --;
		if(num <= 1) num = 1;
		$num.val(num);
		
		var temp = parseFloat(num)*parseFloat('${product.price}');
		$("#price").html(parseFloat(temp.toFixed(2).toString()));
		$("#totalAmount").val(parseFloat(temp.toFixed(2).toString()));
		$("#total").html(parseFloat(temp.toFixed(2).toString()));
	});
	//+
	$('.count_add').on('tap', function(){
		var $num = $('#group_num');
		var num = parseInt($num.val());
		num ++;
		$num.val(num);
		
		var temp = parseFloat(num)*parseFloat('${product.price}');
		$("#price").html(parseFloat(temp.toFixed(2).toString()));
		$("#totalAmount").val(parseFloat(temp.toFixed(2).toString()));
		$("#total").html(parseFloat(temp.toFixed(2).toString()));
	});
	
});
function payOrder(){

//	var address = '${address}';
	var address = $("#hasAddress").val();
	if(address == 'no'){
		alert("您尚未选择收货地址");
		return false;
	}
	
	var val = $('#group_num').val();
	if(val == ''){
		alert('购买数量不能为空');
		 e.preventDefault(); 
	}else if(val == 0){
		alert('购买数量不能为0');
		 e.preventDefault(); 
	}
	$("#payOrder").submit();
}

function price(id){
	var num = $("#group_num").val();
//	alert('${product.price}');
	var temp = parseFloat(num)*parseFloat('${product.price}');
	$("#price").html(parseFloat(temp.toFixed(2).toString()));
	$("#totalAmount").val(parseFloat(temp.toFixed(2).toString()));
	$("#total").html(parseFloat(temp.toFixed(2).toString()));
}
</script>
<script type="text/javascript">
$(function(){
	if(/MicroMessenger/i.test(navigator.userAgent)){
		$(".head").css('display','none');
		$("#w_div").removeClass().addClass("content d_content_1 order_group_content");
	}else if (/Android/i.test(navigator.userAgent)) {
		$(".head").css('display','none');
		$("#w_div").removeClass().addClass("content d_content_1 order_group_content");
	}else if (/webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
	
	}else {
		$(".head").css('display','none');
		$("#w_div").removeClass().addClass("content d_content_1 order_group_content");
	}
});
</script>
		
</html>
