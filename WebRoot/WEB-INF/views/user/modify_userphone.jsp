<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
        <title>设置-手机绑定</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/compilations_pz.css">
	</head>
	<body>
		<div class="setting_phone_content">
        	<div class="setting_use_phone">
            	<div class="z_setting_phone">已绑定手机</div>
                <div class="setting_phone_number" id="phone_number">
	                <c:if test="${session_manager.bindPhone != null }">
	             		<c:set var="phone" value="${fn:substring(session_manager.bindPhone, 0, 3)}*****${fn:substring(session_manager.bindPhone, 7,fn:length(session_manager.bindPhone))}"></c:set>
	             		${phone}
	             	</c:if>
                </div>
            </div>
			<a href="<%=basePath %>wpv/urphoneChangePage1">
                <div class="setting_change_phone">
                    <div class="z_setting_phone">更换绑定手机</div>
                    <div class="bin_arrow_right">
                    	<img src="<%=basePath %>resources/images/brown-arrow-w24.png" alt="箭头">
                    </div>
                </div>
            </a>
        </div>
        <jsp:include page="../back.jsp">
			<jsp:param value="wpv/ursetting" name="backUrl"/>
		</jsp:include>
    </body>
</html>