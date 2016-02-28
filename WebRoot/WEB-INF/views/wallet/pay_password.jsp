<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<jsp:include page="../phone/is_phone.jsp"></jsp:include>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
     <meta http-equiv="content-type" content="text/html" charset="utf-8">
     <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
     <title>输入手机支付密码</title>
     <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
	<!--[if IE]> 
    	<link href="<%=basePath %>resources/css/ie.css" rel="stylesheet">
    <![endif]-->
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<style type="text/css">
		.mb_pay_content {
       		width: 100%;
       		overflow: hidden;
       	}
       	.mb_pay_container {
       		width: 92%;
       		margin: 0 auto;
       	}
       	.mb_pay_tip {
       		margin: 10px auto 15px;
       	}
       	.mb_pay_tip p {
       		font-size: 1.4rem;
       		color: #858386;
       	}
       	.mb_pay_passbox {
       		width: 100%;
       		height: 50px;
       		line-height: 50px;
       		border: 1px solid #ffb400;
       		border-radius: 5px;
       		-webkit-border-radius: 5px;
       		-moz-border-radius: 5px;
       		box-sizing: border-box;
       		-webkit-box-sizing: border-box;
       		-moz-box-sizing: border-box;
       		-moz-box-sizing: border-box;
       		background-color: white;
       	}
       	.passw_input {
       		width: 15.4%;
       		height: 40px;
       		line-height: 40px;
       		font-size: 1.6rem;
       		color: #322c2c;
       		text-align: center;
       		border: none;
       		border-right: 1px solid #ffb400;
       		box-sizing: border-box;
       		-webkit-box-sizing: border-box;
       		-moz-box-sizing: border-box;
       		-moz-box-sizing: border-box;
       		background: none;
       	}
       	.mb_pay_passbox input:last-child {
       		border: none !important;
       	}
       	.next_bton {
       		width: 100%;
       		height: 40px;
       		line-height: 40px;
       		margin-top: 20px;
       		font-size: 1.6rem;
       		color: white;
       		text-align: center;
       		border: none;
       		border-radius: 3px;
       		-webkit-border-radius: 3px;
       		-moz-border-radius: 3px;
       		background-color: #FFB400;
       	}
	
	</style>
  </head>
  
  <body>
   		<div class="head">
           <a href="javascript:history.back(-1)" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
           <p>输入手机支付密码</p>
       </div>
       <form method="post" name="form" id="form" action="<%=basePath%>balance/takeCashSave">
       	<div style="display: none;">
        	<input type="hidden" name="cardId" id="cardId" value="${cardId }">
        	<input type="password" name="payPassword" id="payPassword">
        	<input type="hidden" name="money" id="money" value="${money }">
        	<input type="hidden" name="s_type" id="s_type" value="${s_type }">
       	</div>
       	<div class="mb_pay_content">
        	<div class="mb_pay_container">
        		<div class="mb_pay_tip">
        			<p>仅用于手机支付的数字密码，以后凭该密码安全支付，请勿与登录密码设置一致</p>
        		</div>
	        	<div class="mb_pay_passbox">
	        		<input type="password" class="passw_input" maxlength="1" name="payPw" id="payPassword1"/>
	        		<input type="password" class="passw_input" maxlength="1" name="payPw" id="payPassword2"/>
	        		<input type="password" class="passw_input" maxlength="1" name="payPw" id="payPassword3"/>
	        		<input type="password" class="passw_input" maxlength="1" name="payPw" id="payPassword4"/>
	        		<input type="password" class="passw_input" maxlength="1" name="payPw" id="payPassword5"/>
	        		<input type="password" class="passw_input" maxlength="1" name="payPw" id="payPassword6"/>
	        	</div>
	        	<input type="button" class="next_bton" value="确定" onclick="save();"/>
        	</div>
        </div>
       </form>
	</body>
  
  <script language="javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
  <script language="javascript">
	/*$(function(){
		if(/MicroMessenger/i.test(navigator.userAgent)){
			$(".head").css('display','none');
		}else if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
		
						
		}else {
			$(".head").css('display','none');
		}
	});*/
	
	function save(){
		var input = $(":input[name=payPw]").length;
		var count = 0;
		var pw = "";
		for(var i = 1 ;i <= input ; i++){
			if($("#payPassword"+i).val() != ''){
				count++;
				pw+=$("#payPassword"+i).val();
			}
		}
		if(count == 6){
			$("#payPassword").val(pw);
			$("#form").submit();
		}
	}
	
	$(document).ready(function(){
  		var messsageCode = '${requestScope.messageCode}';
  		var messsage = '${requestScope.message}';
  		if(messsage != ''){
  			alert(messsage);
  		}
  	});
	
  </script>
</html>
