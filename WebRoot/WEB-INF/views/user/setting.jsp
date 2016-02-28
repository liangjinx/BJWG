<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>设置</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/compilations_pz.css">
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<p class="z_h10">&nbsp;</p>
		 <div class="p_content">
           	<a href="<%=basePath %>wpv/uamanageList?pageSource=50001">
            	<div class="content_box">
            		<div class="p_font">收货地址管理</div>
            		<div class="right_arrows">
            			<img src="<%=basePath %>resources/images/brown-arrow-w24.png" alt="">
            		</div>
            	</div>
           	</a>
           	<a href="<%=basePath %>wpv/uruserInfoModifyPage?r_type=2">
        		<div class="content_box">
        			<div class="p_font">手机绑定</div>
        			<div class="right_arrows">
        				<img src="<%=basePath %>resources/images/brown-arrow-w24.png" alt="">
        			</div>
        			<div class="right_phone">${session_manager.bindPhone }</div>
        		</div>
        	</a>
           	<a href="<%=basePath %>wpv/urloginPasswordPage">
            	<div class="content_box">
            		<div class="p_font">修改登录密码</div>
            		<div class="right_arrows">
            			<img src="<%=basePath %>resources/images/brown-arrow-w24.png" alt="">
            		</div>
            	</div>
           	</a>
        </div>
        <jsp:include page="../back.jsp">
			<jsp:param value="wpv/urstoreMe" name="backUrl"/>
		</jsp:include>
	</body>
</html>
