<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<meta name="keywords" content="八戒王国online">
<meta name="description" content="八戒王国online">
<meta http-equiv="Pragma" content="no-cache" />
<title>搜索好友</title>
<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
<script src="<%=basePath %>resources/js/layer/layer.js"></script>

<style type="text/css">

</style>

<script type="text/javascript">
	function query(url,id){
		$("#id").val(id);
		$("#searchForm").attr("action",url).submit();
	}
</script>

</head>

<body>
	<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
	<div class="z_bg">
		<form action="<%=basePath %>wpv/ursearchFriends" id="allProjectForm" name="allProjectForm" method="post">
			<input type="hidden" name="freindId" id="freindId">
			<p class="z_h20">&nbsp;</p>
			<div class="z_friend_search mb20">
				<div class="friend_search_box">
					<input type="text" name="keywords" id="keywords" maxlength="15" class="z_search_number" placeholder="通过手机号码/昵称添加好友" />
					<img src="<%=basePath %>resources/images/my-friend-2.png" alt="搜索" class="friend_sarch_icon" onclick="javascript:search();" />
				</div>
			</div><!-- end z_friend_search -->
			
			<c:choose>
				<c:when test="${fn:length(freindsList) > 0}">
					<c:forEach items="${freindsList }" var="l" varStatus="status">
						<!-- star search result -->
						<div class="friend_search_result mb20">
							<div class="friend_list_box">
								<div class="friend_info">
									<div class="friend_info_img">
										<c:choose>
											<c:when test="${l.headImg != null && l.headImg != ''}">
												<img src="${l.headImg}" alt="头像${l.userId }" />
											</c:when>
											<c:otherwise>
												<img src="<%=basePath %>resources/images/default.png" alt="个人头像${l.userId }">
											</c:otherwise>
										</c:choose>
									</div>
									<div class="friend_info_detail">
										<p class="z_friend_name">${l.nickname }</p>
										<p class="z_friend_sex">
											<c:choose>
												<c:when test="${l.sex == 1}">
													男
												</c:when>
												<c:when test="${l.sex == 2}">
													女
												</c:when>
												<c:otherwise>
													未知
												</c:otherwise>
											</c:choose>
				                    	</p>
									</div>
								</div>
								<div class="friend_option_way">
									<div class="friend_option_invite" onclick="$('#freindId').val(${l.userId});">加为好友</div>
								</div>
							</div>
						</div><!-- end search result -->
					</c:forEach>
				</c:when>
				<c:otherwise>
					<!-- <p class="z_no_search_friend">还没有好友，赶紧添加好友吧.</p> -->
				</c:otherwise>
			</c:choose>
			<div class="friend_verification">
				<p>好友验证</p>
				<input type="text" class="friend_verification_input"  placeholder="我是..." />
				<div class="friend_verification_options">
					<input type="button" class="cancel_bton" value="取消" />
					<input type="button" class="confirm_bton" value="确定" onclick="apply()"/>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="../back.jsp">
		<jsp:param value="wpv/urmyFriends" name="backUrl"/>
	</jsp:include>
</body>
<script type="text/javascript">
	function search(){
		if($.trim($("#keywords").val()) == ""){
			alert("请输入关键字");
			return;
		}
		$("#allProjectForm").submit();
	}
	function apply(){
		var freindId = $("#freindId").val();
		if(freindId == '' || isNaN(freindId) || freindId <= 0){
			alert("请重新选择要添加的好友");
			return false;
		}
		
		$("#allProjectForm").attr("action","<%=basePath %>wpv/urapplyFriends");
		$("#allProjectForm").submit();
	}
	// 好友验证 
	$(function(){
		$('.friend_option_invite').on('click',function(){
			var height_ = 150,
				layer_width = $(window).width()*80/100,
				window_heigit = $(window).height(),
				offset = 'auto';
				
			if(window_heigit <= height_) offset = "0px";
			if(layer_width>=640) layer_width = "640*90/100";
			
			var index = layer.open({
			    type: 1,
			    title:false,
			    shade: 0.6,
			    area: [layer_width+'px', height_+'px'],
			    offset: offset,
			    scrollbar:true,
			    closeBtn: false, //不显示关闭按钮
				shift:1, //0-6的动画形式，-1不开启
			    content: $(".friend_verification") 
			}); 
			layer.style(index,{
				'border-radius':'3px'//修改layer最外层容器样式
			});
			
			$('.cancel_bton').on('click',function(){
				layer.closeAll();
			});
		});
	});
</script>

</html>
