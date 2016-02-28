<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
		<title>服务人员管理</title>
		<style>
			.waiter_content {
				width: 100%;
				overflow: hidden;
			}
			.waiter_list {
				margin-bottom: 30px;
				background-color: #fff;
			}
			.waiter_list li {
				float: left;
				width: 33.3333%;
				height: 130px;
				font-size: 1.5rem;
				text-align: center;
				border-bottom: 1px solid #dedede;
			}
			.top {
				position: relative;
				width: 60px;
				margin: 20px auto 0;
				cursor: pointer;
			}
			.top .waiter_big_img {
				width: 60px;
				border-radius: 50%;
				-webkit-border-radius: 50%;
				-moz-border-radius: 50%;
			}
			.edit_img {
				position: absolute;
				bottom: -8px;
				right: -15px;
				width: 25px;
				height: 25px;
			}
			.waiter_small_img {
				width: 20px;
				height: 20px;
			}
			.waiter_name,
			.waiter_ren {
				font-size: 1.2rem;
				text-align: center;
			}
			.waiter_name {
				margin-top: 5px;
				color: #858386;
			}
			.waiter_ren {
				margin-top: 2px;
				color: #ffb402;
			}
			.waiter_foot {
				position: fixed;
				bottom: 0;
				left: 0;
				width: 100%;
				height: 50px;
				line-height: 50px;
				font-size: 1.6rem;
				color: #ffb402;
				text-align: center;
				border-top: 1px solid #efefef;
				background-color: #fff;
			}
			.waiter_info_popup {
				position: absolute;
				top: 50%;
				left: 50%;
				display: none;
				width: 90%;
				height: auto;
				border: 1px solid #efefef;
				border-radius: 5px;
				-webkit-border-radius: 5px;
				-moz-border-radius: 5px;
				background-color: #fff;
				z-index: 100;
				transform: translate(-50%,-50%); 
				-webkit-transform: translate(-50%,-50%);
				-moz-transform: translate(-50%,-50%); 
				-ms-transform: translate(-50%,-50%);
			}
			.mark {
				position: fixed;
				left: 0;
				right: 0;
				top: 0;
				bottom: 0;
				display: none;
				width: 100%;
				height: 100%;
				background: rgba(0,0,0,.5);
				z-index: 99;
			}
			.info_popup_top,
			.info_popup_content,
			.info_popup_content2,
			.info_popup_bottom {
				width: 94%;
				margin: 0 auto;
			}
			.info_popup_top {
				height: 220px;
				text-align: center;
			}
			.info_touxiang {
				width: 140px;
				height: 140px;
				margin-top: 21px;
				border-radius: 50%;
				-webkit-border-radius: 50%;
				-moz-border-radius: 50%;
			}
			.info_close {
				position: absolute;
				top: 15px;
				right: 15px;
				width: 16px;
			}
			.info_popup_content {
				height: 55px;
				line-height: 55px;
				margin-bottom: 10px;
				font-size: 1.6rem;
				color: #322c2c;
				text-align: left;
				border-top: 1px solid #dedede;
				border-bottom: 1px solid #dedede;
			}
			.info_popup_content em {
				color: #858386 !important;
			}
			.info_popup_contente2 {
				margin-top: 15px;
				margin-bottom: 15px;
			}
			.info_popup_contente2 .imgbox {
				float: left;
				width: 30%;
			}
			.info_popup_contente2 div.imgbox:nth-child(1) {
				margin-left: 5%;
				margin-right: 2%;
			}
			.info_popup_contente2 div.imgbox:nth-child(2) {
				margin-right: 2%;
			}
			.info_popup_contente2 .imgbox img {
				width: 80px;
				border-radius: 3px;
				-webkit-border-radius: 3px;
				-moz-border-radius: 3px;
			}
			.info_popup_bottom {
				margin-top: 5px;
				margin-bottom: 20px;
			}
			.del_waiter,
			.edit_waiter {
				width: 47%;
				height: 45px;
				line-height: 45px;
				font-size: 1.5rem;
				text-align: center;
				border-radius: 3px;
				-webkit-border-radius: 3px;
				-moz-border-radius: 3px;
			}
			.del_waiter {
				margin-right: 4%;
				color: #ffb400;
				border: 1px solid #efefef;
				background-color: #fff;
			}
			.edit_waiter {
				color: #fff;
				border: 1px solid #ffb400;
				background-color: #ffb400;
			}
			.no_waiter {
				width: 90%;
				margin: 0 auto;
				padding: 30px 15px;
				font-size: 1.6rem;
				color: #858386;
				text-align: center;
			}
			/*Guide the instructions*/
			.mark2 { position: fixed; left: 0; right: 0; top: 0; bottom: 0; display: block; width: 100%; height: 100%; z-index: 99;}
			.mark2 img { width: 100%;}
			.img2 { display: none;}
			.area1, .area11 { -webkit-tap-highlight-color: transparent;}
		</style>
		
		<script type="text/javascript" src="<%=basePath %>resources/js/introduceSwitch.js"></script> 
	</head>
	<body>
		<div class="head">
            <a href="<%=basePath%>index/manage" class="head_back">
            	<img src="<%=basePath %>resources/images/back.png" alt="返回" />
            </a>
            <p>服务人员管理</p>
        </div>
        
 <form action="" id="searchForm" name="searchForm" method="post" target="_self">
		<input type="hidden" id="shopId" name="shopId" value="${shopId }">
			       
        <div class="waiter_content">
        	<ul class="waiter_list">
        	
	        	<c:forEach items="${list}" var="waite" >
	        		<li>
		        		<input type="hidden" id="waiterId_${waite.waiterId}" value="${waite.waiterId}">
		        		<input type="hidden" id="name_${waite.waiterId}" value="${waite.name}">
						<input type="hidden" id="headImg_${waite.waiterId}" value="${waite.headImg}">
						<input type="hidden" id="idCard_${waite.waiterId}" value="${waite.idCard}">
						<input type="hidden" id="idCardImg1_${waite.waiterId}" value="${waite.idCardImg1}">
						<input type="hidden" id="idCardImg2_${waite.waiterId}" value="${waite.idCardImg2}">
						<input type="hidden" id="idCardImg3_${waite.waiterId}" value="${waite.idCardImg3}">	
					
	        			<a href="javascript:void(0);">
		        			<div class="top" onclick="details('${waite.waiterId}')">
		        				<img class="waiter_big_img" src="${waite.headImg}" alt="服务人员头像" />
	<!--	        				<a href="<%=basePath%>shop/waiterEdit?waiterId=${waite.waiterId}&shopId=${shopId}">-->
		        				<div class="edit_img" >
		        					<img class="waiter_small_img" src="<%=basePath %>resources/images/waiter/waiter_02.png" alt="编辑信息" />
		        				</div>
	<!--	        				</a>-->
		        			</div>
		        		</a>
	        			<p class="waiter_name">${waite.name}</p>
	        			<p class="waiter_ren">
	        				<c:if test="${waite.auth == 1}">未认证</c:if>
	        				<c:if test="${waite.auth == 2}">已认证</c:if>
	        				<c:if test="${waite.auth == 3}">认证不通过</c:if>
	        			</p>
	        		</li>
	 			</c:forEach>     
	 			<c:if test="${fn:length(list) == 0}">
	 			   	<p class="no_waiter">请添加相关服务人员</p>
	 			</c:if>
        	</ul>
        	<a href="<%=basePath%>shop/waiterEdit?shopId=${shopId}">
	        	<div class="waiter_foot">
	        		添加服务人员
	        	</div>
	        </a>
        </div><!--/waiter_content-->
        
        <div class="waiter_info_popup">
        	<div class="info_popup_top">
        		<img class="info_touxiang" src="" alt="服务人员头像" />
        		<img class="info_close" src="<%=basePath %>resources/images/attestation/close.png" alt="关闭" />
        		<p id="waiterName" >小小白(特级厨师)</p>
        	</div>
        	<div class="info_popup_content">
        		<p>身份证：<em class="idCard" >430923********2021</em></p>
        	</div>
        	<div class="info_popup_contente2">
        		<div class="imgbox"><img src="<%=basePath %>resources/images/attestation/zheng_1.png" alt="身份证正面照" class="info_touxiang1" /></div>
        		<div class="imgbox"><img src="<%=basePath %>resources/images/attestation/zheng_2.png" alt="身份证反面照" class="info_touxiang2" /></div>
        		<div class="imgbox"><img src="<%=basePath %>resources/images/attestation/zheng_3.png" alt="手持身份证照" class="info_touxiang3" /></div>
        	</div>
        	<div class="info_popup_bottom">
        			<input type="button" class="del_waiter" value="删除服务员" onclick="deleteWai('<%=basePath%>shop/waiterDel');" />
        		<input type="button" class="edit_waiter" value="修改并认证" onclick="deleteWai('<%=basePath%>shop/waiterEdit');" />
        		<input type="hidden" id="delEdit" value="">
        	</div>
        </div>
        <div class="mark"></div>
        
        <%-- 关闭调用 troggleThisIntroduceSwitch('<%=basePath%>') --%>
	 	<c:if test="${introduceSwitch }">
	        <div class="mark2">
		        <img src="<%=basePath %>resources/images/guidance/waiter.jpg" alt="查看明细" usemap="#Map1" class="img1" />
	            <map name="Map1">
	              <area shape="poly" coords="5,3,7,53,164,53,164,3" href="javascript:void(0);" class="area1" >
	              <area shape="poly" coords="3,341,3,378,1503,376,1504,338" href="javascript:void(0);" class="area11" >
	            </map>
	    	</div>
	    </c:if>
	</body>
	<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>
