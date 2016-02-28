<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="__page_name__" value="我的猪肉券 - 消费记录" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/public.css"/>
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
     
    <div class="pig_tit_box pig_tit_box5">
    	<img src="resources/images/pc/point1.png" alt="点"/><p>消费记录</p><img src="resources/images/pc/point1.png" alt="点"/>
    </div>
       
    <div class="coupons_record_box">    	
        <ul class="coupons_record_list">
        	<c:forEach items="${rdList}" var="rd">
    			<li>
        			<p class="xfje_p">
        				消费金额：<span>￥${rd.useMoney }</span>&nbsp;
        			</p>
        			<p class="dsd_p">${rd.useAddress }&nbsp;</p>
        			<p class="time_p"><fmt:formatDate value="${rd.useTime}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</p>
        		</li>
    		</c:forEach>
        
        
        	<!--<li><p class="xfje_p">消费金额：<span>￥46</span></p><p class="dsd_p">深圳润民鲜肉代售点</p><p class="time_p">2015-09-05   14:58:06</p></li>
        -->
        </ul>
         <div class="clear"></div> 
         <jsp:include page="../pager.jsp">
			<jsp:param name="otherQueryArg" value="ticketId=${param.ticketId}" />
		</jsp:include>
        <div class="clear"></div>  
    </div>
    	     
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