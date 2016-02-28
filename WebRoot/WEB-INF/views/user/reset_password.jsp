<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>找回密码页面</title>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta name="keywords" content="八戒王国online,找回密码">
		<meta name="description" content="找回密码页面">
		<link rel="stylesheet" href="/resources/css/public.css"/>
		<link rel="stylesheet" href="/resources/css/enter.css"/>
		<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>resources/js/verifyCode.js"></script>
		<style type="text/css">
        	.register_input { width: 100%;}
        	.z_verification_code_input { width: 33%; height: 36px; line-height: 36px; float: left; outline: 0px; border: 0px; background: none; font-family: 'Microsoft YaHei'; color: #615968; margin: 5px 0px; font-size: 14px;}
			.send_code { float: left; width: 35%; margin-top: 12px; margin-left: 2%; font-size: 14px; color: #3dbd6d; text-align: center; border: none; border-left: 1px solid #3dbd6d; border-radius: 0; background: none; cursor: pointer;}
			.login_1 { width: 94%; background-color: none; margin: 30px auto 50px;}
			.log_button { width: 100%; height: 45px; line-height: 45px; margin-bottom: 10px; font-size: 16px; color: #fff; border: none; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; background-color: #3dbd6d; cursor: pointer;}
        	.position_r { position: relative;}
        	.te_clear_phone, .te_clear_password { position: absolute;top: 20%; right: 5%; display: none;}
			.te_clear_phone img, .te_clear_password img { width: 18px; margin-top: 5px; vertical-align: middle;}
        </style>
	</head>

	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<div class="bodyheight body_bg">
	        <form method="post" name="form" id="form" action="/wpnv/lgsavePassword">
	        	<input type="hidden" name="type" id="type" value="3">
	        	
	        	<p class="p_top">&nbsp;</p>
				<div class="register_box">
			    	<div class="center80 b_bottom position_r">        	
			        	<input type="tel" maxlength="11" name="phone" id="bind_phone" class="register_input" placeholder="请输入手机号" onkeyup="showClaer_phone()" />
			        	<a href="javascript:void(0);">
		                	<span class="te_clear_phone" onclick="clearInput_phone()">
		            			<img src="<%=basePath%>resources/images/tele_remove.png" alt="删除" />
		            		</span>
		            	</a>
			        	<div class="clear"></div>
			        </div>
			        <div class="center80 b_bottom">        	
			        	<span class="register_tit"><b>短信验证码</b></span>
			        	<input type="tel" name="verifyCode" id="code" maxlength="4" class="z_verification_code_input" placeholder="请输入效验码" />
			        	<input type="button" class="send_code" id="send_code" value="发送效验码">
			        	<div class="clear"></div>
			        </div>
			        <div class="center80 position_r">
			        	<input type="password" name="password" id="password" maxlength="16" class="register_input" placeholder="6-16位数字字母或符号" onkeyup="showClaer_password()" />
			        	<a href="javascript:void(0);">
		                	<span class="te_clear_password" onclick="clearInput_password()">
		            			<img src="<%=basePath%>resources/images/tele_remove.png" alt="删除" />
		            		</span>
		            	</a>
			        	<div class="clear"></div>
			        </div>       
			    </div><!--register_box -->
			    
	            <%-- <div class="reg_content">
	                <ul id="list">
	                    <li class="position_r">
	                    	<input maxlength="11" type="tel" name="phone" id="bind_phone" class="username" placeholder="请输入手机号" onkeyup="showClaer_phone()" />
	                    	<a href="javascript:void(0);">
			                	<span class="te_clear_phone" onclick="clearInput_phone()">
			            			<img src="<%=basePath %>resources/images/tele_remove.png" alt="删除" />
			            		</span>
			            	</a>
	                    </li>
	                    <li>
	                    	<input type="tel"  name="verifyCode" id="code" class="check_code" maxlength="4" placeholder="请输入效验码" />
	                    	<input type="button" class="send_code" id="send_code" value="发送效验码" />
	                    </li>
	                    <li class="position_r">
	                    	<input type="password" name="password" id="password" class="userpassword" maxlength="32" placeholder="设置新密码" onkeyup="showClaer_password()" />
	                    	<a href="javascript:void(0);">
			                	<span class="te_clear_password" onclick="clearInput_password()">
			            			<img src="<%=basePath %>resources/images/tele_remove.png" alt="删除" />
			            		</span>
			            	</a>
	                    </li>
	                </ul>
	            </div> --%>
	            <div class="login_1">
	                <input type="button" class="log_button" id="log_button" value="确定" onClick="javascript:save();">
	            </div>
	        </form>
	    </div>
	</body>
	
	<jsp:include page="../common/commonTip.jsp"></jsp:include>
	
	<script type="text/javascript">
		function save(){
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
			
			var path = '/wpnv/lgsavePassword';
			$('#form').attr("action", path).submit();
		}		
		function back(url){
			$("#type").val(4);
			$("#form").attr("action",url).submit();
		}
		$(function(){
			//发送验证码
			$('#send_code').click(function(){
				var bind_phone=$('#bind_phone').val();
				requestSendCode('<%=basePath%>',bind_phone,3,this);
			});
		});
		  	
	  	//清除输入
		function clearInput_phone() {
			document.getElementById('bind_phone').value = '';
			showClaer_phone();
		}
		function clearInput_password() {
			document.getElementById('password').value = '';
			showClaer_password();
		}
		function showClaer_phone() {
			var inObj = document.getElementById('bind_phone');
			if (inObj.value != '') {
				$(".te_clear_phone").css("display","block");
			} else {
				 $(".te_clear_phone").css("display","none");
			}
		}
		function showClaer_password() {
			var inObj = document.getElementById('password');
			if (inObj.value != '') {
				$(".te_clear_password").css("display","block");
			} else {
				 $(".te_clear_password").css("display","none");
			}
		}
	</script>
</html>