<script type="text/javascript">
	$(function(){
//		$(".top").on("click",function(){
//			
//			$("#waiterName").html($("#name").val());
//			$(".info_touxiang").attr('src',$("#headImg").val());
//			$(".idCard").html($("#idCard").val());
//			$(".info_touxiang1").attr('src',$("#idCardImg1").val());
//			$(".info_touxiang2").attr('src',$("#idCardImg2").val());
//			$(".info_touxiang3").attr('src',$("#idCardImg3").val());
//		
//			var parent = $(this).closest("li");
//			$(".waiter_info_popup, .mark").show();
//			$(".del_waiter").on("click",function(){
//				$(".waiter_info_popup, .mark").hide();
//				parent.remove();
//			});
//		});
		$(".mark").on("click",function(){
			$(".waiter_info_popup, .mark").hide();
		});
		$(".info_close").on("click",function(){
			$(".waiter_info_popup, .mark").hide();
		});
	});
	
	function details(id){
		$("#delEdit").val($("#waiterId_"+id).val());
		
		$("#waiterName").html($("#name_"+id).val());
		$(".info_touxiang").attr('src',$("#headImg_"+id).val());
		$(".idCard").html($("#idCard_"+id).val());
		
		$(".info_touxiang1").attr('src',$("#idCardImg1_"+id).val());
		$(".info_touxiang2").attr('src',$("#idCardImg2_"+id).val());
		$(".info_touxiang3").attr('src',$("#idCardImg3_"+id).val());
	
		var parent = $(this).closest("li");
		$(".waiter_info_popup, .mark").show();
		$(".del_waiter").on("click",function(){
			$(".waiter_info_popup, .mark").hide();
			parent.remove();
		});
	}	
	
	function deleteWai(url){
		var waiterId = $('#delEdit').val();
		window.location.href = url+"?waiterId="+waiterId+"&shopId=${shopId}";
	}
	//star 热点
	$(function(){
		var w = window.innerWidth;
		var y = window.innerHeight;
		var x1 = 0;
		var y1 = 0;
		var x2 = 0;
		var y2 = 0.1667 * y ;
		var x3 = w ;
		var y3 = y2;
		var x4 = x3;
		var y4 = 0;
		
		//1、添加服务员
		$('.area1').attr('coords',x1 +','+ y1 +','+ x2 +','+ y2 +','+ x3 +','+ y3 +','+ x4 +','+ y4);
		$('.area11').attr('coords',x2 +','+ y2 +','+ x2 +','+ y +','+ w+','+ y +','+ x3 +','+ y3);
	});
	
	$(function(){
		$('.mark2').show();
		$('.area1,.area11').on('click',function(){
			$('.mark2').hide();
			troggleThisIntroduceSwitch('<%=basePath%>',4);
		});
	});//end 热点
</script>
