<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.bjwg.main.util.ToolKit"%>
<%  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<!-- 导入 -->

<!doctype html>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <title>用户反馈</title>
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/module.css">
		<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<style>
		.feedback_content { width: 100%; overflow: hidden;}
		.opinion { width: 94%; padding: 10px 10px 0;}
		.feed_phone { padding-left: 10px;}
	</style>
 </head>
    
    <body>
    	<div class="head">
            <a href="javascript:history.back(-1)" class="head_back">
            	<img src="<%=basePath %>resources/images/back.png" alt="返回">
            </a>
            <p>用户反馈</p>
        </div>
       <form action="" method="post" id="back_form">
            <div class="feedback_content">
<!--                <textarea class="opinion" placeholder="感谢您提出的宝贵意见"></textarea>-->
	    		<textarea class="opinion" id="content" name="content" placeholder="亲爱的用户，您好！欢迎您留下对我们宝贵的意见，帮助我们更好的改进我们的产品，谢谢！"></textarea>
                <input type="tel" class="feed_phone" name="linkType" placeholder="请输入您的手机号或者邮箱，方便我们联系您">
                <input type="button" class="feed_button" value="提交"  id="setting_submit">
            </div>
        </form>
    </body>
</html>
    <!--
		<div class="head">
	        <a href="<%=basePath%>index/storeMe" target="_self" class="head_back">
	        	<img src="<%=basePath %>resources/images/back.png" alt="返回">
	        </a>
	        <p>用户反馈</p>
	    </div>
	    <form action="" method="post" id="back_form">
	    	<input type="hidden" name="userId" value="${userId}" />
		    <div class="feedback_content">
		    	<textarea class="opinion" id="content" name="content" placeholder="亲爱的用户，您好！欢迎您留下对我们宝贵的意见，帮助我们更好的改进我们的产品，谢谢！"></textarea>
		        <input type="button" class="feel_button" value="提交" id="setting_submit">
		    </div>
	    </form>
	    <ul class="content">
	    	<li class="mb20"><a href="javascript:;"><textarea class="opinion" id="content" name="content" placeholder="亲爱的用户，您好！欢迎您留下对我们宝贵的意见，帮助我们更好的改进我们的产品，谢谢！"></textarea></a></li>
	        <li class="mb20"><a href="javascript:;"><input class="contact" type="tel" name="linkType" id="" name="" placeholder="请填写您的手机号或邮箱，以便我们联系您。"></a></li>
	        <li><a href="javascript:;"><input type="submit" class="tijiao" value="提交" id="setting_submit" ></a></li>
	    </ul>
 	-->
 <script type="text/javascript">
 /*$(function(){
	if(/MicroMessenger/i.test(navigator.userAgent)){
		$(".head").css('display','none');
	}else if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
	
					
	}else {
		$(".head").css('display','none');
	}
});*/
$(document).ready(function(){
	 $('#setting_submit').click(function(){
	 	var content = $('#content').val();
        if (!$.trim(content)) {
            alert("请填写你的意见！");
            $('#content').focus();
            return false;
        }
         //接口
        var path = '<%=basePath%>main/user/saveOpinion';
 		$('#back_form').attr("action", path).submit();
    }); 
});
 </script>
</body>
<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>

