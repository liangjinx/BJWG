<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>润民金融双11抽奖活动后台管理员登录</title>

    <link href="resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>

<div class="body_content" style="background-image:url(resources/images/turnplate-bg.png);background-size:100% 100%;">
    <div class="content">
       
        <!--记录区-->
        <div class="user">
            
            <div class="user_welcome">
             	    <div class="user_welcome_input"> 
             	    	账号 : <input type="text" name="username" id="username">
             	    </div>
             	    <div class="divMsg" id="divMsg_phone"></div>
            		<div class="user_welcome_input">
            			密码 : <input type="password" name="password" id="password">
            		</div>
            		<div class="divMsg" id="divMsg_password"></div>
            		<div class="button">
            			<button id="login">登录</button>
            			<button id="reset">重置</button>
            		</div>
            		
            </div>
            
        </div>
    </div>
</div>

</body>
<script src="resources/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript">
	
	
	//回车触发登录事件
	$(document).ready(function(){ 
		$("#password").keydown(function(e){ 
		var curKey = e.which; 
		if(curKey == 13){ 
			login();
			return false; 
			} ;
		});
		$("#username").keydown(function(e){ 
		var curKey = e.which; 
		if(curKey == 13){ 
			login();
			return false; 
			};
		});  
		$("#username").focus();
	}); 
	
	$(function() {
		//重置按钮事件
		$("#reset").click(function() {
			$("#username").val("");
			$("#password").val("");
			$(".divMsg").empty();
		});
		//登录按钮事件
		$("#login").click(function() {
			login();
		});
	});
	
	
	function login(){
	//清空div内容
		$(".divMsg").empty();
		$.ajax({
				type:"post",
				url:'back',
				data:"username="+$("#username").val()+"&password="+$("#password").val(),
				success:function(responseText){
					if(responseText=="True"){
						window.location.href="backlist.jsp";
					};
				}
			});
	
	}
	
  	//密码验证
    function checkPassword(str){
	    var re = /^[0-9a-zA-Z]{6,16}$/;
	    if(!re.test(str)){
	    	$("#divMsg_password").show().html("请输入6-16位的字母、数字或符号");
	    	$("#password").focus();
	        return false;
	    }
	    return true;          
	}
</script>
</html>