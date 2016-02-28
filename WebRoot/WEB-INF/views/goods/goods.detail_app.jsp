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
<title>热门应用详情</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/swiper3.07.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/module.css">
<style type="text/css">	
	/*content*/
    h1,h2,h3,h4,h5,h6{
		font-weight:normal;
		font-size:1.4rem;
	}
	html,body{
		width:100%;
		height:100%;
	}
	*{
		box-sizing: border-box;
		-webkit-box-sizing: border-box;
		-moz-box-sizing: border-box;
	}
	.details_content>div{background:#fff;}
	.d_content_1{ padding:0 0 55px;top:15px}
	.share_container { position: absolute; top: 50%; left: 50%; display: none; width: 90%; height: auto; border: 1px solid #efefef; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; transform: translate(-50%,-50%) !important; -webkit-transform: translate(-50%,-50%) !important; -moz-transform: translate(-50%,-50%) !important; background-color: #fff; z-index: 100;}
	.share_title { position:relative; width: 90%; height: 45px; line-height: 45px; margin: 5px auto 15px; font-size: 1.7rem; color: #322c2c; text-align: center; border-bottom: 1px solid #dedede;}
	.share_content { margin: 10px 5px; text-align: center;}
	.share_content a { display: inline-block;}
	.right_call2, .right_call3 { display: inline-block;}
	.right_call2 img, .right_call3 img { width: 60px;}
	.right_call2 p, .right_call3 p { font-size: 1.2rem; color: #322c2c;}
	.right_call2 { margin-right: 10px;}
	.right_call3 { margin-left: 10px;}
	.share_close { position: absolute; top: -10px; right: 5px;}
	.share_close{top:0;}
	.share_close img { width: 15px;}
	
	.app_info_rihgt .right_collected{
		background:url(/resources/images/details/collect_2.png) no-repeat center center;
		background-size:21px auto;
		margin-left:18px;
	}
</style>
<script type="text/javascript">
	function querySearch(url){
		$("#facorAjax").attr("action",url).submit();
	}
</script>
</head>

<form id="facorAjax" action="<%=basePath%>index/goodsDetailApp" method="post">
	<input type="hidden" name="id" value="${shop.shopId}" >
	<input type="hidden" name="type" value="${type}" >
	<input type="hidden"   name="keyword" id="keyword" value="${keyword}"></a>
	<input type="hidden" name="orderby" id="orderby" value="${orderby}">
	<input type="hidden" name="class_id" id="class_id" value="${class_id}">
	<input type="hidden" name="city_id" id="city_id" value="${city_id}">
</form>

<body class="details">
		<div class="head d_head d_header">
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
            <p>
            	${fn:substring(shop.name,0,8) }
			</p>
        </div>
        <div class="content d_content details_content" id="w_div">
        	<c:if test="${fn:length(shopslides) > 0 }">
	        	<div class="det_app_banner swiper-container">
		    		<ul class="swiper-wrapper">
		    			<c:forEach items="${shopslides }" var="slide">
		    				<c:if test="${slide.path != null }">
				    			<li class="swiper-slide"><a href="javascript:;"><img src="${slide.path}" /></a></li>
		    				</c:if>
		    			</c:forEach>
		    		</ul>
		    		<div class="swiper-pagination" id="swiper-pagination">
		    			<span class="swiper-pagination-bullet"></span>
		    			<span class="swiper-pagination-bullet"></span>
		    			<span class="swiper-pagination-bullet"></span>
		    		</div>
		    	</div>
	    	</c:if>
	    	
	    	<div class="det_app_info">
	    		<div class="app_info_left">
	    			<span class="left_img">
	    				<c:if test="${shop.logo != null}">
	                		<img src="${shop.logo}">
	                	</c:if>
	                	<c:if test="${shop.logo == null}">
	                		<img src="<%=basePath %>resources/images/goods_picture.png" >
	                	</c:if>
	    			</span>
	    			<span class="left_name">
	    				<p>${fn:substring(shop.name,0,8) }</p>
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
	    		<div class="app_info_rihgt">
	    			<span class="right_share share_bton"></span>
	    			<c:choose>
		          		<c:when test="${requestScope.isFavorite eq 'yes' }">
			    			<span class="right_collect right_collected" onclick="javascript:favorites('${session_manager.userId}','${shop.shopId}','${shop.name}',${requestScope.favoriteId});"></span>
		                </c:when>
		                <c:otherwise>
			    			<span class="right_collect" onclick="javascript:favorites('${session_manager.userId}','${shop.shopId}','${shop.name}',null);"></span>
		           		</c:otherwise>
		           	</c:choose>
	    		</div>
	    	</div>
	    	
	    	<div class="det_app_office_hours">
	    		<h5 class="d_h5">营业时间<span>${shop.sndtime == null ? "09:00" : shop.sndtime}-${shop.endtime == null ? '22:00' : shop.endtime}</span></h5>
	    		<ul class="justify">
	    			<c:if test="${shop.w1 ==0 }">
           				<li>周一</li>
            		</c:if>
            		<c:if test="${shop.w1 ==1 }">
           				<li class="open_time">周一</li>
            		</c:if>
            		
            		<c:if test="${shop.w2 ==0 }">
            			<li>周二</li>
            		</c:if>
            		<c:if test="${shop.w2 ==1 }">
            			<li class="open_time">周二</li>
            		</c:if>
            		
                	<c:if test="${shop.w3 ==0 }">
            			<li>周三</li>
            		</c:if>
            		<c:if test="${shop.w3 ==1 }">
            			<li class="open_time">周三</li>
            		</c:if>
            		
            		<c:if test="${shop.w4 ==0 }">
            			<li>周四</li>
            		</c:if>
            		<c:if test="${shop.w4 ==1 }">
            			<li class="open_time">周四</li>
            		</c:if>
            		
            		<c:if test="${shop.w5 ==0 }">
            			<li>周五</li>
            		</c:if>
            		<c:if test="${shop.w5 ==1 }">
            			<li class="open_time">周五</li>
            		</c:if>
            		
            		<c:if test="${shop.w6 ==0 }">
            			<li>周六</li>
            		</c:if>
            		<c:if test="${shop.w6 ==1 }">
            			<li class="open_time">周六</li>
            		</c:if>
            		
            		<c:if test="${shop.w7 ==0 }">
            			<li>周日</li>
            		</c:if>
            		<c:if test="${shop.w7 ==1 }">
            			<li class="open_time">周日</li>
            		</c:if>
	    		</ul>
	    		<h5 class="d_h5">简介</h5>
	    		<p class="brief" id="shop_description">
	    			<c:if test="${not empty shop.summary}">
    					${shop.summary}
    				</c:if>
					<c:if test="${empty shop.summary}">
						具体的服务要求请电话咨询商家，致电商家时请告知是在"好站点"上发现的此商家。
					</c:if>
	    		</p>
	    	</div>
	    	<c:if test="${fn:length(services) > 0 }">
		    	<div class="det_app_commodity">
		    		<c:forEach items="${services }" var="s">
			    		<a href="javascript:;">
			    			<div class="commodity_left"><img src="${s.path }" /></div>
			    			<div class="commodity_right">
			    				<p>${s.name }<span>￥${s.price }起</span></p>
			    				<p>${s.summary }</p>
			    			</div>
			    		</a>
		    		</c:forEach>
		    	</div>
	    	</c:if>
        </div>
        <div class="share_container">
        	<p class="share_title">分享到<span class="share_close"><img src="<%=basePath %>resources/images/close.png" alt="关闭" /></span></p>
        	<div class="share_content">
        		<a href="javascript:void(0);" class="jiathis_button_qzone"><em class="right_call2"><img src="<%=basePath %>resources/images/share_01.png" alt="分享店铺" /><p>QQ空间分享</p></em></a>
        		<a href="javascript:void(0);" class="jiathis_button_tsina"><em class="right_call3"><img src="<%=basePath %>resources/images/share_02.png" alt="分享店铺" /><p>新浪微博分享</p></em></a>
        	</div>
        </div>
        <div class="mark"></div>
        <footer class="d_footer det_app_footer">
        	<a href="javascript:download(${shop.shopId});"  id="download_${shop.shopId}"><span>下载应用</span></a>
        	<a href="javascript:phoneCalls2(${shop.shopId},'<%=basePath%>call/addCall');" id="phoneTel_${shop.shopId}"><span>拨号</span></a>
        </footer>
        
        
	</body>
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
		url: "<%=basePath%>index/goodsDetailApp?id=${shop.shopId}&type=1", 
		title:"我在好站点看到一个"+categoryName+"的应用，非常棒，你也来看看",
		summary:"好站点" 
	};
</script>
<script>
//tab点击跳转
function headClickEvent(index){
	querySearch('<%=basePath%>index/goodsDetailApp?id=${shop.shopId}&goods=1');
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
	        		if(favoriteId && favoriteId != null){
		        		alert('取消收藏成功');
	        		}else{
	        			alert('收藏成功');
	        		}
//	        		location.reload();
					$("#facorAjax").submit();
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




</script>
</body>
<!-- 
<jsp:include page="../head/hideHead.jsp"></jsp:include>
 -->
</html>

<script>

$(function(){
	if(/MicroMessenger/i.test(navigator.userAgent)){
		$(".head").css('display','none');
		$("#w_div").removeClass().addClass("content d_content_1 activity_content");
	}else if (/Android/i.test(navigator.userAgent)) {
		$(".head").css('display','none');
		$("#w_div").removeClass().addClass("content d_content_1 activity_content");
	}else if (/webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
	
		$(".head").css('display','none');
		$("#w_div").removeClass().addClass("content d_content_1 activity_content");
	}else {
		$(".head").css('display','none');
		$("#w_div").removeClass().addClass("content d_content_1 activity_content");
	}
});

function download(shopId){
//	$.ajax({
//		   type: "POST",
//		   url: "<%=basePath%>index/download",
//		   data:{"shopId":shopId},
//		   success: function(dat)
//		   {	
//			   if(dat.respCode==200){
//				   //self.location=dat.result;
//				   self.location='<%=basePath%>downloadPage.jsp?downloadUrl='+encodeURIComponent(encodeURIComponent(dat.result));
//			   }else{
//				   alert(dat.reason);
//			   }
//	       },
//	       error: function() {
//	       		alert('error');
//	       }
//	});
	
	self.location="<%=basePath%>index/download?shopId="+shopId
}

/**幻灯片*/
 var swiper = new Swiper('.swiper-container', {
     pagination: '.swiper-pagination',
     paginationClickable: true,
     spaceBetween: 0,
     autoplay: 3000
 });
 
 /**简介加载更多*/
$('.d_more').on('tap', function(){
		$('.brief').removeClass('brief_hide');
})

 $(function(){
   	
   	$(".mark").on("click",function(){
   		$(".share_container, .mark").hide();
   	});
   	
   	/*分享box*/
   	$(".share_bton").on("click",function(){
   		$(".share_container, .mark").show();
   	});
   	$(".share_close").on("click",function(){
   		$(".share_container, .mark").hide();
   	});/*end分享*/
   	
    
 });
 

//shop-hours
/*$(function(){
	$(".bottom-box ul a").click(function(){
		$(this).addClass("hit").siblings().removeClass("hit");
		$(".top-box>div:eq("+$(this).index()+")").show().siblings().hide();
	});
});*/
</script>