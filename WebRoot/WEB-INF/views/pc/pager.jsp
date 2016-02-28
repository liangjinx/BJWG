<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	/*page*/
	.paging{ float: right; height:94px; margin-right: 13px; line-height:94px; text-align:right;}
	.paging *{ font-size:16px; height:29px; line-height:29px; margin:0 1px; vertical-align: middle;}
	.paging button, .paging a{ display:inline-block; *display:inline; *zoom:1; border: none; outline:none; border:1px solid #e5e5e5; padding:0 12px; background-color:#fff; cursor:pointer; color: #333;}
	.paging a:hover{ color: #ff6600;text-decoration: underline;}
	.paging a input{ height:29px; line-height:29px; border:none; width:42px; vertical-align:top; text-align:center;}
	.paging .disable{cursor:default;color:#999;}
	.paging .int{padding:0;}
	.paging .current{ color:#FF6600; cursor:default; border:none; background-color:inherit; *background-color:#f0f2f1;}
</style>
<%-- 翻页栏参数对象 --%>
<c:if test="${param.pagerConfigArg!=null}">
	<c:set var="pagerArg" value="${requestScope[param.pagerConfigArg]}"/>
</c:if>
<c:if test="${param.pagerConfigArg==null}">
	<c:set var="pagerArg" value="${requestScope.pager}"/>
</c:if>
<%-- 页面URI --%>
<c:if test="${param.otherQueryArg!= null}">
	<c:set var="pageURL"><%=request.getAttribute("javax.servlet.forward.request_uri").toString()%>?${param.otherQueryArg}&</c:set>
</c:if>
<c:if test="${param.otherQueryArg== null}">
	<c:set var="pageURL"><%=request.getAttribute("javax.servlet.forward.request_uri").toString()%>?</c:set>
</c:if>
<c:if test="${pagerArg != null and pagerArg.pageCount>0 }">
<div class="paging">
	<a href="${pageURL}currentPage=${pagerArg.lastPage}" class="dib">上一页</a>
	<c:forEach begin="${pagerArg.beginPage}" end="${pagerArg.endPage}" var="p">
		<a href="${pageURL}currentPage=${p}" class="${pagerArg.currentPage==p?'current':'' }">${p}</a>
	</c:forEach>
	<c:if test="${pagerArg.endPage != pagerArg.pageCount }">
		<span>...</span>
		<a href="${pageURL}currentPage=${pagerArg.pageCount}">${pagerArg.pageCount}</a>
	</c:if>
	<a class="dib" href="${pageURL}currentPage=${pagerArg.nextPage }">下一页</a>
	<span>&nbsp;&nbsp;到第</span>
	<a href="javascript:;" class="int">
		<input type="text" value="1" name="${param.pagerConfigArg}_currentPage" maxLength=5 />
	</a>
	<span>页</span>
	<button type="button" class="dib ${param.pagerConfigArg}_btn_jump">
		确定
	</button>
</div>
<script>
	document.getElementsByClassName('${param.pagerConfigArg}_btn_jump')[0].onclick = function(){
		window.location.href='${pageURL}currentPage='+document.getElementsByName('${param.pagerConfigArg}_currentPage')[0].value;
	};
	/*$(function(){
		$('.${param.pagerConfigArg}_btn_jump').click(function(){
			window.location.href='${pageURL}currentPage='+$('[name=${param.pagerConfigArg}_currentPage]').val();
		})
	})*/
</script>
</c:if>
