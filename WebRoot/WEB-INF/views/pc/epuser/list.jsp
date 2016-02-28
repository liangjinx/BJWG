<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="__page_name__" value="我的订单" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script src="<%=basePath %>resources/js/pc/order/list.js"></script>
<style>
.paging{  float: right; margin-right: 15px;}
</style>
</head>
<body class="body_bg">
<!--banner_box -->
<jsp:include page="../header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="../nav.jsp">
	<jsp:param value="5" name="nav"/>
</jsp:include>
<!-- 导航栏-->
<!--中间部分 -->
<div class="center mypig_center">
<!--mypig_left_nav -->
<jsp:include page="nav.jsp">
	<jsp:param value="3" name="nav"/>
</jsp:include>
<!--mypig_left_nav -->
<div class="right_main">
	<div class="my_pig_tit"><!--my_pig_tit -->
    	<img src="resources/images/pc/nav_tit_bg.png" alt="我的订单"/>
        <div class="pig_tit"><p>我的订单</p></div>
    </div><!--my_pig_tit -->
    <div class="mypig_body" style="min-height: 600px;"> 
    		<div class="orders_ts_box">
            	<img src="resources/images/pc/orders_ts.png" alt="感叹号！"/><p class="p_16">八戒王国online不会以订单异常、系统升级等为由，要求您点击任何链接进行退款、重新付款、额外付款操作。谨防受骗！请认准八戒王国online电话 0755-83579888</p>
            </div><!--orders_ts_box -->  
            <div class="orders_tab_box">
            	<a class="orders_but all_orders_but ${(status == null or status == 0) ? 'this_orders' :'' }" href="pc/pv/epuser/list">全部订单</a>
                <a class="orders_but dfk_orders_but ${(status != null and status == 1) ? 'this_orders' :'' }" href="pc/pv/epuser/list?status=1">待付款</a>
                <a class="orders_but dsh_orders_but ${(status != null and status == 3) ? 'this_orders' :'' }" href="pc/pv/epuser/list?status=4">已付款</a>
                <div class="clear"></div>
                <div class="orders_box_tab all_orders_tab">
                <table class="orders_tab">
                 	<tr class="tab_tit">
                    	<td style="width:25%;">订单信息</td>
                        <td style="width:20%;">商品</td>
                        <td style="width:15%;">数量（只）</td>
                        <td style="width:15%;">总计（元）</td>
                        <td style="width:15%;">订单状态</td>
                        <td style="width:10%;"><p>操作</p> <img src="resources/images/pc/letter_but.png" alt="删除"/></td>
                    </tr>
                    <c:forEach items="${orderList}" var="order">
                    	<tr class="tab_main" data-order="${order.orderId }">                    	
                        	<td style="width:25%;"><p>订单号：${order.orderCode }<br>下单时间：<br/><fmt:formatDate value="${order.ctime }" pattern="yyyy-MM-dd HH:mm:ss"/></p></td>
                        	<td style="width:20%;"><img src="${order.productImg }" alt=""/></td>
                        	<td style="width:15%;">${order.num }</td>
                        	<td style="width:15%;">￥${order.totalMoney }</td>
                        	<td style="width:15%;">
                        		<a>
                        			<c:choose>
                        				<c:when test="${order.status==-1 }">订单已取消</c:when>
                        				<c:when test="${order.status==1 }">未付款</c:when>
                        				<c:when test="${order.status==2 }">付款中</c:when>
                        				<c:when test="${order.status==3 }">已付款</c:when>
                        				<c:when test="${order.status==4 }">待收货</c:when>
                        				<c:when test="${order.status==5 }">已确认收货</c:when>
                        			</c:choose>
                        		</a>
                        		<br>
                        		<a href="pc/pv/order/detail?orderId=${order.orderId}">订单详情</a>
                        	</td>
                        	<td style="width:10%;">
                        		<c:if test="${order.status==1 }">
                        			<a href="pc/pv/order/choosePay?orderId=${order.orderId }">立即付款</a>
                        			<br>
                        			<a href="javascript:;" class="cancel">取消订单</a>
                        		</c:if>
                        		<c:if test="${order.status==2 }">
                        			<a href="pc/pv/order/choosePay?orderId=${order.orderId }">立即付款</a>
                        			<br>
                        		</c:if>
                        		<c:if test="${order.status==4 }">
                        			<a href="javascript:;" class="confirm">确认收货</a>
                        			<br>
                        			<a href="javascript:;" class="cancel">取消订单</a>
                        		</c:if>
                        		<c:if test="${order.status==-1 or order.status==5 }">
                        			<a href="javascript:;" class="delete">删除订单</a>
                        		</c:if>
                        		
                        	</td>
                    	</tr>
                    </c:forEach>
                    <c:if test="${orderList == null || fn:length(orderList) <= 0 }">
                    	<tr class="tab_main">
                    		<td colspan="6">您暂时还未有订单，赶紧去抢购吧</td>
                    	</tr>
                    </c:if>
                 </table>
                 </div>
                <div class="clear"></div>
            </div>
            <c:if test="${pager.pageCount>0 }">
            	<jsp:include page="../pager.jsp">
					<jsp:param name="otherQueryArg" value="status=${status}"/>
				</jsp:include>
			</c:if>
        <div class="clear"></div>
    </div><!--mypig_body -->
</div>


<div class="clear"></div>
</div>

   
<!-- 中间部分-->
<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->
</body>
<script>
/* $(function(){
	 $('.all_orders_but').click(function(){
		 $('.orders_but').removeClass('this_orders');
		 $(this).addClass('this_orders');
		 $('.orders_box_tab').css('display','none');
		 $('.all_orders_tab').css('display','block');
		 })
	$('.dfk_orders_but').click(function(){
		 $('.orders_but').removeClass('this_orders');
		 $(this).addClass('this_orders');
		 $('.orders_box_tab').css('display','none');
		 $('.dfk_orders_tab').css('display','block');
		 })
	$('.dsh_orders_but').click(function(){
		 $('.orders_but').removeClass('this_orders');
		 $(this).addClass('this_orders');
		 $('.orders_box_tab').css('display','none');
		 $('.dsh_orders_tab').css('display','block');
		 })
	 })*/
</script>
</html>





<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title>订单列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script language="JavaScript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<script language="JavaScript" src="<%=basePath %>resources/js/pc/order/list.js"></script>
  </head>
  
  <body>
    <h3>订单列表</h3>
		<div>
			订单列表类型:
			<c:choose>
				<c:when test="${requestScope.status == 1}">
				待付款
				</c:when>
				<c:when test="${requestScope.status == 4}">
				待收货
				</c:when>
				<c:otherwise>
				全部
				</c:otherwise>
			</c:choose>
		</div>
		<div>
    	<c:forEach items="${orderList}" var="order">
    		<div>
    			<div>订单号:${order.orderCode }</div>
    			<div>下单时间:${order.ctime }</div>
    			<div>商品img:${order.productImg }</div>
    			<div>数量:${order.num }</div>
    			<div>总计:${order.totalMoney }</div>
    			<div>订单状态:${order.status }</div>
    			<div data-order="${order.orderId }">
    				<a href="pv/order/detail?orderId=${order.orderId}">订单详情</a> | 
    				<a href="pv/order/choosePay?orderId=${order.orderId }">立即付款</a> | 
    				<a href="javascript:;" class="cancel">取消订单</a> |
    				<a href="javascript:;" class="confirm">确认收货</a> | 
    				<a href="javascript:;" class="delete">删除订单</a>
    			</div>
    		</div>
    		<hr>
    	</c:forEach>
    </div>
    <script>
	
</script>
  </body>
</html>
--%>