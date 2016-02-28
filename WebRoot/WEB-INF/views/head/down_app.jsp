<%@page import="java.net.URLDecoder"%>
<%@page import="com.bjwg.main.util.StringUtils"%>
<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
 	/*String downloadUrl = request.getParameter("downloadUrl");
 	if(StringUtils.isNotEmpty(downloadUrl)){
 		downloadUrl = URLDecoder.decode(downloadUrl);
 		request.setAttribute("downloadUrl",downloadUrl);
 	}*/
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title></title>
<style>
	.foot { position: fixed; bottom: 0; left: 0; width: 100%; height: 70px; background: #fff1bb; z-index: 2;}
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
<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
</head>

<body>
<div class="foot">
 	<div class="container">
         <div class="logo_box">
             <div class="logo_pic"><img src="<%=basePath %>resources/images/logo_m.png" alt="好站点Logo"></div>
             <div class="text_two"><img src="<%=basePath %>resources/images/txt_2.png" alt="好站点，您身边的上门服务."></div>
         </div>
         <div class="download">
             <a href="http://wx.hzd.com/download.jsp">
                 <div class="downlaod-box">下载 </div>
             </a>
         </div>
     </div>
 </div>
<script type="text/javascript">
	$(document).ready(function() {
	    var ua = navigator.userAgent.toLowerCase();
	 	//微信进入的
	    if(ua.match(/MicroMessenger/i)=="micromessenger") {
	    	$(".foot").css("display","none");
	     } else {
	     	//$("body").css("background","#484848");
	     	//是安卓或uc浏览器 
	     	if(ua.indexOf('android') > -1 || ua.indexOf('linux') > -1){
	     		 return true;
	     	//ios终端 
	     	}else if(ua.indexOf('iphone') > -1 || ua.indexOf('ipad') > -1 || !!ua.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)){
	     		return true;
	     		//alert("ios");
	     		if(ua.match(/qq\//)){
	     		}
	     	}else{
	     		return true;
	     	}
	     }
	});
 
 
</script>

</body>
</html>
