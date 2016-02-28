<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>注册</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<meta name="keywords" content="八戒王国online">
<meta name="description" content="八戒王国online">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/enter.css"/>
<script type="text/javascript" src="<%=basePath %>resources/js/verifyCode.js"></script>
<style type="text/css">
	.z_verification_code_input { width: 30%; height: 36px; line-height: 36px; float: left; outline: 0px; border: 0px; background: none; font-family: 'Microsoft YaHei'; color: #615968; margin: 5px 0px; font-size: 14px;}
	.send_code { float: left; width: 35%; margin-top: 12px; margin-left: 3%; padding-left: 5px; font-size: 14px; color: #3dbd6d; text-align: center; border: none; border-left: 1px solid #3dbd6d; border-radius: 0; background: none; cursor: pointer;}
	.z_register_button { width: 100%; text-align: center; line-height: 50px; height: 56px; background-color: #3cbd6d; border: 0px; outline: 0px; color: #FFF; font-family: 'Microsoft YaHei'; font-size: 24px; border-radius: 4px; cursor: pointer;}
	.login_dj_p a, .login_dj_p a:visited { color: #3dbd6d;}
</style>
</head>
<body>
<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
<div class="bodyheight body_bg">    
	<form action="/wpnv/rsregister" id="allProjectForm" name="allProjectForm" onsubmit="return register();">
	   	<!--register_box -->
	    <p class="p_top">&nbsp;</p>
		<div class="register_box">
	    	<div class="center80 b_bottom">        	
	        	<span class="register_tit"><b>手机号</b></span>
	        	<input type="tel" maxlength="11" name="phone" id="bind_phone" class="register_input" placeholder="支持大陆手机"/>
	        	<div class="clear"></div>
	        </div>
	        <div class="center80 b_bottom">        	
	        	<span class="register_tit"><b>短信验证码</b></span>
	        	<input type="tel" name="verifyCode" id="code" maxlength="4" class="z_verification_code_input" placeholder="短信验证码"/>
	        	<input type="button" class="send_code" id="send_code" value="发送效验码">
	        	<div class="clear"></div>
	        </div>
	        <div class="center80">
	        	<span class="register_tit"><b>登录密码</b></span>
	        	<input type="password" name="password" id="password" maxlength="16" class="register_input" placeholder="6-16位数字字母或符号"/>
	        	<div class="clear"></div>
	        </div>       
	    </div><!--register_box -->
	    	<div class="register_box mt10">
	    	<div class="center80">        	
	        	<span class="register_tit"><b>邀请码</b></span>
	        	<input type="text" name="inviteCode" id="inviteCode" maxlength="12" class="register_input" placeholder="如果有邀请码，请输入"/>
	        	<div class="clear"></div>
	        </div>              
	    </div><!--register_box -->
	
		 <div class="center80 register_but_box">
	        	<button>注册</button>
	            <p class="login_dj_p">点击“注册”，表示你同意<br>
	            	<a href="<%=basePath %>wpnv/ixprotocol?code=BJWG_SERVICE_PROTOCOL.TYPE.USER">《用户注册协议》</a>
	            </p>
	     </div>
	</form>
</div>
</body>

<jsp:include page="../common/commonTip.jsp"></jsp:include>

<script type="text/javascript">
	$(function(){
		//发送验证码
		$('#send_code').click(function(){
			var bind_phone=$('#bind_phone').val();
			requestSendCode('<%=basePath%>',bind_phone,2,this);
		});
	});
	function register(){
		var phone = $('#bind_phone').val();
		if (!$.trim(phone)) {
		 	alert('手机号码不能为空');
		 	return false;
		}
		var myreg = /^((1)+\d{10})$/;
	    if(!myreg.test($.trim(phone)))
	    {
	        alert('请输入有效的手机号码！');
	        return false;
	    }
		var code=$('#code').val();
		if (!$.trim(code)) {
			alert("验证码不能为空");
			return false;
		}
		if ($.trim(code).length != 4) {
			alert("请输入有效的4位数字的验证码");
			return false;
		}
		var password=$('#password').val();
		if (!$.trim(password)) {
			alert("密码不能为空");
			return false;
		}
		if ($.trim(password).length < 6) {
			alert("密码至少要6位");
			return false;
		}
		var inviteCode=$('#inviteCode').val();
		if (!$.trim(inviteCode) && $.trim(inviteCode) != '' && $.trim(inviteCode).length<12) {
			alert("请输入正确的邀请码");
			return false;
		}
		/*if($(":input[id=cb]:checked").length < 1){
			alert("请您先阅读好站点用户协议");
			return false;
		}*/
		//var path = '';
		//$('#form').attr("action", path).submit();
		return true;
	}
</script>

</html>


