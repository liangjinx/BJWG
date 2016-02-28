<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="设置支付密码" scope="request"/>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<jsp:include page="../meta.jsp"></jsp:include>
	 	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" href="resources/css/pc/base.css"/>
		<link rel="stylesheet" href="resources/css/pc/main.css"/>
		<link rel="stylesheet" href="resources/css/pc/pangzi_overview.css" />
	</head>
	<body class="body_bg">
		<!--banner_box -->
		<jsp:include page="../header.jsp"></jsp:include>
		<!--banner_box -->
		<!--导航栏-->
		<jsp:include page="../nav.jsp">
			<jsp:param value="5" name="nav"/>
		</jsp:include>
		<!-- 导航栏-->
		
		
		<!--中间部分 -->
		<div class="center mypig_center">
			<!--mypig_left_nav -->
			<jsp:include page="../user/nav.jsp">
				<jsp:param value="1" name="nav"/>
			</jsp:include>
			<!--mypig_left_nav -->
			<div class="right_main">
			    <div class="mypig_body">
			    	
			    	<!-- 添加银行卡 -->
			    	<div class="z_fir">
			    		<div class="z_fir_title f_l clearfix">
			    			<div class="z_green_point f_l"></div>
			    			<div class="z_fir_title_word f_l">添加银行卡</div>
			    			<div class="z_green_point f_l"></div>
			    		</div>
			    		
			    		<div class="z_payword_box f_l">
			    			<h4 class="z_payword_h4">为保障您账户安全，请设置支付密码。</h4>
			    			<div class="z_payword_content">
			    				<div class="z_inputbox">
			    					<label class="z_payword_label">支付密码:</label>
			    					<input type="password" name="newpwd" class="z_payword" maxlength="6" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
			    					<span class="z_hint">请输入6位数字支付密码</span>
			    				</div>
			    				<div class="z_inputbox">
			    					<label class="z_payword_label">确认密码:</label>
			    					<input type="password" name="newpwd2" class="z_payword" maxlength="6" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
			    				</div>
			    				<input type="button" id="btnPayPwdModify" class="z_payword_save_btn" value="确定" />
			    			</div>
			    		</div>
			    		
			    	</div><!-- 添加银行卡 -->
			    	
			    </div>
			</div>
			<div class="clear"></div>
		</div><!-- end mypig_center -->
		<!-- 中间部分-->
		
		
		<!--底部 -->
		<jsp:include page="../footer.jsp"></jsp:include>
		<!--底部 -->
	</body>
</html>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/public.js"></script>

<script>
	$(function(){
		$('#btnPayPwdModify').click(function(){
			var self = $(this);
			var submitUrl = __base_path__+'pc/pv/wallet/setPayPassword';
			
			var newpwd = $('[name=newpwd]').val();
			var newpwd2 = $('[name=newpwd2]').val();
			
			if(newpwd=='' || newpwd.length!=6 || !/^[0-9]*$/.test(newpwd)){
				alert('请正确输入新支付密码!(支付密码为6位数字)');
				return;
			}
			if(newpwd!=newpwd2){
				alert('两次输入的密码不一致');
				return;
			}
			
			self.attr('disabled','disabled');
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: submitUrl,
			    cache: false,
			    data: {newPwd:newpwd},
			    success: function(data){
			    	if(data.msg == 'success'){
			    		alert('设置成功');
			    		window.location.href = __base_path__+"pc/pv/wallet/home";
			    	} else {
			    		alert(data.data.text);
			    		self.removeAttr('disabled');
			    	}
			    },
			    error: function(){
			    	alert('error');
			    }
			});
		});
	})
</script>



<%--

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>支付密码设置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery.js"></script>
	<script>
		$(function(){
			$('#btnPayPwdModify').click(function(){
		var self = $(this);
		var submitUrl = 'pv/wallet/setPayPassword';
		
		var newpwd = $('#payPwdModifyPanel [name=newpwd]').val().trim();
		var newpwd2 = $('#payPwdModifyPanel [name=newpwd2]').val().trim();
		
		if(newpwd == '' || newpwd2 == ''){
			alert('请输入必填项');
			return;
		}
		if(newpwd.length<6){
			alert('密码必须是6位数');
			return;
		}
		if(newpwd!=newpwd2){
			alert('两次输入的密码不一致');
			return;
		}
		
		self.attr('disabled','disabled');
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: submitUrl,
		    cache: false,
		    data: {newPwd:newpwd},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('设置成功');
		    		window.location.href = "pv/wallet/home";
		    	} else {
		    		alert(data.data.text);
		    		self.removeAttr('disabled');
		    	}
		    },
		    error: function(){
		    	alert('error');
		    }
		});
	});
		})
	</script>
  </head>
  
  <body>
    <h3>支付密码设置</h3>
    <div id="payPwdModifyPanel">
    <div>请输入新密码<input type="text" name="newpwd"/></div>
    <div>请输入新密码2<input type="text" name="newpwd2"/></div>
    </div>
    <button type="button" id="btnPayPwdModify">支付密码修改提交</button>
  </body>
</html>
--%>