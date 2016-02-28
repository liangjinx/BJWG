<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
		<title>提示</title>
		<link rel="stylesheet" href="<%=basePath %>resources/css/public.css" />
		<style>
			.z_main { position: relative; width: 100%; min-height: 100%; padding-bottom: 10px; background: url(<%=basePath %>resources/images/background.jpg) repeat-y; background-size: 100% auto;}
			.z_h80 { width: 100%; height: 80px;}
			.z_error_img { width: 100%; height: 120px; background: url(<%=basePath %>resources/images/z-error-img_03.png) no-repeat center center;}
			.z_word { width: 100%; font-size: 16px; color: #979698; text-align: center;}
			.z_error_detail { width: 100%; height: auto; margin-top: 20px; text-align: center;}
			.z_btnsbox { width: 100%; height: auto;}
			.z_return, .z_showreason { width: 80px; height: auto; padding: 5px 0; font-size: 16px; text-align: center; border: none; -webkit-border-radius: 2px; -moz-border-radius: 2px; border-radius: 2px;}
			.z_return { margin-right: 10px; color: #615868; background-color: #ebebeb;}
			.z_showreason { color: #fff; background-color: #3cbd6d;}
			.z_reason_datail { display: none; width: 80%; height: auto; margin: 10px auto 0; padding: 5px; line-height: 1.6; font-size: 14px; color: #615868; text-align: left; text-indent: 2em; border: 1px solid #dedede; -webkit-border-radius: 2px; -moz-border-radius: 2px; border-radius: 2px; background-color: #fff;}
		</style>
	</head>
	<body>
		<div class="z_main">
			<p class="z_h80">&nbsp;</p>
			<div class="z_error_img"></div>
			<p class="z_word">进入页面失败</p>
			<div class="z_error_detail">
				<div class="z_btnsbox">
					<input type="button" class="z_return" value="重新进入" onclick="javascript:location.href='<%=basePath %>wpnv/ixfirst'" />
					<input type="button" class="z_showreason" value="显示错误" />
				</div>
				<div class="z_reason_datail">
					<p>错误代号：${messageCode }</p>
					<p>错误信息：${message }</p>
					<p>具体内容：${error_detail }</p>
				</div>
			</div>
		</div>
	</body>
</html>
<script type="text/javascript" src="<%=basePath %>resources/js/zepto.min.js" ></script>
<script>
	$(function(){
		$('.z_showreason').data('flag', false).on('click',function(){
			var $self = $(this),
				reason = $('.z_reason_datail'),
				flag = $self.data('flag');
			
			// 通过标记当前赠送按钮状态来显示弹层
			if (!flag) {
				$(this).parent().parent().find(reason).show();
				$self.data('flag', true);
			} else {
				$(this).parent().parent().find(reason).hide();
				$self.data('flag', false);
			}
		});
	});
</script>


