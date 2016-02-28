<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="移动端" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="./meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
</head>
<body>
<!--banner_box -->
<jsp:include page="header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="nav.jsp">
	<jsp:param value="1" name="nav"/>
</jsp:include>
<!-- 导航栏-->
<!--中间部分 -->
<div class="clear"></div>
<div class="pigfarm_box">
	<div class="center">
    	<div  class="pigfarm_tit"><img src="resources/images/pc/pig_tit.png" alt="这个猪场被我承包了"/></div>
        <div class="pigfarm_phone">
        	<img src="resources/images/pc/phone_img3.png" alt=""/>
        	<!--<iframe src="http://wx.bajiewg.com/wpnv/ixhome" class="z_iframe_s"></iframe>
        -->
        	<iframe src="http://wx.bajiewg.com/wpnv/ixhome" class="z_iframe_s"></iframe>
        </div>
    </div>
</div>
<div class="clear"></div>
<!--中间部分 -->
<!--底部 -->
<jsp:include page="footer.jsp"></jsp:include>
<!--底部 -->
</body>
<script>

</script>

</html>

