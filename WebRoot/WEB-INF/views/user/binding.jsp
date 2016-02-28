<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>

<!doctype html>
<html>
<head>
<meta http-equiv="content-type" content="text/html" charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>绑定手机号</title>

<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
<!--[if IE]> 
	<link href="<%=basePath %>resources/css/ie.css" rel="stylesheet">
<![endif]-->
<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>

<style type="text/css">
	input::-webkit-input-placeholder { color: #322c2c;}
	input::-moz-input-placeholder { color: #322c2c;}
	input:-moz-input-placeholder { color: #322c2c;}
	input::-moz-input-placeholder { color: #322c2c;}
	input:-ms-input-placeholder { color: #322c2c;}
    .top { width: 100%; text-align: center; overflow: hidden;}
	.top .succeed { margin: 15px 0 3px; font-size: 1.6rem; color: #ffb402;}
	.top .hint { font-size: 1.5rem; color: #858386;}
	.l_content { width: 100%; background-color: #white; margin: 20px 0 10px;}
	.l_content .input_box, .l_content .input_box2 { height: 50px; color: #322c2c; background-color: white;}
	.l_content .input_box { border-bottom: 1px solid #e9e9e9;}
	.userphone, .l_verification_code { height: 35px; padding: 7px 15px; font-size: 1.5rem; border: none;}
	.userphone { width: 45%;}
	.input_box input[type="button"]{ float: right; width: 35%; height: 40px; margin-top: 5px; margin-right: 10px; font-size: 1.6rem; color: #ffb402; border: 1px solid #ffb402; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; -o-border-radius: 3px; background-color: white;}
	.l_verification_code { width: 90%;}
	.verification_box { width: 94%; margin: 0 auto; line-height: 45px; margin-top: 20px;}
	.verification_box input[type="button"] { width: 100%; height: 40px; font-size: 1.6rem; color: #fff; border: none; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; -o-border-radius: 5px; background-color: #ffb402;}
    .verifyError { display: block; width: 100%; height: 25px; line-height: 25px; color: red; text-align:center;}
	.relieve_link {display:none; width: 94%; margin: 15px auto; text-align: left;}
	.relieve_link p { font-size: 1.4rem; color: #858386;}
	.relieve_link p span{ font-size: 1.4rem; color: #ffb402 !important; text-decoration: underline;}
</style>
</head>

<body>
	<div class="head">
        <a href="javascript:history.back(-1)" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
        <p>绑定手机号</p>
    </div>
    <div class="top">
    	<p class="succeed">授权成功</p>
        <p class="hint">请绑定你的手机号</p>
    </div>
    <form id="verifyForm" action="" method="post" >
		<input type="hidden" name="shopId" value="${shopId}" }>
		<input type="hidden" name="type" value="${type}" />
		<!--<input type="hidden" name="user_id" value="${userId}" >
		-->
		<!--<input type="hidden" name="redirectUri" value="${redirectUri}" >
	    --><div class="l_content">
	    	<div class="input_box">
	        	<input type="tel" class="userphone" id="bind_phone" name="phone" maxlength="11" value="${verifyPhone.phoneNo}" placeholder="请输入您的手机号">
	        	<input type="button" class="set_code" id="send_code" value="获取验证码">
	        </div>
	        <div class="input_box2">
	        	<input type="tel" class="l_verification_code" id="code" name="verifyCode" value="${verifyPhone.verifyCode}" placeholder="请输入短信中的验证码">
	        </div>
	        <div class="relieve_link" id="phone_bind_p">
            	<p>该号码已绑定其他用户，<a href="javascript:unbinding();"><span>请点击此处解绑</span></a>
            	</p>
            </div>
	        <div class="verification_box">
              	<span class="verifyError" id="verifyError" >${verifyError}${bindModel.invalid}</span>
	            <input type="button" class="" value="确定" onClick="javascript:save();">
	        </div>
	    </div>
    </form>
            
</body>
<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>
<script type="text/javascript">
/*$(function(){
	if(/MicroMessenger/i.test(navigator.userAgent)){
		$(".head").css('display','none');
	}else if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
	
					
	}else {
		$(".head").css('display','none');
	}
});*/

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
		if (!$.trim(bind_phone)) {
			alert("手机号不能为空");
			return false;
		}
		//var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|170|145|147)+\d{8})$/;
		var myreg = /^((1)+\d{10})$/;
	    if(!myreg.test($.trim(bind_phone)))
	    {
	        alert('请输入有效的手机号码！');
	        return false;
	    }
		if (isNaN(bind_phone)) {
			alert('你输入的含有其它字符');
			return false;
		};
//	alert(bind_phone);	
//	alert('${userId}');
		$.ajax({  
	   		type: "POST",  
	        url: '<%=basePath%>verify/sendVerifyCode',  
	        data: 'phone='+bind_phone+'&userId=${userId}&type=1',
	        success: function(data){
//	        	alert(data);
	        	if("false" == data){
	        		alert("验证码获取间隔时间过短");
	        	}else if("smsError" == data){
//	        		alert("网络无法连接");
	        	}else if("error" == data){
//	        		alert("登录已退出，请重新登录!"+data);
	        	}else if("bindModel" == data){
//	        		location= location;
	        		//alert("该号码已绑定其他用户！");
					//window.location.reload();
					$("#phone_bind_p").show();
	        		return false;
	        	}else if("success" == data){
	        		alert("验证码已发送，请注意查收信息！");
	        	}
			}  
		});  
		send_time(this);
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
	 
	var code=$('#code').val();
	if (!$.trim(code)) {
		alert("验证码不能为空");
		return false;
	}
		
	var path = '<%=basePath%>verify/matching';
	$('#verifyForm').attr("action", path).submit();
}

function unbinding(){
	$('#verifyForm').attr("action", "<%=basePath%>verify/unbinding").submit();
}
$(document).ready(function(){
	var messsageCode = '${requestScope.messageCode}';
	var messsage = '${requestScope.message}';
	if(messsage != ''){
		alert(messsage);
	}
});

</script>
