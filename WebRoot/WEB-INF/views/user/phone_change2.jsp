<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>手机绑定-绑定新手机</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/compilations_pz.css">
	</head>
	<body>
		<form method="post" id="verifyForm" name="verifyForm" action="<%=basePath %>wpv/urphoneChangeNew">
            <div class="c_content_new">
                <div class="tip">
                    <ul>
                        <li>选择验证方式</li>
                        <li>&nbsp;&gt;&nbsp;</li>
                        <li class="color_ffb">绑定新手机</li>
                    </ul>
                </div>
				<div class="new_phone_box">
                	<input maxlength="11" type="tel" class="new_phone" id="bind_phone" name="phone" placeholder="请输入新手机号">
                </div>
                <div class="check_box">
                	<span>效验码</span>
                    <input type="tel" class="verification_code" id="verifyCode" name="verifyCode" placeholder="短信效验码">
                    <input type="button" class="send_code" id="send_code" name="send_code" value="发送效验码">
                </div>
                <div class="verification_box">
                	<p>重新绑定之后，之前绑定的手机号将不能作为登录凭证</p>
                	<input type="button" class="" value="绑定" onClick="javascript:save();">
                </div>
            </div>
        </form>
        <jsp:include page="../common/commonTip.jsp"></jsp:include>
        <jsp:include page="../back.jsp">
			<jsp:param value="wpv/urphoneChangePage1" name="backUrl"/>
		</jsp:include>
    </body>
</html>
<script language="javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/js/verifyCode.js"></script>
<script language="javascript">
$(function(){
	$(".log-main").css("height",$(window).height());
})
$(function(){
	$(".log-main").css("height",$(window).height());
	// add by oyja
	var wait=60;
	function send_time(obj){
		if (wait == 0) { 
			$(obj).val('发送验证码');
			$(obj).attr("disabled",false);
			wait=60;
			return false;
		}else {
			wait--;
			$(obj).val("重新发送(" + wait + ")");
			$(obj).attr("disabled",true);
		}
		setTimeout(function(){
			send_time(obj);
		},1000);
	}
	//发送验证码
	$('#send_code').click(function(){alert();
		var bind_phone=$('#bind_phone').val();
		requestSendCode('<%=basePath%>',bind_phone,5,this);
		
	});
});
//保存
function save(){
	 var phone = $('#bind_phone').val();
	 if (!$.trim(phone)) {
	 	alert('手机号码不能为空');
	 	return false;
	 }
	//var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|170|145|147)+\d{8})$/;
	var myreg = /^((1)+\d{10})$/;
    if(!myreg.test($.trim(phone)))
    {
        alert('请输入有效的手机号码！');
        return false;
    }
	 
	var code=$('#verifyCode').val();
	if (!$.trim(code)) {
		alert("验证码不能为空");
		return false;
	}
		
	var path = '<%=basePath %>wpv/urphoneChangeNew';
	$('#verifyForm').attr("action", path).submit();
}
</script>
<!--











<jsp:include page="../phone/is_phone.jsp"></jsp:include>
<!doctype html>
<html>
<head>
<meta http-equiv="content-type" content="text/html" charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>绑定新手机</title>


</head>

<body>
	<div class="head">
        <a href="javascript:history.back(-1)" class="head_back">
        	<img src="images/back.png" alt="返回">
        </a>
        <p>绑定新手机</p>
    </div>
    <form method="post" id="verifyForm" name="verifyForm" action="<%=basePath %>wpv/urphoneChangeNew">
        <div class="c_content">
            <div class="tip">
                <ul>
                    <li>选择验证方式</li>
                    <li>&nbsp;&gt;&nbsp;</li>
                    <li class="color_ffb">绑定新手机</li>
                </ul>
            </div>
			<div class="new_phone_box">
            	<input maxlength="11" type="tel" class="new_phone" id="bind_phone" name="phone" placeholder="请输入新手机号">
            </div>
            <div class="check_box">
            	<span>效验码</span>
                <input type="tel" class="verification_code" id="verifyCode" name="verifyCode" placeholder="短信效验码">
                <input type="button" class="send_code" id="send_code" name="send_code" value="发送效验码">
            </div>
            <div class="verification_box">
            	<p>重新绑定之后，之前绑定的手机号将不能作为登录凭证</p>
            	<input type="button" class="" value="绑定" onClick="javascript:save();">
            </div>
        </div>
    </form>
    
<jsp:include page="../common/commonTip.jsp"></jsp:include>
</body>
<script type="text/javascript" src="<%=basePath %>resources/js/verifyCode.js"></script>
</html>
<script type="text/javascript">

$(function(){
	$(".log-main").css("height",$(window).height());
})
$(function(){
	$(".log-main").css("height",$(window).height());
	// add by oyja
	var wait=60;
	function send_time(obj){
		if (wait == 0) { 
			$(obj).val('发送验证码');
			$(obj).attr("disabled",false);
			wait=60;
			return false;
		}else {
			wait--;
			$(obj).val("重新发送(" + wait + ")");
			$(obj).attr("disabled",true);
		}
		setTimeout(function(){
			send_time(obj);
		},1000);
	}
	//发送验证码
	$('#send_code').click(function(){
		var bind_phone=$('#bind_phone').val();
		requestSendCode('<%=basePath%>',bind_phone,5,this);
		
	});
});
//保存
function save(){
	 var phone = $('#bind_phone').val();
	 if (!$.trim(phone)) {
	 	alert('手机号码不能为空');
	 	return false;
	 }
	//var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|170|145|147)+\d{8})$/;
	var myreg = /^((1)+\d{10})$/;
    if(!myreg.test($.trim(phone)))
    {
        alert('请输入有效的手机号码！');
        return false;
    }
	 
	var code=$('#verifyCode').val();
	if (!$.trim(code)) {
		alert("验证码不能为空");
		return false;
	}
		
	var path = '<%=basePath %>wpv/urphoneChangeNew';
	$('#verifyForm').attr("action", path).submit();
}


</script>
-->