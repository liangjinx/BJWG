<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="__page_name__" value="资讯详情" scope="request"/>
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
	<jsp:param value="7" name="nav"/>
</jsp:include>
<!-- 导航栏-->
	
	
<div class="d-banner">
	<img src="resources/images/pc/news-banner-1.jpg" alt="亚洲最大单体生态养猪基地" />
</div>

<!-- content start -->

<div class="d-wrap of-hide">
	
	<div class="d-contain">
		<div class="d-nav fl-left of-hide">
			<div class="nav-cnt fl-right">
				<h2 class="title">资讯导航</h2>
				<div class="list">
					<c:forEach items="${categories}" var="cy" varStatus="status">
						<a href="pc/pnv/news?type=${cy.value }" 
						<c:if test="${type == cy.value || ((type == null || type<=0) && status.index==0)}">
							class="current"
						</c:if>
						>${cy.name }<i class="d-icon"></i></a>
					</c:forEach>
				</div>
			</div>
		</div>
		
		<div class="d-content fl-left of-hide">
			<div class="d-article fl-right">
				<div class="title">
					<h1>${news.title }</h1>
					<p class="sub">
						<span class="s1"><fmt:formatDate value='${news.ctime }' pattern='yyyy-MM-dd HH:mm:ss' /></span>
						<span class="s2">字号：
							<i>小</i>
							<i class="current">标准</i>
							<i>中</i>
							<i>大</i>
						</span>
					</p>
				</div>
				
				<div class="content z_new_detail">
					${news.detail }
				</div>
				
				<div class="other">
					<p>上一篇：
						<c:choose>
							<c:when test="${lastNews!=null}">
								<a href="pc/pnv/newsDetail?newsId=${lastNews.infoId }">${lastNews.title}</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:;">无</a>
							</c:otherwise>
						</c:choose>
					</p>
					<p>下一篇：
						<c:choose>
							<c:when test="${nextNews!=null}">
								<a href="pc/pnv/newsDetail?newsId=${nextNews.infoId }">${nextNews.title}</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:;">无</a>
							</c:otherwise>
						</c:choose>
					</p>
					<p>所属类别： <a href="pc/pnv/news?type=${type }">
						<c:forEach items="${categories}" var="cy" varStatus="status">
							<c:if test="${type == cy.value}">
								${cy.name }
							</c:if>
						</c:forEach>
					</a></p>
					<!--<p>该资讯的关键词为：<a href="javascript:;">深圳广电集团</a>&nbsp;&nbsp;<a href="javascript:;">广电润民调研</a>&nbsp;&nbsp;<a href="javascript:;">润民集团</a></p>
				--></div>
				
			</div>
		</div>
	</div>
	
	<div class="bd-left wrap-bd"></div>
	<dvi class="bd-right wrap-bd"></dvi>
</div>

<!-- content end -->

<!--底部 -->
<jsp:include page="footer.jsp"></jsp:include>
<!--底部 -->

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
