$(function(){
	//基础信息修改按钮
	$('#btnBasicInfoModify').click(function(){
		var self = $(this);
		var nickName = $('#basicInfoModifyPanel [name=nickName]').val().trim();
		var sex = $('#basicInfoModifyPanel [name=sex]:checked').val().trim();
		
		if(nickName == '' || sex == ''){
			alert('请输入必填项');
			return;
		}
		
		self.attr('disabled','disabled');
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/user/basicInfoSave',
		    cache: false,
		    data: {nickName:nickName, sex:sex},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('修改成功')
		    		window.location.href=__base_path__+"/pc/pv/user/personalSetting";
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
	//登录密码修改按钮
	$('#btnLoginPwdModify').click(function(){
		var self = $(this);
		var flag=$("#flag").val();
		
		var oldpwd = $('#loginPwdModifyPanel [name=oldpwd]').val().trim();
		var newpwd = $('#loginPwdModifyPanel [name=newpwd]').val().trim();
		var newpwd2 = $('#loginPwdModifyPanel [name=newpwd2]').val().trim();
		
		if(oldpwd == '' || newpwd == '' || newpwd2 == ''){
			alert('请输入必填项');
			return;
		}
		if(!/^(\w){6,20}$/.test(oldpwd)){
			alert('请正确输入旧密码');
			return;
		}
		if(!/^(\w){6,20}$/.test(newpwd)){
			alert('请正确输入新密码!(密码为6-20位非中文字符)');
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
		    url: __base_path__+'pc/pv/user/updateLoginPassword',
		    cache: false,
		    data: {oldPwd:oldpwd, newPwd:newpwd},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('修改成功');
		    		if(flag=='2'){
		    			window.location.href=__base_path__+'pc/pv/epuser/personalSetting'
		    		}
		    		else{
		    		window.location.href=__base_path__+'pc/pv/user/personalSetting';}
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
	//支付密码修改按钮
	$('#btnPayPwdModify').click(function(){
		var self = $(this);
		var submitUrl = __base_path__+'pc/pv/wallet/payPasswordModify';
		//判断是否第一次设置密码
		var isNewPayPwd = false;
		if($('#payPwdModifyPanel [name=oldpwd]').parent().css('display')=='none'){
			isNewPayPwd = true;
			submitUrl = __base_path__+'pc/pv/wallet/setPayPassword';
		}
		
		var oldpwd = $('#payPwdModifyPanel [name=oldpwd]').val().trim();
		var newpwd = $('#payPwdModifyPanel [name=newpwd]').val().trim();
		var newpwd2 = $('#payPwdModifyPanel [name=newpwd2]').val().trim();
		
/*		if((isNewPayPwd ? false : (oldpwd == '')) || newpwd == '' || newpwd2 == ''){
			alert('请输入必填项');
			return;
		}*/
		if(!isNewPayPwd && (oldpwd=='' || oldpwd.length!=6 || !/^[0-9]*$/.test(oldpwd))){
			alert('请正确输入旧支付密码');
			return;
		}
		if(newpwd=='' || newpwd.length!=6 || !/^[0-9]*$/.test(newpwd)){
			alert('请正确输入新支付密码');
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
		    data: {oldPwd:oldpwd, newPwd:newpwd},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('修改成功');
		    		window.location.href=__base_path__+'pc/pv/user/personalSetting';
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
	//邮箱修改按钮
	$('#btnEmailModify').click(function(){
		var self = $(this);
		var email = $('#emailPanel [name=email]').val().trim();
		
		if(email == ''){
			alert('请输入必填项');
			return;
		}
		if(!/^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/.test(email)){
			alert('请输入正确的邮箱地址');
			return;
		}
		
		self.attr('disabled','disabled');
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/user/updateEmail',
		    cache: false,
		    data: {email:email},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('修改成功')
		    		window.location.href=__base_path__+'pc/pv/user/personalSetting';
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
	//手机号码更改-->旧手机号验证码获取按钮
	$('#btnOldMobileVerifyCodeGet').click(function(){
		var self = $(this);
		var timerId;
		if(self.text()=='获取验证码'){
			self.attr('disabled','disabled');
			var mobile = $('#mobileModifyPanel [name=mobile]').val();
			//ajax
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "http://wx.bajiewg.com/"+'wpnv/vpsendVerifyCode',
			    cache: false,
			    data: {phone:mobile,type:4},
			    success: function(data){
			    	if(data.msg == 'success'){
			    		var num=5;
						timerId = window.setInterval(function(){
							if(num == 0){
								window.clearInterval(timerId);
								self.text('获取验证码');
								self.removeAttr('disabled');
								return;
							}
							self.text((num--)+'秒后可重新发送');
						},1000);
			    	} else {
			    		alert(data.data.text);
			    		self.removeAttr('disabled');
			    	}
			    },
			    error: function(){
			    	alert('error');
			    }
			});
		}
	});
	//手机号码更改-->下一步按钮
	$('#next').click(function(){
		var self = $(this);
		var code = $('#mobileModifyPanel [name=oldVerifyCode]').val();
		if(!code || code.trim()=='' || code.length!=4 || !/^[0-9]*$/.test(code)){
			alert('请正确输入验证码!');
			return;
		}
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/user/mobileModifyVerify',
		    cache: false,
		    data: {verifyCode:code,type:1},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		//alert('旧手机号校验成功');
		    		//self.removeAttr('disabled');
		    		$('.step1_element').css('display','none');
		    		$('.step2_element').css('display','block');
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
	//手机号码更改-->新手机号验证码获取按钮
	$('#btnNewMobileVerifyCodeGet').click(function(){
		var self = $(this);
		var timerId;
		var mobile = $('#mobileModifyPanel [name=newMobile]').val();
		if(!mobile || mobile.trim()=='' || !/^((1)+\d{10})$/.test(mobile)){
			alert('请正确输入新手机号!');
			return;
		}
		if(self.text()=='获取验证码'){
			self.attr('disabled','disabled');
			//ajax
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "http://wx.bajiewg.com/"+'wpnv/vpsendVerifyCode',
			    cache: false,
			    data: {phone:mobile,type:5},
			    success: function(data){
			    	if(data.msg == 'success'){
			    		var num=5;
						timerId = window.setInterval(function(){
							if(num == 0){
								window.clearInterval(timerId);
								self.text('获取验证码');
								self.removeAttr('disabled');
								return;
							}
							self.text((num--)+'秒后可重新发送');
						},1000);
			    	} else {
			    		alert(data.data.text);
			    		self.removeAttr('disabled');
			    	}
			    },
			    error: function(){
			    	alert('error');
			    }
			});
		}
	});
	//手机号码更改-->完成提交按钮
	$('#btnMobileModifyFinish').click(function(){
		var self = $(this);
		var code = $('#mobileModifyPanel [name=newVerifyCode]').val();
		var mobile = $('#mobileModifyPanel [name=newMobile]').val();
		if(!code || code.trim()=='' || code.length!=4 || !/^[0-9]*$/.test(code)){
			alert('请正确输入验证码!');
			return;
		}
		if(!mobile || mobile.trim()=='' || !/^((1)+\d{10})$/.test(mobile)){
			alert('请正确输入新手机号!');
			return;
		}
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/user/mobileModifyVerify',
		    cache: false,
		    data: {verifyCode:code,type:2,phone:mobile},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('修改成功');
		    		window.location.href=__base_path__+'pc/pv/user/personalSetting';
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
	
	$('.mypig_body [id$=Panel] .btnPanelShow').click(function(){
		if($(this).text()=='修改'){
			$(this).parents('[id$=Panel]').children('.innerElement').css('display','block');
			$(this).text('取消修改');
		}else{
			$(this).parents('[id$=Panel]').children('.innerElement').css('display','none');
			$(this).text('修改');
		}
		
	});
	
	$('.mypig_body [id$=Panel] .innerElement').css('display','none');
	
})

































