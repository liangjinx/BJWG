
$(function(){
	$('#clickShop1').hide();
	$('#clickShop2').hide();
	var f1=null;
	var f2=null;
	
	function flashCount1(){
		var activeId=$("#activeId1").val();
		var count1=$("#remindCount1");
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : __base_path__+'pc/pnv/remindCount',
			cache : false,
			data : {
				
				activeId:activeId
			},
			success : function(data) {
				count1.text(data.data.text);
			},
			error : function() {
				alert('error');
			}
		});
		
		
	}
	
	function flashCount2(){
		var activeId=$("#activeId2").val();
		var count2=$("#remindCount2");
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : __base_path__+'pc/pnv/remindCount',
			cache : false,
			data : {
				
				activeId:activeId
			},
			success : function(data) {
				count2.text(data.data.text);
			},
			error : function() {
				alert('error');
			}
		});		
	}

	$('#button1').click(function(){

		clearInterval(f1);
		var activeId=$("#activeId1").val();
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : __base_path__+'pc/pnv/selectCount',
			cache : false,
			data : {
				
				activeId:activeId
			},
			success : function(data) {
				if (data.msg == 'success') {
					$('#clickShop1').show();
					var f1=setInterval(flashCount1,1000);
				} 
				else if(data.msg == 'restart'){
					alert(data.data.text);
					
					$('#clickShop1').show();
					var f1=setInterval(flashCount1,1000);
				}
				
				else {					
					alert(data.data.text);
					self.removeAttr('disabled');
					
				}
			},
			error : function() {
				alert('error');
			}
		});
	
	});
	
	$('#button2').click(function(){
	
		var self = $(this);
		clearInterval(f2);
		
		
		var activeId=$("#activeId2").val();
		self.attr('disabled', 'disabled');
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : __base_path__+'pc/pnv/selectCount',
			cache : false,
			data : {
				
				activeId:activeId
			},
			success : function(data) {
				if (data.msg == 'success') {
					$('#clickShop2').show();
					var f2=setInterval(flashCount2,1500);
				} 
				else if(data.msg == 'restart'){
					alert(data.data.text);
					
					$('#clickShop1').show();
					var f1=setInterval(flashCount1,1000);
				}
				
				
				else {					
					alert(data.data.text);
					self.removeAttr('disabled');
					
				}
			},
			error : function() {
				alert('error');
			}
		});
		
		
		
		
		
		
	});
	
	
	$("#affirm1").click(function(){
		clearInterval(f1);
		var self = $(this);
		var count=$("#count1").val();
	
		var activeId=$("#activeId1").val();
		if(count==''|| !/^[0-9]*[1-9][0-9]*$/.test(count)){
			alert("请正确输入数量");
			return;
		}
		
		if(parseInt(count)>parseInt(300)){
			alert("请给别人留点机会");
			return;
		}
		self.attr('disabled', 'disabled');
		
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : __base_path__+'pc/pnv/activeSub1',
			cache : false,
			data : {
				count : count,
				activeId:activeId
			},
			success : function(data) {
				if (data.msg == 'success') {
					window.location.href="/pc/active/orderConfirm";
				} 
				else if(data.msg == 'outofCode'){
					alert(data.data.text);
					self.removeAttr('disabled');
				}
				else {					
					alert(data.data.text);
					self.removeAttr('disabled');
					window.location.href="/pc/pnv/loginPage"
				}
			},
			error : function() {
				alert('error');
			}
		});
	});
	
	
	
	$("#affirm2").click(function(){
		clearInterval(f2);
		var self = $(this);
		var count=$("#count2").val();
		var activeId=$("#activeId2").val();
		if(count==''|| !/^[0-9]*[1-9][0-9]*$/.test(count)){
			alert("请正确输入数量");
			return;
		}
		if(count>300){
			alert("请给别人留点机会");
			return;
		}
		
		self.attr('disabled', 'disabled');
		
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : __base_path__+'pc/pnv/activeSub2',
			cache : false,
			data : {
				count : count,
				activeId:activeId
			},
			success : function(data) {
				if (data.msg == 'success') {
					window.location.href="/pc/active/orderConfirm";
				} else if(data.msg == 'outofCode'){
					alert(data.data.text);
					self.removeAttr('disabled');
				}
				else {					
					alert(data.data.text);
					self.removeAttr('disabled');
					window.location.href="/pc/pnv/loginPage"
				}
			},
			error : function() {
				alert('error');
			}
		});
	});
	
	
	
	
	
	
	/*
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
	
	*/
	
	
	
	
	
})