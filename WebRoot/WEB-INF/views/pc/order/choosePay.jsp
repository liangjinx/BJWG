<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="选择支付方式" scope="request"/>
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
	
	<div class="pays-cont">
		 
		 <div class="cont-row row-1">
		 	<div class="title">
		 		<h5 class="d-h5">
		 			<img src="resources/images/pc/d-icons-tips.png" width="34" height="34" alt="提交成功"/>
		 			订单提交成功，现在只差最后一步啦！
		 		</h5>
		 		<p class="sub">请您在提交订单后<span>${limitMin }分钟内</span>完成支付</p>
		 	</div>
		 	<div class="info">
		 		<h5 class="d-h5">订单信息</h5>
		 		<p class="p1">${order.relationName }   数量${order.num }只    共计：¥${order.totalMoney }</p>
		 		<!--<p class="p1">收货信息：广东省,深圳市,龙岗区,布吉镇逸马大厦8f 互联在线云计算有限公司,黄金宝，手机：132****2340</p>
		 	--></div>
		 </div>
		
		<div class="cont-row row-2">
			<div class="title">
				支付金额：<span class="d-price">￥${order.totalMoney }</span>
			</div>
			<ul class="list">
				<li>
					<input type="radio" name="pays" id="zhifubao" value="alipay" class="pays" checked/>
					<label class="dib current" for="zhifubao"><img src="resources/images/pc/pays-zfb.jpg" alt="支付宝" width="168" height="66" /></label>
				</li>
				<!--<li>
					<input type="radio" name="pays" id="wxzf" value="test" class="pays" />
					<label class="dib" for="wxzf"><img src="resources/images/pc/pays-wxzfmm.jpg" alt="余额测试支付" width="168" height="66" /></label>
				</li>
				-->
				<li>
					<input type="radio" name="pays" id="ylzx" value="unionpay" class="pays" />
					<label class="dib" for="ylzx"><img src="resources/images/pc/pays-yl.jpg" alt="银联在线" width="168" height="66" />大额支付</label>
				</li>
				<li>
					<input type="radio" name="pays" id="ylzx2" value="unionpay2" class="pays" />
					<label class="dib" for="ylzx2"><img src="resources/images/pc/pays-yl.jpg" alt="银联在线" width="168" height="66" />快捷支付</label>
				</li>
			</ul>
			
			<div class="btn-pays">
				<input type="hidden" name="orderId" value="${order.orderId }"/>
				<input type="button" class="btn-submit" value="去支付" ${overTime?'disabled':'' } id="btnSub"/>
			</div>
		</div>
		
	</div>

</div>

<!-- content end -->

<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->
<c:if test="${overTime }">
    <script type="text/javascript">
    	alert('订单超出时间,无法支付!');
    	window.location.href=__base_path__+"pc/pv/order/list";
    </script>
</c:if>

<!-- star 支付弹窗 -->
<div class="z_choosepay_mark">
	<div class="z_choosepay_box">
		<div class="z_choosepay_tit">
			<div class="z_choosepay_l f_left">支付遇到问题？</div>
			<div class="z_choosepay_r f_right" onclick="zHideChoosePay();"></div>
		</div>
		<div class="z_choosepay_btns">
			<h4 class="z_choosepay_tips"><span class="z_tishi"><img src="resources/images/pc/ts_img.png" alt="请注意！"/></span>支付完成前请不要关闭此窗口。完成支付后请根据你的情况点击下面的按钮:</h4>
			<h4 class="z_choosepay_tips2">请在打开的支付页面收银台完成付款后再选择。</h4>
			<input type="button" class="z_choosepay_cancel" value="已完成支付" onclick="jump();" />
			<input type="button" class="z_choosepay_ensure" value="支付遇到问题" onclick="zHideChoosePay();" />
			<a href="javascript:;" class="z_choosepay_back" onclick="zHideChoosePay();">重新返回支付</a>
		</div>
	</div>
</div>
<!-- end 支付弹窗 -->



</body>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script>
	
	// 支付弹窗
	function zShowChoosePay(){
		$('.z_choosepay_mark').show();
	}
	function zHideChoosePay(){
		$('.z_choosepay_mark').hide();
	}
	function jump(){
		window.location.href=__base_path__+"pc/pv/order/detail?orderId="+$('[name=orderId]').val();
	}

	$(function(){
		
		/*支付方式选择*/
		var labels = $('.pays-cont .list label'),
			inputPays = $('.pays-cont .list input');
			
//		labels.on('click', function(){
//			labels.removeClass('current');
//			$(this).addClass('current');
//		})
		
		inputPays.on('click', function(){
			labels.removeClass('current');
			$(this).closest('li').find('label').addClass('current');
		})
		
		$('#btnSub').click(function(){
			var self = $(this);
			//self.attr('disabled','disabled');
			
			var orderId = $('[name=orderId]').val().trim();
			var way = $('[name=pays]:checked').val();
			var href = '';
			if(way == 'alipay'){
				href=__base_path__+'pc/pv/order/alipayPay?orderId=' + $('[name=orderId]').val();
			} else if(way == 'unionpay')
			{
				href=__base_path__+'pc/pv/order/unionpayPay?orderId=' + $('[name=orderId]').val();
			}else if(way == 'unionpay2')
			{
				href=__base_path__+'pc/pv/order/unionpayPay2?orderId=' + $('[name=orderId]').val();
			} else if (false && way=='test'){
				<%--$.ajax({
				type : 'POST',
				dataType : 'json',
				url : 'pc/pv/order/walletPay',
				cache : false,
				data : {
					orderId : $('[name=orderId]').val(),
					password : '123456'
				},
				success : function(data) {
					if (data.msg == 'success') {
						alert('支付成功');
						window.location.href=__base_path__+"pc/pv/order/detail?orderId="+orderId;
					} else {
						alert(data.data.text);
						self.removeAttr('disabled');
					}
				},
				error : function() {
					alert('error');
				}
				});
				return;--%>
			}
			window.open(href);
			zShowChoosePay();
			//window.location.href=href;
		})
		
	})
	
</script>

</html>




<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>选择支付方式</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script language="JavaScript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<script>
	$(function() {
		$('button').click(function(){
			if ($('[name=payway]').val() == '1') {
			var self = $(this);
		
			var orderId = $('[name=orderId]').val().trim();
			var password = $('[name=password]').val().trim();
			
			self.attr('disabled','disabled');
			$.ajax({
				type : 'POST',
				dataType : 'json',
				url : 'pc/pv/order/walletPay',
				cache : false,
				data : {
					orderId : orderId,
					password : password
				},
				success : function(data) {
					if (data.msg == 'success') {
						alert('支付成功')
						window.location.href="pc/pv/order/detail?orderId="+orderId;
					} else {
						alert(data.data.text);
						self.removeAttr('disabled');
					}
				},
				error : function() {
					alert('error');
				}
			});
		}
		})
	})
</script>
	</head>
  
  <body>
    <h3>选择支付方式</h3>
    <div>
    	订单信息
    	<div>名字:${order.relationName }</div>
    	<div>数量:${order.num }</div>
    	<div>总计:${order.totalMoney }</div>
    	<div>收货地址:${order.relationName }</div>
    	<div>
    		<input type="radio" name="payway" value="1" checked>余额支付<br>
    		<input type="radio" name="payway" value="2">支付宝支付
    		支付密码:<input type="text" name="password">
    		<input type="hidden" name="orderId" value="${order.orderId }">
    		<button type="button" ${overTime?'disabled':'' }>去支付</button>
    	</div>
    	
    </div>
    
  </body>
</html>
-->