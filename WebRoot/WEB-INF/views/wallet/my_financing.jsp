<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<title>我的投资列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<meta name="keywords" content="八戒王国online">
<meta name="description" content="八戒王国online">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/enter.css"/>
<script src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
<script src="<%=basePath %>resources/js/jquery.classyloader.min.js"></script>
<style>
	.z_no_financing { width: 100%; height: 45px; line-height: 45px; margin-top: 30px; font-size: 16px; color: #615868; text-align: center;}
</style>
</head>
<body>
<div class="bodyheight earning_bg"><!--bodyheight -->
	<p class="p_top">&nbsp;</p>
    <ul class="center90 my_bid_ul">
    	<c:choose>
    		<c:when test="${fn:length(list) >0 }">
	    		 <c:forEach items="${list}" var="l">
			    	<c:set var="percent" value="${l.intervalDays * 100 / l.days }"></c:set>
			   		<%--<fmt:formatNumber value="${percent}" type="number" pattern="0.00%" />
			    	--%><li>
			    	<a href="<%=basePath %>wpv/wlMyFinancingDetail?projectId=${l.paincbuyProjectId }">
			        	<div class="bid_box">
			        		<canvas class="loader" data-ratio="${percent  }"></canvas>                       
			            	<div class="bid_p">
			                <p class="mt15">${l.paincbuyProjectName}</p>
			                <p class="mt5">购买数量${l.purchaseNum}只</p>
			                <p>花费金额：${l.money}元</p>
			                </div>
			                <div class="clear"></div>
			            </div>   
			            </a>         
			        </li>
			    </c:forEach>
			</c:when>
			<c:otherwise>
				<div class="z_no_financing">暂无投资，赶紧去购买猪仔吧！</div>
			</c:otherwise>
    	</c:choose>
    </ul>
    <div class="clear"></div>
</div>
<jsp:include page="../back.jsp">
	<jsp:param value="wpv/urstoreMe" name="backUrl"/>
</jsp:include>
<script>	
	$(document).ready(function() {
		$('.loader').each(function(){
			var $self = $(this),
				_num = $self.data('ratio'); // 获取对应百分比  
				_num = parseInt(_num);
			$self.ClassyLoader({
	            percentage: _num,			// 百分比
				width: '100px',
				height: '100px',
	            speed: 5,					// 动画循环秒
	            fontSize: '20px',			// 字体尺寸
				fontColor:'#666666',
	            diameter:38, 				// 直径
				start: 'top',
				showText: true, 			//是否显示字体
	            lineColor: 'rgba(255,102,51,1)', // 进度条颜色
	            remainingLineColor: 'rgba(214,214,214,0.8)', // 剩余线颜色
	            lineWidth: 3 				// 圆形线条宽度
	        });
			
			
		})
	});
</script>
</body>
</html>

