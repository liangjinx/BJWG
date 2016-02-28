<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setAttribute("confirmFunc",request.getParameter("confirmFunc"));
%>


<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta http-equiv="Pragma" content="no-cache" />
	<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
	 <link rel="stylesheet" href="<%=basePath%>resources/css/compilations_pz.css" />
	<style type="text/css">
		/*输入支付密码*/
       	.pay_password_box, .pay_password_box3 { position: fixed; top: 50%; left: 50%; display: none; width: 90%; height: auto; border: 1px solid #dedede; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; background-color: #fff; z-index: 100; transform: translate(-50%,-50%); -webkit-transform: translate(-50%,-50%); -moz-transform: translate(-50%,-50%); -ms-transform: translate(-50%,-50%);}
		.password_box_container { width: 92%; margin: 0 auto; overflow: hidden;}
		.password_box_top { padding: 10px 0 14px; font-size: 1.6rem; color: #615868;}
		.password_box_bottom { width: 100%; height: 60px; line-height: 60px; text-align: center;}
		.password_box2 { position: relative; width: 231px; height: 40px; margin: 10px auto; font-size: 1.6rem; border: 1px solid #dedede; -webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; background-color: #fff;}
		.password_input { width: 100%; height: 40px; padding-left: 15px; font-size: 1.5rem; border: none; background-color: transparent; letter-spacing: 28px;}
		/*确认按钮*/
		.quxiao, .queren, .queren2 { width: 100px; height: 45px; line-height: 45px; margin-bottom: 10px; font-size: 1.6rem; text-align: center; border: none; -webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px;}
		.queren { color: #fff; background-color: #3dbd6d;}
		.quxiao { margin-right: 15px; color: #615868; background-color: #dedede;}
		.z_colse { width: 18px;}
		.password_box_top3 { font-size: 1.6rem; text-align: left; padding: 21px 0 45px;}
		.password_box_content3 { text-align: right;}
		.quxiao3, .queren3 { width: 90px; height: 40px; line-height: 40px; margin-bottom: 10px; font-size: 1.6rem; color: #ff6600; text-align: center; border: none; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; background: transparent;}
		.mark { position: fixed; left: 0; right: 0; top: 0; bottom: 0; display: none; width: 100%; height: 100%; background: rgba(0,0,0,.1); z-index: 99;}
	</style>
	<title> 我的银行卡-提现成功 </title>
</head>
<body class="bg-gray">
			<div class="pay_password_box">
            	<div class="password_box_container">
            		<div class="password_box_top">请输入支付密码<img src="<%=basePath%>resources/images/layer-close.png" class="z_colse f_r" onclick="hidePayPwd();"/></div>
            		<div class="password_box_content">
            			<div class="password_box2">
            				<input type="password" class="password_input" maxlength="6" name="password" id="password" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
            			</div>
            		</div>
            		<div class="password_box_bottom">
            			<input type="button" class="quxiao" value="取消" onclick="hidePayPwd();" />
            			<input type="button" class="queren" value="确认" id="confirmBtn" />
            		</div>
            	</div>
            </div>
            <!--输入的支付密码错误弹出的提示框 -->
            <div class="pay_password_box3" id="pwd_error_div">
            	<div class="password_box_container">
	            	<div class="password_box_top3">支付密码错误,请重试</div>
	            	<div class="password_box_content3">
	            			<input type="button" class="quxiao3" value="重试" onclick="showPayPwd()"/>
	            		<a href="<%=basePath%>wpv/wlpayPasswordForget">
	            			<input type="button" class="queren3" value="忘记密码"/>
	            		</a>
	            	</div>
	            </div>
            </div><!--/pay_password_box3-->
        	<div class="mark"></div>
</body>
</html>
<script type="text/javascript">
<!--
	//显示输入支付密码框
	function showPayPwd(){
		$(".pay_password_box, .mark").show();
		$(".pay_password_box3").hide();
		confirmBtn();
	}
	//显示错误提示框
	function showPayPwdError(){
		$(".pay_password_box").hide();
		$(".pay_password_box3, .mark").show();
	}
	//取消隐藏提示框
	function hidePayPwd(){
		$(".pay_password_box,.pay_password_box3, .mark").hide();
	}
	//传递方法名称执行相应的方法
	function backCall(obj){
		var password = $("#password").val();
		if(password =='' || password.length < 6){
			alert("请输入6位支付密码");
			return 
		}
		obj();
	}
	//设置确认按钮绑定时间
	function confirmBtn(){
		$("#confirmBtn").unbind("click");
		$("#confirmBtn").bind("click",function(){
			backCall(${confirmFunc});
		});
	}
//-->
</script>


