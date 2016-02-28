<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=0.5,minimum-scale=0.5,maximum-scale=0.5, user-scalable=no">
<title>登录</title>

<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
<%--<script src="http://res.wx.qq.com/connect/zh_CN/htmledition/js/wxLogin.js"></script>
<script type="text/javascript"  src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js" data-appid="101208160" data-redirecturi="http://www.hzd.com" charset="utf-8"></script>

--%>
</head>

<!--
<body>

<div align="center" style="margin-top: 10%;font-size: 24px;">
<a href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx61286443bbef2e4f&redirect_uri=http%3A%2F%2Fm.hzd.com%2Findex%2Findexhome&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect">点击这里绑定</a>
</div>

</body>
-->

<script type="text/javascript">

$(document).ready(function(){
//	window.open('https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx61286443bbef2e4f&redirect_uri=http%3A%2F%2Fm.hzd.com%2Findex%2Findexhome&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect');
	//window.location.href = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx61286443bbef2e4f&redirect_uri=http%3A%2F%2Fm.hzd.com%2Findex%2Findexhome&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect';
	window.location.href = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=${appid}&redirect_uri=http%3A%2F%2Fwx.bajiewg.com%2Fwpnv%2Fixindex&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect';
	
});

</script>

</html>
