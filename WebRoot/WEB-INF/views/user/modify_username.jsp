<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
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
        <title>个人信息</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/compilations_pz.css">
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<form method="post" name="allProjectForm" action="<%=basePath %>wpv/uruserInfoSave" id="allProjectForm">
			<div class="z_change_box">
				<input id="c_username" name="nickName" type="text" class="z_info_change" value="${session_manager.nickname}" placeholder="${session_manager.nickname }" maxlength="11" />
			</div>
			<input type="button" class="z_change_save" value="保存" onclick="javascript:save();"/>
		</form>
	</body>
	<jsp:include page="../common/commonTip.jsp"></jsp:include>
<script type="text/javascript">
function save(){
	var username = $('#c_username').val();
	if (!$.trim(username) || $.trim(username).length < 3) {
		alert('请填写新用户名，长度至少3位');
		return false;
	}
	$("#allProjectForm").submit();
};
</script>
</html>