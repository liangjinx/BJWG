<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>猪仔总数</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<div class="z_bg">
			<c:choose>
				<c:when test="${dataMap.list == null || fn:length(dataMap.list) == 0 }">
					<jsp:include page="../user/next_prenotify.jsp"></jsp:include>
				</c:when>
				<c:otherwise>
					<p class="z_h10"></p>
					<div class="z_pig_number">
						<p class="pig_amount_word mt50">总数</p>
						<p class="pig_amount_num">${dataMap.totalNum }<em>只</em></p>
					</div>
					<div class="z_pig_list mt15">
						<c:forEach items="${dataMap.list }" var="l" varStatus="status">
							<div class="pig_list_box" attrId=${ l.paincbuyProjectId}>
								<div class="pig_list_date">${l.paincbuyProjectName }</div>
								<div class="pig_list_num">${l.num - l.presentNum}只</div>
								<div class="pig_list_state">${l.remark }</div>
							</div>
						</c:forEach>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</body>
	<c:if test="${operate eq 'sendPig' }">
		<jsp:include page="../user/send.jsp"></jsp:include>
	</c:if>
	<jsp:include page="../back.jsp">
		<jsp:param value="wpnv/ixhome" name="backUrl"/>
	</jsp:include>
</html>
