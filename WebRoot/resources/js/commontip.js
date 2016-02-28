/**
	本js文件作为公共提示信息使用
**/

/**
 * alert提示框
 * @param type - 类型 1成功 0失败
 * @param msgCode - 消息代号
 * @param msg - 消息内容
 * @param successTip - 成功是否提示
 */
function alertTip(type,msg,msgCode,successTip){
	
	if(type == '1'){
		
		if(!successTip){
			
			return ;
		}else{
			
			alert('操作成功');
			
			return ;
		}
	}
	
	if('' != msg){
		
		var pwd_error_div = $("#pwd_error_div");
		
		//alert(pwd_error_div);
		
		if(pwd_error_div && $(pwd_error_div) != null && $(pwd_error_div).length > 0 && msgCode == 'payPasswordIncorrect'){
			
			showPayPwdError();
		}else{
			
			alert(msg);
			
			//支付获取openid失败，重新进入公众号
			if('dataErrorAccessAgain' == msgCode){
				
				window.location.href="http://wx.bajiewg.com/wpnv/ixfirst";
			}
		}
	}
}
/**
 * div自定义提示框
 * @param type - 类型 1成功 0失败
 * @param msg - 消息内容
 * @param successTip - 成功是否提示
 */
function divTip(type,msg,successTip,btn){
	
	if(type == 1){
		
		if(!successTip){
			
			return ;
		}
	}
	
	alert(msg+'--'+btn);
}