<%@page import="java.net.URLDecoder"%>
<%@page import="com.bjwg.main.util.StringUtils"%>
<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title></title>
<style>
	/*Guide the instructions*/
	.mark2 { position: fixed; left: 0; right: 0; top: 0; bottom: 0; display: block; width: 100%; height: 100%; z-index: 99;}
	.mark2 img { width: 100%;}
	#img2, #img3 { display: none;}
	#area1, #area2, #area3, #area11, #area22 { -webkit-tap-highlight-color: transparent;}
</style>
</head>

<body>
	
</body>
</html>
<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
	//star 热点
	$(function(){
		var w = window.innerWidth;
		var y = window.innerHeight;
		var x1 = 0;
		var y1 = 0;
		var x2 = 0;
		var y2 = 0.1667 * y ;
		var x3 = w ;
		var y3 = y2;
		var x4 = x3;
		var y4 = 0;
		
		//1、钱包明细；2、银行卡管理，3、支付管理
		$('#area1, #area2, #area3, #area4, #area5').attr('coords',x1 +','+ y1 +','+ x2 +','+ y2 +','+ x3 +','+ y3 +','+ x4 +','+ y4);
		$('#area11, #area22, #area33, #area44, #area55').attr('coords',x2 +','+ y2 +','+ x2 +','+ y +','+ w+','+ y +','+ x3 +','+ y3);
	});
	
	$(function(){
		$('.mark2').show();
	});
	$(function(){
		$('#area1, #area2, #area3, #area4, #area5').on('click',function(){
			$('.mark2').hide();
		});
		$('#area11').on('click',function(){
			$('#img1').hide();
			$('#img2').show();
		});
		$('#area22').on('click',function(){
			$('#img2').hide();
			$('#img3').show();
		});
		$('#area33').on('click',function(){
			$('#img3').css('display','none');
			$('#img4').css('display','block');
		});
		$('#area44').on('click',function(){
			$('#img4').css('display','none');
			$('#img5').css('display','block');
		});
	});//end 热点
</script>

