<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
     <meta http-equiv="content-type" content="text/html" charset="utf-8">
     <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
     <title>我的钱包</title>
     <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
	
	<!--[if IE]> 
    	<link href="<%=basePath %>resources/css/ie.css" rel="stylesheet">
    <![endif]-->
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<style type="text/css">
		.record_content,
       	.wd_at_present,
       	.wd_last {
       		width: 100%;
       		overflow: hidden;
       	}
       	.record_content {
       		margin-bottom: 20px;
       	}
       	.wd_at_present,
       	.wd_last {
       		border-bottom: 1px solid #efefef;
       	}
       	.top_title {
       		height: 60px;
       		line-height: 60px;
       		font-size: 1.6rem;
       		color: #858386;
       		text-align: center;
       	}
       	.at_present_time {
       		margin-right: 5px;
       	}
       	.record_box {
       		height: 80px;
       		border-top: 1px solid #efefef;
       		background-color: white;
       	}
       	.record_box_top,
       	.record_box_bottom {
       		height: 40px;
       		line-height: 40px;
       	}
       	.record_box_top {
       		font-size: 1.6rem;
       		color: #322c2c;
       	}
       	.record_box_bottom {
       		font-size: 1.5rem;
       		color: #858386;
       	}
       	.record_box_top span,
       	.record_box_bottom span {
       		float: left;
       		margin-left: 12px;
       	}
       	.record_box_top em,
       	.record_box_bottom em {
       		float: right;
       		margin-right: 12px;
       	}
		.no_thing {
			font-size: 1.6rem;
			color: #322c2c;
			margin-top: 30px;
			text-align: center;
		}
	</style>
  </head>
  <body>
  	<div class="head">
        <a href="javascript:history.back(-1)" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
        <p>提现记录</p>
    </div>
    <div class="record_content">
	    <c:choose>
	  		<c:when test="${fn:length(tmap)>0}">
		    	<c:forEach items="${tmap }" var="m" varStatus="status">
		    		<c:choose>
		    			<c:when test="${status.index == 0}">
		    				<div class="wd_at_present">
					    		<div class="top_title">
					    			<span class="at_present_time">
										<c:choose>
											<c:when test="${currentMonth eq m.key }">
												本月
											</c:when>
											<c:when test="${fn:substring(m.key,0,4) eq fn:substring(currentMonth,0,4)}">
												${fn:substring(m.key,5,fn:length(m.key))}
											</c:when>
											<c:otherwise>
												m.key
											</c:otherwise>
										</c:choose>
									</span>
					    			<em>提现:${mmap[m.key] }元</em>
					    		</div>
					    		<c:forEach items="${m.value }" var="l">
						    		<div class="record_box">
						    			<div class="record_box_top">
						    				<span>提现到银行卡</span>
						    				<em>-${l.money }</em>
						    			</div>
						    			<div class="record_box_bottom">
						    				<span>${l.fmtCTime }</span>
						    				<em>提现成功</em>
						    			</div>
						    		</div>
					    		</c:forEach>
					    	</div>
		    			</c:when>
		    			<c:otherwise>
		    				<div class="wd_last">
					    		<div class="top_title">
					    			<span class="at_present_time">
					    				<c:choose>
											<c:when test="${currentMonth eq m.key }">
												本月
											</c:when>
											<c:when test="${fn:substring(m.key,0,4) eq fn:substring(currentMonth,0,4)}">
												${fn:substring(m.key,5,fn:length(m.key))}
											</c:when>
											<c:otherwise>
												m.key
											</c:otherwise>
										</c:choose>
					    			</span>
					    			<em>提现:${mmap[m.key] }元</em>
					    		</div>
					    		<div class="record_box">
					    			<div class="record_box_top">
					    				<span>提现到银行卡</span>
					    				<em>-${l.money }</em>
					    			</div>
					    			<div class="record_box_bottom">
					    				<span>${l.fmtCTime }</span>
					    				<em>提现成功</em>
					    			</div>
					    		</div>
					    	</div>
		    			</c:otherwise>
		    		</c:choose>
		    	</c:forEach>
		    </c:when>
		    <c:otherwise>
		    	<p class="no_thing">您暂时还未有提现记录</p>
		    </c:otherwise>
		 </c:choose>
    </div>
  </body>
  <script language="javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
  <script language="javascript">
	/*$(function(){
		if(/MicroMessenger/i.test(navigator.userAgent)){
			$(".head").css('display','none');
		}else if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
		
						
		}else {
			$(".head").css('display','none');
		}
	});*/
	
  </script>
  <jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>
