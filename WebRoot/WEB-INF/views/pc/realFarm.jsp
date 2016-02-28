<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="实时猪场" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="./meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/video-js.min.css" />
<link rel="stylesheet" href="resources/css/pc/public.css"/>
<style type="text/css">
	.lg_but_box{ margin-top: 30px; width: 470px; height: 105px; position:relative; cursor: pointer;}
	.li_real_but{ width: 470px; height: 90px; text-align: center; margin-top:15px;line-height: 90px; background: #999999; color: #fff; border: 0px; outline: 0px;font-family: "Microsoft YaHei" ! important; font-size: 30px; border-radius:5px; cursor: pointer; }
	.real_img{ background:url(resources/images/pc/realFarm_but.png) no-repeat center center; width: 23px; height: 16px; margin-left:231px; position:absolute; display: none;}
	.this_real .real_img{ display: block;}
	.this_real .li_real_but{background: #98bf0c;}
</style>
<script src="resources/js/pc/video.js"></script>
<script>
    videojs.options.flash.swf = "flash/video-js.swf";  
 </script>

</head>
<body>
	
<!--banner_box -->
<jsp:include page="header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="nav.jsp">
	<jsp:param value="4" name="nav"/>
</jsp:include>
<!-- 导航栏-->
	
<div class="d-video" style="background:url(resources/images/pc/real-video-bd.jpg) no-repeat center center;">
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
			<div id="playercontainer1" ></div>
		<div class="logo"><img src="resources/images/pc/logo_img02.png" alt="八戒王国online" /></div>
	</div>
</div>

<!-- star 多个监控  -->
<!-- --><div class="center">

	<div class="lg_but_box f_left this_real" >
		<div class="real_img"></div>
		<input type="button" value="俯瞰猪场" class="li_real_but" onclick="zShowPlayer1();" />
	</div>
	
	<div class="lg_but_box f_right" >
		<div class="real_img"></div>
		<input type="button" value="猪栏动态" class="li_real_but" onclick="zShowPlayer2();" />
	</div>
<div class="clear"></div>	
</div> 
<!-- end 多个监控  -->
<!-- content start -->




<div class="d-wrap">
	
	<div class="real-cont">
		
		<div class="row-1">
			<div class="row-cnt">
				<div class="title">
					<h2>互联网+畜牧业</h2>
					<p class="sub">3.8万亩超大生态养猪基地，随时随地拥有自己的猪场</p>
				</div>
				
				<div class="box">
					<ul class="list of-hide">
						<li>
							<div class="li-img"><img src="resources/images/pc/real-row-1-1.png" alt="透明" /></div>
							<div class="li-title">透明</div>
							<div class="li-sub">在线养殖，实时查看猪只在各个环节的生长情况</div>
						</li>
						<li>
							<div class="li-img"><img src="resources/images/pc/real-row-1-2.png" alt="实时" /></div>
							<div class="li-title">实时</div>
							<div class="li-sub">全程可远程监控，实时观看猪仔健康成长的过程</div>
						</li>
						<li>
							<div class="li-img"><img src="resources/images/pc/real-row-1-3.png" alt="低风险" /></div>
							<div class="li-title">低风险</div>
							<div class="li-sub">由于猪肉需求市场巨大， 收益不能达成的风险极低。</div>
						</li>
						<li>
							<div class="li-img"><img src="resources/images/pc/real-row-1-4.png" alt="高收益" /></div>
							<div class="li-title">高收益</div>
							<div class="li-sub">投三至四个月养殖期，9.6%收益率保本保息，秒杀余额宝</div>
						</li>
						<li>
							<div class="li-img"><img src="resources/images/pc/real-row-1-5.png" alt="食物回报" /></div>
							<div class="li-title">食物回报</div>
							<div class="li-sub">高品质，安全放心，“ 三零”标准进行生态养殖，吃上放心猪肉</div>
						</li>
					</ul>
				</div>
			</div>

		</div>
		
	</div>

</div>

<!-- content end -->

<!--底部 -->
<jsp:include page="footer.jsp"></jsp:include>
<!--底部 -->

</body>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script type="text/javascript" src="resources/js/cyberplayer.min.js"></script>
<script type="text/javascript" src="resources/js/cyberplayer.html5.min.js"></script>
<script type="text/javascript">
	
	
	var player = cyberplayer("playercontainer1").setup({
		width : '100%',
		height : 457,
		backcolor : "#FFFFFF",
		stretching : "uniform",
		file : "rtmp://hzrtmp01.ys7.com:1935/livestream/529421280_1_2_1_0",
		image : "resources/images/jk_1.jpg",
		autoStart : false,
		repeat : "always",
		volume : 100,
		controlbar : "over",
		// ak 和 sk（只需前 16 位）参数值需要开发者进行申请
		ak:'',
		sk:''
	});
	
</script>
<script>
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
 <script type="text/javascript">
 
 $('.lg_but_box').click(function(){
 	$('.lg_but_box').removeClass('this_real');
	$(this).addClass('this_real');
});

 function zShowPlayer1(){
	  player = cyberplayer("playercontainer1").setup({
			width : '100%',
			height : 457,
			backcolor : "#FFFFFF",
			stretching : "uniform",
			file : "rtmp://hzrtmp01.ys7.com:1935/livestream/529421280_1_2_1_0",
			image : "resources/images/jk_1.jpg",
			autoStart : false,
			repeat : "always",
			volume : 100,
			controlbar : "over",
			// ak 和 sk（只需前 16 位）参数值需要开发者进行申请
			ak:'',
			sk:''
		});
 }
 function zShowPlayer2(){
	  player = cyberplayer("playercontainer1").setup({
			width : '100%',
			height : 457,
			backcolor : "#FFFFFF",
			stretching : "uniform",
			file : "rtmp://hzrtmp02.ys7.com:1935/livestream/529421280_3_2_1_0",
			image : "resources/images/jk_2.jpg",
			autoStart : false,
			repeat : "always",
			volume : 100,
			controlbar : "over",
			// ak 和 sk（只需前 16 位）参数值需要开发者进行申请
			ak:'',
			sk:''
		});
 };
 
 </script>

</html>
