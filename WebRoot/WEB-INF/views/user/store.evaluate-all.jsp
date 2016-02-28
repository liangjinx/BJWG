<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>

<!doctype html>
<html lang=zh-CN>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=0.5,minimum-scale=0.5,maximum-scale=0.5, user-scalable=no">
<title>全部评价</title>

<style>
	.head em{ padding-left: 2px;}
	.write-eval{ position: absolute; top: 25px; right: 25px; display: block; height: 30px; line-height: 30px; padding: 3px 15px; font-size: 24px; border: 1px solid #272728; border-radius: 8px; color: #272728;}
	/**/
	.content{ width: 100%; background-color: white; overflow: hidden;}
	.content ul{ width: 100%; margin-top: 6px; border-bottom: 1px solid #d5d4d6;}
	.content .fir-li{ width: 90%; margin: 15px auto 0; height: 58px; line-height: 48px;}
	.content .fir-li img{ width: 52px; height: 52px; padding: 3px; vertical-align: bottom; border-radius: 50%; -webkit-border-radius: 50%; -moz-border-radius: 50%;}
	.content .fir-li .eva-name{ font-size: 24.72px; padding-left: 15px; color: #272728;}
	.content .fir-li .eva-time{ float: right; height: 33px; line-height: 33px; font-size: 17.98px; color: #858585;}
	.content .sec-li{ width: 85%; margin: 0 auto; height: 37px; line-height: 37px;}
	.content .sec-li .eva-comment{ color: #392f3c;}
	.content .sec-li .mr3{ margin-right: 3px;}
	.content .sec-li .eva-comment, .content .thr-li{ margin: 0 auto; font-size: 18px;}
	.content .thr-li{ width: 85%; padding-bottom: 30px; color: #858585;}
</style>
</head>

<body>
	<div class="head">
    	<a class="head-back" href="javascript:history.back(-1)"><img src="<%=basePath %>resources/images/head-back.png"></a>
        <p>全部评价<em class="">( ${evaluates} )</em></p>
        <a class="write-eval" href="<%=basePath%>comment/getEvaluate?id=${shopId}">写评价</a>
    </div>
    <div class="content">
    	
    	<c:forEach items="${comments}" var="comm">
    		<ul>
	            <li class="fir-li">
                   <img src="<%=basePath%>${comm.headImg }">
                   <span class="eva-name">${comm.username }</span>
                   <span class="eva-time"><fmt:formatDate value='${comm.ctime }' pattern='yyyy-MM-dd HH:mm:ss' /></span>
                </li>
	            
	            <li class="sec-li">
                   <div class="eva-comment">
                      	<span class="mr3">质量<em>${comm.quality }</em></span>
                        <span class="mr3">速度<em>${comm.speed }</em></span>
                        <span class="mr3">服务<em>${comm.service }</em></span>
                        <span class="mr3">态度<em>${comm.attitude }</em></span>
                   </div>
               </li>
               <li class="thr-li">${comm.content }</li>
       		</ul>
    	</c:forEach>
        
    </div>
</body>
<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>
