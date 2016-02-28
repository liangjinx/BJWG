<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="收益记录" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script src="resources/js/pc/highcharts.js"></script>
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
	<jsp:param value="1" name="nav"/>
</jsp:include>
<!--mypig_left_nav -->
<div class="right_main">
	<div class="my_pig_tit bg_f6"><!--my_pig_tit -->
    	<img src="resources/images/pc/nav_tit_bg.png" alt="我的现金收益"/>
        <div class="pig_tit"><p>我的现金收益</p></div>
    </div><!--my_pig_tit -->
    <div class="mypig_body bottom4">
    	<div class="earnings_list_box">
        	<p class="p1">收益记录</p>
            <p class="p2"><%-- ${average } --%>9.6%</p>
            <p class="p3">往期平均年化收益率</p>
        </div>
        <div class="clear"></div>
    </div><!--mypig_body -->
    <div class="earnings_list">
    	<p class="f_left">项目期数</p><p class="f_right">总收益</p>       
    </div>
     <ul class="revenue_ul">
     	<c:choose>
    		<c:when test="${list != null }">
    			<c:forEach items="${list }" var="l">
    				<li>
            			<div class="revenue_p_box">
                			<span class="f_lt">${l.paincbuyProjectName }</span><span class="f_rt"><span class="percent">${l.rate }</span>%</span>
                    		<div class="clear"></div>
                		</div>
                		<div class="pmgress_bar"></div>
            		</li>
    			</c:forEach>
    		</c:when>
    		<c:otherwise>
    			<li>您暂时还没有收益记录</li>
    		</c:otherwise>
    	</c:choose>
        </ul>
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
$(function(){
	var per;//百分比
	 
	 $(".revenue_ul li").each(function(){ 
	 	per = $(this).find('.percent').text();
	 	$(this).find('.pmgress_bar').animate({width: (per+'%')}, "slow");
	  });
	})

</script>
</html>




<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>历史收益</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	

  </head>
  
  <body>
    <h3>历史收益</h3>
    <div>
    	<div>年化收益率:${average }%</div>
    	<c:choose>
    		<c:when test="${list != null }">
    			<c:forEach items="${list }" var="l">
    				<div>${l.paincbuyProjectName } ${l.rate }%</div>
    			</c:forEach>
    		</c:when>
    		<c:otherwise>
    			您暂时还没有收益记录
    		</c:otherwise>
    	</c:choose>
    </div>
  </body>
</html>
-->