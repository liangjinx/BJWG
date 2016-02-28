<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>首页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta name="keywords" content="keyword1,keyword2,keyword3">
	<meta name="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/pc/index.js"></script>
	<style>
		*{
		font-family: 微软雅黑;
    	font-size: 13px;
		}
		.panel{
			margin-bottom:20px;
		}
		.panel>.title{
			display: block;
    		border-bottom: 1px solid red;
    		margin-bottom: 5px;
    		color: red;
    		width: 300px;
		}
		.panel>.title:before{
			content: '>';
		}
	</style>
  </head>
  
  <body>
  	<div>登录用户: <span style="color:red">${sessionScope[CommConstant.SESSION_MANAGER]=='session_manager'?'未登录':sessionScope[CommConstant.SESSION_MANAGER].username}</span></div>
    <div>
    	<div class="panel" id="project_now_panel">
    		<span class="title">当期正在进行的项目</span>
    		<div>
    			<div>猪品种:${curProj.variety }</div>
    			<div>已抢购数量:${curProj.num - curProj.leftNum }</div>
    			<div>总数:${curProj.num }</div>
    			<div>单价:${curProj.price }</div>
    			<div>预计年化收益:${curProj }%</div>
    			<div><a href="pv/order/submitConfirm?projectId=${curProj.paincbuyProjectId }&num=10">立即抢购</a></div>
    		</div>
    	</div>
    	<div class="panel" id="project_next_panel">
    		<span class="title">下期预告</span>
    		<div>
    			<div>猪品种:${nextProj.variety }</div>
    			<div>已抢购数量:0</div>
    			<div>总数:${nextProj.num }</div>
    			<div>单价:${nextProj.price }</div>
    			<div>预计年化收益:${nextProj }%</div>
    			<div>倒计时:${nextProj.beginTime }</div>
    		</div>
    	</div>
    	<div class="panel" id="top_20_panel">
    		<span class="title">当期抢购数量前20名单</span>
    	</div>
    	<div class="panel" id="news_panel">
    		<span class="title">资讯导航</span>
    	</div>
    </div>
    <div>
    	<a href="pv/user/home">我的猪场</a>
    </div>
  </body>
</html>








