${jsonRes}
${userArea.city}
${code}
${json}
${weixinUser.nickname}
${weixinUser.country}



${session_manager}
${session_manager.userId}
${weixinUser}
${json}
${code}
${addUser}

<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
%>

<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" />
  <script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
  <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
  
  <script type="text/javascript" src="http://api.map.baidu.com/api?ak=DqTGazNxpb6tujm41W2ULrtb&v=2.0&services=true"></script>  
</head>
<body>

<span onclick="getLatlog();">获取经纬度</span><br>
<span click="checkApi();">检查api</span><br>
timestamp:${timestamp}<br>
nonceStr:${nonceStr}<br>
signature:${signature}<br>
url:${url}<br>
jsapi_ticket:${jsapi_ticket}<br>
token:${token}<br>


<div id="map"></div>

<script type="text/javascript">

var timestamp = '${timestamp}';
var nonceStr = '${nonceStr}';
var signature = '${signature}';
//var thecode = '${code}';
var code = '${code}';

$(document).ready(function(){
	wx.config({
	    debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	    appId: 'wxbe1733e33bb01bdf',//'wx61286443bbef2e4f', // 必填，公众号的唯一标识
	    timestamp: timestamp, // 必填，生成签名的时间戳
	    nonceStr: nonceStr, // 必填，生成签名的随机串
	    signature: signature,// 必填，签名，见附录1
	    jsApiList: ['getLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
	
	wx.ready(function(){
		getLatlog();
	});

	wx.error(function(res){
		//alert('error');
	    // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
	
	});
});
	
	
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
function getLatlog() {
	wx.getLocation({
	    success: function (res) {
	        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
	        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
	        var speed = res.speed; // 速度，以米/每秒计
	        var accuracy = res.accuracy; // 位置精度
	        //根据经纬度获取城市名
	        var map = new BMap.Map("map");      
			map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);      
			// 创建地理编码实例      
			var myGeo = new BMap.Geocoder();      
			// 根据坐标得到地址描述  
			myGeo.getLocation(new BMap.Point(longitude,latitude), function(result){      
				if (result){    
					var addcomp = result.addressComponents;  
				    city = addcomp.city;   
				    window.location.href = '<%=basePath%>wpnv/ixhome?code='+code+'&latitude='+latitude+'&longitude='+longitude+'&city_id='+city;   
				 }      
			});
	    },
	    fail: function (data) {
	    	alert('获取当前位置失败，请手动选择');
	    	//window.location.href = '<%=basePath%>wpnv/ixprovince';
	    }
	});
}
</script>
<a href="/index/laglot">test</a>
</body>
</html>