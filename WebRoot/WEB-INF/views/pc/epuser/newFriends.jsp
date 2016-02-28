<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="新的好友" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<link rel="stylesheet" href="resources/css/pc/pangzi_overview.css"/>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
</head>
<body class="body_bg">
<!--banner_box -->
<jsp:include page="../header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="../nav.jsp">
	<jsp:param value="5" name="nav"/>
</jsp:include>
<!-- 导航栏-->
<!--中间部分 -->
<div class="center mypig_center">
<!--mypig_left_nav -->
<jsp:include page="../user/nav.jsp">
	<jsp:param value="4" name="nav"/>
</jsp:include>
<!--mypig_left_nav -->
<div class="right_main">
	<div class="my_pig_tit"><!--my_pig_tit -->
    	<img src="resources/images/pc/nav_tit_bg.png" alt="新增好友"/>
        <div class="pig_tit"><p>新增好友</p></div>
    </div><!--my_pig_tit -->
    <div class="mypig_body"> 
        <div class="myfriends_tit">新增好友列表</div>
        <ul class="myfriends_list">
        	<c:forEach items="${friendList}" var="f">
        		<li data-user="${f.userId }">
                	<img src="${f.headImg }" alt="logo" class="logo_img"/>
               		<div class="friends_p m_top20"><p>昵称：${f.nickname }</p></div>
               		<c:choose>
               			<c:when test="${f.status eq 0}">
							<div class="friends_p m_top10"><p>${f.extend2 }</p></div>
                			<div class="z_friend_pass friend_pass2" onclick="submit(this,1);">接受</div>
                			<!--<div class="z_friend_pass" onclick="submit(this,2);">不接受</div>
						-->
						</c:when>
						<c:when test="${f.status eq 1 }">
							<div class="z_friend_pass">已添加</div>
						</c:when>
						<c:when test="${f.status eq 4 }">
							<div class="z_friend_pass">已发送</div>
						</c:when>
               		</c:choose>
            	</li>
    		</c:forEach>
        </ul>
        <c:if test="${pager.pageCount>0 }">
			<jsp:include page="../pager.jsp" />
		</c:if>
        <div class="clear"></div>
    </div><!--mypig_body -->
</div>


<div class="clear"></div>
</div>


<!-- 中间部分-->
<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->

<script>
	function submit(caller,type){
		var self = $(caller);
		
		var id = self.parent().attr('data-user');
		
		if(id == ''){
			alert('请输入必填项');
			return;
		}
		
		self.attr('disabled','disabled');
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/user/addFriend',
		    cache: false,
		    data: {agreeType:type,friendId:id},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('操作成功')
		    		window.location.href=__base_path__+'pc/pv/user/newFriends';
		    	} else {
		    		alert(data.data.text);
		    		self.removeAttr('disabled');
		    	}
		    },
		    error: function(){
		    	alert('error');
		    }
		});
	}
</script>
</body>
</html>
