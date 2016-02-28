<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="__page_name__" value="赠送猪仔" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
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
    <div class="mypig_body m_top10">
    	<div class="pig_tit_box">
        	<img src="resources/images/pc/point1.png" alt="点"/><p>选择猪仔</p><img src="resources/images/pc/point1.png" alt="点"/>
        </div>
    	<ul class="pig_list_ul">
    		<c:forEach items="${dataMap.list }" var="l" varStatus="status">
    			<c:if test="${(l.num - l.presentNum) > 0 }">
    			<c:set var="hasPig" value="true"/>
    			<li data-id="${ l.paincbuyProjectId}" data-count="${l.num - l.presentNum }">
            		<img src="resources/images/pc/pig1.png" alt="点"/>
                	<div class="pig_list_tit">
                		<p>${l.remark }</p>
                		<div class="selected ${status.index == 0 ? 'this_s' :''}"></div>
                	</div><!--pig_list_tit -->
                	<p class="p_16">${l.paincbuyProjectName } <br>${l.num - l.presentNum }只</p>
            	</li>
            	</c:if>
			</c:forEach>
        </ul> 
        <div class="clear"></div>
        <div class="pig_number_box">
        	<p class="p_16">赠送数量:</p> <input type="text" name="sendCount" value=""/>
        </div>
        <div class="pig_number_box">
        	<p class="p_16">留言:</p> <textarea placeholder="  有什么想对大家说的，快讲吧！" name="mark" maxLength=50></textarea>
        </div>
        <div class="pig_number_box">
        	<p class="p_16">支付密码:</p> <input type="password" name="password" maxLength=6/>
        </div>
        <div class="clear"></div>
        	<input type="text" value="提交" readOnly class="pig_number_but" id="btnSub"/>
        <div class="clear m_top30"></div>
    </div><!--mypig_body -->
</div>

<form action="" method="post">
	<input type="hidden" name="friendId" value="${friendId }">
	<input type="hidden" name="" value="" id="" />
</form>

<div class="clear"></div>
</div>

   
<!-- 中间部分-->
<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->
<script>
	$(function(){
		$('#btnSub').click(function(){
			
			var self = $(this);
		
			var selEle = $('.selected.this_s');
			var projId = selEle.parent().parent().attr('data-id');
			var projCount = selEle.parent().parent().attr('data-count');
			
			var sendCount = $('[name=sendCount]').val();
			var password = $('[name=password]').val();
			var mark = $('[name=mark]').val();
			var friendId = $('[name=friendId]').val();

			if(sendCount.trim()=='' || !/^[0-9]*$/.test(sendCount) || sendCount==0){
				alert('请正确填写数量');
				return;
			}
			if(sendCount>projCount){
				alert('数量超出');
				return;
			}
			if(password.trim()=='' || password.length!=6 || !/^[0-9]*$/.test(password)){
				alert('请正确填写支付密码');
				return;
			}
		
		self.attr('disabled','disabled');
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/user/sendPigSubmit',
		    cache: false,
		    data: {friendId:friendId,projectId:projId,sendCount:sendCount,sendRemark:mark,password:password},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('赠送成功')
		    		window.location.href=__base_path__+"pc/pv/user/friend";
		    	} else {
		    		alert(data.data.text);
		    		self.removeAttr('disabled');
		    	}
		    },
		    error: function(){
		    	alert('error');
		    }
		});
		});
		
		<c:if test="${dataMap.list eq null or fn:length(dataMap.list)<=0 or hasPig ne 'true'}">
    		alert('您没有可以赠送的猪仔哦');
    		window.location.href=__base_path__+'pc/pv/user/friend';
    	</c:if>
	})
</script>
</body>
</html>

























