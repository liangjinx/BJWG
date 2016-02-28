<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="myTags" uri="my-taglib" %>
<%   
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
	request.setAttribute("basePath",basePath);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 导入 -->
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>个人中心</title>

<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>

<style type="text/css">
    .top { width: 100%; height: 131px; border: none; background-color: #fa4953;}
    .user_box { width: 85px; height: 85px; margin: 0 auto; padding-top: 15px; /*text-align: center;*/}
	.user_box a { position: relative; display: inline-block; width: 80px; height: 80px;}
	.user_box .p_img { width: 80px; height: 80px; /*border: 2px solid #fff;*/ border-radius: 50%; -webkit-border-radius: 50%; -moz-border-radius: 50%;}
    /*.user_box .p_name { font-size: 1.6rem; color: #fff;}
    .change { position: absolute; bottom: 20px; right: 23%; width: 20px; height: 20px;}*/
	.change { position: absolute; bottom: -4px; right: -10px; display: none; width: 20px; height: 20px;}
    .change img { width: 20px;}
	.top .p_name { margin-top: 5px; font-size: 1.6rem; color: #fff; text-align: center;}
    .p_content { width: 100%; overflow: hidden;}
    .aboutg li, .aboutg1 li {  position: relative; height: 50px; line-height: 50px; background-color: white;}
    .aboutg li img, .aboutg1 li img { width: 35px;}
    .aboutg li .left-img, .aboutg1 li .left-img { display: block; float: left;}
    .aboutg { margin-bottom: 80px;}
    .aboutg li { width: 100%; border-bottom: 1px solid #efefef;}
    .aboutg li .left-img { margin: 8px 15px 7px;}
    .aboutg li:first-child { border-top: 1px solid #efefef !important;}
    .aboutg li:last-child { border-bottom: none;}
    .aboutg li .font-span, .aboutg1 li .font-span { font-size: 1.6rem; color: #322c2c;}
    .aboutg li .right-arrows { width: 10px; height: auto; position: absolute; right: 15px; top: -1px;}
    .right-arrows img { width: 10px !important; padding-top: 18px; /*vertical-align: middle;*/}
    .aboutg1 { overflow: hidden;}
    .aboutg1 li { float: left; width: 50%; border-bottom: none;}
    .aboutg1 li .left-img { margin: 8px 15px 7px 50px;}
    .aboutg1 .p1, .aboutg1 .p11 { position: absolute; top: 5px; left: 93px; font-size: 1.6rem;}
    .aboutg1 .p2, .aboutg1 .p22 { position: absolute; bottom: 5px; left: 93px; width: auto; text-align: center; color: #ffb402 !important;}
    .aboutg1 .p2 em, .aboutg1 .p22 em { font-size: 1.3rem;}
    .aboutg1 .p2 em { padding-left: 10px;}
    .aboutg1 .p1, .aboutg1 .p2, .aboutg1 .p11, .aboutg1 .p22 { height: 20px; line-height: 20px; color: #322c2c;}
    .toevaluate { position: absolute; right: 30px; top: 0; font-size: 1.4rem; color: #ffb402;}
    .toevaluate b { margin-right: 2px; font-size: 1.3rem;}
    .nav { position: fixed; bottom: 0; left: 0; width: 100%; height: 55px; background-color: white;}
    .nav ul li { float: left; width: 20%; height: 55px; font-size: 1.1rem; color: #858386; text-align: center;}
    .nav ul li img { width: 30px; margin-top: 5px;}
    .wd_record { position: absolute; top: 0; right: 0; width: 50px; height: 50px; font-size: 1.4rem; color: #fff; text-align: center;}
	.wd_record img { width: 22px; padding-top: 15px; vertical-align: middle;}
	.wd_record span { padding-left: 5px;font-size: 1.2rem; color: #fff; text-align: center;}
	.wd_record .new_message { position: absolute; top: 10px; right: 10px; width: 10px; height: 10px; border-radius: 50%; -webkit-border-radius: 50%; -moz-border-radius: 50%; background-color: #f42a02;}
	.bigbox { width: 80px; height: 80px; border: 2px solid #fff; border-radius: 50%; -webkit-border-radius: 50%; -moz-border-radius: 50%;}
	.new_function { position: absolute; right: 45px; top: 0; font-size: 1.4rem; color: red; -webkit-animation: 1.5s shadow infinite; animation: 1.5s shadow infinite;}
	@-webkit-keyframes shadow{
		0% { opacity: 1;}
		20% { opacity: .5;}
		40% { opacity: .3;}
		60% { opacity: .5;}
		100% { opacity: 1;}
	}
	@keyframes shadow{
		0% { opacity: 1;}
		20% { opacity: .5;}
		40% { opacity: .3;}
		60% { opacity: .5;}
		100% { opacity: 1;}
	}
</style>

<c:choose>
     <c:when test="${requestScope.switch_str=='close'}">
            <style type="text/css">		
				.footer{ height:55px; bottom:0; border-top:1px solid #e7e7e7; background:#fff;}
				.footer a{ width: 25%; float:left; text-align:center; color:#868686; font-size:1.1rem;}
				.footer a:before{ content:''; display:block; height:30px; width:31px; margin:4px auto 2px;}
				.footer a:nth-child(1):before{ background:url(/resources/images/home_18.png) no-repeat center center;}
				.footer a:nth-child(2):before{ background:url(/resources/images/home_19.png) no-repeat center center;}
				.footer a:nth-child(3):before{ background:url(/resources/images/home_21.png) no-repeat center center;}
				.footer a:nth-child(4):before{ background:url(/resources/images/home_24.png) no-repeat center center;}
				.footer a:nth-child(1n):before{ background-size: 30px auto;}
				.footer a:nth-child(3):before{ background-size:30px auto;}
			</style>
	  </c:when>
	  <c:otherwise>
	  		<style type="text/css">
				.footer{ height:55px; bottom:0; border-top:1px solid #e7e7e7; background:#fff; box-sizing:border-box; -webkit-box-sizing:border-box;}
				.footer a{ width:25%; float:left; text-align:center; color:#868686; font-size:1.1rem;}
				.footer a:before{ content:''; display:block; height:30px; width:30px; margin:4px auto 2px;}
				.footer a:nth-child(1):before{ background:url(/resources/images/home_18.png) no-repeat center center;}
				.footer a:nth-child(2):before{ background:url(/resources/images/home_19.png) no-repeat center center;}
				.footer a:nth-child(3):before{ background:url(/resources/images/home_21.png) no-repeat center center;}
				.footer a:nth-child(4):before{ background:url(/resources/images/home_24.png) no-repeat center center;}
				.footer a:nth-child(1n):before{ background-size:30px auto;}
			</style>
	  </c:otherwise>
</c:choose>


</head>

<body>

	<header class="head">
        <a href="<%=basePath %>wpv/ixhome" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
        <p>我的猪场</p>
    </header>
    <div class="top">
        <div class="user_box">
            <a href="<%=basePath %>wpv/uruserInfo">
            	 <c:choose>
                	<c:when test="${session_manager.headImg != null}">
                		<div class="bigbox">
							<img src="${session_manager.headImg}" alt="个人头像" class="p_img">
						</div>
                	</c:when>
                	<c:otherwise>
                		<div class="bigbox">
							<img src="<%=basePath %>resources/images/defaul_headurl.png" alt="个人头像" class="p_img">
						</div>
                	</c:otherwise>
                </c:choose>
               
                <div class="change">
                    <img src="<%=basePath %>resources/images/personalcenter_5.png" alt="修改个人资料">
                </div>
            </a>
        </div>
        <p class="p_name">
        	<c:choose>
        		<c:when test="${fn:length(session_manager.username) > 11 }">
          			${fn:substring(session_manager.username,0,11)}
        		</c:when>
        		<c:otherwise>
        			${session_manager.username }
        		</c:otherwise>
        	</c:choose>
        </p>
    </div>
    <div class="p_content">
        <ul class="aboutg1 mb10">
            <a href="<%=basePath %>wpv/wlmyWallet">
	            <li>
	                <img class="left-img" src="<%=basePath %>resources/images/personalcenter_7.png" alt="我的钱包">
	                <p class="p11">我的钱包</p>
	                <p class="p22">￥<em>0</em></p>
	            </li>
            </a>
            <a href="<%=basePath%>balance/myWallet">
	            <li>
	                <img class="left-img" src="<%=basePath %>resources/images/personalcenter_7.png" alt="我的钱包">
	                <p class="p11">我的猪仔</p>
	                <p class="p22">￥<em>0</em></p>
	            </li>
            </a>
            <a href="<%=basePath%>balance/myWallet">
	            <li>
	                <img class="left-img" src="<%=basePath %>resources/images/personalcenter_7.png" alt="我的钱包">
	                <p class="p11">我的收益</p>
	                <p class="p22">￥<em>0</em></p>
	            </li>
            </a>
        </ul>
        <ul class="aboutg">
			<a href="<%=basePath %>wpv/urpersonalMsg">
				<li>
                    <img class="left-img" src="<%=basePath %>resources/images/personalcenter_22.png" alt="我的活动">
                    <div class="font-span">消息</div>
                    <div class="toevaluate">${userCenter.msgUnReadNum }</div>
                    <div class="right-arrows"><img src="<%=basePath %>resources/images/personalcenter/personalcenter_13.png" alt="箭头"></div>
            	</li>
            </a>
            <a href="<%=basePath %>wpv/orderList">
	            <li>
	                <img class="left-img" src="<%=basePath %>resources/images/personalcenter_9.png" alt="我的订单">
	                <div class="font-span">我的订单</div>
	                <div class="toevaluate"></div>
	                <div class="right-arrows"><img src="<%=basePath %>resources/images/personalcenter_13.png" alt="箭头"></div>
	            </li>
            </a>
            
            <a href="<%=basePath%>index/manage">
            	<li class="mb10">
		            <img class="left-img" src="<%=basePath %>resources/images/personalcenter_11.png" alt="管理店铺">
	                <div class="font-span">我的猪肉券</div>
	                <div class="new_function"></div>
	                <div class="right-arrows"><img src="<%=basePath %>resources/images/personalcenter_13.png" alt="箭头"></div>
	            </li>
		    </a>
            <a href="<%=basePath%>index/manage">
            	<li class="mb10">
		            <img class="left-img" src="<%=basePath %>resources/images/personalcenter_11.png" alt="管理店铺">
	                <div class="font-span">我要预抢</div>
	                <div class="new_function"></div>
	                <div class="right-arrows"><img src="<%=basePath %>resources/images/personalcenter_13.png" alt="箭头"></div>
	            </li>
		    </a>
            <a href="<%=basePath %>wpv/wlMyFinancing">
            	<li class="mb10">
		            <img class="left-img" src="<%=basePath %>resources/images/personalcenter_11.png" alt="管理店铺">
	                <div class="font-span">我的理财</div>
	                <div class="new_function"></div>
	                <div class="right-arrows"><img src="<%=basePath %>resources/images/personalcenter_13.png" alt="箭头"></div>
	            </li>
		    </a>
            <a href="<%=basePath %>wpv/ursetting">
            	<li>
	                <img class="left-img" src="<%=basePath %>resources/images/personalcenter_12.png" alt="设置">
	                <div class="font-span">系统设置</div>
	                <div class="right-arrows"><img src="<%=basePath %>resources/images/personalcenter_13.png" alt="箭头"></div>
            	</li>
            </a>
            <a href="<%=basePath%>main/user/setting">
            	<li>
	                <img class="left-img" src="<%=basePath %>resources/images/personalcenter_12.png" alt="设置">
	                <div class="font-span">服务热线</div>
	                <div class="right-arrows"><img src="<%=basePath %>resources/images/personalcenter_13.png" alt="箭头"></div>
            	</li>
            </a>
        </ul>
    </div>
    <jsp:include page="../common/commonTip.jsp"></jsp:include>
    <jsp:include page="../footer.jsp"></jsp:include>
    
</body>
</html>

