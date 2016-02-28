<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
	<meta http-equiv="content-type" content="text/html" charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="keywords" content="八戒王国online">
	<meta name="description" content="八戒王国online">
	<meta http-equiv="Pragma" content="no-cache" />
    <title>修改登录密码</title>
    <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/compilations_pz.css">
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<!-- <style type="text/css">
		.z_change_box { width: 100%; background-color: #fff; overflow: hidden;}
       	.z_change_childbox { width: 100%; height: 50px; line-height: 50px; text-align: left; border-bottom: 1px solid #dedede;}
       	.z_change_childbox input { display: block; width: 90%; margin: 5px auto 0; height: 45px; font-size: 1.6rem; color: #322c2c; border: none; background: none;}
       	.z_ensure_box { width: 100%; overflow: hidden;}
       	.z_ensure_bton { display: block; width: 94%; padding: 12px 0; margin: 20px auto; font-size: 1.6rem; color: #fff; text-align: center; border: none; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; background-color: #ffb400;}
	</style> -->
  </head>
  
  <body>
  		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
	   <p class="z_h10">&nbsp;</p>
       <form method="post" name="form" id="form" action="<%=basePath %>wpv/urupdateLoginPassword">
       		<div class="z_setting_box f_l">
				<label class="z_setting_word">新密码</label>
				<input type="password" maxlength="16" name="password" id="password" class="z_password" placeholder="输入新密码" />
			</div>
			<div class="z_setting_box f_l">
				<label class="z_setting_word">确认密码</label>
				<input type="password" maxlength="16" name="confirmPassword" id="confirmPassword" class="z_password" id="password" placeholder="请输入确认密码" />
			</div>
			
			<input type="button" class="z_save_bton f_l" value="完成" onclick="save()"/>
       </form>
</body>
  <jsp:include page="../common/commonTip.jsp"></jsp:include>
  <script language="javascript">
	
  	function save(){
		var password = $("#password").val();
		var confirmPassword = $("#confirmPassword").val();
		if(password.length < 6){
			alert("请输入至少6位密码");
			return ;
		}
		if(password != confirmPassword){
			alert("两次密码输入不一致");
			//$("#password").val('');
			$("#confirmPassword").val('');
			return ;
		}
		$("#form").submit();
	}
  </script>
</html>



