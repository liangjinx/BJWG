<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>实时监控</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/pc/video-js.min.css" />
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
        <script src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
        <script type="text/javascript" src="<%=basePath %>resources/js/cyberplayer.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>resources/js/cyberplayer.html5.min.js"></script>
	</head>
	<body>
		
		<%--
		<div id="a1"></div>
		<script type="text/javascript" src="<%=basePath %>resources/ckplayer/ckplayer.js" charset="utf-8"></script>
		<script type="text/javascript">
		    var flashvars={
		        f:'rtmp://hzrtmp02.ys7.com:1935/livestream/529859849_1_2_1_0',
		        c:0
		    };
		    var video=['http://vshare.ys7.com:80/hcnp/529859849_1_2_1_0_183.136.184.7_6500.m3u8'];
		    CKobject.embed('<%=basePath %>resources/ckplayer/ckplayer.swf','a1','ckplayer_a1','600','400',false,flashvars,video);
		</script>
		
		
		
		<div id="playercontainer"></div>
		<script type="text/javascript" src="<%=basePath %>resources/js/cyberplayer.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>resources/js/cyberplayer.html5.min.js"></script>
		<script type="text/javascript">
			var player = cyberplayer("playercontainer").setup({
			width : '100%',
			height : 400,
			backcolor : "#FFFFFF",
			stretching : "uniform",
			file : "rtmp://hzrtmp02.ys7.com:1935/livestream/529859849_1_2_1_0",
			image : "https://i.ys7.com/static/images/f19cf6375d224ec4b6a785f54f12b153/c884ff4c3163ac36f15de962393c8e2d/2.jpeg",
			autoStart : false,
			repeat : "always",
			volume : 100,
			controlbar : "over",
			// ak 和 sk（只需前 16 位）参数值需要开发者进行申请
			ak:'',
			sk:''
			});
		</script>
		--%>
		<%--
		
		 --%>
		 <%--<p align="center">   
			<OBJECT classid="clsid:9BE31822-FDAD-461B-AD51-BE1D1C159921"  
			codebase="http://downloads.videolan.org/pub/videolan/vlc/latest/win32/axvlc.cab"  
			width="800" height="450" id="vlc" events="True">  
			<param name="AutoLoop" value="0" />  
			<param name="AutoPlay" value="-1" />  
			<param name="Toolbar" value="0">  
			<param name="ExtentWidth" value="21167">  
			<param name="ExtentHeight" value="11906">  
			<param name="MRL" ref value="rtsp://183.136.184.33:8554/demo://529421280:5:2:1:0:183.136.184.7:6500">  
			<param name="Visible" value="-1">  
			<param name="Volume" value="50">  
			<param name="StartTime" value="0">  
			<param name="BaseURL" value="unsaved:///new_page_1.htm">  
			<param name="BackColor" value="0">  
			</OBJECT>  
			</p>  
			<div id="liveVideo" class="clear">
			</div>

		<script type="text/javascript">
			var camerPlug ="<OBJECT ID='axvlc' classid='clsid:9BE31822-FDAD-461B-AD51-BE1D1C159921'	 codebase='axvlc.cab' 	 id='vlc' events='True'>	 <param name='MRL' id='MRL' ref value='rtsp://183.136.184.33:8554/demo://529421280:5:2:1:0:183.136.184.7:6500'>	 <param name='Volume' value='50'> </OBJECT>"
			document.getElementById('liveVideo').innerHTML = camerPlug;
		</script>
		--%>
		<!-- star wx video -->
		<div class="z_video_box" name="v1">
			<p class="z_monitoring_way_1">八戒王国online实时监控---俯瞰猪场</p>
			<video src="http://vshare.ys7.com:80/hcnp/529421280_1_2_1_0_183.136.184.7_6500.m3u8" 
					controls="controls" poster="<%=basePath %>resources/images/jk_1.jpg" 
					webkit-playsinline="" webkit-playsinline="" preload="none" class="z_videos">
			</video>
		</div>
		<div class="z_video_box" name="v1">
			<p class="z_monitoring_way_1">八戒王国online实时监控---猪栏动态</p>
			<video src="http://vshare.ys7.com:80/hcnp/529421280_3_2_1_0_183.136.184.7_6500.m3u8" 
					controls="controls" poster="<%=basePath %>resources/images/jk_2.jpg" 
					webkit-playsinline="" webkit-playsinline="" preload="none" class="z_videos">
					
			</video>
		</div><!-- end wx video -->
		
		<!-- star pc--wx video -->
		<div class="z_video_box" name="v2">
			<div class="d-video">
				<p class="z_monitoring_way_1">八戒王国online实时监控---俯瞰猪场</p>
				<div class="cnt">
					<div id="playercontainer1" ></div>
					<div class="logo"><img src="<%=basePath %>resources/images/pc/logo_img02.png" alt="八戒王国" /></div>
				</div>
			</div>
		</div>
		<div class="z_video_box" name="v2">
			<div class="d-video">
				<p class="z_monitoring_way_1">八戒王国online实时监控---猪栏动态</p>
				<div class="cnt">
					<%--
					<div class="date"></div>
					<video id="example_video_1" class="video-js vjs-default-skin" controls preload="none" width="808" height="457"
					      poster="resources/images/pc/real-video-img.jpg"
					      data-setup="{}">
					   		<source src="http://video-js.zencoder.com/oceans-clip.mp4" type='video/mp4' />
					   		您的浏览器不支持此视频播放！
					</video>
					--%>
					<div id="playercontainer2" ></div>
					<div class="logo"><img src="<%=basePath %>resources/images/pc/logo_img02.png" alt="八戒王国" /></div>
				</div>
			</div>
		</div>
		
	</body>
	



