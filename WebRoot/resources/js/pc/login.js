$(function(){
	
	$('#btnlogin1').click(function() {
		
		var self = $(this);
		var mobile = $('[name=mobile]').val().trim();
		var password = $('[name=password]').val().trim();
		var auto = $('#log-auto').is(':checked');
		if(!mobile || mobile.trim()=='' || !/^((1)+\d{10})$/.test(mobile)){
			alert('请正确输入手机号!');
			return;
		}
		if(password == '' || !/^(\w){6,20}$/.test(password)){
			alert('请正确输入登录密码');
			return;
		}
		self.attr('disabled', 'disabled');
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : __base_path__+'pc/pnv/login',
			cache : false,
			data : {
				phone : mobile,
				password : password,
				type : 3,
				autoLogin: auto?1:0
			},
			success : function(data) {
				if (data.msg == 'success') {
					window.location.href="/";
				} else {
					
					alert(data.data.text);
					self.removeAttr('disabled');
				}
			},
			error : function() {
				alert('error');
			}
		});

	});
	
	
	$('#btnlogin2').click(function() {
	
		var self = $(this);
		var ep_username = $('[name=ep_username]').val().trim();
		var ep_password = $('[name=ep_password]').val().trim();
		var auto = $('#log-auto').is(':checked');
		if(!ep_username || ep_username.trim()=='' || !/^\w+$/.test(ep_username)){
			alert('请正确输入登录名!');
			return;
		}
		if(password == '' || !/^(\w){6,20}$/.test(ep_password)){
			alert('请正确输入登录密码');
			return;
		}
		self.attr('disabled', 'disabled');
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : __base_path__+'pc/pnv/login',
			cache : false,
			data : {
				username : ep_username,
				password : ep_password,
				type : 4,
				autoLogin: auto?1:0
			},
			success : function(data) {
				if (data.msg == 'success') {
					window.location.href="/";
				} else {				
					alert(data.data.text);
					self.removeAttr('disabled');
				}
			},
			error : function() {
				alert('error');
			}
		});

	});
	
	
	
	
	
	
	
})