<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
        <title>我的猪场</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/compilations_pz.css">
   	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<div class="z_my_pigfarm">
			
			<div class="z_personage_top position_r" onclick="window.location.href='<%=basePath %>wpv/uruserInfo'">
				<div class="z_personage_img">
					<c:choose>
						<c:when test="${session_manager.headImg != null}">
							<div class="z_personage_img_box">
								<img src="${session_manager.headImg}" alt="个人头像">
							</div>
						</c:when>
						<c:otherwise>
							<div class="z_personage_img_box">
								<img src="<%=basePath %>resources/images/default.png" alt="个人头像">
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="z_personage_info_jump">
					<div class="left_name">
						<c:choose>
							<c:when test="${fn:length(session_manager.nickname) > 11 }">
          						${fn:substring(session_manager.nickname,0,11)}
        					</c:when>
							<c:otherwise>
        						${session_manager.nickname }
        					</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="right_jump_arrow"></div>
			</div><!-- end z_personage_top -->
			
			<div class="z_my_option">
				<a href="<%=basePath %>wpv/wlmyWallet">
					<div class="my_option_wallet">
						<p class="wallct_word">钱包</p>
						<p class="wallct_balance">${userCenter.walletMoney == null ? 0 : userCenter.walletMoney}</p>
					</div>
				</a>
				<a href="<%=basePath %>wpnv/ixpigGrow">
					<div class="my_option_wallet">
						<p class="wallct_word">猪仔</p>
						<p class="wallct_balance">${userCenter.pigNumber }</p>
					</div>
				</a>
				<a href="<%=basePath %>wpnv/ixRecentEarning">
					<div class="my_option_wallet">
						<p class="wallct_word">我的收益</p>
						<p class="wallct_balance">${userCenter.earnings}</p>
					</div>
				</a>
			</div><!-- end z_my_option -->
			
			<div class="z_my_list mt10">
				<a href="<%=basePath %>wpv/urpersonalMsg">
					<div class="my_list_message mb10">
						<div class="z_my_container">
							<div class="list_left_content">
								<div class="message_icon"><img src="<%=basePath %>resources/images/my-pig-farm-2.png" alt="信息" /></div>
								<div class="message_name">消息</div>
							</div>
							<div class="list_right_content">
								<div class="message_num">${userCenter.msgUnReadNum}</div>
								<div class="brown_arrow"><img src="<%=basePath %>resources/images/brown-arrow-w24.png" alt="" /></div>
							</div>
						</div>
					</div>
				</a>
			</div><!-- end z_my_list -->
			
			<div class="z_my_list">
				<a href="<%=basePath %>wpv/orderList">
					<div class="my_list_message border_no_bottom">
						<div class="z_my_container">
							<div class="list_left_content">
								<div class="order_icon"><img src="<%=basePath %>resources/images/my-pig-farm-3.png" alt="我的订单" /></div>
								<div class="message_name">我的订单</div>
							</div>
							<div class="list_right_content">
								<div class="brown_arrow"><img src="<%=basePath %>resources/images/brown-arrow-w24.png" alt="" /></div>
							</div>
						</div>
					</div>
				</a>
			</div>
			<div class="z_my_list">
				<a href="<%=basePath %>wpv/urmyCoupon">
					<div class="my_list_message mb10">
						<div class="z_my_container">
							<div class="list_left_content">
								<div class="pork_securities_icon"><img src="<%=basePath %>resources/images/my-pig-farm-4.png" alt="我的猪肉劵" /></div>
								<div class="message_name">我的猪肉劵</div>
							</div>
							<div class="list_right_content">
								<div class="brown_arrow"><img src="<%=basePath %>resources/images/brown-arrow-w24.png" alt="" /></div>
							</div>
						</div>
					</div>
				</a>
			</div>
			<div class="z_my_list">
				<a href="<%=basePath %>wpv/urpreorderIndex">
					<div class="my_list_message border_no_bottom">
						<div class="z_my_container">
							<div class="list_left_content">
								<div class="forestall_icon"><img src="<%=basePath %>resources/images/my-pig-farm-7.png" alt="我的预抢" /></div>
								<div class="message_name">我的预抢</div>
							</div>
							<div class="list_right_content">
								<div class="brown_arrow"><img src="<%=basePath %>resources/images/brown-arrow-w24.png" alt="" /></div>
							</div>
						</div>
					</div>
				</a>
				<a href="<%=basePath %>wpv/wlMyFinancing">
					<div class="my_list_message mb10">
						<div class="z_my_container">
							<div class="list_left_content">
								<div class="manage_wallet_icon"><img src="<%=basePath %>resources/images/my-pig-farm-5.png" alt="我的理财目标" /></div>
								<div class="message_name">我的投资</div>
							</div>
							<div class="list_right_content">
								<div class="brown_arrow"><img src="<%=basePath %>resources/images/brown-arrow-w24.png" alt="" /></div>
							</div>
						</div>
					</div>
				</a>
			</div>
			
			<div class="z_my_list">
				<a href="<%=basePath %>wpv/ursetting">
					<div class="my_list_message border_no_bottom">
						<div class="z_my_container">
							<div class="list_left_content">
								<div class="message_icon"><img src="<%=basePath %>resources/images/my-pig-farm-6.png" alt="设置" /></div>
								<div class="message_name">设置</div>
							</div>
							<div class="list_right_content">
								<div class="brown_arrow"><img src="<%=basePath %>resources/images/brown-arrow-w24.png" alt="" /></div>
							</div>
						</div>
					</div>
				</a>
			</div>
			<div class="z_my_list mb80">
				<a href="javascript:;">
					<div class="my_list_message z_hotline">
						<div class="z_my_container">
							<div class="list_left_content">
								<div class="my_list_hotline">服务热线</div>
							</div>
							<div class="list_right_content">
								<div class="brown_arrow"><img src="<%=basePath %>resources/images/brown-arrow-w24.png" alt="" /></div>
							</div>
						</div>
					</div>
				</a>
			</div>
		</div><!-- end z_my_pigfarm -->
		<div class="z_show_hotline" id="show_hotline">
			<c:forEach items="${serviceList }" var="l">
				<c:choose>
					<c:when test="${l.code eq 'SYS_MANAGE_CUSTOMER_SERVICE.PHONE' }">
						<a href="tel:${l.value }"><div class="z_telephone">电话交谈:${l.value }</div></a>
					</c:when>
					<c:when test="${l.code eq 'SYS_MANAGE_CUSTOMER_SERVICE.QQ' }">
						<%--
							<a href="http://wpa.qq.com/msgrd?v=3&uin=${l.value }&site=qq&menu=yes">
						--%>
						<div class="z_talk_q">QQ交谈:${l.value }</div>
						<%--
							</a>
						--%>
					</c:when>
					<c:otherwise>
						<div class="z_talk_q">QQ群:${l.value }</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<div class="z_talk_q">微信群:bajiewgol</div>
		</div>
		<jsp:include page="../common/commonTip.jsp"></jsp:include>
    	<jsp:include page="../footer.jsp">
    		<jsp:param value="10003" name="pageIndex"/>
    	</jsp:include>
	</body>
</html>
<script src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
<script src="<%=basePath %>resources/js/layer/layer.js"></script>
<script>
	$(function(){
		$('.z_hotline').on('click',function(){
			var height_ = 251,
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
			    closeBtn: true, // false，不显示关闭按钮
				shift:1, // 0-6的动画形式，-1不开启
			    content: $("#show_hotline") 
			}); 
			layer.style(index,{
				'border-radius':'5px'// 修改layer最外层容器样式
			});
		});
		$('.z_talk_q, .z_telephone').on('click',function(){
			layer.closeAll();
		});
	});
</script>
