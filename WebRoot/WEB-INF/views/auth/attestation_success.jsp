<%@page import="com.bjwg.main.constant.CommConstant"%>
<%@page import="com.bjwg.main.util.MyUtils"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//JSONObject jsonObject = MyUtils.appParamsToJsonFromSession(request, CommConstant.SESSION_APP_PARAM);
//String source = jsonObject.optString(CommConstant.SOURCE);					
//String redirectUri = jsonObject.optString(CommConstant.REDIRECT_URL);
//String script = "";		
//if("1".equals(source)){
	//script = "<script>appInvoke(3,'"+redirectUri+"')</script>";
//}			
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>认证提交成功页面</title>
    
    <meta http-equiv="content-type" content="text/html" charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="好站点,认证提交成功">
	<meta http-equiv="description" content="认证提交成功页面">
	
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
	<!--[if IE]> 
    	<link href="<%=basePath %>resources/css/ie.css" rel="stylesheet">
    <![endif]-->
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/attestation.css">
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	
  </head>
  <body>
  	<div class="main">
	  	<div class="head">
	        <a href="<%=basePath%>index/home" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
	        <p>我要开店</p>
	    </div>
	    <div class="stshop_content">
	        <p class="succeed">恭喜！您的资料已经提交审核</p>
	        <p class="remind">请耐心等待，我们工作人员会在3个工作日内审核完毕</p>
	    </div>
	</div>
	
  </body>
  <script language="javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
  <script language="javascript">
	/*$(function(){
		if(/MicroMessenger/i.test(navigator.userAgent)){
			$(".head").css('display','none');
		}else if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
		
						
		}else {
			$(".head").css('display','none');
		}
	});
	*/
	$(function(){
		//2秒自动跳转
		appInvoke(2,'appInvoke');
	});
	function appInvoke(time,obj){
		if(--time>0){
			setTimeout("appInvoke("+time+",'"+obj+"')",1000);
		}else{
			if('${requestScope.re}' != ''){
				if('${requestScope.re}'== '0'){
					window.location.href='<%=basePath%>index/goodsDetailShop?id=${shopId}&type=2';
				}else if('${requestScope.re}'== '1'){
					window.location.href='<%=basePath%>index/manage';
				}
			}
		}
	} 
  </script>
  <jsp:include page="../head/hideHead.jsp"></jsp:include>
  <jsp:include page="../head/down_app.jsp"></jsp:include>
</html>
