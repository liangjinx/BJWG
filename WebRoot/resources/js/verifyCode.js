/**
	发送短信验证码
**/

var wait=60;
/**
 * 计数器
 * @param obj
 * @returns {Boolean}
 */
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
				
/**
 * 请求发送验证码
 * @param bind_phone
 * @returns {Boolean}
 */
function requestSendCode(basePath,bind_phone,sendType,obj){
	
	if (!$.trim(bind_phone)) {
		alert("手机号不能为空");
		return false;
	}
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
	$.ajax({  
   		type: "POST",  
        url: basePath+'wpnv/vpsendVerifyCode',  
        data: 'phone='+bind_phone+'&type='+sendType,
        dataType:'json',
        success: function(data){
        	var msg = "";
        	if(1 == data.status){
        		msg = "验证码已发送，请注意查收信息！";
        	}else if(-9 == data.status){
        		msg = "验证码获取间隔时间过短，请在"+data.leftTime+"秒后继续获取";
        		wait = data.leftTime;
        	}else if("" != data.msg){
        		msg = data.data.text;
        	}
        	send_time(obj);
        	alert(msg);
		},error : function() {
			wait = 60;
			send_time(obj);
			alert("发送验证失败");
		}
	});  
	
}
				