<%-- 
<!--content/begin-->
<div id="content" >

<!--HLSPlayer代码开始-->
<div class="video" id="HLSPlayer" >
<SCRIPT LANGUAGE=JavaScript>
<!--
/*
* HLSPlayer参数应用=========================<br>
* @Contact QQ:261532593 
* @param {Object} vID        ID
* @param {Object} vWidth     播放器宽度设置
* @param {Object} vHeight    播放器宽度设置
* @param {Object} vPlayer    播放器文件
* @param {Object} vHLSset    HLS配置
* @param {Object} vPic       视频缩略图
* @param {Object} vCssurl    移动端CSS应用文件
* @param {Object} vHLSurl    HLS(m3u8)地址
* ==========================================
*/
var vID        = ""; 
var vWidth     = "100%";                //播放器宽度设置
var vHeight    = 400;                   //播放器宽度设置
var vPlayer    = "<%=basePath %>resources/HLS/HLSPlayer.swf"; //播放器文件
var vHLSset    = "<%=basePath %>resources/HLS/HLS.swf";             //HLS配置
var vPic       = "<%=basePath %>resources/HLS/images/start.jpg";    //视频缩略图
var vCssurl    = "<%=basePath %>resources/HLS/images/mini.css";     //移动端CSS应用文件

//HLS(m3u8)地址,适配PC,安卓,iOS,WP
var vHLSurl    = "http://vshare.ys7.com:80/hcnp/529859849_1_2_1_0_183.136.184.7_6500.m3u8";

//-->
</SCRIPT> 
<script type="text/javascript" src="<%=basePath %>resources/HLS/hls.min.js?rand=20141217"></script>
</div>
<!--HLSPlayer代码结束-->

--%>
</html>
<script>
	var browser={    
	    versions:function(){     
	           var u = navigator.userAgent, app = navigator.appVersion;     
	           return {//移动终端浏览器版本信息     
	                trident: u.indexOf('Trident') > -1, //IE内核    
	                presto: u.indexOf('Presto') > -1, //opera内核    
	                webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核    
	                gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核    
	                mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端    
	                ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端    
	                android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器    
	                iPhone: u.indexOf('iPhone') > -1 , //是否为iPhone或者QQHD浏览器    
	                iPad: u.indexOf('iPad') > -1, //是否iPad      
	                webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部    
	            };    
	         }(),    
	         language:(navigator.browserLanguage || navigator.language).toLowerCase()    
	}     
	    
	if(browser.versions.mobile || browser.versions.ios || browser.versions.android ||     
	   browser.versions.iPhone || browser.versions.iPad){          
	   	
		//window.location = "http://m.baidu.com";       
		
		$("div[name=v1]").show();
		$("div[name=v2]").hide();
	}else{
		
		$("div[name=v1]").hide();
		$("div[name=v2]").show();
	} 

	$(function(){
		//时间
		function nowDate(){
			var date = new Date().toLocaleString();
			return date.replace(/([^\u0000-\u00FF])/g, '&nbsp;');
		}
		setInterval(function(){
			$('.date').html(nowDate());
		},1000);
	})
</script>
<script>
//function zShowPlayer1(){
	  player = cyberplayer("playercontainer1").setup({
			width : '100%',
			height : 457,
			backcolor : "#FFFFFF",
			stretching : "uniform",
			file : "rtmp://hzrtmp01.ys7.com:1935/livestream/529421280_1_2_1_0",
			image : "<%=basePath %>resources/images/jk_1.jpg",
			autoStart : false,
			repeat : "always",
			volume : 100,
			controlbar : "over",
			// ak 和 sk（只需前 16 位）参数值需要开发者进行申请
			ak:'',
			sk:''
		});
//}
//function zShowPlayer2(){
	  player = cyberplayer("playercontainer2").setup({
			width : '100%',
			height : 457,
			backcolor : "#FFFFFF",
			stretching : "uniform",
			file : "rtmp://hzrtmp02.ys7.com:1935/livestream/529421280_3_2_1_0",
			image : "<%=basePath %>resources/images/jk_2.jpg",
			autoStart : false,
			repeat : "always",
			volume : 100,
			controlbar : "over",
			// ak 和 sk（只需前 16 位）参数值需要开发者进行申请
			ak:'',
			sk:''
		});
/*};*/
</script>
