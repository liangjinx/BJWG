<%@page import="com.bjwg.main.constant.CommConstant"%>
<%@page import="com.bjwg.main.util.MyUtils"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>


<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<meta name="keywords" content="八戒王国online">
<meta name="description" content="八戒王国online">
<meta http-equiv="Pragma" content="no-cache" />

<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/enter.css"/>
<style>
	#projectForm { height: 100%;}
	#register_body{ display:none;}
	.register_box { padding: 0;}
	.z_p5 { padding: 5px 0;}
	.show_img { position: absolute; top: 0; right: 0; width: 10%; height: 36px; margin: 5px 0px;}
	.show_img img { width: 20px; padding-top: 15px;}
	.z_login { width: 100%; height: 45px; line-height: 45px; font-size: 25px; color: #fff; text-align: center; border: none; -webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; background-color: #3dbd6d;}
	.re_or_lg_box .re_but { width: 100px;}
	.te_clear_name, .te_clear_password { position: absolute;top: 20%; right: 5%; display: none;}
	.te_clear_name img, .te_clear_password img { width: 18px; margin-top: 5px; vertical-align: middle;}
	.forget_p a { display: inline-block; height: auto; line-height: 35px; text-align: center;}
	.z_register_btn { margin-right: 5px;}
	.position_r { position: relative;}
</style>
</head>
<body>
	<form action="/wpnv/lging" method="post" id="projectForm" name="projectForm" onsubmit="return login(3);">
		<%-- 登录类型为3 手机号登录 --%>
		<input type="hidden" name="type" value="3">
		
		<div class="bodyheight register_login_bg" id="register_login"><!--bodyheight -->
			<p class="p_top">&nbsp;</p>
			<div class="pig_logo_box"><img src="<%=basePath %>resources/images/pig_logo.png" alt=""/></div>
		   
		    <div class="bottom20">
			<div class="re_or_lg_box">
		    	<!-- <button class="but re_but" id="register_but" type="button">登录</button> -->
		    	<a class="but re_but" id="register_but">登录</a>
				<a href="<%=basePath %>wpnv/rsregisterInit" class="but lg_but">注册</a>
		        <div class="clear"></div>
		    </div>
		    </div>
		</div><!--bodyheight -->
		
		
		<div class="bodyheight body_bg" id="register_body"><!--login_body -->
			<p class="p_top">&nbsp;</p>
			<div class="register_box">
		    	<div class="center80 b_bottom position_r">
		        	<span class="register_tit"><b>手机号</b></span>
		        	<input id="phone" maxlength="11" type="tel" name="phone" class="register_input" placeholder="请输入你的手机号" onkeyup="showClaer_name()" />
		        	<a href="javascript:void(0);">
	                	<span class="te_clear_name" onclick="clearInput_name()">
	            			<img src="<%=basePath%>resources/images/tele_remove.png" alt="删除" />
	            		</span>
	            	</a>
		        	<div class="clear"></div>
		        </div>
		        <div class="center80 position_r">
		        	<span class="register_tit"><b>登录密码</b></span>
		        	<input id="userpassword" maxlength="32" type="password" name="password" class="register_input" placeholder="请输入你的密码" onkeyup="showClaer_password()" />
		        	<a href="javascript:void(0);">
	                	<span class="te_clear_password" onclick="clearInput_password()">
	            			<img src="<%=basePath%>resources/images/tele_remove.png" alt="删除" />
	            		</span>
	            	</a>
		        	<div class="clear"></div>
		        </div>       
		    </div>
			<div class="center80 register_but_box">
		        <!--<button type="button" onclick="login(3);">登录</button>-->
		        <input type="submit" value="登录" class="z_login" />
		    </div>
		    <div class="center80 forget_p">
		    	<a href="<%=basePath %>wpnv/rsregisterInit" class="z_register_btn">注册?</a>
		     	<a href="<%=basePath %>wpnv/lgresetPassword">忘记密码?</a>
		    </div>
		</div><!--login_body -->
	</form>
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript">
		//login or register to login
		$(function(){
			$('#register_but').click(function(){
				$('#register_login').css('display','none');
				$('#register_body').css('display','block');
			})
			if('${requestScope.msgType}' != '' && '${requestScope.msgType}' != '1'){
				$('#register_but').click();
				alert('${requestScope.message}');
			}
		});
		/* 第三方 */ 
		/* $(function(){
			$("#phone, #userpassword").focus(function(){
				$(".thirdparty").hide();
			});
			$("#phone, #userpassword").blur(function(){
				$(".thirdparty").show();
			});
		}); */
		function login(type){
			$("#type").val(type);
			if(type==3){
				var phone = $('#phone').val();
				var mi = $('#userpassword').val();
				if (!$.trim(phone)) {
					alert('手机号不能为空');
					return false;
				}
				if (!$.trim(mi)) {
					alert('请填写密码');
					return false;
				}
				var myreg = /^((1)+\d{10})$/;
				if(!myreg.test($.trim(phone)))
				{
					alert('请输入有效的手机号！');
					return false;
				}
			}
			$(":input[type=button]").attr("disabled",true);
			return true;
		}
		
	  	//清除输入
		function clearInput_name() {
			document.getElementById('phone').value = '';
			showClaer_name();
		}
		function clearInput_password() {
			document.getElementById('userpassword').value = '';
			showClaer_password();
		}
		function showClaer_name() {
			var inObj = document.getElementById('phone');
			if (inObj.value != '') {
				$(".te_clear_name").css("display","block");
			} else {
				 $(".te_clear_name").css("display","none");
			}
		}
		function showClaer_password() {
			var inObj = document.getElementById('userpassword');
			if (inObj.value != '') {
				$(".te_clear_password").css("display","block");
			} else {
				 $(".te_clear_password").css("display","none");
			}
		}
	</script>
</body>
</html>
