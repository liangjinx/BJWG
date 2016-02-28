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
			<div class="news-list fl-left">
				<div class="title">
					<h1>
						<c:forEach items="${categories}" var="cy" varStatus="status">
						<c:if test="${type == cy.value || ((type == null || type<=0) && status.index==0)}">
							${cy.name }
						</c:if>
						</c:forEach>
					</h1>
				</div>
				
				<div class="content">
					<c:forEach items="${news}" var="nw" varStatus="status">
						<div class="item of-hide">
							<div class="img fl-left">
								<a href="pc/pnv/newsDetail?newsId=${nw.infoId }"><img src="${nw.path }" alt="${nw.title }" /></a>
							</div>
							<div class="info fl-left">
								<h3 class="title"><a href="pc/pnv/newsDetail?newsId=${nw.infoId }" class="title">${nw.title }</a></h3>
								<p class="sub">${nw.summary }</p>
								<a href="pc/pnv/newsDetail?newsId=${nw.infoId }" class="detail">详情</a>
							</div>
						</div>
					</c:forEach>
				</div>
				
				<div class="paging">
					<span class="dib">${pagerArg.rowCount }条</span>
					<c:if test="${pagerArg.pageCount>0 }">
						<a href="pc/pnv/news?type=${type }&currentPage=${pagerArg.beginPage }" class="dib">上一页</a>
						<c:forEach begin="${pagerArg.beginPage }" end="${pagerArg.endPage }" var="p">
							<a href="pc/pnv/news?type=${type }&currentPage=${p }" class="dib ${pagerArg.currentPage==p?'current':'' }">${p }</a>
						</c:forEach>
						<c:if test="${pagerArg.endPage!=pagerArg.pageCount }">
							<span class="dib">...</span>
						</c:if>
						<a href="pc/pnv/news?type=${type }&currentPage=${pagerArg.nextPage }" class="dib">下一页</a>
					</c:if>
				</div>
				
			</div>
		</div>
	</div>
	
	<div class="bd-left wrap-bd"></div>
	<dvi class="bd-right wrap-bd"></dvi>
</div>

<!-- content end -->

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

