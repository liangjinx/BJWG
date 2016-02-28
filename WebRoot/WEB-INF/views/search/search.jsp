<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/swiper3.07.min.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/module.css">
		<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
		<title>好站点，您身边的上门服务!</title>

<script type="text/javascript">
	function querySearch(url,id){
		$("#class_id").val(id);
		$("#search_Form").attr("action",url).submit();
	}
</script>
		
	</head>
	<body class="search">
		<div class="head d_head">
	    	<a href="javascript:history.back(-1);" class="head_back"></a>
	    	<div class="search_input_box">
	    		<form action="<%=basePath%>index/getShopSearchList" id="searchForm" method="post" >
	    			<input type="text" name="keyword" class="form_search" placeholder="外卖" id="form_search" style="color: white;"/>
	    		</form>
	    	</div>
	    	<a href="javascript:;" class="top_search"></a>
	    </div>
		
		<div class="content d_content search_content">
			
			<div class="not_result_search" >
				<div>
					<p>没有搜索结果哦！</p>
					<p>试试下面的吧</p>
				</div>
			</div>
			
	<form action="" id="search_Form"  method="post" target="_self">
		<input type="hidden" name="class_id" id="class_id" value="">
				
			<div class="hot_search">
				<h6 class="h6">热门搜索：</h6>
				<div class="search_text_box">
				
					 <c:forEach items="${categories }" var="cate" varStatus="gory">
	            		<a href="javascript:querySearch('<%=basePath %>index/getShopSearchList',${cate.categoryId});"><span>${cate.name}</span></a>
	            	</c:forEach>
	            	
				</div>
			</div>
			
			<div class="history_search">
				<h6 class="h6">搜索历史：</h6>
				<div class="search_text_box">
				
					<c:forEach items="${categories }" var="cate" varStatus="gory">
	            		<a href="javascript:querySearch('<%=basePath %>index/getShopSearchList',${cate.categoryId});"><span>${cate.name}</span></a>
	            	</c:forEach>
	            	
				</div>
			</div>
			
			<div class="clear_search"><span>清空历史搜索</span></div>
	</form>		
		</div>
		
		
	</body>
	
<script language="javascript" src="<%=basePath %>resources/js/zepto.min.js"></script>
<script>
	$('.top_search').tap(function(){
		alert(11);
		var name=$('#form_search').val();
		if (!$.trim(name)) {
			alert("搜索条件不能为空");
			$('#form_search').focus();
			return false;
		}
		//接口
		$('#searchForm').submit();
	});
	
	$('.clear_search span').on('tap', function(){
		$('.history_search').html('');
	});
    
</script>
	
</html>
