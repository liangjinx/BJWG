<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
	
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
		<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
		<title>订单管理</title>
		<style>
        	.or_top_nav li { width: 33.33333%;}
        	.or_comment_1 { width: 98px; padding: 10px 12px; margin-left: 20px; font-size: 1.6rem; color: #fff; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; border: 1px solid #ffb400; background-color: #ffb400;}
			.or_comment_2 { width: 98px; padding: 10px 12px;　margin-left: 20px;　font-size: 1.6rem;　color: #858386;　border-radius: 5px;　-webkit-border-radius: 5px; -moz-border-radius: 5px; border: 1px solid #dedede; background-color: #dedede;}
			.or_nothing { width: 100%; height: 40px; line-height: 40px; font-size: 1.6rem; color: #858386; text-align: center; background-color: #fff;}
			.z_status { font-size: 1.5rem; color: #322c2c;}
			.z_comment { font-size: 1.6rem; color: #322c2c;}
			.or_content_content { height: auto;}
			/*Guide the instructions*/
			.mark2 { position: fixed; left: 0; right: 0; top: 0; bottom: 0; display: block; width: 100%; height: 100%; z-index: 99;}
			.mark2 img { width: 100%;}
			.img2, .img3 { display: none;}
			.area1, .area2, .area3, .area11, .area22 .area33 { -webkit-tap-highlight-color: transparent;}
			/*refund reason in list*/
			.refund_reasonshow span, .refund_reasonshow em { font-size: 1.6rem; color: #322c2c;}
			.refund_reasonshow, .or_container { padding: 5px 0;}
			.refund_reasonshow { width: 100%; border-top: 1px solid #dedede;}
			.or_content_title { height: auto; margin: 8px auto; padding: 0;}
        </style>
        <script type="text/javascript" src="<%=basePath %>resources/js/introduceSwitch.js"></script>
	</head>
	<%--
	<body class="search">
		<c:forEach items="${list }" var="l">
			<p>店铺名称：${l.name }</p>
			<p>服务详情：${l.goodsInfo }</p>
			<a>去服务</a>
		</c:forEach>
		当前页：${page.currentPage },总记录数${page.countRows }
	</body>
	 --%>
	<body>
		<div class="head">
            <a href="<%=basePath%>index/manage" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
            <p>订单管理</p>
        </div>
        <div class="or_all_content">
	        <div class="or_topbox">
	        	<ul class="or_top_nav">
	        		<li <c:if test="${queryOrderStatus eq -9 || queryOrderStatus == null || queryOrderStatus eq 0 }">class="or_active"</c:if>><a href="<%=basePath%>order/shopOrderList?queryOrderStatus=-9&shopId=${shopId}"><em class="z_status">全部</em><a></li>
	        		<li <c:if test="${queryOrderStatus eq 2}">class="or_active"</c:if>><a href="<%=basePath%>order/shopOrderList?queryOrderStatus=2&shopId=${shopId}"><em class="z_status">待服务</em><a></li>
	        		<li <c:if test="${queryOrderStatus eq 6}">class="or_active"</c:if>><a href="<%=basePath%>order/shopOrderList?queryOrderStatus=6&shopId=${shopId}"><em class="z_status">退款处理</em><a></li>
	        		<!-- 
	        		<li  <c:if test="${queryOrderStatus eq -1}">class="or_active"</c:if>><a href="<%=basePath%>order/shopOrderList?queryOrderStatus=-1&shopId=${shopId}">已关闭订单</li> -->
	        	</ul>
	        </div>
	        <form action="" method="post" id="personalForm" name="personalForm">
	        	<input type="hidden" id="shopId" name="shopId" value="">
	        	<input type="hidden" id="orderId" name="orderId" value="">
	        	<input type="hidden" id="queryOrderStatus" name="queryOrderStatus" value="${queryOrderStatus }">
		        <c:forEach items="${list }" var="l">
			        <div class="or_content">
			        	<a href="<%=basePath%>order/orderDetails?orderId=${l.orderId}&s_type=2&queryOrderStatus=${queryOrderStatus}" target="_self">
				        	<div class="or_content_title">	
				        		<div class="or_container">
				        			<div class="left_shop_name">
				        				<c:choose>
			        						<c:when test="${fn:length(l.username) > 10 }">
					        					${fn:substring(l.username,0,10)}
			        						</c:when>
			        						<c:otherwise>
					        					${l.username}
			        						</c:otherwise>
			        					</c:choose>
				        			</div>
				        			<div class="right_operation">
				        				<c:choose>
				        					<c:when test="${l.orderStatus eq 1 }">
				        						未付款
				        					</c:when>
				        					<c:when test="${l.orderStatus eq 2 || l.orderStatus eq 3}">
				        						待服务
				        					</c:when>
				        					<c:when test="${l.orderStatus eq 4}">
				        						待评价
				        					</c:when>
				        					<c:when test="${l.orderStatus eq 5}">
				        						已评价
				        					</c:when>
				        					<c:when test="${l.orderStatus eq 6}">
				        						<c:choose>
				        							<c:when test="${l.refundApplyStatus eq 1}">
				        								未处理
				        							</c:when>
				        							<c:when test="${l.refundApplyStatus eq 2 || l.refundApplyStatus eq 6 || l.refundApplyStatus eq 8}">
				        								退款中
				        							</c:when>
				        							<c:when test="${l.refundApplyStatus eq 3}">
				        								商家不同意退款
				        							</c:when>
				        							<c:when test="${l.refundApplyStatus eq 5}">
				        								平台不同意退款
				        							</c:when>
				        							<c:when test="${l.refundApplyStatus eq 4}">
				        								平台已介入
				        							</c:when>
				        							<c:when test="${l.refundApplyStatus eq 7}">
				        								取消退款
				        							</c:when>
				        						</c:choose>
				        						<!-- 
				        						退款中
				        						<c:choose>
				        							<c:when test="${l.refundApplyStatus eq 1}">
				        								，未处理
				        							</c:when>
				        							<c:when test="${l.refundApplyStatus eq 2}">
				        								，商家同意退款
				        							</c:when>
				        							<c:when test="${l.refundApplyStatus eq 3}">
				        								，商家不同意退款
				        							</c:when>
				        							<c:when test="${l.refundApplyStatus eq 4}">
				        								，平台介入中
				        							</c:when>
				        							<c:when test="${l.refundApplyStatus eq 5}">
				        								，平台不同意退款
				        							</c:when>
				        							<c:when test="${l.refundApplyStatus eq 6}">
				        								，平台同意退款
				        							</c:when>
				        							<c:when test="${l.refundApplyStatus eq 7}">
				        								，取消退款
				        							</c:when>
				        							<c:when test="${l.refundApplyStatus eq 8}">
				        								，系统自动退款
				        							</c:when>
				        						</c:choose>
				        						-->
				        					</c:when>
				        					<c:when test="${l.orderStatus eq 7}">
				        						退款成功
				        					</c:when>
				        					<c:when test="${l.orderStatus eq -1}">
				        						已取消
				        					</c:when>
				        					<c:otherwise>
				        						<%-- 已删除 --%>
				        						<c:choose>
				        							<c:when test="${l.payStatus lt 2}">
				        								未付款
				        							</c:when>
				        							<c:when test="${l.payStatus eq 2}">
				        								已评价
				        							</c:when>
				        							<c:otherwise>
				        							</c:otherwise>
				        						</c:choose>
				        					</c:otherwise>
				        				</c:choose>
				        				<!--点击‘全部’选项后的状态-->
				        				<!--待服务--><!--待服务	点击‘待服务’选项后的状态-->
				        			</div>
				        		</div>
				        		<c:if test="${l.orderStatus eq 6 || l.orderStatus eq 7}">
					        		<div class="refund_reasonshow">
					        			<span>退款原因：</span>
					        			<em>
					        				<c:set var="rr" value="${l.refundReason }"></c:set>
				        					<c:if test="${fn:length(l.refundReason) > 11 }">
						        				<c:set var="rr" value="${fn:substring(l.refundReason, 0 , 11)}..."></c:set>
				        					</c:if>
					        				${rr}
					        			</em>
					        		</div>
					        	</c:if>

				        	</div>
				        	<div class="or_content_content">
				        			<%-- 订单中记录的服务信息 --%>
			        				<c:forEach items="${l.goodsInfoArr }" var="g">
						        		<div class="or_container">
						        			<div class="left_service_pic">
						        				<img src="http://img.hzd.com${g.path}" alt="服务名称" />
						        			</div>
						        			<div class="right_service_intro">
						        				<p class="r_service_name">【${l.shopName}】${g.name}</p>
						        				<div class="r_norm">
						        					<span>价格：<em>￥${g.price}</em></span>
						        					<span class="r_norm_numer">数量：${g.purchaseNum }</span>
						        				</div>
						        			</div>
						        		</div>
			        				</c:forEach>
				        	</div>
				        </a>	
				        	<div class="or_content_bottom">
				        <a href="<%=basePath%>order/orderDetails?orderId=${l.orderId}&s_type=2&queryOrderStatus=${queryOrderStatus}" target="_self">	
				        		<div class="or_botm_price">
				        			<span class="orders_time"><fmt:formatDate value="${l.ctime}" pattern="yyyy.MM.dd"/></span>
				        			<span class="orders_sum">共计：￥${l.totalMoney }</span>
				        		</div>
				        </a>		
				        		<div class="or_botm_btn">
				        			<c:choose>
			        					<c:when test="${l.orderStatus eq 1 }">
			        					</c:when>
			        					<c:when test="${l.orderStatus eq 2 }">
						        			<a href="tel:${l.linkPhone }">联系买家</a>
					        				<input type="button" class="or_comment_1" value="去服务" onclick="submitForm(1,${l.shopId},${l.orderId})"/>
			        					</c:when>
			        					<c:when test="${l.orderStatus eq 3}">
						        			<a href="tel:${l.linkPhone }">联系买家</a>
					        				<input type="button" class="or_comment_2" value="去服务" disabled="disabled"/>
			        					</c:when>
			        					<c:when test="${l.orderStatus eq 4}">
			        					</c:when>
			        					<c:when test="${l.orderStatus eq 5}">
						        			<!--<a href="<%=basePath%>index/goodsDetailComment?id=${l.shopId}">
						        				 <em class="z_comment">查看评价</em> -->
						        				<input type="button" class="or_pay" value="查看评价" onclick="query('<%=basePath%>index/goodsDetailComment?id=${l.shopId}')" />
						        			<!-- </a> -->
			        					</c:when>
			        					<c:when test="${l.orderStatus eq -1}">
			        					</c:when>
			        					<c:when test="${l.orderStatus eq 6}">
		        							<c:if test="${l.refundApplyStatus eq 1}">
						        				<input type="button" class="or_comment_1" value="不同意退款" id="disagree_refund" onclick="refundAudit(0,${l.orderId},${l.shopId},'<%=basePath%>order/refundShopAudit')" />
						        				<input type="button" class="or_pay" value="同意退款" onclick="refundAudit(1,${l.orderId},${l.shopId},'<%=basePath%>order/refundShopAudit')" />
		        							</c:if>
			        					</c:when>
			        					<c:when test="${l.orderStatus eq 7}">
			        					</c:when>
			        					<c:otherwise>
			        						<%-- 已删除 --%>
			        						<c:choose>
			        							<c:when test="${l.payStatus eq 2}">
			        								<input type="button" class="or_pay" value="查看评价" onclick="query('<%=basePath%>index/goodsDetailComment?id=${l.shopId}')"  />
			        							</c:when>
			        							<c:otherwise>
			        							</c:otherwise>
			        						</c:choose>
			        					</c:otherwise>
			        				</c:choose>
				        		</div>
				        	</div>
		        	</div>
		        </c:forEach>
		        <c:if test="${fn:length(list) == 0}">
	            	<div class="or_nothing">您暂时还未有订单记录！</div>
	            </c:if>
	            
	            <jsp:include page="../order/refund_reason.jsp"></jsp:include>
        	</form>
        	
	    </div>
	    
	    <%-- 关闭调用 troggleThisIntroduceSwitch('<%=basePath%>') --%>
	 	<c:if test="${introduceSwitch }">
		    <div class="mark2">
		        <img src="<%=basePath %>resources/images/guidance/customer_01.jpg" alt="联系买家" usemap="#Map1" class="img1" />
	            <map name="Map1">
	              <area shape="poly" coords="5,3,7,53,164,53,164,3" href="javascript:void(0);" class="area1" >
	              <area shape="poly" coords="3,341,3,378,1503,376,1504,338" href="javascript:void(0);" class="area11" >
	            </map>
	            
	            <img src="<%=basePath %>resources/images/guidance/customer_02.jpg" alt="去服务" usemap="#Map2" class="img2" />
	            <map name="Map2">
	            	<area shape="poly" coords="5,3,7,53,164,53,164,3" href="javascript:void(0);" class="area2" >
	              	<area shape="poly" coords="3,341,3,378,1503,376,1504,338" href="javascript:void(0);" class="area22" >
	            </map>
	            
	            <img src="<%=basePath %>resources/images/guidance/customer_03.jpg" alt="退款处理" usemap="#Map3" class="img3" />
	            <map name="Map3">
	            	<area shape="poly" coords="5,3,7,53,164,53,164,3" href="javascript:void(0);" class="area3" >
	              	<area shape="poly" coords="3,341,3,378,1503,376,1504,338" href="javascript:void(0);" class="area33" >
	            </map>
	    	</div>
	    </c:if>
	    
	    
	</body>
	
	<script type="text/javascript">
		
	function phoneCalls2(shopId,url){
		$.ajax({
			   type: "POST",
			   url: url,
			   data:{"shop_id":shopId},
			   success: function(data)
			   {
				   $("#phoneTel_"+shopId).attr('href','tel:'+ data);
				   $("#phoneTel_"+shopId)[0].click(); 
				   var phone = $('#phoneTimes_'+shopId).html();
				   $('#phoneTimes_'+shopId).html( Number(phone) + Number(1) );
		       },
		       error: function() {
		       		alert('error');
		       }
		});
	}
	//提交表单
	function submitForm(type,shopId,orderId){
	
		var url = "";
		//去服务
		if(type == 1){
			url = "<%=basePath%>order/shopOrderToSerive";
			$("#shopId").val(shopId);
			$("#orderId").val(orderId);
			$("#personalForm").attr("action",url).submit();
		}
	}
		
	$(document).ready(function(){
  		var messsageCode = '${requestScope.messageCode}';
  		var messsage = '${requestScope.message}';
  		if(messsage != ''){
  			alert(messsage);
  		}
  	});
	  	
	 //提交
	function query(url){
		window.location.href=url;
	}
	  	 
	//star 热点
	 $(function(){
		var w = window.innerWidth;
		var y = window.innerHeight;
		var x1 = 0;
		var y1 = 0;
		var x2 = 0;
		var y2 = 0.1667 * y ;
		var x3 = w ;
		var y3 = y2;
		var x4 = x3;
		var y4 = 0;
		
		//1、联系买家；2、去服务，3、退款处理
		$('.area1, .area2, .area3').attr('coords',x1 +','+ y1 +','+ x2 +','+ y2 +','+ x3 +','+ y3 +','+ x4 +','+ y4);
		$('.area11, .area22, .area33').attr('coords',x2 +','+ y2 +','+ x2 +','+ y +','+ w+','+ y +','+ x3 +','+ y3);
	});
	
	$(function(){
		if('${introduceSwitch }'=='true'){
			$('.mark2').show();
		}
	});
	$(function(){
		$('.area1, .area2, .area3').on('click',function(){
			$('.mark2').hide();
			troggleThisIntroduceSwitch('<%=basePath%>',3);
		});
		$('.area11').on('click',function(){
			$('.img1').hide();
			$('.img2').show();
		});
		$('.area22').on('click',function(){
			$('.img2').hide();
			$('.img3').show();
		});
		$('.area33').on('click',function(){
			$('.img3').css('display','none');
			$('.mark2').hide();
			troggleThisIntroduceSwitch('<%=basePath%>',3);
		});
	}); /*end 热点*/
	
	</script>
	<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>
