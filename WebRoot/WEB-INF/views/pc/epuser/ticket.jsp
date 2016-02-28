<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="__page_name__" value="我的猪肉券" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
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
<jsp:include page="../user/nav.jsp">
	<jsp:param value="5" name="nav"/>
</jsp:include>
<!--mypig_left_nav -->
<div class="right_main">
	<div class="my_pig_tit bg_f6"><!--my_pig_tit -->
    	<img src="resources/images/pc/nav_tit_bg.png" alt="我的猪肉券"/>
        <div class="pig_tit"><p>我的猪肉券</p></div>
    </div><!--my_pig_tit -->
    <c:choose>
    	<c:when test="${fn:length(ticketList)>0 }">
    		<ul class="pig_coupons_ul">
    		<c:forEach items="${ticketList}" var="ticket">
    		<li data-ticket="${ticket.myCouponId}">
         		<div class="coupons_ul_tit"><p>电子券号码：${ticket.couponCode}</p><a href="pc/pv/user/ticketUseRecord?ticketId=${ticket.myCouponId }">消费记录</a></div>
            	<div class="coupons_code"><img src="${ticket.couponImg}" alt="二维码"/><p>通过二维码支付</p></div>
            	<div class="coupons_yue"><p>余额￥</p><span>${ticket.canUseMoney}</span></div>
            	<div class="coupons_time"><p>使用有效期：<fmt:formatDate value="${ticket.beginTime}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${ticket.endTime}" pattern="yyyy-MM-dd"/></p></div>
         	</li>
    		</c:forEach>
    		</ul>
    	</c:when>
    	<c:otherwise>
    		<div class="clear"></div> 
    		<div class="z_no_ticket">您还没有猪肉券哦。</div>
    	</c:otherwise>
    </c:choose>
<div class="clear"></div>    
</div>


<div class="clear"></div>
</div>

   
<!-- 中间部分-->
<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->
</body>
<script>
 
</script>
</html>
<!--



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>我的猪肉券</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script language="JavaScript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<script>
	$(function() {
		$('.useRd').click(function() {
			var self=$(this);
			
			$.ajax({
				type : 'POST',
				dataType : 'json',
				url : 'pv/user/ticketUseRecord',
				cache : false,
				data : {
					ticketId : self.parent().attr('data-ticket')
				},
				success : function(data) {
					if (data.msg == 'success') {
						var rds = data.data.rds;
						for(var i in rds){
							self.next().html(self.next().html()+'<div>消费金额:'+rds[i].money+' | '+ rds[i].where+' | '+rds[i].time+'</div>');
						}
						console.log(data);
						//window.location.reload();
					} else {
						alert(data.data.text);
						self.removeAttr('disabled');
					}
				},
				error : function() {
					alert('error');
				}
			});
		})
	})
</script>
	</head>
  
  <body>
    <h3>我的猪肉券</h3>
    <c:forEach items="${ticketList}" var="ticket">
    	<div data-ticket="${ticket.myCouponId}">
    		<div>电子券号码:${ticket.couponCode}</div>
    		<div>余额:${ticket.canUseMoney}</div>
    		<div>二维码:${ticket.couponImg}</div>
    		<div>${ticket.beginTime}~${ticket.endTime}</div>
    		<a href="javascript:;" class="useRd">使用记录</a>
    		<div>
    			
    		</div>
    		<hr>
    	</div>
    </c:forEach>
  </body>
</html>
-->