<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="订单确认" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/public.css"/>
</head>
<body>

<!--banner_box -->
<jsp:include page="../header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="../nav.jsp">
	<jsp:param value="3" name="nav"/>
</jsp:include>
<!-- 导航栏-->
	

<!-- content start -->

<div class="d-wrap">
	
	<div class="shop-order-cont">
		
		<div class="d-tips of-hide">
			<i class="fl-left"></i>
			<p class="fl-left">安全提醒： 请不要将银行卡、密码、手机验证码提供给他人，八戒王国online不会通过任何非官方电话、QQ、微博、微信与您联系。任何以”订单异常、系统升级“等为由要求
您点击链接进行退款、重新付款、额外付款或取消订单的都是骗子！请认准八戒王国online电话 0755-83579888</p>
		</div>
		<div class="d-orders">
			<h2 class="title">确认商品信息</h2>
			<div class="d-order-tab">
				<div class="ord-tr ord-head-tr clearfix">
					<div class="tr-td tr-td-1">商品</div>
					<div class="tr-td tr-td-2">数量（只）</div>
					<div class="tr-td tr-td-3">单价</div>
					<div class="tr-td tr-td-4">总计（元）</div>
				</div>
				<div class="ord-tr ord-body-tr clearfix">
					<div class="tr-td tr-td-1">
						<a href="javascript:;">
							<img src="${proj.imgs }" alt="苏联大白猪" />
							${proj.name }
						</a>
					</div>
					<div class="tr-td tr-td-2">${num }</div>
					<div class="tr-td tr-td-3">￥${proj.price }</div>
					<div class="tr-td tr-td-4">￥${proj.price * num }</div>
				</div>
			</div>
			<input type="hidden" name="projectId" value="${proj.paincbuyProjectId }" />
    		<input type="hidden" name="num" value="${num }" />
			<div class="d-pub-btn">
				<p><input type="button" value="提交订单" class="orders-pub-btn d-sub-btn" id="btnsub" /></p>
				<p>
					<input type="checkbox" checked="checked" class="order-pub-protocol" id="protocol"/>
					<a href="javascript:;" class="agreement-btn">本人同意并接受《服务协议》</a>
				</p>
			</div>
		</div>
		
	</div>
	
	
	<div class="d-shade"></div>
	
	<div class="agreement">
		<div class="agr-bd"></div>
		<div class="agr-main">
			<h2 class="title">“八戒王国online”协议书</h2>
			<div class="cont">
				${protocol.content }
			</div>
			<div class="btn-sure">
				<button class="btn-submit">同意并继续</button>
			</div>
		</div>
	</div>

</div>

<!-- content end -->

<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->
<input type="hidden" name="leftCount" value="${leftCount }"/>
</body>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script>
	$(function(){
		
		(function(){
			
			///*协议*/
			$('.agreement-btn').on('click', function(){
				$('.agreement').fadeIn('fast');
			})
			$('.agreement .btn-submit').on('click', function(){
				$('.agreement').fadeOut('fast');
			})
			
			///*同意协议才能抢购*/
			/*$('#protocol').on('change', function(){
				if($('#protocol').is(':checked')){
					$('#submit').removeAttr('disabled');
				}else{
					$('#submit').attr('disabled','disabled');
				}
				return false;
			})*/
			
		})()
		
		$('#btnsub').click(function() {
			if(!$('#protocol').is(':checked')){
				alert('请先同意服务协议');
				return;
			}
			var self = $(this);
			var projectId = $('[name=projectId]').val().trim();
			var num = $('[name=num]').val().trim();

			self.attr('disabled', 'disabled');
			$.ajax({
				type : 'POST',
				dataType : 'json',
				url : __base_path__+'pc/pv/order/submit',
				cache : false,
				data : {
					projectId : projectId,
					num : num
				},
				success : function(data) {
					if (data.msg == 'success') {
						window.location.href = __base_path__+data.data.redirectUrl;
					} else {
						alert(data.data.text);
						self.removeAttr('disabled');
					}
				},
				error : function() {
					alert('error');
				}
			});
		})
		
		
	})
</script>
<script>
	var leftCount = parseInt($('[name=leftCount]').val());
	var num = $('[name=num]').val().trim();
	if(num>leftCount){
		alert('您下手太慢了,没有这么多猪仔哦,请返回重新选择!');
		window.location.href=__base_path__+"pc/pnv/inShopping";
	}
</script>

</html>
<%--





<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>确认订单</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery.js"></script>
	<script>
	$(function() {
		
	})
	</script>
	</head>
  
  <body>
    <h3>确认订单</h3>
    <div>
    	<div>名字:${proj.name }</div>
    	<div>图片:${proj.imgs }</div>
    	<div>单价:${proj.price }</div>
    	<div>数量:${num }</div>
    	<div>金额:${proj.price * num }</div>
    	<input type="hidden" name="projectId" value="${proj.paincbuyProjectId }" />
    	<input type="hidden" name="num" value="${num }" />
    	<input type="hidden" name="remark" value="" />
    	<button type="button" id="btnsub">提交订单</button>
    </div>
  </body>
</html>
--%>