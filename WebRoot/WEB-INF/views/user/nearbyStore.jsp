<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>附近八戒王国</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<div class="z_runmin">
			<p class="z_h10">&nbsp;</p>
			<c:choose>
				<c:when test="${fn:length(list) >0 }">
					<c:forEach items="${list}" var="store">
						<div class="storefront_box mb10">
							<div class="storefront_name">${store.name}</div>
							<div class="storefront_address">
								<span class="storefront_distance"><c:choose><c:when test="${store.distance != null }">${store.distance }</c:when><c:otherwise>--</c:otherwise></c:choose></span>
								<span class="fengexina"></span>
								<span class="storefront_specific_adress">${store.address}</span></div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="z_no_store">附近暂无润民鲜肉店.</div>
				</c:otherwise>
			</c:choose>				
		</div>
		<jsp:include page="../back.jsp">
			<jsp:param value="wpv/urmyCoupon" name="backUrl"/>
		</jsp:include>
	</body>
</html>
