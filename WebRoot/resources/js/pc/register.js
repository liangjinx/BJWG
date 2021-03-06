$(function(){
	$('#getVerifyCode').click(function(){
		var self = $(this);
		var timerId;
		
		var mobile = $('[name=mobile]').val();
		if(!mobile || mobile.trim()=='' || !/^((1)+\d{10})$/.test(mobile)){
			alert('请正确输入手机号!');
			return;
		}
		
		if(self.val()=='发送验证码'){
			self.attr('disabled','disabled');
			//ajax
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    url: "http://wx.bajiewg.com/"+'wpnv/vpsendVerifyCode',
			    cache: false,
			    data: {phone:mobile,type:2},
			    success: function(data){
			    	if(data.msg == 'success'){
			    		var num=60;
						timerId = window.setInterval(function(){
							if(num == 0){
								window.clearInterval(timerId);
								self.val('发送验证码');
								self.removeAttr('disabled');
								return;
							}
							self.val((num--)+'');
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
	$('#regbtn').click(function(){
		
		if(!$('#log-auto').is(":checked")){
			alert('请先同意用户协议!');
			return;
		}
		var self = $(this);
		var mobile = $('[name=mobile]').val().trim();
		var password = $('[name=password]').val().trim();
		var verifyCode = $('[name=verifyCode]').val().trim();
		if(!mobile || mobile.trim()=='' || !/^((1)+\d{10})$/.test(mobile)){
			alert('请正确输入手机号!');
			return;
		}
		if(!verifyCode || verifyCode.trim()=='' || verifyCode.length!=4 || !/^[0-9]*$/.test(verifyCode)){
			alert('请正确输入验证码!');
			return;
		}
		if(!/^(\w){6,20}$/.test(password)){
			alert('请正确输入密码!(密码为6-20位非中文字符)');
			return;
		}
		
		self.attr('disabled','disabled');
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pnv/register',
		    cache: false,
		    data: {phone:mobile,password:password,verifyCode:verifyCode},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('注册成功');
		    		window.location.href="/";
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