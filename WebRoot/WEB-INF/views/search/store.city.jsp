<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=0.5,minimum-scale=0.5,maximum-scale=0.5, user-scalable=no">
<title>选择城市</title>

<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout.css">

<style type="text/css">
	.content{ width: 100%; margin-bottom: 50px; background-color: white; overflow: hidden;}
	.content li, .content .provincebox{ margin: 0 auto; height: 80px; line-height: 80px;}
	.content li{ width: 100%; text-align: left; border-bottom: 1px solid #dfdfdf;}
	.content .provincebox{ display: block; width: 90%; position: relative;}
	.content .province{ float: left; font-size: 22px; color: #272728;}
	.content .province02{ width: 90%; margin: 0 auto; height: 80px; line-height: 80px; font-size: 22px; color: #272728;}
	.content .present{ padding-left: 24px; font-size: 18px; color: #858585;}
	.content .address-map{ position: absolute; top: 27px; right: 0;}
	/*sundry*/
	.color-dfdfdd{ width: 100% !important; background-color: #dfdfdd;}
</style>
</head>

<body>
	<div class="head">
    	<a class="head-back" href="javascript:history.back(-1)"><img src="<%=basePath %>resources/images/head-back.png"></a>
        <p>选择城市</p>
    </div>
    <ul class="content">
    	<!--<li><a class="provincebox"><p class="province">深圳</p><span class="present">当前定位</span><img class="address-map" src="<%=basePath %>resources/images/map-icon.png"></a></li>
        <li class="color-dfdfdd"><p class="province02">选择城市</p></li>
        -->
        <%--v1
        <c:forEach items="${citys}" var="city">
        	<li><a class="provincebox" href="javascript:city_name('${city.code}','type');"><p class="province">${city.name}</p><img class="address-map" src="<%=basePath %>resources/images/province-arrow.png"></a></li>
    	</c:forEach>
        --%>
        <!--v2-->
        <c:forEach items="${citys}" var="city">
        	<li><a class="provincebox" href="javascript:city_name('${city.areaId}','${type}','${city.parent}');"><p class="province">${city.name}</p><img class="address-map" src="<%=basePath %>resources/images/province-arrow.png"></a></li>
    	</c:forEach>
    </ul>
<script type="text/javascript">

function city_name(code,type,parent){
//	alert(type);
	if(type == 'weizhang')
	{
		window.location.href ='<%=basePath%>box/weizhangArea?city_id='+code+'&parent='+parent;  
	}else {
		window.location.href ='<%=basePath%>index/main/index?city_id='+code+'&type='+type;
	}
	  
}	

</script>
</body>
</html>