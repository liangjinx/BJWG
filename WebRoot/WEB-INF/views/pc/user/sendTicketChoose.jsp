<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="__page_name__" value="赠送猪肉券" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<link rel="stylesheet" href="resources/css/pc/public.css"/>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<style>
.paging{ margin-right:95px;}
.checked_img{ width:60px; height:60px; position:absolute; z-index:10; bottom:9px; right:6px; background:url(resources/images/pc/checked_img.png) center no-repeat; display:none;}
.pig_coupons_ul li{ cursor:pointer;}
</style>
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
	<div class="pig_tit_box m_top10">
    	<img src="resources/images/pc/point1.png" alt="点"/><p>选择猪肉券</p><img src="resources/images/pc/point1.png" alt="点"/>
    </div>  
    <ul class="pig_coupons_ul">
    	<c:forEach items="${ticketList}" var="ticket" varStatus="status">
    		<li data-ticket="${ticket.myCouponId}" data-total="${ticket.canUseMoney}">
    			<c:set var="hasPig" value="true"/>
         		<div class="coupons_ul_tit"><p>电子券号码：${ticket.couponCode}</p><a href="pc/pv/user/ticketUseRecord?ticketId=${ticket.myCouponId }">消费记录</a></div>
            	<div class="coupons_code"><img src="${ticket.couponImg}" alt="二维码"/><p>通过二维码支付</p></div>
            	<div class="coupons_yue"><p>余额￥</p><span>${ticket.canUseMoney}</span></div>
            	<div class="coupons_time"><p>使用有效期：<fmt:formatDate value="${ticket.beginTime}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${ticket.endTime}" pattern="yyyy-MM-dd"/></p></div>
            	<div class="checked_img"></div>
         	</li>
    	</c:forEach>
    </ul>	     
<div class="clear"></div>
	<jsp:include page="../pager.jsp">
		<jsp:param name="otherQueryArg" value="friendId=${friendId }" />
	</jsp:include>
<div class="clear"></div> 

        <div class="pig_number_box">
        	<p class="p_16">填写赠送金额:</p> <input type="text" name="money" value="" maxLength=8 onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
        </div>
        <div class="pig_number_box">
        	<p class="p_16">留言:</p> <textarea placeholder="  有什么想对好友说的，快讲吧！" name="remarks" maxLength=140 ></textarea>
        </div>
        <div class="pig_number_box">
        	<p class="p_16">填写支付密码:</p> <input type="password" name="paypwd" maxLength=6 onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
        </div>
        <div class="clear"></div>
        	<input type="hidden" name="friendId" value="${friendId }"/>
        	<input type="hidden" name="ticketId"/>
        	<input type="hidden" name="canUseMoney"/>
        	<input type="text" value="提交" id="btnSub" readOnly="readonly" class="pig_number_but"/>
        <div class="clear m_top30"></div>
</div>
<div class="clear"></div>
</div>

   
<!-- 中间部分-->
<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->
</body>
<script>
 $('.pig_coupons_ul li').click(function(){
	 $('.pig_coupons_ul li').find('.checked_img').css('display','none');
	 $(this).find('.checked_img').css('display','block');
	 $('[name=ticketId]').val($(this).attr('data-ticket'));
	 $('[name=canUseMoney]').val($(this).attr('data-total'));
	 })
	 
	 $(function(){
	 	$('#btnSub').click(function(){
	 		var self = $(this);
			
			var canUse = $('[name=canUseMoney]').val();
			var ticketId = $('[name=ticketId]').val();
			var sendMoney = $('[name=money]').val();
			var password = $('[name=paypwd]').val();
			var mark = $('[name=remarks]').val();
			var friendId = $('[name=friendId]').val();
			
			if(ticketId==''){
				alert('请选择猪肉券');
				return;
			}
			if(sendMoney.trim()=='' || sendMoney==0){
				alert('请正确填写金额');
				return;
			}
			if(parseFloat(sendMoney)>parseFloat(canUse)){
				alert('金额超出!');
				return;
			}
			if(password.trim()==''){
				alert('请填写支付密码');
				return;
			}
		self.attr('disabled','disabled');
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/user/sendTicketSubmit',
		    cache: false,
		    data: {
		    	friendId:friendId,
		    	ticketId:ticketId,
		    	sendMoney:sendMoney,
		    	sendRemark:mark,
		    	password:password
		    },
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
		})
		<c:if test="${hasPig ne 'true'}">
    		alert('您没有可以赠送的猪肉券哦');
    		window.location.href=__base_path__+'pc/pv/user/friend';
    	</c:if>
	 })
</script>
</html>












