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
        <title>我的好友</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/swiper.min.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
        <style>
        	.swiper-container { height: auto !important;}
        </style>
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<div class="z_bg">
			<div class="z_friend_top">
				<p class="z_h20">&nbsp;</p>
				<div class="friend_search_box_1">
					<img src="<%=basePath %>resources/images/my-friend-2.png" alt="搜索" class="friend_sarch_icon_2" />
					<input type="text" class="z_search_number_1" readonly="readonly" placeholder="通过手机号码/昵称添加好友"  onclick="window.location.href='<%=basePath %>wpv/ursearchFriends'"/>
				</div>
				<c:if test="${type == null}">
					<div class="my_friend_list">
						<ul>
							<a href="<%=basePath %>wpv/urmyFriends?type=new">
								<li>
									<div class="list_img_1 position_r">
										<img src="<%=basePath %>resources/images/my-friend-3.png" alt="新的朋友" />
										<!-- 朋友数量-->
											<c:if test="${newFreindsCount > 0 }">
												<span class="friend_number"><%-- ${newFreindsCount } --%></span>
											</c:if>
										<!-- 朋友数量-->
									</div>
									<div class="list_word">新的朋友</div>
								</li>
							</a>
							<li>
								<a class="friend_erweima">
									<div class="list_img_1">
										<img src="<%=basePath %>resources/images/my-friend-4.png" alt="新的朋友" />
									</div>
									<div class="list_word">我的二维码</div>
								</a>
							</li>
							<li>
								<a class="invite_friend">
									<div class="list_img_1">
										<img src="<%=basePath %>resources/images/my-friend-5.png" alt="新的朋友" />
									</div>
									<div class="list_word">邀请链接</div>
								</a>
							</li>
							<!-- <a href="javascript:;" style="-webkit-user-select: auto; user-select: auto;"></a> -->
								<li style="-webkit-user-select: auto ; user-select: auto;">
									<!-- <div class="list_img_4">${session_manager.inviteCode}</div> -->
									<p class="list_img_4">${session_manager.inviteCode}</p>
									<div class="list_word">邀请码</div>
								</li>
							
						</ul>
					</div>
				</c:if>
			</div><!-- end z_friend_top -->
			
			<!-- star friend list -->
			<c:choose>
				<c:when test="${fn:length(freindsList) > 0}">
					<h3 class="wx_title">好友列表</h3>
					<div class="wx_friend">
						<c:forEach items="${freindsList}" var="l" varStatus="status">
							<div class="friend_list_box_1" <c:if test="${null == type && l.status != 1}">style="display:none"</c:if>>
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
											<p class="z_friend_name">
												${l.nickname }
											</p>
											<p class="z_friend_sex">
												<c:if test="${l.sex == 1}">男</c:if>
					                    		<c:if test="${l.sex == 2}">女</c:if>
											</p>
										</div>
									</div>
									<div class="friend_option_way">
										<c:choose>
											<c:when test="${type eq 'new' }">
												<div class="friend_option_invite">
													<c:choose>
														<c:when test="${l.status eq 0 }">
															<a href="javascript:agree(${l.userId })">同意</a>
							                    		</c:when>
							                    		<c:when test="${l.status eq 1 }">
							                    			已添加
							                    		</c:when>
							                    		<c:when test="${l.status eq 4 }">
							                    			已发送
							                    		</c:when>
													</c:choose>
												</div>
											</c:when>
											
											<c:otherwise>
												<c:choose>
													<c:when test="${operate eq 'sendPig' }">
														<div class="friend_option_invite_sendpig" onclick="sendPig(${l.userId})">
															赠送猪仔
														</div>
													</c:when>
													<c:when test="${operate eq 'sendPigCoupon' }">
														<div class="friend_option_invite_sendpingcoupon" onclick="sendPigCoupon(${l.userId})">
															赠送猪肉券
														</div>
													</c:when>
													<c:otherwise>
														<div class="friend_option_invite"><%-- onclick="sendPig(${l.userId})" --%>
															赠送
														</div>
														<!--赠送猪仔or猪肉劵-->
														<div class="z_gift_selection">
															<a href="javascript:;" class="sent_piggy" onclick="sendPig(${l.userId})">赠送猪仔</a>
															<div class="send_pork_securities">赠送猪肉劵</div>
															<em class="z_top_right"></em>
														</div>
														<!-- end 赠送猪仔or猪肉劵 -->
														<!-- star 点击'赠送'出现全屏遮罩层  -->
														<div class="z_send_zhao"></div>
														<!-- end 点击'赠送'出现全屏遮罩层  -->
													</c:otherwise>
												</c:choose>
												
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<!-- 删除 -->
								<div class="list_delete_friend" data-uid=${l.userId}><img src="<%=basePath %>resources/images/shopping_11.png" alt="删除"></div>
								<!-- end 删除 -->
								
								<!-- 赠送猪肉券 -->
								<div class="z_pork_securitites">
									<div class="swiper-container">
  										<div class="swiper-wrapper">
											<c:if test="${couponList != null && fn:length(couponList) > 0}">
												<c:set var="count" value="0"></c:set>
												<c:set var="r" value="0"></c:set>
												<c:forEach items="${couponList }" var="cl" varStatus="status">
													<c:if test="${r eq 0  }">
														<div class="swiper-slide">
														<ul>
													</c:if>
													<c:if test="${count < 6  }">
														<c:set var="r" value="1"></c:set>
														<c:set var="count" value="${count+1 }"></c:set>
														<li>
															<div class="friend_pig_ticket" data-id="${ cl.myCouponId}" data-leftMoney="${cl.canUseMoney }" data-userId="${l.userId }">
																<div class="friend_pig_ticket_middle">
																	<span>￥</span>
																	<span class="friend_pig_ticket_num">${cl.canUseMoney }</span>
																</div>
																<div class="friend_pig_ticket_bottom"><fmt:formatDate value="${cl.endTime}" pattern='yyyy-MM-dd' /></div>
															</div>
														</li>
														<c:if test="${count eq 6 || status.index eq fn:length(couponList) -1 }">
															<c:set var="count" value="0"></c:set>
															<c:set var="r" value="0"></c:set>
														</c:if>
													</c:if>
													<c:if test="${r eq 0  }">
														</ul>
														</div>
													</c:if>
												</c:forEach>
											</c:if>
										</div>
									</div>
								</div>
								<!-- end 赠送猪肉券 -->
							</div>
							<!-- end friend_list_box_1 -->
						</c:forEach>
					</div><!-- end friend list -->
				</c:when>
				<c:otherwise>
					<p class="z_friend_no_thing">您尚未有好友记录</p>
				</c:otherwise>
			</c:choose>
			<c:if test="${operate eq 'sendPig' }">
				<jsp:include page="../user/send.jsp"></jsp:include>
			</c:if>
		</div>
		
		<!-- star 删除好友 -->
		<div class="message_info_friend">
			<div class="title_info_friend">
			<c:choose>
				<c:when test="${type == null}">
					<div class="title_info_friend">确定删除好友？</div>
				</c:when>
				<c:otherwise>	
					<div class="title_info_friend">是否删除申请记录？</div>
				</c:otherwise>
			</c:choose>
			</div>
			<div class="content_info_friend">
				<input type="button" class="z_friend_cancel" value="取消" />
				<input type="button" class="z_friend_ensure" value="确定" />
			</div>
		</div>
		<div class="z_friend_mark"></div>
		<!-- end 删除好友 -->
			
		<!-- star 删除好友 -->
		<!-- <div class="message_info_friend">
			<div class="title_info_friend">确定拒绝该好友？</div>
			<div class="content_info_friend">
				<input type="button" class="z_friend_cancel" value="取消" />
				<input type="button" class="z_friend_ensure" value="确定" />
			</div>
		</div>
		<div class="z_friend_mark"></div> -->
		<!-- end 删除好友 -->
		
		<!-- 我的二维码-->
		<div class="friend_erweima_box">
			<img src="${session_manager.qrCode }" alt="" />
			<h4>说明：此二维码可用于邀请他人注册。</h4>
			<p>1.让您的朋友使用手机浏览器或是微信“扫一扫”扫描上方二维码；</p>
			<p>2.扫描成功后，可在弹出的页面中完成注册。 </p>
		</div>
		<!-- end 我的二维码-->
		
		<c:if test="${operate != 'sendPig'}">
			<form action="<%=basePath %>wpv/ursendCoupon" id="allProjectForm2" name="allProjectForm2" method="post">
				<input type="hidden" id="myCouponId" name="myCouponId" value="${myCouponId }">
				<input type="hidden" id="freindId2" name="freindId" value="${freindId }">
				<input type="hidden" id="pageSource" name="pageSource" value="${pageSource }">
				<!--送猪肉券-->
				<div class="z_send_box">
					<div class="z_send_box_1">
						<input type="tel" id="sendMoney" name="sendMoney" maxlength="9" class="get_piglets_num" placeholder="请填写赠送金额" />
						<textarea id="sendRemark" name="sendRemark" class="leave_a_message" placeholder="给好友留言"></textarea>
					</div>
					<div class="z_send_box_2">
						<input type="button" class="z_cancel_btn" value="取消" />
						<input type="button" class="z_confirm_btn" value="确定" />
					</div>
				</div>
				<!--end 送猪肉券-->
				<jsp:include page="../wallet/input_pay_password.jsp">
					<jsp:param value="submitFormToSendPigCoupon" name="confirmFunc"/>
				</jsp:include>
			</form>
			
		</c:if>
		<!-- 我的邀请 -->
		<div class="friend_mask_layer"></div>
		<div class="invite_friend_box">
			<!-- <div class="invite_friend_link">
				<div class="share_icon_wx"></div>
				<p>微信好友</p>
			</div>
			<div class="invite_friend_link">
				<div class="share_icon_wx_q"></div>
				<p>朋友圈</p>
			</div> -->
			<div class="invite_friend_link">
				<a href="javascript:;" class="jiathis_button_qzone">
					<div class="share_icon_qzone"></div>
					<p>QQ空间</p>
				</a>
			</div>
			<div class="invite_friend_link">
				<a href="javascript:;" class="jiathis_button_cqq">
					<div class="share_icon_qq"></div>
					<p>QQ好友</p>
				</a>
			</div>
			<div class="invite_friend_link">
				<a href="javascript:;" class="jiathis_button_tsina">
					<div class="share_icon_sina"></div>
					<p>新浪微博</p>
				</a>
			</div>
		</div>
		<!-- end 我的邀请 -->
		
		<!-- 邀请自定义标题、链接  -->
		<script>
			var jiathis_config = {
				url: "<%=basePath %>wpnv/ixhome?inviteCode=${session_manager.inviteCode}" ,
				title: "欢乐养猪、快速收益，“八戒王国online”不一样的猪场 ，快到碗里来！",
				pic: "<%=basePath %>resources/images/share-logo.png"
			}
		</script>	
		<!-- end 邀请自定义标题、链接  -->
		<jsp:include page="../common/commonTip.jsp"></jsp:include>
		<c:choose>
			<c:when test="${type eq 'new'}">
				<jsp:include page="../back.jsp">
					<jsp:param value="wpv/urmyFriends" name="backUrl"/>
				</jsp:include>
			</c:when>
			<c:otherwise>
		    	<jsp:include page="../footer.jsp">
		    		<jsp:param value="10002" name="pageIndex"/>
		    	</jsp:include>
			</c:otherwise>
		</c:choose>
	</body>
