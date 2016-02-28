<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="myTags" uri="my-taglib" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<jsp:include page="../phone/is_phone.jsp"></jsp:include>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>设置密码</title>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="好站点,设置密码">
		<meta http-equiv="description" content="好站点设置密码页面">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
		<style>
			.username, .userpassword { width: 90% !important; height: 50px !important;}
			input::-webkit-input-placeholder { color: #322c2c !important;}
			input::-moz-input-placeholder { color: #322c2c !important;}
			input:-moz-input-placeholder { color: #322c2c !important;}
			input:-ms-input-placeholder { color: #322c2c !important;}
			.name_left { margin-left: 16px;}
			.position_rel { position: relative;}
			#show_pw, #hide_pw { position: absolute;top: 30%; right: 16px; display: none;}
			#show_pw img, #hide_pw img { width: 20px; /* margin-top: -15px; vertical-align: middle; */}
		</style>
		<!--[if IE]> 
	    	<link href="<%=basePath %>resources/css/ie.css" rel="stylesheet">
	    <![endif]-->
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/login.css">
		<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>

	</head>

	<body>
		<div class="head">
            <a href="javascript:history.back(-1);" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
            <p>设置密码</p>
        </div>
		<form action="<%=basePath%>main/user/savePassword" method="post" id="projectForm" name="projectForm">
          	<input type="hidden" name="username" id="username" value="${username }">
          	<input type="hidden" name="source" id="source" value="${source }">
          	<input type="hidden" name="shopId" id="shopId" value="${shopId }">
            <div class="content">
                <div class="input_box">
                	<span class="name_left">${username }</span>
                </div>
                <div class="input_box position_rel">
                	<span id="box">
                		<input type="password" class="userpassword" name="password" id="userpassword" maxlength="32" placeholder="密码" onkeyup="showTransform()" >
                	</span>
                	<span id="show_pw">
              			<img src="<%=basePath %>resources/images/pt.png" alt="显示密码" onclick="showPassword()" />
              		</span>
              		<span id="hide_pw">
              			<img src="<%=basePath %>resources/images/pw.png" alt="隐藏密码" onclick="hidePassword()" />
              		</span>
                </div>
            </div>
            <div class="login_1">
                <button type="button" class="log_button" id="log_button" value="保存" onclick="save();">确定</button>
            </div>
            
            </div>
        </form>
    </body>

	<script type="text/javascript">
		/*$(function(){
			if(/MicroMessenger/i.test(navigator.userAgent)){
				$(".head").css('display','none');
			}else if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
			
							
			}else {
				$(".head").css('display','none');
			}
		});*/
		function save(type){
			var mi = $('#userpassword').val();
			if (!$.trim(mi) || mi.length < 6) {
				alert('请填写密码，长度至少为6位');
				return false;
			}
			$(":input[type=button]").attr("disabled",true);
			$("#projectForm").submit();
		}
		$(document).ready(function(){
	  		var messsageCode = '${requestScope.messageCode}';
	  		var messsage = '${requestScope.message}';
	  		if(messsage != ''){
	  			alert(messsage);
	  		}
	  	});
		function showTransform() {
			var inObj = document.getElementById('userpassword');
	        if (inObj.value != '') {
	            $("#show_pw").show();
	        } else {
	             $("#show_pw").hide();
	        }
		}
		function hidePassword() {
			if (this.projectForm.password.type="text"){
				box.innerHTML="<input type=\"password\" class=\"userpassword\" id=\"userpassword\" name=\"password\" maxlength=\"32\" placeholder=\"密码\" onkeyup=\"showTransform()\" size=\"20\" value="+this.projectForm.password.value+">";	
				show_pw.innerHTML="<img src=\"/resources/images/pt.png\" alt=\"隐藏密码\" onclick=\"showPassword()\" />";
			}
		}
		function showPassword() {
			if (this.projectForm.password.type="password"){
				box.innerHTML="<input type=\"html\" class=\"userpassword\" id=\"userpassword\" name=\"password\" maxlength=\"32\" placeholder=\"密码\" onkeyup=\"showTransform()\" size=\"20\" value="+this.projectForm.password.value+">";
				show_pw.innerHTML="<img src=\"/resources/images/pw.png\" alt=\"显示密码\" onclick=\"hidePassword()\" />";
			}
		}
	</script>
</body>
<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>
