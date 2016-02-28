<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="注册" scope="request"/>
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

<!-- 导航栏-->
<jsp:include page="nav.jsp">
	<jsp:param value="1" name="nav"/>
</jsp:include>
<!-- content start -->

<div class="d-wrap login-wrap reg-wrap">
	
	<div class="login-cont">
		
		<div class="reg-code">
			<img src="resources/images/pc/erweima-1.png" alt="扫一扫" />
		</div>
		
		<div class="login-main">
			
			<div class="main-bd"></div>
			
			<form action="#">
				<ul class="main-box">
					<li class="row row-1 clearfix">
						<span class="fl-left s1">八戒王国online欢迎您</span>
						<a href="pc/pnv/loginPage" class="fl-right s2">
							<img src="resources/images/pc/but_left.png" alt="立即注册" />立即登录
						</a>
					</li>
					<li class="row row-2">
						<div class="inpt">
							<span class="lg_span">*</span>
							<label for="phone" class="lab"></label>
							<input type="text" placeholder="请输入手机号" class="phone btn-item" id="phone" name="mobile" maxLength=11/>
						</div>
					</li>
					<li class="row row-3">
						<div class="inpt">
							<span class="lg_span">*</span>
							<label for="phone" class="lab"></label>
							<input type="text" placeholder="请输入验证码" class="auth-code btn-item" id="authCode" name="verifyCode" maxLength=4/>
							<input type="button" class="btn-code" value="发送验证码" id="getVerifyCode"/>
						</div>
					</li>
					<li class="row row-4">
						<div class="inpt">
							<span class="lg_span">*</span>
							<label for="password" class="lab"></label>
							<input type="password" placeholder="请输入密码" class="password" id="password" name="password"/>
						</div>
					</li>
					<li class="row row-4 row-4-1">
						<div class="inpt">
							<label for="password" class="lab"></label>
							<input type="password" placeholder="请输入邀请码" class="password" id="password"/>
						</div>
					</li>
					<li class="row row-5 error-tips"></li>
					<li class="row row-6">
						<input type="button" value="注册" class="reg-submit btn-submit" id="regbtn"/>
					</li>
					<li class="row row-7 clearfix">
						<span class="fl-left">
							<input type="checkbox" checked class="log-auto" id="log-auto"/>
							<a href="javascript:;" class="agreement-btn">同意用户协议</a>
						</span>
					</li>
				</ul>
			</form>
			
		</div>
		
	</div>

	<div class="agreement">
		<div class="agr-bd"></div>
		<div class="agr-main">
			<h2 class="title">“八戒王国online”协议书</h2>
			<div class="cont">
				${protocol.content}
			</div>
			<div class="btn-sure">
				<button class="btn-submit">同意并继续</button>
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
<!--<script src="js/login.js"></script>
--><script type="text/javascript" src="<%=basePath %>resources/js/pc/register.js"></script>
<script>

/*协议*/
		$('.agreement-btn').on('click', function(){
			$('.agreement').fadeIn('fast');
		})
		$('.agreement .btn-submit').on('click', function(){
			$('.agreement').fadeOut('fast');
		})
	
</script>

</html>



<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>注册</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/pc/register.js"></script>
  </head>
  
  <body>
    <h3>注册</h3>
    <div id="registerPanel" class="panel">
    		<span class="title">注册</span>
    		帐号<input type="text" name="mobile" />
    		密码<input type="password" name="password" />
    		验证码<input type="text" name="verifyCode" />
    		<button type="button" id="getVerifyCode">获取验证码</button>
    		<button type="button" id="regbtn">注册</button>
    	</div>
  </body>
</html>
-->