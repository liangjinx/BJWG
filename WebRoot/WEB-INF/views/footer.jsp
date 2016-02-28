<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
 	request.setAttribute("pageIndex",request.getParameter("pageIndex"));
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
        <title>底部导航</title>
        <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/footer.css">
	</head>
	<body>
		<footer class="foot">
			<ul>
				<a href="<%=basePath %>wpnv/ixhome">
					<li>
						<c:choose>
							<c:when test="${pageIndex eq 10001 }">
								<img src="<%=basePath %>resources/images/nav-1.png" class="index_icon" alt="首页" />
								<p class="b_nav_active">八戒王国</p>
							</c:when>
							<c:otherwise>
								<img src="<%=basePath %>resources/images/nav-11.png" class="index_icon" alt="首页" />
								<p>八戒王国</p>
							</c:otherwise>
						</c:choose>
					</li>
				</a>
				<a href="<%=basePath %>wpv/urmyFriends">
					<li>
						<c:choose>
							<c:when test="${pageIndex eq 10002 }">
								<img src="<%=basePath %>resources/images/nav-2.png" class="friend_icon" alt="我的好友" />
								<p class="b_nav_active">我的好友</p>
							</c:when>
							<c:otherwise>
								<img src="<%=basePath %>resources/images/nav-22.png" class="friend_icon" alt="我的好友" />
								<p>我的好友</p>
							</c:otherwise>
						</c:choose>
					</li>
				</a>
				<a href="<%=basePath %>wpv/urstoreMe">
					<li>
						<c:choose>
							<c:when test="${pageIndex eq 10003 }">
								<img src="<%=basePath %>resources/images/nav-3.png" class="pig_farm_icon" alt="我的猪场" />
								<p class="b_nav_active">我的猪场</p>
							</c:when>
							<c:otherwise>
								<img src="<%=basePath %>resources/images/nav-33.png" class="pig_farm_icon" alt="我的猪场" />
								<p>我的猪场</p>
							</c:otherwise>
						</c:choose>
					</li>
				</a>
			</ul>
		</footer>
	</body>
</html>