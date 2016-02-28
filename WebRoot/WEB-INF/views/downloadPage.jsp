<%@page import="java.net.URLDecoder"%>
<%@page import="com.bjwg.main.util.StringUtils"%>
<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
 	/*String downloadUrl = request.getParameter("downloadUrl");
 	if(StringUtils.isNotEmpty(downloadUrl)){
 		downloadUrl = URLDecoder.decode(downloadUrl);
 		request.setAttribute("downloadUrl",downloadUrl);
 	}*/
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=0.5,minimum-scale=0.5,maximum-scale=0.5, user-scalable=no">
<title></title>
<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>

<style>
	body { background: #484848 url(/resources/images/weixin_download.png) 86% 0 no-repeat;}
</style>
</head>

<body onload="click();">
<a id="link" href="${requestScope.downloadUrl}"></a>
<script type="text/javascript">
 function click(){
 	$("#link").click();
 }
 $(document).ready(function() {
 		var downloadUrl = "${requestScope.downloadUrl}";
		if(downloadUrl == "" || downloadUrl.length <= 10){
			alert("无效下载地址");
			return false;
		}
	    var ua = navigator.userAgent.toLowerCase();
     	//alert(ua);
     	//微信进入的
	    if(ua.match(/MicroMessenger/i)=="micromessenger") {
	    
			//window.location.href = "http://hzdo2o.oss-cn-shenzhen.aliyuncs.com/upload/apk/android_new.apk";
	        return true;
	     } else {
	     	$("body").css("background","#484848");
	     	//是安卓或uc浏览器 
	     	if(ua.indexOf('android') > -1 || ua.indexOf('linux') > -1){
	     		//alert("android");
		     	//window.location.href = "http://hzdo2o.oss-cn-shenzhen.aliyuncs.com/upload/apk/android_new.apk";
		     	$("#link").click(function(){
					//window.location.href = "http://hzdo2o.oss-cn-shenzhen.aliyuncs.com/upload/apk/android_new.apk";
					window.location.href = "${requestScope.downloadUrl}";
				});
		     	//ios终端 
	     	}else if(ua.indexOf('iphone') > -1 || ua.indexOf('ipad') > -1 || !!ua.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)){
	     		
	     		//alert("ios");
	     		if(ua.match(/qq\//)){
	     			//alert(2);
	     		}
		     	//window.location.href = "itms-services://?action=download-manifest&url=https://dn-fkpinche.qbox.me/fkpc.plist";
		     	$("#link").click(function(){
		     		//alert("暂未开放");
		     		//window.location.href = "itms-services://?action=download-manifest&url=https://www.hzd.com/ftp/hzdios/plist.plist";
		     		window.location.href = "${requestScope.downloadUrl}";
		     	});
		     	
	     	}else{
	     		//alert("其它");
	     		//window.location.href = "http://hzdo2o.oss-cn-shenzhen.aliyuncs.com/upload/apk/android_new.apk";
		     	$("#link").click(function(){
			     	//window.location.href = "http://hzdo2o.oss-cn-shenzhen.aliyuncs.com/upload/apk/android_new.apk";
			     	window.location.href = "${requestScope.downloadUrl}";
		     	});
	     	}
	     }
	    
	  //window.location.href = "http://hzdo2o.oss-cn-shenzhen.aliyuncs.com/upload/apk/201505250151.apk";
 });
 
 
</script>

</body>
</html>
