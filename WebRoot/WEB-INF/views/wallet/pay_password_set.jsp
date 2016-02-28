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
    <meta name="keywords" content="八戒王国online">
	<meta name="description" content="八戒王国online">
	<meta http-equiv="Pragma" content="no-cache" />
    <title>设置手机支付密码</title>
     <%-- <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css"> --%>
    <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
    <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" /> 
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/md5.js"></script>
	<style type="text/css">
		.mb_pay_content { width: 100%; overflow: hidden;}
       	.mb_pay_container { width: 92%; margin: 0 auto;}
       	.mb_pay_tip { margin: 10px auto 15px;}
       	.mb_pay_tip p { font-size: 1.4rem; color: #858386;}
       	.mb_pay_passbox { width: 90%; margin: 0 auto 20px;}
       	.password_input { width: 65%; height: 40px;/*  padding-top: 5px; */ padding-left: 6px; margin-left: 15px; font-size: 1.6rem; border: 1px solid #3dbd6d; border-radius: 4px; -webkit-border-radius: 4px; -moz-border-radius: 4px; box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box; -moz-box-sizing: border-box; background-color: white; letter-spacing: 20px;}
       	.next_bton { display: block; width: 90%; margin: 20px auto; height: 40px; line-height: 40px; font-size: 1.6rem; color: white; text-align: center; border: none; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; background-color: #3dbd6d;}
		.mb_pay_passbox label { float: left; height: 40px; line-height: 40px; font-size: 1.6rem; color: #322c2c;}
	</style>
  </head>
  
  <body>
  	   <c:choose>
  	   		<c:when test="${empty is_first || is_first != 2}">
		       <form method="post" name="form" id="form" action="<%=basePath %>wpv/wlpayPasswordSave">
		        	<input type="hidden" name="s_type" id="s_type" value="${s_type }">
			       	<div class="mb_pay_content">
			        	<div class="mb_pay_container">
			        		<div class="mb_pay_tip">
			        			<p>仅用于手机支付的数字密码，以后凭该密码安全支付，请勿与登录密码设置一致</p>
			        		</div>
				        	<div class="mb_pay_passbox">
				        		<label>输入密码</label>
				        		<input type="password" class="password_input" maxlength="6" name="payPassword" id="payPassword" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
				        	</div>
				        	<div class="mb_pay_passbox">
				        		<label>确认密码</label>
				        		<input type="password" class="password_input" maxlength="6" name="confirmPayPassword" id="confirmPayPassword" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
				        	</div>
			        	</div>
			        	<input type="button" class="next_bton" value="确定" onclick="save();"/>
			        </div>
		       </form>
  	   		</c:when>
  	   		<c:otherwise>
		        </form>
  	   		</c:otherwise>
  	   </c:choose>
	</body>
  
  <script language="javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
  <script language="javascript">
	
	function onkeyfocus() {
		if($("#T1").val().length != 1){
			$("#T1").focus();
		}else if($("#T2").val().length != 1){
			$("#T2").focus();
		}else if($("#T3").val().length != 1){
			$("#T3").focus();
		}else if($("#T4").val().length != 1){
			$("#T4").focus();
		}else if($("#T5").val().length != 1){
			$("#T5").focus();
		}else if($("#T6").val().length != 1){
			$("#T6").focus();
		}
		if($.trim($("#T6").val()) != ''){
			var input = $(":input[name=payPw]").length;
			var count = 0;
			var pw = "";
			for(var i = 1 ;i <= input ; i++){
				if($("#T"+i).val() != ''){
					count++;
					pw+=$("#T"+i).val();
				}
			}
			if(count == 6){
				$("#payPassword").val(pw);
			}
		}
	} 
	
	function save(){
		var p1 = $("#payPassword").val();
		var p2 = $("#confirmPayPassword").val();
		if(p1.length < 6){
			alert("请输入6位密码");
			return 
		}
		if(p2.length < 6){
			alert("请输入6位确认密码");
			return 
		}
		if(p1 != p2){
			alert("两次密码输入不一致，请重新输入");
			return ;
		}
		$("#form").submit();
	}
	
  </script>
</html>
