<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
<style>
.z_no_thing { width: 96%; margin: 15px auto; height: 45px; ling-height: 45px; font-size: 2.0rem; color: #615868; text-align: center; border: none;}
</style>
<form action="<%=basePath %>wpv/ursendPig" id="allProjectForm" name="allProjectForm" method="post">
	<input type="hidden" name="freindId" id="freindId" value="${freindsId }">
	<input type="hidden" name="projectId" id="projectId" value="${ projectId}">
	<input type="hidden" name="pageSource" id="pageSource" value="${pageSource }">
	<!--送猪仔-->
	<div class="z_send_box">
		<div class="z_send_box_1">
			<input type="tel" name="sendNum" id="sendNum" maxlength="6" class="get_piglets_num" placeholder="赠送数量 " />
			<textarea class="leave_a_message" name="sendRemark" id="sendRemark" placeholder="给好友留言"></textarea>
		</div>
		<div class="z_send_box_2">
			<input type="button" class="z_cancel_btn" value="取消" />
			<input type="button" class="z_confirm_btn" value="确定" onclick="showPasswordBox()" />
		</div>
	</div>
	<!--end 送猪仔-->
	<jsp:include page="../wallet/input_pay_password.jsp">
		<jsp:param value="send" name="confirmFunc"/>
	</jsp:include>
</form>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
<script src="<%=basePath %>resources/js/layer/layer.js"></script>
<script type="text/javascript">
	function send(){
		var sendNum = $.trim($("#sendNum").val());
		if(sendNum == '' || isNaN(sendNum) || sendNum <= 0 || sendNum >= 1000000){
			alert("请输入正确的数量");
			return false;
		}
		var freindId = $.trim($("#freindId").val());
		if(freindId == '' || isNaN(freindId) || freindId <= 0){
			alert("请重新选择好友");
			return false;
		}
		var projectId = $.trim($("#projectId").val());
		if(projectId == '' || isNaN(projectId) || projectId <= 0){
			alert("请选择哪一期");
			return false;
		}
		$("#allProjectForm").submit();
	}
	
	// 送猪数量, 留言
	$(function(){
		$('.pig_list_box').on('click',function(){
			$("#projectId").val($(this).attr("attrId"));
			showDiv();
		});
	});
	
	function showDiv(){
		var height_ = 220,
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
		    content: $(".z_send_box") 
		}); 
		layer.style(index,{
			'border-radius':'3px'//修改layer最外层容器样式
		});
		
		$('.z_cancel_btn').on('click',function(){
			layer.closeAll();
		});
	}
	
	// 调用支付密码弹层
	function showPasswordBox(){
			
		var sendNum = $.trim($("#sendNum").val());
		if(sendNum == '' || isNaN(sendNum) || sendNum <= 0 || sendNum >= 1000000){
			alert("请输入正确的数量");
			return false;
		}
		
		showPayPwd();
		
		layer.closeAll();
	}
</script>


