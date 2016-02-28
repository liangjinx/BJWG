<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html>
<html>
	<head>
		<title>忘记密码</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
		<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
		<style>
        	.amend_content { width: 100%; padding-bottom: 20px; background-color: #fff; overflow: hidden;}
	        .mb_pay_tip { margin: 10px auto 15px;}
	       	.mb_pay_tip p { margin: 0 5px; font-size: 1.5rem; color: #858386;}
	       	.amend_container { width: 90%; margin: 0 auto;}
	       	.amend_tips { float: left; margin: 0 5px; font-size: 1.4rem; color: #322c2c;}
	       	.amend_password_box { width: 80%; height: 50px; line-height: 50px; margin: 0 auto; text-align: center;}
			.amend_bton { width: 100%; height: 40px; line-height: 40px; margin-top: 40px; font-size: 1.6rem; color: white; text-align: center; border: 1px solid #efefef; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; background-color: #ffb400;}
			.amend_password_box2 { width: 100%; height: 40px; line-height: 40px; margin: 0 auto; margin-top: 10px; font-size: 1.6rem;}
	       	.am_password { width: 55%; height: 30px; line-height: 30px; padding-left: 15px; font-size: 1.5rem; border: 1px solid #dedede; border-radius: 3px; -webkit-border-radius: border-radius: 3px; -moz-border-radius: 3px; background-color: #fff; letter-spacing: 17px;}
	       	.amend_container .amend_password_box2:nth-child(2) .amend_tips { margin: 0 33px 0 5px;}
	       	.amend_container .amend_password_box2:nth-child(3) .amend_tips { margin: 0 20px 0 5px;}
	       	.next_bton { display: block; width: 90%; margin: 0 auto; height: 40px; line-height: 40px; margin-top: 20px; font-size: 1.6rem; color: white; text-align: center; border: none; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; background-color: #3dbd6d;}
        </style>
	</head>
	<body>
		<form method="post" name="allProjectForm" id="allProjectForm" action="<%=basePath %>wpv/wlpayPasswordModify3">
        	<div class="amend_content">
	        	<div class="amend_container">
	        		<div class="mb_pay_tip">
	        			<p>仅用于手机支付的数字密码，以后凭该密码安全支付，请勿与登录密码设置一致</p>
	        		</div>
	        		<div class="amend_password_box2">
	        			<p class="amend_tips">新支付密码：</p>
	        			<input type="password" name="payPassword" id="payPassword" class="am_password" size="5" maxlength="6" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
	        		</div>
	        		<div class="amend_password_box2">
	        			<p class="amend_tips">重复支付密码：</p>
	        			<input type="password" name="confirmPayPassword" id="confirmPayPassword" class="am_password" size="5" maxlength="6" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
	        		</div>
	        		<input type="button" class="next_bton" value="确定" onclick="save();">
	        	</div>
	        </div>	
        </form>
	</body>
	<jsp:include page="../common/commonTip.jsp"></jsp:include>
	<jsp:include page="../back.jsp">
		<jsp:param value="wpv/wlpayPasswordModify1" name="backUrl"/>
	</jsp:include>
</html>
<script type="text/javascript">
<!--
function save(){
	var payPassword = $("#payPassword").val();
	var confirmPayPassword = $("#confirmPayPassword").val();
	if(payPassword.length < 6){
		alert("请输入6位数字的新密码");
		return ;
	}
	if(confirmPayPassword.length < 6){
		alert("请输入6位数字的确认密码");
		return ;
	}
	if(payPassword != confirmPayPassword){
		alert("新密码与确认密码两次输入不一致");
		return ;
	}
	$("#allProjectForm").submit();
}

//-->
</script>