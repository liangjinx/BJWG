<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
        <title>手机绑定-验证手机</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/compilations_pz.css">
	</head>
	<body>
		<form method="post" id="verifyForm" name="verifyForm" action="<%=basePath %>wpv/urphoneChangePage2">
            <div class="c_content">
                <div class="tip">
                    <ul>
                        <li class="color_ffb">选择验证方式</li>
                        <li>&nbsp;&gt;&nbsp;</li>
                        <li>绑定新手机</li>
                    </ul>
                </div>
				<div class="old_phone" id="old_phone">${fn:substring(session_manager.bindPhone, 0, 3)}*****${fn:substring(session_manager.bindPhone, 7,fn:length(session_manager.bindPhone))}</div>
                <div class="check_box">
                	<span>效验码</span>
                	<input type="hidden" name="bind_phone" id="bind_phone" value="${session_manager.bindPhone }">
                    <input type="tel" class="verification_code" id="verifyCode" name="verifyCode" maxlength="4" placeholder="短信效验码">
                    <input type="button" class="send_code" id="send_code" value="发送效验码">
                </div>
                <div class="verification_box">
					<input type="button" value="验证" onClick="javascript:save();">
                </div>
                <div class="other_box">
                	<p>收不到短信验证码?试试以下验证方式</p>
                    <a href="tel:4006801888">
                        <div class="other_way">
                            <span class="left_font">人工验证&nbsp;</span>
                            <span class="right_font">立即验证</span>
                        </div>
                    </a>
                </div>
                <a href="tel:4006801888" class="z_contact_phone">客服电话：400-680-1888</a>
            </div>
        </form>
        <jsp:include page="../common/commonTip.jsp"></jsp:include>
        <jsp:include page="../back.jsp">
			<jsp:param value="wpv/uruserInfoModifyPage?r_type=2" name="backUrl"/>
		</jsp:include>
	</body>
</html>
<script type="text/javascript" src="<%=basePath %>resources/js/verifyCode.js"></script>
<script language="javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
<script language="javascript">
$(function(){
	$(".log-main").css("height",$(window).height());
})
$(function(){
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
		requestSendCode('<%=basePath%>',bind_phone,4,this);
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
		
	var path = '<%=basePath %>wpv/urphoneChangePage2';
	$('#verifyForm').attr("action", path).submit();
}
</script><!--
















<body>
	<div class="head">
        <a href="javascript:history.back(-1)" class="head_back">
        	<img src="<%=basePath %>resources/images/back.png" alt="返回">
        </a>
        <p>选择验证方式</p>
    </div>
    <form method="post" id="verifyForm" name="verifyForm" action="<%=basePath %>wpv/urphoneChangePage2">
        <div class="c_content">
            <div class="tip">
                <ul>
                    <li class="color_ffb">选择验证方式</li>
                    <li>&nbsp;&gt;&nbsp;</li>
                    <li>绑定新手机</li>
                </ul>
            </div>
			<div class="old_phone" id="old_phone">${fn:substring(session_manager.bindPhone, 0, 3)}*****${fn:substring(session_manager.bindPhone, 7,fn:length(session_manager.bindPhone))}</div>
            <div class="check_box">
            	<span>效验码</span>
            	<input type="hidden" name="bind_phone" id="bind_phone" value="${session_manager.bindPhone }">
                <input type="tel" class="verification_code" id="verifyCode" name="verifyCode" maxlength="4" placeholder="短信效验码">
                <input type="button" class="send_code" id="send_code" value="发送效验码">
            </div>
            <div class="verification_box">
				<input type="button" value="验证" onClick="javascript:save();">
            </div>
            <div class="other_box">
            	<p>收不到短信验证码?试试以下验证方式</p>
                <a href="tel:4006801888">
                    <div class="other_way">
                        <span class="left_font">客服验证&nbsp;</span>
                        <span class="right_font"><img src="<%=basePath %>resources/images/call.png" alt="客户验证电话">400-680-1888</span>
                    </div>
                </a>
            </div>
        </div>
    </form>
</body>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
</html>
<script type="text/javascript" src="<%=basePath %>resources/js/verifyCode.js"></script>
<script type="text/javascript">

$(function(){
	$(".log-main").css("height",$(window).height());
})
$(function(){
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
		requestSendCode('<%=basePath%>',bind_phone,4,this);
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
		
	var path = '<%=basePath %>wpv/urphoneChangePage2';
	$('#verifyForm').attr("action", path).submit();
}

</script>
-->