<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="忘记密码" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="./meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/login.css"/>
</head>
<body>

<!--banner_box -->
<jsp:include page="header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="nav.jsp">
	<jsp:param value="1" name="nav"/>
</jsp:include>
<!-- 导航栏-->

<!-- content start -->

<div class="d-wrap forg-wrap">
	
	<div class="forg-cont">
		
		<h1 class="forg-title">找回密码</h1>
		
		<div class="forg-main clearfix">
			
			<ul class="fl-left main-form">
				<li class="row row-phone">
					<div class="inpt">
						<label for="phone" class="lab">手机号</label>
						<input type="text" placeholder="请输入手机号" class="phone btn-item" id="phone" name="mobile" maxLength=11/>
					</div>
				</li>
				<li class="row row-code">
						<div class="inpt">
							<label for="phone" class="lab">验证码</label>
							<input type="text" placeholder="请输入验证码" class="auth-code btn-item" id="authCode" name="verifyCode" maxLength=4/>
							<input type="button" class="btn-code" value="发送验证码" id="getVerifyCode"/>
						</div>
					</li>
				<li class="row row-pass">
					<div class="inpt">
						<label for="password" class="lab">新密码</label>
						<input type="password" placeholder="请输入密码" class="password1" id="password" name="password1" maxLength=20/>
					</div>
				</li>
				<li class="row row-pass2">
					<div class="inpt">
						<label for="password" class="lab">重复新密码</label>
						<input type="password" placeholder="请输入密码" class="password2" id="password" name="password2" maxLength=20/>
					</div>
				</li>
				<li class="row error-tips"></li>
				<li class="row row-sub">
					<input type="button" value="确定" class="forg-submit btn-submit" id="btnSub"/>
				</li>
			</ul>
			
			<div class="fl-left main-login">
				<p>已有账号？</p>
				<a class="link-login btn-submit dib" href="pc/pnv/loginPage">马上登录</a>
			</div>
			
		</div>
		
	</div>

</div>

<!-- content end -->

<!--底部 -->
<jsp:include page="footer.jsp"></jsp:include>
<!--底部 -->

</body>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script src="resources/js/pc/forgetPwd.js"></script>
<!--<script src="js/login.js"></script>
--><script>

	$(function(){
		
		/*placeholder兼容IE*/
		var doc=document,inputs=doc.getElementsByTagName('input'),supportPlaceholder='placeholder'in doc.createElement('input'),placeholder=function(input){var text=input.getAttribute('placeholder'),defaultValue=input.defaultValue;
	    if(defaultValue==''){
	        input.value=text}
	        input.onfocus=function(){
	            if(input.value===text){this.value=''}};
	            input.onblur=function(){if(input.value===''){this.value=text}}};
	            if(!supportPlaceholder){
	                for(var i=0,len=inputs.length;i<len;i++){var input=inputs[i],text=input.getAttribute('placeholder');
	                if(input.type==='text'&&text){placeholder(input)}
	    }}
		
		/*注册*/
		/*$('.forg-submit').on('click', function(){
			
			var phone = $('.phone').val(),
				code = $('.auth-code').val(),
				pass1 = $('.password1').val(),
				pass2 = $('.password2').val();
			
			if(checkPhone(phone) && checkCode(code) && checkPassword(pass1, pass2)){
				//注册成功
				console.log('111111');
				return true;
			}else{
				return false;
			}
			
		})*/
	
	})
	
</script>

</html>