<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="__page_name__" value="资讯导航" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="./meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/public.css"/>
</head>
<body>

<!--banner_box -->
<jsp:include page="header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="nav.jsp">
	<jsp:param value="6" name="nav"/>
</jsp:include>
<!-- 导航栏-->
	
<div class="d-banner">
	<img src="resources/images/pc/about-banner-1.jpg" alt="亚洲最大单体生态养猪基地" />
</div>
<div class="d-wrap of-hide">
		<div class="d-contain">
			<div class="d-nav fl-left of-hide">
				<div class="nav-cnt fl-right">
					<h2 class="title">关于我们</h2>
					<div class="list">
						
						<a href="pc/pnv/runminIntro">润民简介<i class="d-icon"></i></a> 
						<a href="pc/pnv/platfarmIntro">平台说明<i class="d-icon"></i></a> 
						<a href="pc/pnv/breedProcess">养猪工艺<i class="d-icon"></i></a> 
						<a href="pc/pnv/question">常见问题<i class="d-icon"></i></a>
						<a href="pc/pnv/protocol">用户协议<i class="d-icon"></i></a>
						<a href="pc/pnv/connect"  class="current">联系我们<i class="d-icon"></i></a>
						
						</div>
				</div>
			</div>
		
		<div class="d-content fl-left of-hide">
			<div class="of-hide"style="width:968px; float: right;">
	
	<div class="d-contain about-cont" style="width:960px;">
		<div class="row">
			<h2 class="title">联系我们</h2>
			<div>
			<table cellspacing="8px">
			<tr>
			<td>公司地址：深圳市福田区深南大道1006号深圳国际创新中心A栋18楼</td>
			</tr>
			<tr>
			<td>客服电话：0755 83579888</td>
			</tr>
			<tr>
			<td>客服QQ：3328285961</td>
			</tr>
			<tr>
			<td>客服微信：bajiewgol</td>
			</tr>
			<tr>
			<td>QQ交流群：178200138</td>
			</tr>
			<tr>
			<td>公司位置地图：</td>
			</tr>
			</table><br/>
			<img src="/resources/images/pc/address.png" alt="公司位置" title="公司位置" align="left" />
			</div>
		</div>
		</div>
	</div>
</div>
		</div>
	</div>
	
	<div class="bd-left wrap-bd"></div>
	<dvi class="bd-right wrap-bd"></dvi>
<jsp:include page="footer.jsp"></jsp:include>

</body>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script>
	(function(){
		/*字号选择*/
		var $i = $('.d-article .title i');
		$i.on('click',function(){
			var index = $(this).index();
			
			$i.removeClass('current');
			$(this).addClass('current');
			$('.d-article .content p').css({
				'font-size': index*2 + 14 + 'px',
			});
		})
		
		/**/
		
	})()
</script>
</html>