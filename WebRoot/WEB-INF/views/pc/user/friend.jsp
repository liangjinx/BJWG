<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="__page_name__" value="我的好友" scope="request"/>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<jsp:include page="../meta.jsp"></jsp:include>
		<link rel="stylesheet" href="resources/css/pc/base.css" />
		<link rel="stylesheet" href="resources/css/pc/main.css" />
		<link rel="stylesheet" href="resources/css/pc/pangzi_overview.css" />
		<script src="resources/js/jquery-1.11.1.min.js"></script>
		<script src="resources/js/pc/public.js"></script>
		<script src="resources/js/pc/layer/layer.js"></script>
		<script src="resources/js/jquery.zclip.min.js"></script>
		<style>
			.show_add_ul{ width:100%; height:auto; position:relative;}
			.show_add_ul li{ width:100%; line-height:30px; float:left; margin-top:20px;}
			.show_add_ul li .this_p{ width:70px; line-height:30px; float:left; text-align:right; font-size:14px;}
			.show_add_ul li .textinput{ width:80%; height:46px; line-height:46px; margin-left:10%;font-size:14px; color:#333;font-family:"Microsoft YaHei" ;}
			.show_add_ul li .lg_buts{width:130px; height:50px; line-height:46px; float:left; margin-right:10px; border:1px solid #ccc; outline:0px; font-size:16px; border-radius:3px; cursor:pointer;font-family:"Microsoft YaHei" ;}
			.show_add_ul li .but_h1{ background-color:#ff6600; color:#fff;border:1px solid #ff6600; }
			.show_add_ul li .but_h2{ background-color:#fff; color:#666;}
			.friends_p a { font-size: 16px;}
			.lg_code_img{width: 150px; height: 150px; border: 1px solid #ccc; margin-top: 20px; margin-left: 130px; outline: 0px;}
		</style>
	</head>
	<body class="body_bg">
		<!--banner_box -->
		<jsp:include page="../header.jsp"></jsp:include>
		<!--banner_box -->
		<!--导航栏-->
		<jsp:include page="../nav.jsp">
			<jsp:param value="5" name="nav" />
		</jsp:include>
		<!-- 导航栏-->
		<!--中间部分 -->
		<div class="center mypig_center">
			<!--mypig_left_nav -->
			<jsp:include page="../user/nav.jsp">
				<jsp:param value="4" name="nav" />
			</jsp:include>
			<!--mypig_left_nav -->
			<div class="right_main">
				<div class="my_pig_tit">
					<!--my_pig_tit -->
					<img src="resources/images/pc/nav_tit_bg.png" alt="我的好友" />
					<div class="pig_tit">
						<p>我的好友</p>
					</div>
				</div>
				<!--my_pig_tit -->
				<div class="mypig_body" style="min-height: 600px;">
					<form action="pc/pv/user/friend" method="get">
						<!-- <input type="text" name="keyword" value="" placeholder="通过手机号/昵称添加好友" class="search_myfriends" />
						<input type="submit" class="z_friend_btn" /> -->
						
						<input type="text" value="" placeholder="通过手机号/昵称添加好友" name="keyword" class="search_myfriends"/>
    					<input type="submit" class="lg_but3" value="搜索"/>
					</form>
					
					<div class="myfriends_tit">
						${!isSearch?'好友列表':'搜索结果' }
					</div>

					<c:if test="${!isSearch }">
						<div class="z_friend_options f_l">
							<div class="z_friend_bd">
								<div class="z_friend_option_way">
									<a href="pc/pv/user/newFriends">
										<img src="resources/images/pc/${newFreindsCount>0?'lg_xzhy':'lg_xzhy2' }.png" alt="新增好友" style="width:200px; height:80px; border:0px; outline:0px;" />
									</a>
								</div>
								<div class="z_friend_option_way" id="lg_code_but">
									<a href="javascript:;">
										<img src="resources/images/pc/lg_ewm.png" alt="二维码" />
									</a>
								</div>
								<div class="z_friend_option_way" onclick="zShowShare();">
									<a href="javascript:;">
										<img src="resources/images/pc/lg_yqlj.png" alt="邀请链接" />
									</a>
								</div>
								<div class="z_friend_option_way">
									<a class="z_invitecode" id="cp-btn" href="javascript:void(0)">
										<p class="z_invitation_code" id="fe_text">${session_manager.inviteCode}</p>
									</a>
								</div>
							</div>
						</div>
					</c:if>

					<ul class="myfriends_list">
						<c:forEach items="${friendList}" var="f">
							<li data-user="${f.userId }">
								<img src="${f.headImg }" alt="logo" class="logo_img" />
								<div class="friends_p m_top20">
									<p>
										昵称：${f.nickname }
									</p>
									<c:if test="${!isSearch }">
										<a href="pc/pv/user/sendPigChoose?friendId=${f.userId }">赠送猪仔</a>
									</c:if>
								</div>
								<div class="friends_p m_top10">
									<p>
										&nbsp;<!-- 抢购数量：22只 -->
									</p>
									
									<c:if test="${!isSearch }">
										<a href="pc/pv/user/sendTicketChoose?friendId=${f.userId }">赠送猪肉券</a>
									</c:if>
								</div>
								<c:if test="${!isSearch }">
									<div class="z_delete_friend btnDeleteFriend"></div>
								</c:if>
								<c:if test="${isSearch }">
									<div class="z_friend_pass friend_pass2 btnAddFriend">添加</div><!-- addSubmit(this); -->
									<!--<button type="button" >添加</button> -->
								</c:if>
							</li>
						</c:forEach>
					</ul>
					<jsp:include page="../pager.jsp">
						<jsp:param name="otherQueryArg" value="${param.keyword != null ? 'keyword='.concat(param.keyword) : '' }" />
					</jsp:include>
					<div class="clear"></div>
				</div>
				<!--mypig_body -->
			</div>


			<div class="clear"></div>
		</div>


		<!-- 中间部分-->
		<!--底部 -->
		<jsp:include page="../footer.jsp"></jsp:include>
		<!--底部 -->
		<div id="show_add" style="display:none;">
			<ul class="show_add_ul">
    			<li><input type="text" class="textinput" placeholder="   请输入验证信息" name="verifyInfo"/></li>        
        		<li>
        		<p class="this_p">&nbsp;</p>
        		<button class="lg_buts but_h1 btnAddSub" >保存</button><button class="lg_buts but_h2 btnAddCancel">取消</button>
        	</li>      
    		</ul>
		</div>
		
		<div id="show_add_code" style="display:none;">
			<img src="${sessionScope[CommConstant.SESSION_MANAGER].qrCode}" class="lg_code_img"/>
		</div>
		
		<!-- star 邀请 -->
		<div class="z_friend_mark" onclick="zHideShare();">
			<div class="z_friend_shares">
				<div class="z_friend_shares_tit">
					<div class="z_friend_shares_l f_left">
						分享至
					</div>
					<div class="z_friend_shares_r f_right" onclick="zHideShare();"></div>
				</div>
				<div class="z_friend_shares_box">
					<div class="z_invite_link">
						<a href="javascript:;" class="jiathis_button_qzone">
							<div class="share_icon_qzone"></div>
							<p>
								QQ空间
							</p> </a>
					</div>
					<div class="z_invite_link">
						<a href="javascript:;" class="jiathis_button_tsina">
							<div class="share_icon_sina"></div>
							<p>
								新浪微博
							</p> </a>
					</div>
				</div>
			</div>
		</div>
		<!-- end 邀请 -->
		<!-- 邀请自定义标题、链接  -->
		<script>
	var jiathis_config = {
		url: "<%=basePath%>?inviteCode=${session_manager.inviteCode}" ,
		title : "欢乐养猪、快速收益，“八戒王国online”不一样的猪场 ，快到碗里来！",
		pic: "<%=basePath %>resources/images/pc/share-logo.png"
	}
</script>
		<!-- 邀请自定义标题、链接  -->
	</body>
</html>
<script type="text/javascript" src="http://v2.jiathis.com/code/jia.js" charset="utf-8"></script>
<script>
	$(function(){
	    $("#cp-btn").zclip({
	        path:'<%=path%>/resources/js/ZeroClipboard.swf', //记得把ZeroClipboard.swf引入到项目中 
	        copy:function(){
	        	//alert("复制成功"+$('#fe_text').text());
	            return $('#fe_text').text();
	        },
	        afterCopy: function () {
	        	//$('.search_myfriends').val(tt);
	        	alert("复制成功");
	        }
	    });
	});
	function zShowShare(){
		$('.z_friend_mark').show();
	}
	function zHideShare(){
		$('.z_friend_mark').hide();
	}
	
	function addSubmit(caller){
		var self = $(caller);
		var id = self.parent().attr('data-user');
		var remark = $('[name=verifyInfo]').val();
		if(remark == ''){
			remark = '请求添加您为好友';
		}
		if(id == ''){
			alert('请输入必填项');
			return;
		}
		self.attr('disabled','disabled');
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/user/sendFriendRequest',
		    cache: false,
		    data: {friendId:id, sendRemark:remark},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('好友添加请求发送成功');
		    		window.location.href=window.location.href;
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
	
	var _click_element;
	
	$(".btnAddFriend").click(function(){
		_click_element = $(this).get(0);
		var layer_height =230;
		var window_heigit = $(window).height();
		var offset = 'auto';
		if(window_heigit <= layer_height) offset = "0px";
		layer.open({
		    type: 1,
		    title:'好友验证',
		    skin: 'layui-layer-rim',
		    area: ['400px', layer_height+'px'],
		    offset: offset,
		    scrollbar:true,
			offset: ['35%', '45%'],
			 shift:1, //0-6的动画形式，-1不开启
		    content: $("#show_add") 
		});	
		
	});
	$(".btnDeleteFriend").click(function(){
		var r=confirm("确认删除?");
		if(r){
		var self = $(this);
		var id = self.parent().attr('data-user');
		if(id == ''){
			alert('请输入必填项');
			return;
		}
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/user/deleteFriend',
		    cache: false,
		    data: {friendId:id},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('删除成功');
		    		window.location.href=window.location.href;
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
	});
	$("#lg_code_but").click(function(){
		_click_element = $(this).get(0);
		var layer_height =230;
		var window_heigit = $(window).height();
		var offset = 'auto';
		if(window_heigit <= layer_height) offset = "0px";
		layer.open({
		    type: 1,
		    title:'扫描二维码可用于邀请他人注册',
		    skin: 'layui-layer-rim',
		    area: ['400px', layer_height+'px'],
		    offset: offset,
		    scrollbar:true,
		    shade: 0.5,
			offset: ['35%', '45%'],
			 shift:0, //0-6的动画形式，-1不开启
		    content: $("#show_add_code") 
		});	
		
	});
	
	$('.btnAddCancel').click(function(){
		layer.closeAll();
	})
	$('.btnAddSub').click(function(){
		addSubmit(_click_element);
	})
</script>
