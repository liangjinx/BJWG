<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.bjwg.main.util.ToolKit"%>
<%  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<!-- 导入 -->

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>关于我们</title>

<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout.css">
<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>

<style>
	.about_banner { display: block; width: 100%; margin-bottom: 20px;}
	.user_content { background-color: white;}
	.user_content_box { width: 92%; margin: 10px auto;}
	.user_content_box p { padding: 15px 0;}
</style>
<script type="text/javascript">
	/*$(function(){
		if(/MicroMessenger/i.test(navigator.userAgent)){
			$(".head").css('display','none');
		}else if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
		
						
		}else {
			$(".head").css('display','none');
		}
	});*/
</script>

</head>

<body>
	<div class="head">
        <a href="javascript:history.back(-1)" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
        <p>关于我们</p>
    </div>
	<div>
		<img class="about_banner" src="<%=basePath %>resources/images/about.banner.jpg">
	</div>
    <div class="user_content">
		<div class="user_content_box">
			<p>好站点 HZD.com -- 您身边的上门服务！中国领先的上门服务平台。是以用户为中心，汇聚周边能提供上门服务的商家；入驻商家包括垂直行业的商家、实体店商家，于2015年04月止已突破21万商家数量。</p>
		</div>
	</div>
    <!-- 
	<div class="head"><a class="head-back" href="javascript:history.back(-1)"><img src="<%=basePath %>resources/images/head-back.png"></a><p>关于我们</p></div>
    <img class="about-banner" src="<%=basePath %>resources/images/about.banner.jpg">
    <p class="abstract">好站点 HZD.com -- 您身边的上门服务！中国领先的上门服务平台。是以用户为中心，汇聚周边能提供上门服务的商家；入驻商家包括垂直行业的商家、实体店商家，于2015年04月止已突破21万商家数量。</p>
    <div class="foot">
    	<p class="mb15">copyright:2002-2015</p>
        <p>深圳市互联在线云计算有限公司</p>
    </div> -->
</body>
<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>

