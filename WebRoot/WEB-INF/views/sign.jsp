<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
%>

<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width,initial-scale=0.5,minimum-scale=0.5,maximum-scale=0.5, user-scalable=no">
    <script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<style type="text/css">
		.mask{ width: 100%; height: 100%; position: fixed; background: rgba(0,0,0,0.2); left:0; right: 0; top: 0; bottom: 0; z-index: 99;}
    	.share_li{position: absolute; top: 50%; left: 50%; transform:translate(-50%,-50%);  -webkit-transform:translate(-50%,-50%); padding-left: 50px; padding-right: 50px;  width: 480px; z-index: 1000; padding-bottom: 40px; }
    	.share_txt{ width: 100%;  text-align: center; padding: 20px 0; font-size: 1.8em;}
    	.share_li ul{ margin: auto;  text-align: center; }
	    .share_li li{ display: inline-block; width: 98%;}
	    .share_li img{  max-width: 100%;}
	</style>

  
  
</head>
<body>
<p><font style="font-size: 2.2em;">正在获取经纬度...</font></p>
<div class="mask"></div>
<!--<div class="share_li">
    <div class="share_txt"></div>
    <ul>
  		<li>
  			<p><font style="font-size: 2.2em;">正在获取经纬度...</font></p>
  		</li>
  	</ul>
</div>

--><script type="text/javascript">

var timestamp = '${timestamp}';
var nonceStr = '${nonceStr}';
var signature = '${signature}';
var falg = true;

$(document).ready(function(){
	wx.config({
	    //debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	    appId: '${appid}',//'wx61286443bbef2e4f', // 必填，公众号的唯一标识
	    timestamp: timestamp, // 必填，生成签名的时间戳
	    nonceStr: nonceStr, // 必填，生成签名的随机串
	    signature: signature,// 必填，签名，见附录1
	    jsApiList: ['getLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
	
	wx.ready(function(){
		falg = false;
		getLatlog();
	});

	wx.error(function(res){
		//alert('error11');
	    // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
	});
	
	if(falg){
	  	//window.location.href = '<%=basePath%>index/weizhi';
	}
	
});
//	
function checkApi() {
	wx.checkJsApi({
    jsApiList: ['getLocation'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
    success: function(res) {
    	//alert('abc');
       // 以键值对的形式返回，可用的api值true，不可用为false
       // 如：{"checkResult":{"chooseImage":true},"errMsg":"checkJsApi:ok"}
       }
	});
}
//
function getLatlog() {
	wx.getLocation({
	    success: function (res) {
	        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
	        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
	        var speed = res.speed; // 速度，以米/每秒计
	        var accuracy = res.accuracy; // 位置精度
	        
	        $('#latitude').val(latitude);
	        $('#longitude').val(longitude);
	        $('#speed').val(speed);
	        $('#accuracy').val(accuracy);
	        $('#index_form').submit();
	        
	        //window.location.href = '<%=basePath%>wpnv/ixhome?latitude='+latitude+'&longitude='+longitude+'&speed='+speed+'&accuracy='+accuracy;
	       // alert(latitude + '--' + longitude);
	    },
	    fail: function (data) {
	    	alert('获取当前位置失败');
	    	//window.location.href = '<%=basePath%>wpnv/ixhome';
	    	$('#index_form').submit();
	    }
	});
}
</script>

<form action="<%=basePath%>wpnv/ixsetLaglot" id="index_form" method="post"> 
	<input type="hidden" name="latitude" id="latitude" value="" >
	<input type="hidden" name="longitude" id="longitude"  value="" >
	<input type="hidden" name="speed" id="speed"  value="" >
	<input type="hidden" name="accuracy" id="accuracy" value="" >
</form>
    
</body>
</html>