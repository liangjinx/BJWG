<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>微信支付</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
  <style type="text/css">
  	body{ font-size: 1.3rem; font-family: "Microsoft YaHei"; background-color: #fff;}
	.z_infor { position: fixed; left: 50%;top:50%; width: 90%; height: auto; text-align: center; border: none; transform: translate(-50%,-50%); -webkit-transform: translate(-50%,-50%); -moz-transform: translate(-50%,-50%); background: none; z-index: 100;}
	.z_infor img { width: 150px;}
	.mark { position: fixed; left: 0; right: 0; top: 0; bottom: 0; width: 100%; height: 100%; background: rgba(0,0,0,0); z-index: 99;}
  </style>
  </head>
  
  <body>
    
    <body>
    	<div class="z_infor"><!--正在加载中……-->
			<img src="<%=basePath %>resources/images/z-load.gif" alt="正在加载中，请稍候..." />
		</div>
		<div class="mark"></div>
		<!--
			<br><br><br><br><br><br><br>
  			<div style="text-align:center;size:30px;"><input type="button" id="btn" style="width:200px;height:80px;" value="微信支付" onclick="callpay()"></div>
  		-->
  </body>
  
  <script type="text/javascript">
	
		setTimeout("callpay()",2000);
		
	  	function callpay(){
			 WeixinJSBridge.invoke('getBrandWCPayRequest',{
	  		 "appId" : "<%=request.getAttribute("appId")%>","timeStamp" : "<%=request.getAttribute("timeStamp")%>", "nonceStr" : "<%=request.getAttribute("nonceStr")%>", "package" : "<%=request.getAttribute("package")%>","signType" : "MD5", "paySign" : "<%=request.getAttribute("paySign")%>" 
	   			},function(res){
	   				//alert("res:"+res);
	   				//alert("err_msg:"+res.err_msg);
					//WeixinJSBridge.log("log:"+res.err_msg);
	 				//alert("err_code:"+res.err_code + "err_desc:"+ res.err_desc+ "err_msg:" + res.err_msg);
	 				var url = "<%=basePath%>wpv/ororderDetail?orderId=<%=request.getAttribute("orderId")%>";
		            if(res.err_msg == "get_brand_wcpay_request:ok"){  
		                alert("微信支付成功!");  
		                //window.location.href=url;
		            }else if(res.err_msg == "get_brand_wcpay_request:cancel"){  
		                alert("用户取消支付!");  
	 					url = "<%=basePath%>wpv/orbreakWxPay?orderId=<%=request.getAttribute("orderId")%>";
		                //window.location.href=url;
		            }else{  
		                alert("支付失败!");  
	 				    url = "<%=basePath%>wpv/orbreakWxPay?orderId=<%=request.getAttribute("orderId")%>";
		                //window.location.href=url;
		            }
		            
	                window.location.href=url;
				});
			}
			
		if(typeof WeixinJSBridge == "undefined"){
		   if( document.addEventListener ){
		       document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
		   }else if (document.attachEvent){
		       document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
		       document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
		   }
		}else{
			callpay();
		}
		
  </script>
  <!-- 
    <form action="https://api.mch.weixin.qq.com/pay/unifiedorder" method="post">
    	公众账号ID:<input type="text" name="appid" value=""><br>
    	商户号:<input type="text" name="mch_id" value=""><br>
    	随机字符串:<input type="text" name="nonce_str" value=""><br>
    	签名:<input type="text" name="sign" value=""><br>
    	商品描述:<input type="text" name="body" value=""><br>
    	商户订单号:<input type="text" name="out_trade_no" value=""><br>
    	总金额:<input type="text" name="total_fee" value="100"><br>
    	终端IP:<input type="text" name="spbill_create_ip" value="120.24.217.254"><br>
    	通知地址:<input type="text" name="" value="http://testweixin.hzd.com/"><br>
    	交易类型:<input type="text" name="trade_type" value="JSAPI"><br>
    	<input type="submit" name="" value="微信支付">
    </form>
     -->
  </body>
</html>
