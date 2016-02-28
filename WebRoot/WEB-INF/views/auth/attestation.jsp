<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
    <title>店铺认证入口页面</title>
    
    <meta http-equiv="content-type" content="text/html" charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="好站点,店铺认证,个人认证,企业认证">
	<meta http-equiv="description" content="店铺认证入口页面">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
	<!--[if IE]> 
    	<link href="<%=basePath %>resources/css/ie.css" rel="stylesheet">
    <![endif]-->
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/attestation.css">
	<style>
		.foot { position: fixed; bottom: 0; left: 0; width: 100%; height: 70px; background: #fff1bb;}
		.logo_box { float: left; width: 50%; text-align: center;}
		.logo_pic { width: 30%;}
		.text_two { width: 58%; padding-left: 12px;}
		.logo_box, .download { height: 70px;}
		.logo_box { margin-top: 5px;}
		.logo_pic, .text_two {  display: inline-block;} 
		.logo_pic img, .text_two img { max-width: 100%;}
		.logo_pic img { padding-left: 5px;;}
		.download { float: right; width: 45%; margin-top: 5px;}
		.downlaod-box{ width: 80px; margin: 10px auto 0; padding: 8px; font-size: 1.7rem; color: #fff; text-align: center; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; -o-border-radius: 3px; background: #0f0e0b;}
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
		function setType(type){
			$("#type").val(type);
			$("#projectForm").submit();
		}
	</script>
  </head>
  
  <body>
  	<div class="head">
        <a href="javascript:history.back(-1)" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
        <p>店铺认证</p>
    </div>
    
    <form action="<%=basePath%>auth/gotoAuthPage" method="post" id="projectForm" name="projectForm">	
    	
    	<input type="hidden" name="type" id="type">
    	<input type="hidden" name="shopId" id="shopId" value="${requestScope.shopId }">
    	<!--<input type="hidden" name="redirectUri" id="redirectUri" value="${requestScope.redirectUri }">
    	
	    --><div class="ren_content">
	        <a href="javascript:setType(1);">
	        	<div class="personage_box">
	            	<p class="f_personage">个人认证</p>
	        	</div>
	        </a>
	        <a href="javascript:setType(2);">
	        	<div class="enterprise_box">
	            	<p class="f_enterprise">商家认证</p>
	        	</div>
	        </a>
	    </div>
    </form>
    
  </body>
  <jsp:include page="../head/hideHead.jsp"></jsp:include>
  <jsp:include page="../head/down_app.jsp"></jsp:include>
</html>