</html>
<script type="text/javascript" src="http://v2.jiathis.com/code/jia.js" charset="utf-8"></script>
<script src="<%=basePath %>resources/js/layer/layer.js" ></script>
<script src="<%=basePath %>resources/js/swiper.min.js"></script>
<script src="<%=basePath %>resources/js/zepto.min.js"></script>
<script type="text/javascript">
	function sendPig(userId){
		
		if(${operate eq 'sendPig' }){
			
			$("#freindId").val(userId);
			
			showDiv();
			
		}else{
			
			window.location.href="<%=basePath %>wpnv/ixpigNumDetail?freindsId="+userId+"&pageSource=40001&operate=sendPig";
		}
	}
	function agree(userId){
		window.location.href="<%=basePath %>wpv/uraddMyFriends?freindsId="+userId+"&agreeType=1&type=new";
	}
	
	$(function(){
		// 二维码
		$('.friend_erweima').on('click',function(){
			var height_ = 310,
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
			    closeBtn: true, // false不显示关闭按钮
				shift:1, // 0-6的动画形式，-1不开启
			    content: $(".friend_erweima_box") 
			}); 
			layer.style(index,{
				'border-radius':'3px'// 修改layer最外层容器样式
			});
		});
		
		// 送猪肉券
		$('.friend_pig_ticket').on('click',function(){
			var dataId = $(this).attr("data-id");
			var leftMoney = $(this).attr("data-leftMoney");
			var freindId2 = $(this).attr("data-userId");
			
			showSendPigCoupon(dataId,leftMoney,freindId2);
		});
		
		// 邀请
		$('.invite_friend').on('click',function(){
			$('.friend_mask_layer, .invite_friend_box').show();
		});
		$('.friend_mask_layer').on('click',function(){
			$('.friend_mask_layer, .invite_friend_box').hide();
		});
	});
	
	function sendPigCoupon(freindId2){
		
		showSendPigCoupon('${queryCouponId}','${leftMoney}',freindId2);
	}
	
	function showSendPigCoupon(dataId,leftMoney,freindId2){
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
		    closeBtn: false, // 不显示关闭按钮
			shift:1, // 0-6的动画形式，-1不开启
		    content: $(".z_send_box") 
		}); 
		layer.style(index,{
			'border-radius':'3px'// 修改layer最外层容器样式
		});
		
		$('.z_cancel_btn').on('click',function(){
			layer.closeAll();
		});
		$('.z_confirm_btn').on('click',function(){
			
			var sendMoney = $("#sendMoney").val();
			if(sendMoney == '' || isNaN(sendMoney) || parseFloat(sendMoney) > parseFloat(leftMoney)){
				alert("请输入正确的赠送金额");
				return;
			}
			$("#myCouponId").val(dataId);
			$("#freindId2").val(freindId2);
			//alert($("#myCouponId").val());
			//alert($("#freindId2").val());
			
			showPayPwd();
		
			layer.closeAll();
			
		});
	}
	
	function submitFormToSendPigCoupon(){
		
		$("#allProjectForm2").submit();
		$(":input[type=button]").attr("disabled",true);
	}
	
	$(function(){
		$('.friend_option_invite').on('click',function(){
			var $self = $(this),
				gift_selection = $('.z_gift_selection'),
				box_1 = $('.friend_list_box_1');
				block_ = $(this).closest(box_1).siblings().find('.z_pork_securitites').css('display','block');//查询当前父元素下z_pork_securitites的状态
				
			var flag = $self.data('flag');
			
			//  当前送券弹层为隐藏状态，同级borther的送券弹层为显示状态，点击后隐藏同级borther的弹层，显示当前的送券弹层
			if(block_){
				$(this).closest(box_1).siblings().find('.z_pork_securitites').hide();
			}
			
			// 通过标记当前赠送按钮状态来显示弹层
			if (!flag) { 	// 显示
				$(this).parent().find(gift_selection).show();
				$self.data('flag', true);
				<c:if test="${type == null}"> // 判断是好友首页还是新增朋友 
					$self.text('取消');
				</c:if>
				
				
			} else {		// 隐藏
				$(this).parent().find(gift_selection).hide();
				$self.data('flag', false);
				<c:if test="${type == null}">
					$self.text('赠送');
				</c:if>
				
			}
			// 点击同级下的其他按钮隐藏当前按钮所触发的弹层
			<c:if test="${type == null}">
				$(this).closest(box_1).siblings().find('.friend_option_invite').data('flag', false).text('赠送');
			</c:if>
			
			$(this).closest(box_1).siblings().find(gift_selection).hide();
			
		});
		
		$('.send_pork_securities').on('click',function(){
			if('${couponList}' == null || '${couponList}' == '' || '${couponList}' == '[]'){
				alert("您当前没有可赠送的猪肉券");
				// 显示送券弹层
				//$(this).parent().hide();
				return ;
			}
			var z_pork_securitites = $('.z_pork_securitites'),
				box_1 = $('.friend_list_box_1');
			
			// 显示送券弹层
			$(this).parent().hide();
			$(this).closest(box_1).find(z_pork_securitites).show();
			
			// 六张以上的猪肉券时可以左划选择
			var mySwiper = new Swiper('.swiper-container', {
				autoplay: false		// 可选选项，自动滑动
			})
		});
		
		// 删除好友
		$('.wx_friend .friend_list_box').on({
			'swipeLeft':function(){
				$('.wx_friend .friend_list_box').removeClass('li_swipeleft_friend');
				// 左划动画
				$(this).addClass('li_swipeleft_friend');
				
				// 标记当前所在行
				var this_ = $(this).closest('.friend_list_box_1');
				
				var uid = null;
				// 点击显示删除确认框
				$('.list_delete_friend').on("click",function(){
					$('.message_info_friend, .z_friend_mark').show();
					uid = $(this).data("uid");
				});
				$('.z_friend_cancel, .z_friend_mark').on('click',function(){
					$('.message_info_friend, .z_friend_mark').hide();
				});
				$('.z_friend_ensure').on('click',function(){
					$('.message_info_friend, .z_friend_mark').hide();
					this_.hide();
					window.location.href="<%=basePath %>wpv/urdeleteMyFriends?freindsId="+uid;
				});
			},
			'swipeRight': function(){
				// 右划还原
				$(this).removeClass('li_swipeleft_friend');
			}
		})
	})
</script>

