<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
	String source = request.getParameter("source");
	request.setAttribute("source",source);
	String tag = request.getParameter("tag");
	request.setAttribute("tag",tag);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath %>resources/js/common.js"></script>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>店铺详情</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/swiper3.07.min.css">
<style type="text/css">	
	h6,h2,h3,h4,h6,h6{ font-weight:normal; font-size:1.4rem;}
	*{ box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box;}
	i { font-style: normal; font-weight: normal;}
	/*.merchant_info_content{top:0;bottom:0;}*/
	.det_info_banner{height:auto;position:relative;overflow:hidden;}
	.det_info_banner li{overflow:hidden;}
	.det_info_banner li img{width:100%;min-height:100px;}
	.det_mer_info{ border-bottom:1px solid #dedede; background-color: #fff;}
	.det_mer_info .info_left{float:left;padding: 14px 0 10px 6px;}
	.info_right{float:right;}
	.det_mer_info .info_left .left_name{margin-left:9px;font-size:1.4rem;color:#322c2c;}
	.det_mer_info .info_left .left_name span{font-size:1.2rem;color:#fff;background:#ffb200;border-radius:3px;margin-left:4px;padding:2px 3px;vertical-align:middle;position:relative;top:-4px;}
	.det_mer_info .left_name img{margin:10px 2px 0 0;width:15px;}
	.det_mer_info span{display:inline-block;vertical-align: top;-webkit-tap-highlight-color: transparent;}
	.det_mer_info .left_img{height:50px;width:50px;border-radius:50%;overflow:hidden;}
	.det_mer_info .left_img img{width:100%;height:100%;}
	.det_mer_info .info_rihgt{float:right; padding: 14px 6px 10px 0; margin-top:15px;}
	.det_mer_info .info_rihgt span{width:25px;height:24px;margin-right:15px;}
	@media only screen and (min-width: 300px) and (max-width: 349px) {
		.det_mer_info .info_rihgt span{width:25px;height:24px;margin-right:3px;}
	}
	.det_mer_info .info_rihgt .right_share{background:url(images/details/share.png) no-repeat center center;background-size:29px auto;}
	.det_mer_info .right_collect{background:url(images/details/collect.png) no-repeat center center;background-size:22px auto;}
	.det_mer_info .right_call{display:inline-block;position:relative;top:-2px;height:30px;width:30px;border-radius:50%;}
	.det_mer_info .right_call img{width:100%;}
	.det_personal{margin:10px 0 10px;border-bottom:1px solid #dedede;padding-bottom:10px;background-color: #fff;overflow:hidden;}
	.det_personal li{overflow:hidden;text-align:center;}
	.det_personal li a{display:block;width:25%;color:#858386;font-size:1.1rem;float:left;}
	.det_personal li a img{width:50px;height:50px;border-radius:50%;margin:8px 0;}
	.det_personal #swiper-pagination2{text-align:center;margin-top:10px;}
	.det_personal #swiper-pagination2 .swiper-pagination-bullet{background:#ffb400;margin:0 2px;}
	.det_personal #swiper-pagination2 .swiper-pagination-bullet-active{background:#ffb900;}
	.det_business_info .brief {color: #848484;font-size: 1.4rem;padding: 5px 15px 0;width:100%;overflow:hidden;}
	.det_business_info .ellipsis{text-overflow:ellipsis;display:-webkit-box;display:box;-webkit-line-clamp:3;-webkit-box-orient:vertical;}
	.det_business_info{border-bottom:1px solid #dedede;}
	.det_authentication{margin:10px 0 0; background-color: #fff;}
	.z_name { font-size: 1.6rem; color: #322c2c; letter-spacing: 1px;}
	.z_weekbox { padding-top: 6px; text-align: center;}
	.z_week { display: inline-block; padding: 0 5px; height: 24px; line-height: 24px; font-size: 1.2rem; color: #fff; text-align: center; border: none; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; background-color: #ffb400;}
	.z_week_active { background-color: #ccc !important;}
	.z_weekbox .z_week:nth-child(1), .z_weekbox .z_week:nth-child(2), .z_weekbox .z_week:nth-child(3), .z_weekbox .z_week:nth-child(4), .z_weekbox .z_week:nth-child(5), .z_weekbox .z_week:nth-child(6) { margin-right: 3px;}
	.d_h5 { padding: 0 15px; font-size: 1.3rem;}
	.z_ren { width: 18px; vertical-align: middle; margin: -3px 10px 0 0;}
	.z_error_correction { position:relative; margin-top: 10px; margin-bottom: 30px; border-bottom: 1px solid #dedede; background-color: #fff;}
	.right-arrows { position: absolute; right: 10px; top: 9px; width: 10px; height: auto; text-align: center;}
	.right-arrows img { width: 6px; height: 15px;}
	.z_error_infobox, .z_information, .share_container, .z_ren_box { position: fixed; top: 50%; left: 50%; display: none; width: 90%; height: auto; border: 1px solid #efefef; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; transform: translate(-50%,-50%) !important; -webkit-transform: translate(-50%,-50%) !important; -moz-transform: translate(-50%,-50%) !important; background-color: #fff; z-index: 100;}
	.z_error_infobox a .z_specific { width: 100%; height: 60px; line-height: 60px; font-size: 1.6rem; color: #322c2c; text-align: center; border-bottom: 1px solid #dedede; background-color: white;}
	.z_error_infobox a:last-child .z_specific { border-bottom: none;}
	.z_information p { width: 100%; height: 30px; line-height: 30px; margin: 15px auto; font-size: 1.6rem; color: #322c2c; text-align: center;}
	.z_information .z_close_bton { display: block; width: 120px; height: 35px; line-height: 35px; margin: 0 auto 20px; font-size: 1.6rem; color: #fff; border: none; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; background-color: #ffb400;}
	.z_just_abox { background-color: #fff;}
	.det_business_info .z_just_abox:nth-child(1) .d_h5 { height: 80px;}
	.z_just_pri { position: relative;}
	.z_just_picdown { width: 15px; height: 7px;}
	.shop_name { display: inline-block; height: 20px; font-size: 1.6rem; color: #322c2c; overflow: hidden;}
	.z_intro { color: #322c2c;}
	.swiper-wrapper, .swiper-slide { height: inherit;}
	.share_title { position:relative; width: 90%; height: 45px; line-height: 45px; margin: 5px auto 15px; font-size: 1.7rem; color: #322c2c; text-align: center; border-bottom: 1px solid #dedede;}
	.share_content { margin: 10px 5px; text-align: center;}
	.share_content a { display: inline-block;}
	.right_call2, .right_call3 { display: inline-block;}
	.right_call2 img, .right_call3 img { width: 60px;}
	.right_call2 p, .right_call3 p { font-size: 1.2rem; color: #322c2c;}
	.right_call2 { margin-right: 10px;}
	.right_call3 { margin-left: 10px;}
	.share_close { position: absolute; top: 0; right: 5px;}
	.share_close img { width: 15px;}
	.det_authentication .d_h5 { border-bottom: 1px solid #dedede;}
	.load_more{display:block;height:20px;line-height:20px;text-align:center;padding-top:6px;}
	.load_more_rotate{transform:rotate(180deg);-webkit-transform:rotate(180deg);}
	.load_more_hide{opacity:0;visibility:hidden;}
	.head{z-index: 10001;}
	.d_more { text-align:center;line-height:20px;width:100%;}
	.right_call_c{display:inline-block;position:absolute;top:0;right:0;height:50px;width:40px;margin:0 1px;text-align:center;border-radius:50%;}
	.right_call_c img { width: 28px; padding-top: 13px;} 
	.z_shopadress { height: auto !important; line-height: 20px !important; padding: 5px 10px !important;}
	.z_ren1 { width: 18px !important; margin: -11px 0 0 3px !important; vertical-align: middle;}
	.z_ren_title, .z_ren_content { width: 100%;}
	.z_ren_title p{ width: 85%; margin: 19px auto 26px; font-size: 1.5rem; color: #322c2c; text-align: center;}
	.z_ren_content { height: 40px; line-height: 40px; margin: 15px 0; text-align: center;}
	.z_ren_cancel, .z_ren_tel { width: 40%; padding: 12px 20px; font-size: 1.6rem; border: none; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px;}
	.z_ren_cancel { margin-right: 10px; color: #858386;}
	.z_ren_tel { margin-left: 10px; color: #fff; background-color: #ffb400;}
	.mark { position: fixed; left: 0; right: 0; top: 0; bottom: 0; display: none; width: 100%; height: 100%; background: rgba(0,0,0,.45);}
	/*waiter picture magnify*/
	.mark2 { position: fixed; left: 0; right: 0; top: 0; bottom: 0; display: none; width: 100%; height: 100%; background: rgba(0,0,0,.85); z-index: 99;}
	/* .magnify { position: absolute; top: 55%; left: 50%; width: 85%;  height: auto; border-top: 1px solid #efefef; border-bottom: 1px solid #efefef;  transform: translate(-50%,-50%) !important; -webkit-transform: translate(-50%,-50%) !important; -moz-transform: translate(-50%,-50%) !important; background-color: #fff;}
	.magnify img { width: 100%;} */
	.swipe { position: fixed; display: none; width: 90%; margin: 50px auto; margin-left: 5%; z-index: 100;}
	#slider4 { line-height: 0; text-align: center; background: #f4f4f4; -webkit-tap-highlight-color: transparent;}
	#slider4 li { padding: 10px; height: 300px;}
	#slider4 li p { margin-top: 12px; padding-top: 5px height: 28px; line-height: 28px; font-size: 1.6rem; color: #322c2c; text-align: center; border-top: 1px solid #dedede;}
	#slider4 img { width: 250px !important; height: 250px;  border-radius: 50%; -webkit-border-radius: 50%; -moz-border-radius: 50%; }
	
	.z_pwd_box { position: fixed; top: 50%; left: 50%; width: 90%; height: auto; border: 1px solid #efefef; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; transform: translate(-50%,-50%) !important; -webkit-transform: translate(-50%,-50%) !important; -moz-transform: translate(-50%,-50%) !important; background-color: #fff; z-index: 100003;}
	.z_ren_title, .z_ren_content { width: 100%;}
	.z_ren_title .z_ren_userbox { width: 90%; margin: 19px auto 11px; font-size: 1.5rem; color: #322c2c;}
	.z_ren_userbox label { display: inline-block; width: 25%;}
	#box { display: inline-block; width: 70%; height: 40px; border: 1px solid #dedede; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; -webkit-appearance: none;}
	.username, .userpassword { height: 40px; font-size: 1.6rem; color: #322c2c; border: 1px solid #dedede; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; -webkit-appearance: none;}
	.username { width: 70% !important; background-color: #ebebe4;}
	.userpassword { width: 75% !important; padding-left: 5px; letter-spacing: 5px; border: none; background: none;}
	.show_word_div { position: absolute; top: 0; right:5%; display: none; width: 45px; height: 40px; padding-top: 14px; text-align: center; -webkit-tap-highlight-color: transparent;}
	/* #hide_word { display: none;} */
	.show_word_div img { width: 20px;}
	.affirmbox { width: 90%; margin: 15px auto 0;}
	.affirm_btn { display: block; width: 110px; margin: 0 auto; padding: 10px 0; font-size: 1.6rem; color: #fff; text-align: center; border: none; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; background: #ffb400;}
	.z_ren_content { width: 100%; height: 40px; line-height: 40px; margin: 15px 0; text-align: center;}
	.z_ren_content a p { font-size: 1.2rem; color: #858386;}
	.z_ren_content a:visited p { color: 858386;}
	.z_ren_content a p em img { width: 13px; margin-left: 5px;}
	.position_rel { position: relative;}
	.mark3 { position: fixed; left: 0; right: 0; top: 0; bottom: 0; width: 100%; height: 100%; background: rgba(0,0,0,.45); z-index: 100002;}
	
</style>
<script type="text/javascript">
	function querySearch(url){
		$("#facorAjax").attr("action",url).submit();
	}
</script>
</head>

<form id="facorAjax" action="<%=basePath%>index/goodsDetailShop" method="post" target="_self">
	<input type="hidden" name="id" value="${shop.shopId}" >
	<input type="hidden" name="type" value="${type}" >
	<input type="hidden"   name="keyword" id="keyword" value="${keyword}"></a>
	<input type="hidden" name="orderby" id="orderby" value="${orderby}">
	<input type="hidden" name="class_id" id="class_id" value="${class_id}">
	<input type="hidden" name="city_id" id="city_id" value="${city_id}">
</form>

<body class="details_merchant_info">
		<div class="head d_head details_merchant_head">
            <p class="details_nav">
				<c:if test="${type == 1 }">
	    			<a class="head_back" href="<%=basePath%>index/main/index?type=type"></a>
	    		</c:if>
	    		<c:if test="${type == 2 }">
	    			<a class="head_back" href="javascript:querySearch('<%=basePath%>index/getShopSearchList');"></a>
	    		</c:if>
				<c:if test="${type== 3 }">
					<a class="head_back" href="<%=basePath%>index/manage?id=${session_manager.userId}"></a> 
				</c:if>	
				<c:if test="${type== 4 }">
					<a class="head_back" href="<%=basePath%>call/getCallRecords"></a> 
				</c:if>	
				<c:if test="${type== 5 }">
					<a class="head_back" href="<%=basePath%>favorite/favoriteList"></a> 
				</c:if>	
				<c:if test="${type== 6 }">
					<a class="head_back" href="<%=basePath%>order/orderPersonal"></a> 
				</c:if>	
				<c:if test="${fn:length(services) > 0}">
	            	<a href="javascript:headClickEvent(0);">服务</a>
				</c:if>
            	<a href="javascript:headClickEvent(1);" >评价</a>
            	<a href="javascript:;" class="current_color" >商家</a>
			</p>
			<c:choose>
          		<c:when test="${requestScope.isFavorite eq 'yes' }">
	            	<a href="javascript:favorites('${userDetail.userId}','${shop.shopId}','${shop.name}',${requestScope.favoriteId});" class="right_call_c">
	                    <img src="<%=basePath %>resources/images/details_31.png" alt="取消收藏店铺" />
                </c:when>
                <c:otherwise>
                	<a href="javascript:favorites('${userDetail.userId}','${shop.shopId}','${shop.name}',null);" class="right_call_c">
	                    <img src="<%=basePath %>resources/images/details_3.png" alt="收藏店铺" />
           		</c:otherwise>
           	</c:choose>
   			</a><!--已收藏-->
        </div>
        
        <div class="content d_content merchant_info_content">
        	<c:if test="${fn:length(shopslides) > 0 }">
	        	<div class="det_info_banner swiper-container1">
		    		<ul class="swiper-wrapper">
		    			<c:forEach items="${shopslides }" var="slide">
		        			<c:if test="${slide.path != null }">
				    			<li class="swiper-slide"><a href="javascript:void(0);"><img src="${slide.path}" alt="" /></a></li>
		        			</c:if>
		        		</c:forEach>
		    		</ul>
		    		<div class="swiper-pagination" id="swiper-pagination"></div>
		    	</div>
	    	</c:if>
	    	
	    	<div class="det_mer_info">
	    		<div class="info_left">
	    			<span class="left_img">
	    				<c:if test="${shop.logo != null}">
	                		<img src="${shop.logo}">
	                	</c:if>
	                	<c:if test="${shop.logo == null}">
	                		<img src="<%=basePath %>resources/images/goods_picture.png" >
	                	</c:if>
	    			</span>
	    			<span class="left_name">
	    				<p>
	    					<div id="shop_name" class="shop_name">${fn:substring(shop.name,0,8) }</div>
	    					<c:choose>
								<c:when test="${shop.userId == null || shop.userId <= 0}">
		    						<span class="z_renling">认领</span>
								</c:when>
								<c:otherwise>
									<c:if test="${authStatus ==  2 }">
										<a href="javascript:void(0);">
				    						<img class="z_ren1" src="<%=basePath %>resources/images/merchantlist_6.png" alt="已认证" />
				    					</a>
									</c:if>
		    						<c:if test="${session_manager != null && shop.userId == session_manager.userId && authStatus != 2}">
		    							<c:choose>
			    							<c:when test="${authStatus ==  -1}">
						    					<a href="javascript:void(0);">
						    						<span>认证中</span>
						    					</a>
											</c:when>
											<c:otherwise>
						    					<a href="javascript:checkShopIsAuth();">
						    						<span>认证</span>
						    					</a>
											</c:otherwise>
										</c:choose>
		    						</c:if>
								</c:otherwise>
							</c:choose>
	    				</p>
	    				<p class="description">
	    					<c:choose>
								<c:when test="${shop.evaluates != null && shop.evaluates>0}">
									<c:set var="n" value="0"></c:set>
									<c:forEach begin="1" end="${score}">
										<c:set var="n" value="${n + 1}"></c:set>
										<img src="<%=basePath %>resources/images/star_bright.png">
									</c:forEach>
									<c:if test="${n < 5}">
										<c:forEach begin="1" end="${5-n}">
											<img src="<%=basePath %>resources/images/star_dark.png">
										</c:forEach>
									</c:if>
								</c:when>
								<c:otherwise>
									<img src="<%=basePath %>resources/images/star_bright.png">
									<img src="<%=basePath %>resources/images/star_bright.png">
									<img src="<%=basePath %>resources/images/star_bright.png">
									<img src="<%=basePath %>resources/images/star_dark.png">
									<img src="<%=basePath %>resources/images/star_dark.png">
								</c:otherwise>
							</c:choose>
	                     </p>
	    			</span>
	    		</div>
	    		<div class="info_rihgt">
	    			<a href="javascript:void(0);" class="right_call share_bton">
	    				<img src="<%=basePath %>resources/images/details_2.png" alt="分享店铺" />
	    			</a>
	    			
	    			<!--<a class="right_call"><img src="<%=basePath %>resources/images/details_31.png" alt="联系我们" /></a>--><!--未收藏-->
	    			<a href="javascript:phoneCalls2(${shop.shopId},'<%=basePath%>call/addCall');"  id="phoneTel_${shop.shopId}" class="right_call"><img src="<%=basePath %>resources/images/details_1.png" alt="联系我们" /></a>
	    		</div>
	    	</div>
	    	
	    	<c:if test="${fn:length(waiterList) > 0 }">
		    	<div class="det_personal swiper-container2">
		    		<h5 class="d_h5">服务人员<span>服务范围：${shop.rangeStr }</span></h5>
		    		<ul class="swiper-wrapper">
		    			
		    			<c:forEach items="${waiterList }" var="w" varStatus="s">
		    				<c:set var="close" value="false"></c:set>
		    				<c:if test="${s.index % 4 == 0 }">
				    			<li class="swiper-slide">
			    				<c:set var="close" value="true"></c:set>
		    				</c:if>
			    				<a href="javascript:void(0);">
			    					<img src="http://img.hzd.com${w.headImg}@160h_160w_1e_1c" alt="服务员照片" waiterName="${w.name}"/>
			    					<p class="z_name">${w.name}</p>
			    				</a>
			    			<c:if test="${(s.index + 1) == fn:length(waiterList) || (s.index + 1) % 4 == 0}">
				    			</li>
		    				</c:if>
		    			</c:forEach>
		    		</ul>
		    		<div class="swiper-pagination2" id="swiper-pagination2"></div>
		    	</div>
	    	</c:if>
	    	
	    	<div class="det_business_info">
		    	<div class="z_just_abox">
		    		<h5 class="d_h5">
		    			营业时间：${shop.sndtime == null ? "09:00" : shop.sndtime}-${shop.endtime == null ? '22:00' : shop.endtime}
		    			<!--<span>周一至周五</span>-->
		    			<div class="z_weekbox">
		    				<c:if test="${shop.w1 ==1 }">
	            				<div class="z_week">周一</div>
		            		</c:if>
		            		<c:if test="${shop.w1 ==0 }">
	            				<div class="z_week z_week_active">周一</div>
		            		</c:if>
		            		
		            		<c:if test="${shop.w2 ==1 }">
		            			<div class="z_week">周二</div>
		            		</c:if>
		            		<c:if test="${shop.w2 ==0 }">
		            			<div class="z_week z_week_active">周二</div>
		            		</c:if>
		            		
		                	<c:if test="${shop.w3 ==1 }">
		            			<div class="z_week">周三</div>
		            		</c:if>
		            		<c:if test="${shop.w3 ==0 }">
		            			<div class="z_week z_week_active">周三</div>
		            		</c:if>
		            		
		            		<c:if test="${shop.w4 ==1 }">
		            			<div class="z_week">周四</div>
		            		</c:if>
		            		<c:if test="${shop.w4 ==0 }">
		            			<div class="z_week z_week_active">周四</div>
		            		</c:if>
		            		
		            		<c:if test="${shop.w5 ==1 }">
		            			<div class="z_week">周五</div>
		            		</c:if>
		            		<c:if test="${shop.w5 ==0 }">
		            			<div class="z_week z_week_active">周五</div>
		            		</c:if>
		            		
		            		<c:if test="${shop.w6 ==1 }">
		            			<div class="z_week">周六</div>
		            		</c:if>
		            		<c:if test="${shop.w6 ==0 }">
		            			<div class="z_week z_week_active">周六</div>
		            		</c:if>
		            		
		            		<c:if test="${shop.w7 ==1 }">
		            			<div class="z_week">周日</div>
		            		</c:if>
		            		<c:if test="${shop.w7 ==0 }">
		            			<div class="z_week z_week_active">周日</div>
		            		</c:if>
		    			</div>
		    		</h5>
		    	</div>
	    		<div class="z_just_abox">
		    		<h5 class="d_h5 z_shopadress">商家地址：${shop.address }</h5>
	    		</div>
	    		<div class="z_just_abox">
	    			<h5 class="d_h5">
	    				<i class="z_intro">简介</i>
	    			</h5>
	    		</div>
	    		<div class="z_just_abox z_just_pri">
	    			<div class="brief ellipsis" id="shop_description">
	    				<c:if test="${not empty shop.summary}">
	    					${shop.summary}
	    				</c:if>
						<c:if test="${empty shop.summary}">
							具体的服务要求请电话咨询商家，致电商家时请告知是在"好站点"上发现的此商家。
						</c:if>
	    			</div>
	    			<a href="javascript:;" class="load_more d_more"><img class="z_just_picdown" src="<%=basePath %>resources/images/personalcenter_131.png" /></a>
	    		</div>
	    	</div>
	    	
  			<c:choose>
				<c:when test="${authStatus ==  2}">
			    	<div class="det_authentication">
			    		<!--已认证-->
			    		<h5 class="d_h5">
							<img class="z_ren" src="<%=basePath %>resources/images/merchantlist_6.png" alt="已认证" />
			  					店铺已认证
			    		</h5>
			    	</div>
				</c:when>
				<c:otherwise>
	  				<!--<img class="z_ren" src="<%=basePath %>resources/images/merchantlist_62.png" alt="未认证" />
	  					店铺未认证
					-->
				</c:otherwise>
			</c:choose>
			<a href="javascript:void(0);">
				<div class="z_error_correction">
					<h5 class="d_h5 z_error_bton"><img class="z_ren" src="<%=basePath %>resources/images/merchantlist_5.png" alt="给商家纠错" />给商家纠错</h5>
					<div class="right-arrows"><img src="<%=basePath %>resources/images/personalcenter_13.png" alt="箭头"></div>
				</div>
			</a>
        </div>
        <div class="mark2"></div> 
		<div class="swipe">
			<ul id="slider4">
				<!-- <img src="#" alt="服务员照片"  id="waiterImg"/> 
				<li><img src="<%=basePath %>resources/images/banner_1.jpg" alt="头像照片"></li>
				<li><img src="<%=basePath %>resources/images/banner_3.jpg" alt="头像照片"></li>
				<li><img src="<%=basePath %>resources/images/banner_3.jpg" alt="头像照片"></li>-->
			</ul>
		</div>
        <div class="z_error_infobox">
        	<a href="javascript:shopError('${shop.shopId}','1');">
        		<div class="z_specific">电话无人接听</div>
        	</a>
        	<a href="javascript:shopError('${shop.shopId}','2');">
        		<div class="z_specific">电话号码错误</div>
        	</a>
        	<a href="javascript:shopError('${shop.shopId}','3');">
        		<div class="z_specific">商家信息错误</div>
        	</a>
        </div>
        <div class="z_information">
        	<p>信息已反馈给商家。</p>
        	<input type="button" class="z_close_bton" value="确定" />
        </div>
        <div class="share_container">
        	<p class="share_title">分享到<span class="share_close"><img src="<%=basePath %>resources/images/close.png" alt="关闭" /></span></p>
        	<div class="share_content">
        		<a href="javascript:void(0);" class="jiathis_button_qzone"><em class="right_call2"><img src="<%=basePath %>resources/images/share_01.png" alt="分享店铺" /><p>QQ空间分享</p></em></a>
        		<a href="javascript:void(0);" class="jiathis_button_tsina"><em class="right_call3"><img src="<%=basePath %>resources/images/share_02.png" alt="分享店铺" /><p>新浪微博分享</p></em></a>
        	</div>
        </div>
        
        <div class="z_ren_box">
        	<div class="z_ren_title">
        		<p id="tipContent">请选择认领方式</p>
        	</div>
        	<div class="z_ren_content">
   				<input type="button" class="z_ren_tel" id="btn_ren_cancel" value="自主认领" onclick="javascript:ren();"/>
        		<a id="a_ren_confirm" href="tel:075528469450">
        			<input type="button" class="z_ren_tel" id="btn_ren_confirm" value="联系客服" />
        		</a>
        	</div>
        </div>
        <div class="mark"></div>
        
        <%-- 点击手机短信链接进入的认领操作 --%>
        <c:if test="${rl_username != null}">
	        <form action="<%=basePath%>index/savePassword" method="post" id="projectForm" name="projectForm">
		        <div class="z_pwd_box">
		        	<div class="z_ren_title">
		        		<!-- <p id="tipContent">请选择认领方式</p> -->
		        		<div class="z_ren_userbox">
		        			<label>用&nbsp;户&nbsp;名:</label>
		        			<input type="hidden" name="username" value="${rl_username }"/>
		        			<input type="hidden" name="shopId" value="${shop.shopId}"/>
		        			<input type="hidden" name="source" value="1001"/>
		        			<input type="text" class="username" disabled="disabled" value="${rl_username }"/>
		        		</div>
		        		<div class="z_ren_userbox position_rel">
		        			<label>设置密码:</label>
		        			<div id="box">
		                		<input type="password" class="userpassword" name="password" id="userpassword" maxlength="32" placeholder="密码" onkeyup="showTransform()" >
		                	</div>
		        			<div class="show_word_div" id="show_word_div" name="show_word_div">
		        				<img src="<%=basePath %>resources/images/details/decode.png" alt="显示密码" onclick="showPassword()" id="pwd_img"/>
		        			</div>
		        		</div>
		        		<div class="affirmbox">
		        			<input type="button" class="affirm_btn" value="确定" onclick="javascript:savePassword();" />
		        		</div>
		        	</div>
		        	<div class="z_ren_content">
		   				<!-- <input type="button" class="z_ren_tel" id="btn_ren_cancel" value="自主认领" onclick="javascript:ren();"/>
		        		<a id="a_ren_confirm" href="tel:075528469450"><input type="button" class="z_ren_tel" id="btn_ren_confirm" value="联系客服" /></a> -->
		        		<a href="tel:0755-28469450"><p>如有疑问，请联系客服咨询：0755-28469450<em><img src="<%=basePath %>resources/images/call.png" alt="客服电话" /></em></p></a>
		        	</div>
		        </div>
		    </form>    
	        <div class="mark3"></div>
	    </c:if>
        <script>
			//var jiathis_config = {
				/*url: "http://m.hzd.com/index/goodsDetail?id=${shop.shopId}&type=1", */ //当前网页链接，可自定义
				/*title:"我在好站点看到一个"+categoryName+"的商铺，非常棒，你也来看看"*/   //categoryName可以为当前店铺名称或者分类名称，但必须是在以这个格式格式引用: <div id="categoryName"></div>
				/*summary: 摘要，没有设置定制的内容是会直接调取头部<meta name="description">内的content的内容，设置同title一样，上面title没有设置指定的值也是同summary一样调取头部meta里面的默认title值*/
				//title: document.getElementById("shop_name").innerText || document.getElementById("shop_name").textContent,
				//summary: document.getElementById("shop_description").innerText || document.getElementById("shop_description").textContent,
			//}
		</script>

<script type="text/javascript" src="http://v2.jiathis.com/code/jia.js" charset="utf-8"></script> 
<script>
	var categoryId = '${shop.categoryId}';
	var categoryName = '';
	if(categoryId == 1){categoryName='外卖';}
	else if(categoryId == 2){categoryName='送水';}
	else if(categoryId == 3){categoryName='家政';}
	else if(categoryId == 4){categoryName='维修';}
	else if(categoryId == 5){categoryName='便利店';}
	else if(categoryId == 6){categoryName='代驾';}
	else if(categoryId == 7){categoryName='洗衣';}
	else if(categoryId == 8){categoryName='下厨';}
	else if(categoryId == 9){categoryName='装修';}
	else if(categoryId == 10){categoryName='保健按摩';}
	else if(categoryId == 11){categoryName='美容美甲';}
	else if(categoryId == 12){categoryName='汽车服务';}
	else if(categoryId == 13){categoryName= "跑腿/配送";}
	else if(categoryId == 0){categoryName='其他';}
	var jiathis_config = {
		url: "<%=basePath%>index/goodsDetailShop?id=${shop.shopId}&type=1", 
		title:"我在好站点看到一个"+categoryName+"的商铺，非常棒，你也来看看",
		summary:"好站点" 
	};
</script>
<script>

//tab点击跳转
function headClickEvent(index){
	if(index==0){
		//self.location="<%=basePath%>index/goodsDetailService?id=${shop.shopId}";
		querySearch('<%=basePath%>index/goodsDetailService?id=${shop.shopId}&goods=1');
	}
	else if(index==1){
		//self.location="<%=basePath%>index/goodsDetailComment?id=${shop.shopId}";
		querySearch('<%=basePath%>index/goodsDetailComment?id=${shop.shopId}&goods=1');
	}
	else if(index==2){
		//self.location="<%=basePath%>index/goodsDetailShop?id=${shop.shopId}";
		querySearch('<%=basePath%>index/goodsDetailShop?id=${shop.shopId}&goods=1');
	}
}

function savePassword(){
	if($.trim($("#userpassword").val()) == '' || $("#userpassword").val().length < 6){
		alert('请设置密码，长度至少为6位');
		return ;
	}
	$("#projectForm").submit();
}


//纠错
function shopError(shopId,type){
	var userId = '${userDetail.userId}';
	var shopUserId = '${shop.userId}';
	if( shopUserId == userId ){
		alert('不能纠错自己的店铺');
		return ;
	}
	$.ajax({  
	   		type: "GET",  
	        url: '<%=basePath%>shop/correct',  
	        data: 'shop_id='+shopId+'&type='+type+'&random='+Math.random(),
	        success: function(data){
	        	if( "true" == data ){
	        		error_sueeccd();
	        	}else{
	        		alert('已有纠错记录，请等待修复！');
	        		cloas_info();
	        	}
			}  
		});  
}
function error_sueeccd(){
	$(".z_information").show();
	$(".z_error_infobox").hide();
	$(".z_close_bton").on("click",function(){
		$(".z_information, .mark").hide();
	});
}
function cloas_info(){
	$(".z_error_infobox, .mark").hide();
}

function checkShopIsAuth(){
	$.ajax({  
   		type: "POST",  
        url: '<%=basePath%>auth/checkAuth',  
        data: 'shopId='+'${shop.shopId}'+'&random='+Math.random(),
        success: function(data){
        	if(data == '-204'){
				alert('您已有店铺，不能认证');
			}else if(data == '-205'){
				alert('店铺已认证');
			}else if(data == '-203'){
				alert('您已认证过，不能多次认证');
			}else if(data == '-48'){
				alert('请重新刷新页面');
			}else if(data == '1'){
				window.location.href='<%=basePath%>auth/gotoAuthEntrance?shopId=${shop.shopId}&source=${requestScope.source }&tag=${requestScope.tag}&redirectUri=/auth/gotoAuthEntrance';
			}
		}  
	});  
}

//
function favorites(user_id,shop_id,name,favoriteId){
	var shopUserId = '${shop.userId}';
	if(user_id == ''){
		alert('收藏失败，请授权登录后操作');
		return ;
	}
	var url = '';
	if(favoriteId && favoriteId != null && favoriteId != '' && favoriteId > 0){
		url = 'collect_id=' + favoriteId + '&user_id='+user_id+'&shop_id='+shop_id;
	}else{
		if(user_id == shopUserId ){
			alert('自己不能收藏自己的店铺');
			return ;
		}
		url = 'fav_name=' + name + '&user_id='+user_id+'&shop_id='+shop_id;
	}
	$.ajax({  
	   		type: "POST",  
	        url: '<%=basePath%>favorite/collect',  
	        data: url,
	        success: function(data){
	        	if( "true" == data ){
//	        		location.reload();
					$("#facorAjax").submit();
	        		if(favoriteId && favoriteId != null){
	        			alert("取消收藏成功");
	        		}else{
	        			alert("收藏成功");
	        		}
	        	}else if ("2" == data){
//	        		alert('已收藏');
	        	}else{
	        	}
			}  
		});  
}


function phoneCalls2(shopId,url){
	$.ajax({
		   type: "POST",
		   url: url,
		   data:{"shop_id":shopId},
		   success: function(data)
		   {
			   $("#phoneTel_"+shopId).attr('href','tel:'+ data);
			   $("#phoneTel_"+shopId)[0].click(); 
	       },
	       error: function() {
	       		alert('error');
	       }
	});
}


//评论
$(document).ready(function(){
 	var success = '${falgComm}';
	if( 1 == success ){
		alert("评论成功");
		<% request.getSession().setAttribute("falgComm", 0); %>
	}else if( 2 == success ){
		alert("自己不能评论自己的店铺");
		<% request.getSession().setAttribute("falgComm", 0); %>
	}else if( 3 == success ){
		alert("一人一天只能评价同一家店铺一次");
		<% request.getSession().setAttribute("falgComm", 0); %>
	}
	else if( 4 == success ){
		alert("评论失败");
		<% request.getSession().setAttribute("falgComm", 0); %>
	}
});


</script>
</body>
</html>
<script language="javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
<script language="javascript" src="<%=basePath %>resources/js/touchslider.js"></script>
<script>

/**幻灯片*/
 var swiper = new Swiper('.swiper-container1', {
     pagination: '.swiper-pagination',
     paginationClickable: true,
     spaceBetween: 0,
     autoplay: 3000,
     loop: true
 });
 var swiper2 = new Swiper('.swiper-container2', {
     pagination: '.swiper-pagination2',
     paginationClickable: true,
     spaceBetween: 0,
     autoplay: false,
     loop: false
 });
 
 if(parseInt($('.brief').get(0).offsetHeight) >= 40){
 	$('.load_more').on('click', function(){
    	$('.load_more').toggleClass('load_more_rotate');
    	$('.brief').toggleClass('ellipsis');
    })
 }else{
 	$('.load_more').addClass('load_more_hide');
 }

 $(function(){
 	$(".z_error_bton").on("click",function(){
   		$(".z_error_infobox, .mark").show();
   	});
   	$(".mark").on("click",function(){
   		$(".z_error_infobox, .share_container, .z_ren_box, .mark").hide();
   	});
   	
   	/*分享box*/
   	$(".share_bton").on("click",function(){
   		$(".share_container, .mark").show();
   	});
   	$(".share_close").on("click",function(){
   		$(".share_container, .mark").hide();
   	});/*end分享*/
   	
    
 });
 //认领
 $(function(){
	$(".z_renling").on("click",function(){
		/*if('${session_manager}' == '' || '${session_manager.userId}' == ''){
			alert("请先登录后再进行认领");
			return ;
		}*/
		/*if('${userDetail.userId}' == ''){
			alert("请先登录后再认领");
			window.location.href="login/login_ing";
		}else{
			$("#tipContent").html("点击确认提交认领申请，审核成功后将以短信方式通知您");
    		$("#a_ren_confirm").attr("href","javascript:ren(${shop.shopId});").show();
    		$("#btn_ren_cancel").attr("value","取消");
		}*/
		$(".z_ren_box, .mark").show();
	});
	$(".z_ren_cancel").on("click",function(){
		$(".z_ren_box, .mark").hide();
	});
});
//浏览器的左右滑动占用
 var control = navigator.control || {};	
 if (control.gesture) {
 	 control.gesture(false);
 }
 var y = window.innerHeight ;
//服务员头像
$(function(){
	$('.swiper-container2 ul').each(function () {
		var $self = $(this),
			$img = $self.find('.swiper-slide a img'),
			$imgWrap = $self.find('.swiper-slide');
			
	
		$img.on('click', function () {
			
			var _html = '';
			
			for(var i = 0 ;i < $img.length;i++){
				//@400h_720w_4e_1c_90Q,.replace(/(\?|@)[^'"]*/, '@500h_780w_1l')
				_html +='<li><img <%-- sign="showImg" src="<%=basePath %>resources/images/loading.gif" alt="服务员头像"  l--%>src="' + $img.eq(i).attr('src').replace(/(\?|@)[^'"]*/, '') + '">'+'<p>'+$img.eq(i).attr('waiterName')+'</p></li>';
			}
			//服务员头像存放制定容器，然后再添加到slider4里面
			$('#slider4').html( _html );
			//显示头像模块
	 		$('.mark2, .swipe').show();
	 		//存放头像容器距离顶部距离
	 		//$("#slider4 img").css({"margin-top": (y/2-200)+"px","width": ""});
	 		//获取当前点击图片位置
	 		var i = $(this).parent().index();
	 		//头像轮循
	 		var t4 = new TouchSlider('slider4',{
	 			auto: false,
	 			begin: i,  //第i个幻灯开始
	 			speed:200, //持续时间，ms
	 			direction:0, //方向
	 			interval:6000, 
	 			fullsize:true
	 		});
	 		$('.swipe img').on('click',function(){
	 			$('.mark2, .swipe').hide();
	 		});
	 		/* $('#slider4 img').load(function(){
				if($(this).attr("src").indexOf("loading.gif") > -1){
					$(this).css({"margin-top": (y/2-200)+"px","width": ""});
					$(this).attr("src",$(this).attr("lsrc"));
				}else{
					$(this).css({"width": "200px !important;","margin-top": ""});
				}
			}); */
	 	});
		$('.mark2, #slider4').on('click',function(){
			/*$("#waiterImg").attr("src","#");*/
			$('.mark2, .swipe').hide();
		});
	});
});
//密码显示与隐藏
function showTransform() {
	//var inObj = document.getElementById('userpassword');
	var inObj = $('#userpassword').val();
    if (inObj != '') {
        $("#show_word_div").show();
    } else {
         $("#show_word_div").hide();
    }
}
function hidePassword() {
	if (this.projectForm.password.type="text"){
		$('#box').html('<input type="password" class="userpassword" id="userpassword" name="password" maxlength="32" placeholder="密码" onkeyup="showTransform()" size="20" value="'+this.projectForm.password.value+'">');
		$("#pwd_img").attr("src","/resources/images/details/decode.png");
		$("#pwd_img").attr("onClick","showPassword()");
	}
}
function showPassword() {
	if (this.projectForm.password.type="password"){
		 $('#box').html('<input type="html" class="userpassword" id="userpassword" name="password" maxlength="32" placeholder="密码" onkeyup="showTransform()" size="20" value="'+this.projectForm.password.value+'">');
		 $("#pwd_img").attr("src","/resources/images/details/encrypt.png");
		 $("#pwd_img").attr("onClick","hidePassword()");
	}
}
//认领申请
function ren(){
	/*$.ajax({  
	   		type: "GET",  
	        url: 'shop/applyVerify',  
	        data: 'shop_id='+shopId+'&random='+Math.random(),
	        success: function(data){
	        	if("success" == data){
	        		$("#tipContent").html("您的认领申请已提交，稍后我们将短信通知您");
	        		$("#a_ren_confirm").attr("href","javascript:void(0)").hide();
	        		$("#btn_ren_cancel").attr("value","关闭");
	        		$(".z_ren_box, .mark").show();
	        	}else{
	        		alert('认领申请失败');
	        	}
			}  
		});  */
	if('${userDetail.userId}' == ''){
		alert("请先登录后再认领");
		window.location.href="<%=basePath%>login/login_ing";
	}else{
		checkShopIsAuth();
	}	
}
//shop-hours
/*$(function(){
	$(".bottom-box ul a").click(function(){
		$(this).addClass("hit").siblings().removeClass("hit");
		$(".top-box>div:eq("+$(this).index()+")").show().siblings().hide();
	});
});*/
</script>
<jsp:include page="../head/down_app.jsp"></jsp:include>