<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="登录" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="./meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/login.css"/>
</head>
<body>

&quot;<!--banner_box -->
<jsp:include page="header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="nav.jsp">
	<jsp:param value="1" name="nav"/>
</jsp:include>
<!-- 导航栏-->

<!-- content start -->

<div class="d-wrap login-wrap">
	
	<div class="login-cont">
		
		<div class="login-main">
			
			<div class="main-bd"></div>
			
			<form action="#">
				<ul class="main-box">
					<li class="row row-1 clearfix">
						<span class="fl-left s1">八戒王国online欢迎您</span>
						<a href="pc/pnv/regPage" id="login"  class="fl-right s2">
							<img src="resources/images/pc/but_left.png" alt="立即注册" />立即注册
						</a>
					</li>
					<li class="row row-2">
						<img src="resources/images/pc/login-bd-2.png" alt="提示" />
					</li>
					<li class="row row-3">
						<div class="inpt">
							<label for="phone" class="lab"></label>
							<input type="text" placeholder="请输入手机号" class="phone btn-item" id="phone" name="mobile" maxLength=11/>
						 
						 
						 <input type="text" placeholder="登陆名" style="display: none;" class="phone btn-item" id="ep_username" name="ep_username" maxLength=11  />
						</div>
					</li>
					<li class="row row-4">
						<div class="inpt">
							<label for="password" class="lab"></label>
							<input type="password" placeholder="请输入密码" class="password" id="password" name="password" maxLength=20/>
						 <input type="password" placeholder="请输入登录密码" class="password"
						id="ep_password" name="ep_password" maxLength=20" style="display: none;"/>
						</div>	
					</li>
					<li class="row row-5 clearfix">
						<span class="fl-left">
							<input type="checkbox" checked class="log-auto" id="log-auto"/>
							<label for="log-auto">自动登录</label>
						</span>
						
						<span class="fl-right" id="wjmm_1"><a href="pc/pnv/forgetPwd">忘记密码？</a></span>
						  <span style="display: none;" id="wjmm_2" class="fl-right">
						  
						  <a href="pc/pnv/epforgetPwd">忘记登录密码？</a> </span>
						  
					</li>
					<li class="row row-6">
					<label id="ridio1" >
					 <input type="radio" onclick="show1();"
								name="login" value="个人用户登录" checked="checked" style="float: left;" />
								个人用户登录</label>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<label id="radio2" > 
							<input type="radio" id="buiness" name="login"  onclick="show2()" value="企业用户登录" /> 
								企业用户登录</label>
						</li>
					<li class="row row-6">
						<input type="button" value="登录" id="btnlogin1" class="log-submit btn-submit"/>
						<input type="button" value="登录" id="btnlogin2" class="log-submit btn-submit"  style="display: none"/>
					
					</li>
					
				
					
					<li class="row row-7 error-tips"></li>
				</ul>
			</form>
			
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
-->
<script type="text/javascript" src="<%=basePath %>resources/js/pc/login.js"></script>
<!--<script>

	$(function(){
		
		
		/*登录*/
		$('.log-submit').on('click', function(){
			
			var phone = $('.phone').val(),
				pass = $('.password').val();
			
			if(checkPhone(phone) && checkPassword(pass)){
				//登录成功
				return true;
			}else{
				return false;
			}
			
		})
	
	})
	
</script>-->
<script>
var SubmitOrHidden = function(evt){
    evt = window.event || evt;
    if(evt.keyCode===13){//如果取到的键值是回车
          //do something 
          $('#btnlogin').trigger('click');
     }else{
        //其他键  dosomething
    }
                 
}
window.document.onkeydown=SubmitOrHidden;//当有键按下时执行函数

function show1(){

document.getElementById("btnlogin1").style.display="block";
document.getElementById("btnlogin2").style.display="none";
		document.getElementById("login").style.display="block";
		document.getElementById("wjmm_1").style.display="block";
		document.getElementById("wjmm_2").style.display="none";
		document.getElementById("ep_username").style.display="none";
		document.getElementById("ep_password").style.display="none";
		document.getElementById("phone").style.display="block";
        document.getElementById("password").style.display="block";
	}
	function show2(){

        document.getElementById("btnlogin2").style.display="block";
        document.getElementById("btnlogin1").style.display="none";
        document.getElementById("login").style.display="none";
        document.getElementById("wjmm_2").style.display="block";
        document.getElementById("wjmm_1").style.display="none";
        document.getElementById("phone").style.display="none";
        document.getElementById("password").style.display="none";
        document.getElementById("ep_username").style.display="block";
		document.getElementById("ep_password").style.display="block";
	}




</script>
</html>



<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/pc/login.js"></script>
  </head>
  
  <body>
    <h3>登录</h3>
    <div id="loginPanel" class="panel">
    		<span class="title">登录</span>
    		帐号<input type="text" name="mobile" value="13000000008"/>
    		密码<input type="password" name="password" />
    		<button type="button" id="btnlogin">登录</button>
    		<a href="pnv/regPage">注册</a>
    	</div>
  </body>
</html>
-->