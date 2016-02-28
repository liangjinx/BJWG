<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
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
        <form id='allProjectForm' name='allProjectForm' method="post" action="<%=basePath %>wpv/uruploadHeadImg" enctype="multipart/form-data">
            <div class="main">
                <div class="touxiang position_r">
                    <span class="font_1">头像</span>
					<div class="img_box">
						<c:choose>
							<c:when test="${session_manager.headImg != null}">
								<img src="${session_manager.headImg}" alt="个人头像" class="original_img">
							</c:when>
							<c:otherwise>
								<img src="<%=basePath %>resources/images/default.png" alt="个人头像" class="original_img">
							</c:otherwise>
						</c:choose>
						<input type="hidden" name="" class="">
						<!-- <input type="file" id="inputfile" accept="image/*" capture="camera" name="imgFile" onchange="fileChange(this,'inputfile')"> -->
						<input type="file" id="inputfile" accept="image/*" capture="camera" name="imgFile" onchange="uploadFileAjax(this,'<%=basePath %>wpv/uruploadHeadImgAjax','user_info');">
					</div>
				</div>
                <a href="<%=basePath %>wpv/uruserInfoModifyPage?r_type=1">
	                <div class="user_name_1 position_r">
	                	<span class="font_1">昵称</span>
	                	<div class="input_box2">
	                		<input type="text" name="nickName" class="z_user_name" readonly="readonly" value="${session_manager.nickname}" placeholder="${session_manager.nickname}">
	                	</div>
	                </div>
                </a>
                <a href="javascript:;">
                	<div class="user_phone_1 position_r">
                		<span class="font_1">性别</span>
                		<div class="input_box z_user_sex">${session_manager.sex==1?'男':'女'}</div>
                		<input type="hidden" name="sex" id="sex" value = "${session_manager.sex}"/>
                	</div>
                </a>
            </div>
            <input type="button" class="log_out" value="退出登录" onclick="window.location.href='<%=basePath%>/wpnv/lglogout'"/>
            <%--<c:if test="${session_manager.bindPhone eq '13544250134'}">
	            <input type="button" class="log_out" value="重新生成二维码" onclick="window.location.href='<%=basePath%>/wpv/urQrCode'"/>
            </c:if>
            --%><div class="z_mark">
            	<div class="z_change_sex">
            		<h3>修改性别</h3>
            		<div class="z_sex_man">男</div>
            		<div class="z_sex_woman">女</div>
            	</div>
            </div>
        </form>
    </body>
    <jsp:include page="../common/commonTip.jsp"></jsp:include>
    <jsp:include page="../back.jsp">
		<jsp:param value="wpv/urstoreMe" name="backUrl"/>
	</jsp:include>
    <script language="javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<script language="javascript" src="<%=basePath %>resources/js/ajaxfileupload.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/uploadFile.js"></script>
</html>
<script language="javascript">
	$(function(){
		$('.user_phone_1').on('click',function(){
			$('.z_mark').show();
		});
		//  change sex
		var man = $('.z_sex_man').text(),
			woman = $('.z_sex_woman').text();
		$('.z_sex_man').on('click',function(){
			$('#sex').val(1);
			$("#allProjectForm").attr("action","<%=basePath %>wpv/uruserInfoSave").submit();
			$('.z_user_sex').text(man);
			$('.z_mark').hide();
		});
		$('.z_sex_woman').on('click',function(){
			$('#sex').val(2);
			$("#allProjectForm").attr("action","<%=basePath %>wpv/uruserInfoSave").submit();
			$('.z_user_sex').text(woman);
			$('.z_mark').hide();
		});
	});
</script>

