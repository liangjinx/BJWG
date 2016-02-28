<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <title>我的消息</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
        <style>
        	.message_info { position: fixed; left: 50%; top: 50%; display: none; width: 80%; height: auto; border: 1px solid #efefef; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; transform: translate(-50%,-50%); -webkit-transform: translate(-50%,-50%); -moz-transform: translate(-50%,-50%); background: url(<%=basePath%>resources/images/share-bd.png) #fff center center no-repeat; background-size: 140px auto; z-index: 100;}
        	.title_info, .content_info { width: 90%; text-align: center;}
        	.title_info { margin: 57px auto 0; font-size: 1.6rem; color: #615868;}
        	.content_info { margin: 10px auto 24px; text-align: center;}
        	.z_cancel, .z_ensure { width: 80px; height: 40px; line-height: 40px; font-size: 1.4rem; border: none; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; background: none;}
			.z_cancel { margin-right: 15px; color: #979698;}
			.z_ensure { margin-left: 15px; color: #615868;}
			.z_msg_mark { position: fixed; left: 0; right: 0; top: 0; bottom: 0; display: none; width: 100%; height: 100%; background: rgba(0,0,0,.1); z-index: 99;}
        </style>
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<div class="z_bg">
			<div class="z_h20">&nbsp;</div>
			<div id="my_message_t">
				<h3 class="message_active">系统消息</h3>
				<h3>猪场公告</h3>
				<div class="my_message_content f_l" style="display: block;">
					<c:choose>
						<c:when test="${fn:length(list)>0}">
							<c:forEach items="${list}" var="l" varStatus="status">
								<div class="system_message_box">
									<div class="system_message_icon f_l">
										<img src="<%=basePath %>resources/images/system-message-img.png" alt="系统消息" />
									</div>
									<div class="system_message_detail f_l">
										<p class="message_content">
											${l.content}
										</p>
										<div class="message_time">
											<img src="<%=basePath %>resources/images/system-message-time.png" alt="通知时间" />
											<span><fmt:formatDate value="${l.ctime }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
										</div>
										<div class="list_delete"><img src="<%=basePath%>resources/images/shopping_11.png" alt="删除"></div>
									</div>
									<input type="hidden" name="messageIds" value="${l.messageId }">
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="z_no_systeninfo">暂无系统通知.</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="my_message_content f_l">
					<c:choose>
						<c:when test="${fn:length(bulletinList)>0}">
							<c:forEach items="${bulletinList}" var="l" varStatus="status">
								<div class="farm_message_box">
									<div class="announcement_periods">${l.title }</div>
									<div class="announcement_pig_num">${l.content }</div>
									<p class="announcement_time">
										<img src="<%=basePath %>resources/images/system-message-time.png" alt="通知时间" />
										<span><fmt:formatDate value="${l.ctime }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
									</p>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="z_no_systeninfo">暂无猪场公告.</div>
						</c:otherwise>
					</c:choose>	
					<%-- <div class="farm_message_box">
						<p class="announcement_periods">第150908期抢猪预告<span>（9月8日）</span></p>
						<p class="announcement_pig_num">周三放猪1000只。单价为1980/只</p>
						<p class="announcement_time">
							<img src="<%=basePath %>resources/images/system-message-time.png" alt="通知时间" />
							<span>2015-09-07&nbsp;&nbsp;14:00:07</span>
						</p>
					</div> --%>
				</div>
			</div>
		</div>
		
		<div class="message_info">
			<div class="title_info_friend">确定删除此消息？</div>
			<div class="content_info">
				<input type="button" class="z_cancel" value="取消" />
				<input type="button" class="z_ensure" value="确定" />
			</div>
		</div>
		<div class="z_msg_mark"></div>
	</body>
	<jsp:include page="../back.jsp">
		<jsp:param value="wpv/urstoreMe" name="backUrl"/>
	</jsp:include>
</html>
<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js" ></script>
<script src="<%=basePath %>resources/js/zepto.min.js"></script>
<script>
	$(function(){
		var oTab = document.getElementById('my_message_t'),
			oH3  = oTab.getElementsByTagName('h3'),
			my_order_content = $('.my_message_content');
			
		//实现h3切换的同时，控制display显隐对应的内容
		for(var i=0;i<oH3.length;i++){
			oH3[i].index = i;
			oH3[i].onclick=function(){
				for(var i=0;i<oH3.length;i++){
					oH3[i].className='';
					my_order_content[i].style.display = 'none';
				}
				this.className='message_active';
				my_order_content[this.index].style.display = 'block';
			};
		}
	});
	
	 $(function(){
        //删去信息
		$('#my_message_t .system_message_box').on({
			'swipeLeft':function(){
				$('#my_message_t .system_message_box').removeClass('li_swipeleft');
				$(this).addClass('li_swipeleft');
				var this_ = $(this).closest(".system_message_box");
				var messageId = $(this).children(":input[name=messageIds]").val();
				console.log("messageId:"+messageId);
				$(".list_delete").on("tap",function(){
					$(".message_info, .z_msg_mark").show();
				});
				$(".z_cancel, .mark").on("tap",function(){
					$(".message_info, .z_msg_mark").hide();
				});
				$(".z_ensure").off("tap");
				$(".z_ensure").on("tap",function(){
		           	$.ajax({
					      type: "post",
					      url: "<%=basePath%>wpv/urpersonalMsgDel",
					      data: {"messageId":messageId},
					      success: function(data) {
					      	if(data){
								$(".message_info, .z_msg_mark").hide();
								this_.hide();
					      	}else{
					      		return false;
					      	}
					      },
					      error: function() {
							 alert("删除失败");
					      }
					});
				});
			},
			'swipeRight': function(){
				$(this).removeClass('li_swipeleft');
			}
		})
    });
</script>

