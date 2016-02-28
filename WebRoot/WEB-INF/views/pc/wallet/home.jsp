<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="__page_name__" value="账户总览" scope="request"/>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<jsp:include page="../meta.jsp"></jsp:include>
	 	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" href="resources/css/pc/base.css"/>
		<link rel="stylesheet" href="resources/css/pc/main.css"/>
		<link rel="stylesheet" href="resources/css/pc/pangzi_overview.css" />
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
				<jsp:param value="2" name="nav"/>
			</jsp:include>
			<!--mypig_left_nav -->
			<div class="right_main">
				<div class="my_pig_tit">
			    	<img src="resources/images/pc/nav_tit_bg.png" alt="标题背景"/>
			        <div class="pig_tit"><p>账户总览</p></div>
			    </div>
			    <div class="mypig_body">
			    	
			    	<!-- 第一部分 -->
			    	<div class="z_fir">
			    		<div class="z_fir_title f_l clearfix">
			    			<div class="z_green_point f_l"></div>
			    			<div class="z_fir_title_word f_l">账户余额</div>
			    			<div class="z_green_point f_l"></div>
			    		</div>
			    		<div class="z_fir_content f_l clearfix">
			    			<div class="z_total_money f_l">总金额：<span>${wallet.money!=null?wallet.money:0 }</span>元</div>
			    			<a <c:choose><c:when test="${wallet.money == null || wallet.money <= 0}">href="javascript:alert('余额不足，无法提现')"</c:when><c:otherwise>href="pc/pv/wallet/takeCash"</c:otherwise></c:choose> class="z_extract_btn f_l">提现</a>
			    		</div>
			    	</div><!-- 第一部分 -->
			    	
			    	<!-- 第二部分 -->
			    	<div class="z_sec">
			    		<div class="z_sec_title f_l clearfix">
			    			<div class="z_green_point f_l"></div>
			    			<div class="z_fir_title_word f_l">我的银行卡</div>
			    			<div class="z_green_point f_l"></div>
			    		</div>
			    		<div class="z_sec_content pig_row_card f_l clearfix">
			    			<div class="title">已绑定${wallet.cardNumber!=null?wallet.cardNumber:0}张</div>
					    	<ul class="list clearfix">
						    	<c:forEach items="${bankCardList}" var="bankCard">
						    		<li class="item" data-id="${bankCard.cardId }">
						    			<div class="row_1">
						    				<span class="s1"><img src="resources/images/pc/bankicon/bank-${bankCard.bankCode }.png" alt="${bankCard.bank }" />${bankCard.bank }</span>
						    				<div class="f_right">
						    					<c:set var="tmpcount" value="${fn:length(bankCard.cardNo)}"/>
							    				<span class="s2">尾号${fn:substring(bankCard.cardNo,tmpcount-4,tmpcount)}</span>
							    				<span class="s3">储蓄卡</span>
						    				</div>
						    			</div>
						    			<%--<div class="row_2">已开通</div>
						    			--%>
						    			<div class="row_3"><a href="javascript:;" class="z_jiebang">解绑</a></div>
						    		</li>
						    	</c:forEach>
					    		<li class="item add"><a href="pc/pv/wallet/bandCardEdit"></a></li>
					    	</ul>
			    		</div>
			    	</div><!-- 第二部分 -->
			    	
			    	<!-- 第三部分 -->
			    	<div class="z_thr">
			    		<div class="z_thr_title f_l clearfix">
			    			<div class="z_green_point f_l"></div>
			    			<div class="z_fir_title_word f_l">收支明细</div>
			    			<div class="z_green_point f_l"></div>
			    		</div>
			    		<div class="pig_row_details">
				    		<div class="det_table">
					    		<div class="tab_head">
					    			<div class="tr">
					    				<div class="td td_1">日期</div>
						    			<div class="td td_2">收入（元）</div>
						    			<div class="td td_3">支出（元）</div>
						    			<div class="td td_4">账户余额</div>
					    			</div>
					    		</div>
					    		<div class="tab_body">
					    			<c:choose>
					    				<c:when test="${fn:length(walletChangeList) > 0 }">
							    			<c:forEach items="${walletChangeList }" var="walletChange" varStatus="status">
							    				
							    				<div <c:choose>
								    					<c:when test="${(status.index + 1) % 2  == 0}">class="tr bg_f8f6f4"</c:when>
								    					<c:otherwise>class="tr"</c:otherwise>
								    				 </c:choose>
							    				>
								    				<div class="td td_1"><fmt:formatDate value='${walletChange.changeTime }' pattern='yyyy-MM-dd HH:mm:ss' /></div>
								    				<div class="td td_2"><c:if test="${walletChange.changeType == 2 || walletChange.changeType == 4 || walletChange.changeType == 5}">${walletChange.changeMoney}</c:if></div>
								    				<div class="td td_3">-<c:if test="${walletChange.changeType == 1 || walletChange.changeType == 3}">${walletChange.changeMoney}</c:if></div>
								    				<div class="td td_4">${walletChange.afterMoney }</div>
								    			</div>
							    			</c:forEach>
					    				</c:when>
					    				<c:otherwise>
					    					<div class="tr bg_f8f6f4">
					    						<div class="z_friend_jilu">暂无记录</div>
					    					</div>
					    				</c:otherwise>
					    			</c:choose>
					    		</div>
					    	</div>
					    </div>
					    <jsp:include page="../pager.jsp" />
			    	</div><!-- 第三部分 -->
			    	
			    </div>
			</div>
			<div class="clear"></div>
		</div><!-- end mypig_center -->
		<!-- 中间部分-->
		
		
		<!--底部 -->
		<jsp:include page="../footer.jsp"></jsp:include>
		<!--底部 -->
		
		<!-- star 解绑银行卡 -->
		<div class="z_card_box">
			<div class="z_close_btn"></div>
			<div class="z_unwrapping f_l">
				<div class="z_unwrapping_img f_l"></div>
				<div class="z_unwrapping_word f_l">解绑银行卡，因为：</div>
			</div>
			<div class="z_unwrapping_reason f_l">
				<input type="radio" name="z_reason_name" class="z_reason_radio f_l" id="z_reason_radio_1" value="我担心资金安全" />
				<label for="z_reason_radio_1" class="z_label">我担心资金安全</label>
				<input type="radio" name="z_reason_name" class="z_reason_radio f_l" id="z_reason_radio_2" value="不明白什么是快捷支付" />
				<label for="z_reason_radio_2" class="z_label">不明白什么是快捷支付</label>
				<input type="radio" name="z_reason_name" class="z_reason_radio f_l" id="z_reason_radio_3" value="我不再使用这张卡" />
				<label for="z_reason_radio_3" class="z_label">我不再使用这张卡</label>
				<input type="radio" name="z_reason_name" class="z_reason_radio f_l" id="z_reason_radio_4" value="其他" checked/>
				<label for="z_reason_radio_4" class="z_label">其他</label>
				支付密码:<input type="password" name="paypwd" maxLength="6"/>
				<input type="hidden" name="cardId"/>
			</div>
			<div class="z_btns f_l">
				<input type="button" class="z_save" value="确定" />
				<input type="button" class="z_cancel" value="取消" />
			</div>
		</div>
		<!-- end 解绑银行卡 -->
	</body>
</html>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script src="resources/js/layer/layer.js" ></script>
<script>
	$('.z_jiebang').bind('click',function(){
		$('[name=cardId]').val($(this).parent().parent().attr('data-id'));
	
		var height_ = 334,
			layer_width = 596,
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
		    closeBtn: false, //false不显示关闭按钮
			shift:1, //0-6的动画形式，-1不开启
		    content: $(".z_card_box") 
		}); 
		layer.style(index,{
			'border-radius':'3px'//修改layer最外层容器样式
		});
		
		$('.z_cancel, .z_close_btn').on('click',function(){
			layer.closeAll(); // 关闭
		});
		$('.z_save').bind('click',function(){
			var self = $(this);
			var cardId = $('[name=cardId]').val();
			var pwd = $('[name=paypwd]').val();
			
			if(pwd=='' || pwd.length!=6 || !/^[0-9]*$/.test(pwd)){
				alert('请正确输入支付密码');
				return;
			}
			
			self.attr('disabled','disabled');
			$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/wallet/bankCardDel',
		    cache: false,
		    data: {cardId:cardId, password:pwd},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('解绑成功')
		    		window.location.href=__base_path__+'/pc/pv/wallet/home';
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
	});
</script>




