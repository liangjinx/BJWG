<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
%>

<!-- 导入 -->
<jsp:include page="head/head.jsp"></jsp:include>

<script src="http://res.wx.qq.com/connect/zh_CN/htmledition/js/wxLogin.js"></script>
<script type="text/javascript"  src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js" data-appid="101208160" data-redirecturi="http://www.hzd.com" charset="utf-8"></script>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=0.5,minimum-scale=0.5,maximum-scale=0.5, user-scalable=no">
<title>登录</title>

<style type="text/css">
	.main{ width: 100%; height: 100%; background: none;}
	.log-main{ width: 100%; background: url(/resources/images/login-bg.png) no-repeat; background-size: 100% 100%; position: relative;}
	.head-login{ width: 100%; height: 50px; line-height: 50px; text-decoration: none; background: none; position: relative; top: 0; left: 0;}
	.log-logo{ width: 100%; text-align: center; position: absolute; top: 25%;}
	.log-way{ width: 90%; position: absolute; top: 50%; left: 5%;}
	.log-way li{ float: left; width: 40%; margin: 0 5%; text-align: center; overflow: hidden;}
	.log-way li img{ vertical-align: middle;}
	.log-way li p{ padding-top: 15px; font-size: 18px; color: #272728;}
</style>
</head>

<body>
	<div class="main">
        <div class="log-main">
            <!--<div class="head-login">
                <div class="head-back" onclick="javascript :history.back(-1)"></div>
            </div>-->
            <div class="log-logo"><img src="<%=basePath %>resources/images/login-logo.png" width="150"></div>
            <ul class="log-way">
            	<a href="javascript:weixinLogin(1);"><li><img src="<%=basePath %>resources/images/login-weixin.png" width="100"><p>使用微信登陆</p></li></a>
                <a href="javascript:login();"><li id="qqLoginBtn" ><img src="<%=basePath %>resources/images/Connect_logo_7.png" width="100"><p>使用QQ登陆</p></li></a>
            </ul>
            <div id="login_container"></div>
        </div>
    </div>
    
<script type="text/javascript">

/*QC.Login({
       btnId:"qqLoginBtn"	//插入按钮的节点id
});*/

$(function(){
	$(".log-main").css("height",$(window).height());
});

//
function weixinLogin(id){

	 var obj = new WxLogin({
                              id:"login_container", 
                              appid: "wxbe0f33707b7dd3cf", 
                              scope: "snsapi_login", 
                              redirect_uri: "http%3A%2F%2Fwx.hzd.com",
                              state: "STATE",
                              style: "black"
                            });
                            
	//获取用户个人信息（UnionID机制）
//	window.location.href = 'https://api.weixin.qq.com/sns/userinfo?access_token=OezXcEiiBSKSxW0eoylIeKwK92Gl8VCuabif72YKlfWfG_bZc6cuuM3sOneXs_6uHW2m6p799ULdlc2y81rtVoYVWNWSdSzUbTx4fLbi4Ao11NbbYNi9bgEwEvIm36gRlbIXLv_KVkhuWVOaeKlaAw&openid=ookLxt3Zi8O3JVLRFS8vzLA6qOpQ';
	
//	window.location.href = 'https://api.weixin.qq.com/sns/auth?access_token=OezXcEiiBSKSxW0eoylIeKwK92Gl8VCuabif72YKlfWfG_bZc6cuuM3sOneXs_6uHW2m6p799ULdlc2y81rtVoYVWNWSdSzUbTx4fLbi4Ao11NbbYNi9bgEwEvIm36gRlbIXLv_KVkhuWVOaeKlaAw&openid=ookLxt3Zi8O3JVLRFS8vzLA6qOpQ';

//	window.location.href = 'https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=wxbe0f33707b7dd3cf&grant_type=refresh_token&refresh_token=OezXcEiiBSKSxW0eoylIeKwK92Gl8VCuabif72YKlfWfG_bZc6cuuM3sOneXs_6uDC4SGaZc94QYQqCM1MGVntQjKngWYDohF8973fAYLyHdREE_hHG3KI0_uqKCafYycDnOjSyv4ApgN7foStNRKQ';

//	window.location.href = 'https://api.weixin.qq.com/sns/oauth2/access_token?appid=wxbe0f33707b7dd3cf&secret=9c95717ff6edf5b5a598aca0f38525fb&code=02166a2d6ec624397e84cb2f78180aet&state=STATE&grant_type=authorization_code';
	
//	window.location.href = 'https://open.weixin.qq.com/connect/qrconnect?appid=wxbe0f33707b7dd3cf&redirect_uri=http%3A%2F%2Fm.hzd.com&response_type=code&scope=snsapi_login&state=STATE#wechat_redirect';
	//公
//	window.location.href = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx61286443bbef2e4f&redirect_uri=m.hzd.com%2Findex.jsp&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect';
}
//
function login(){
	window.location.href = '<%=basePath%>login/sign';
//以下为按钮点击事件的逻辑。注意这里要重新打开窗口
   //否则后面跳转到QQ登录，授权页面时会直接缩小当前浏览器的窗口，而不是打开新窗口
//   var A=window.open("oauth/index.php","TencentLogin","width=450,height=320,menubar=0,scrollbars=1,resizable=1,status=1,titlebar=0,toolbar=0,location=1");
//   window.location.href = 'https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=101208160&redirect_uri=http%3A%2F%2Fwww.hzd.com&scope=get_user_info';
}
</script>
</body>
</html>
