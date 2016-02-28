<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <title>确认服务</title>
	</head>
	<body>
	
	<c:choose>
		<c:when test="${actQR == 'PR' }">
			<div class="head">
				<c:choose>
					<c:when test="${switch_str eq 'close' }">
			            <a href="<%=basePath%>order/orderPersonal?type=3" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
					</c:when>
					<c:otherwise>
			            <a href="<%=basePath%>order/orderPersonal" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
					</c:otherwise>
				</c:choose>
	            <p>确认收货</p>
	        </div>
	    	<div class="aff_content">
	    		<div class="aff_information">
	    			<p class="p_first">您已"确认收货"</p>
	    			<p class="p_second">感谢您的支持</p>
	    		</div>
				<!--<a href="order/evaluate">	
					<div class="aff_evaluate">
						去评价
					</div>
				</a>	
	    	--></div>
		</c:when>
		<c:otherwise>
			<div class="head">
	            <a href="javascript:history.back(-1)" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
	            <p>确认服务</p>
	        </div>
	    	<div class="aff_content">
	    		<div class="aff_information">
	    			<p class="p_first">您已"确认服务"</p>
	    			<p class="p_second">感谢您的支持</p>
	    		</div>
				<a href="<%=basePath%>order/evaluate?orderId=${orderId}">	
					<div class="aff_evaluate">
						去评价
					</div>
				</a>	
	    	</div>
		</c:otherwise>
	</c:choose>

	</body>
	<jsp:include page="../head/hideHead.jsp"></jsp:include>
	
	<c:if test="${actQR == 'PR' }">
		<script type="text/javascript">
			$(function(){
				//2秒自动跳转
				appInvoke(2,'appInvoke');
			});
			function appInvoke(time,obj){
				if(--time>0){
					setTimeout("appInvoke("+time+",'"+obj+"')",1000);
				}else{
					window.location.href='<%=basePath%>order/orderPersonal';
				}
			} 
		</script>
	</c:if>
</html>

