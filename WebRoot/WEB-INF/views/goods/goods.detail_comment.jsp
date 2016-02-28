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
<jsp:include page="../phone/is_phone.jsp"></jsp:include>
<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath %>resources/js/common.js"></script>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>店铺详情</title>

<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
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
	.details_merchant_head {background: #fff;}
	.details_nav a {color: #322c2c;display: inline-block;padding: 0 16px;}
	.details_nav a.current_color {color: #ffb402;border-bottom: 4px solid #ffb402;}
	.d_h5 {border-bottom: 1px solid #dddddd;font-size: 1.6rem;color:#6d6d6d;height: 30px;line-height: 30px;padding: 0 10px;background:#e7e7e7;}
	.merchant_appraise_content{top:4px;bottom:0px;font-size:1.4rem;}
	.appraise_grade div{float:left;font-size:1.6rem;}
	.appraise_grade{padding:25px 0;}
	.appraise_grade .grade_left{width:40%;text-align:center;}
	.appraise_grade .grade_left p:first-child{font-size:3rem;color:#ffb200;line-height:3rem;margin-bottom:5px;}
	.appraise_grade .grade_right{width:60%;}
	.appraise_grade .grade_right img{width:16px;}
	.appraise_grade .grade_right p{margin-bottom:20px;}
	.appraise_grade .grade_right p:last-child{margin-bottom:0;}
	.appraise_grade .grade_right span{margin-right:10px;}
	.appraise_list li{padding:10px;border-bottom:1px solid #d5d5d5;font-size:inherit;}
	.appraise_list .list_user{height:28px;line-height:28px;vertical-align: top;position:relative;}
	.appraise_list .user_head_img{display:inline-block;width:25px;height:25px;margin-right:5px;border-radius:50%;overflow:hidden;}
	.appraise_list .user_head_img img{width:100%;min-height:25px;}
	.appraise_list .user_publish_time{display:inline-block;position:absolute;right:0;top:0;font-size:1.2rem;line-height:1.2rem;color:#757575;}
	.appraise_list .list_score span{margin-right:20px;line-height:30px;}
	.appraise_list .list_content{color:#7a7a7a;} 
	.head { z-index: 10001;}
	.right_call_c{display:inline-block;position:absolute;top:0;right:0;height:50px;width:40px;margin:0 1px;text-align:center;border-radius:50%;}
	.right_call_c img { width: 28px; padding-top: 13px;} 
	/*comment*/
	.z_cusmoter_comment { position: fixed; bottom: 0; left: 0; width: 100%; height: 50px; line-height: 50px; text-align: center; background-color: #ffb400;}
	.z_cusmoter_comment a { display: block; width: 100%; height: 50px; font-size: 1.6rem;}
	.z_cusmoter_comment a, .z_cusmoter_comment a:visited { color: #fff; }
	.appraise_list ul { margin-bottom: 50px;}
</style>
</head>

	<body class="details_merchant_appraise">
		<form id="facorAjax" action="<%=basePath%>index/goodsDetailShop" method="post" target="_self">
			<input type="hidden" name="id" value="${shopid}" >
			<input type="hidden" name="type" value="2" >
			<input type="hidden"   name="keyword" id="keyword" value="${keyword}"></a>
			<input type="hidden" name="orderby" id="orderby" value="${orderby}">
			<input type="hidden" name="class_id" id="class_id" value="${class_id}">
			<input type="hidden" name="city_id" id="city_id" value="${city_id}">
		</form>
	
		<div class="head d_head details_merchant_head">
            <a href="javascript:querySearch('<%=basePath%>index/getShopSearchList');" class="head_back"></a>
            <p class="details_nav">
            	<c:if test="${fn:length(services) > 0}">
	            	<a href="javascript:headClickEvent(0);">服务</a>
            	</c:if>
            	<a href="javascript:;" class="current_color">评价</a>
            	<a href="javascript:headClickEvent(2);">商家</a>
			</p>
			<c:choose>
          		<c:when test="${requestScope.isFavorite eq 'yes' }">
	            	<a href="javascript:favorites('${session_manager.userId}','${shopid}','${shop.name}',${requestScope.favoriteId});" class="right_call_c">
	                    <img src="<%=basePath %>resources/images/details_31.png" alt="取消收藏店铺" />
                </c:when>
                <c:otherwise>
                	<a href="javascript:favorites('${session_manager.userId}','${shopid}','${shop.name}',null);" class="right_call_c">
	                    <img src="<%=basePath %>resources/images/details_3.png" alt="收藏店铺" />
           		</c:otherwise>
           	</c:choose>
   			</a><!--已收藏-->
        </div>
        
        <div class="content d_content merchant_appraise_content">
        	
        	<div class="appraise_grade">
        		<div class="grade_left">
        			<p>${(shop.score <= 0) ? 3.0 : shop.score}</p>
        			<p>整体评价</p>
        		</div>
        		<div class="grade_right">
        			<p class="description">
    					<span>服务质量</span>
    					<c:choose>
							<c:when test="${qua != null && qua>0}">
								<c:set var="n" value="0"></c:set>
								<c:forEach begin="1" end="${qua}">
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
		                    	<img src="<%=basePath %>resources/images/star_bright.png" alt="星星">
		                        <img src="<%=basePath %>resources/images/star_bright.png" alt="星星">
		                        <img src="<%=basePath %>resources/images/star_bright.png" alt="星星">
		                        <img src="<%=basePath %>resources/images/star_dark.png" alt="星星">
		                        <img src="<%=basePath %>resources/images/star_dark.png" alt="星星">
		                    </c:otherwise>
		                </c:choose>
								                
                     </p>
        			<p>
        				<span>速&#12288;&#12288;度</span>
        				<c:choose>
							<c:when test="${speed != null && speed>0}">
								<c:set var="n" value="0"></c:set>
								<c:forEach begin="1" end="${speed}">
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
		                    	<img src="<%=basePath %>resources/images/star_bright.png" alt="星星">
		                        <img src="<%=basePath %>resources/images/star_bright.png" alt="星星">
		                        <img src="<%=basePath %>resources/images/star_bright.png" alt="星星">
		                        <img src="<%=basePath %>resources/images/star_dark.png" alt="星星">
		                        <img src="<%=basePath %>resources/images/star_dark.png" alt="星星">
		                    </c:otherwise>
		                </c:choose>
        			</p>
        		</div>
        	</div>

        	<div class="appraise_list">
        		<h5 class="d_h5">用户评价</h5>
        		<c:if test="${(empty comments||fn:length(comments) == 0) &&(empty commentTempList||fn:length(commentTempList) == 0)}">
        			<ul>
        				<li>
							<p>暂无评价</p>
						</li>
					</ul>
				</c:if>
        		<ul>
        			<c:if test="${not empty commentTempList&&fn:length(commentTempList)>0}">
        				<c:forEach items="${commentTempList}" var="comm" varStatus="com">
		        			<li>
		        				<div class="list_user">
		        					<span class="user_head_img"><img src="${comm.headImg}" alt="" /></span>
		        					<c:choose>
		        						<c:when test="${fn:length(comm.userName) > 11 }">
				        					${fn:substring(comm.userName,0,11)}
		        						</c:when>
		        						<c:otherwise>
				        					${comm.userName}
		        						</c:otherwise>
		        					</c:choose>
		        					<span class="user_publish_time"><fmt:formatDate value='${comm.ctime }' pattern='yyyy-MM-dd HH:mm:ss' /></span>
		        				</div>
		        				<div class="list_score">
		        					质量<span>${comm.quality }</span>
		        					速度<span>${comm.speed }</span>
		        					服务<span>${comm.service }</span>
		        					态度<span>${comm.attitude }</span>
		        				</div>
		        				<div class="list_content">
		        					${comm.content }
		        				</div>
		        			</li>
		        		</c:forEach>
        			</c:if>
        			<c:if test="${not empty comments&&fn:length(comments)>0}">
        				<c:forEach items="${comments}" var="comm" varStatus="com">
		        			<li>
		        				<div class="list_user">
		        					<span class="user_head_img"><img src="${comm.headImg}" alt="" /></span>
		        					<c:choose>
		        						<c:when test="${fn:length(comm.username) > 11 }">
				        					${fn:substring(comm.username,0,11)}
		        						</c:when>
		        						<c:otherwise>
				        					${comm.username}
		        						</c:otherwise>
		        					</c:choose>
		        					<span class="user_publish_time"><fmt:formatDate value='${comm.ctime }' pattern='yyyy-MM-dd HH:mm:ss' /></span>
		        				</div>
		        				<div class="list_score">
		        					质量<span>${comm.quality }</span>
		        					速度<span>${comm.speed }</span>
		        					服务<span>${comm.service }</span>
		        					态度<span>${comm.attitude }</span>
		        				</div>
		        				<div class="list_content">
		        					${comm.content }
		        				</div>
		        			</li>
		        		</c:forEach>
        			</c:if>
        		</ul>
        	</div>
        </div>
        <c:if test="${!evaluated }">
	        <%-- 评价入口 --%>
	        <div class="z_cusmoter_comment">
	        	<a href="<%=basePath%>comment/getEvaluate?id=${shop.shopId }&orderId=-1">我要评价</a>
	        </div>
        </c:if>
    </body>
    
<script>

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
<!-- 
<jsp:include page="../head/hideHead.jsp"></jsp:include>
 -->
</html>

<script type="text/javascript" src="http://v2.jiathis.com/code/jia.js" charset="utf-8"></script> 
<script type="text/javascript">

//纠错
function shopError(shopId,type){
	var userId = '${userDetail.userId}';
	var shopUserId = '${shop.userId}';
	if( shopUserId == userId ){
		alert('不能纠错自己的店铺');
		$("#correct").slideToggle(100);
		return ;
	}
	$.ajax({  
	   		type: "GET",  
	        url: '<%=basePath%>shop/correct',  
	        data: 'shop_id='+shopId+'&type='+type+'&random='+Math.random(),
	        success: function(data){
	        	if( "true" == data ){
	        		alert('纠错成功');
	        		$("#correct").slideToggle(100);
	        	}else{
	        		alert('已有纠错记录，请等待修复！');
	        		$("#correct").slideToggle(100);
	        	}
			}  
		});  
}


//nav
$(function(){
	$("#correct-li").click(function(){
		$("#correct").slideToggle(100);
		$("#correct").css({"bottom":"100%","left":"0"});
		$("#correct ul .to-bottom").css("left",$("#correct").width()/2-11 +"px");
		$(".mask").show();
		$("#share").slideUp(100);
	});
	$("#share-li").click(function(){
		$("#share").slideToggle(100);
		$("#share").css({"bottom":"100%","right":"0"});
		$("#share ul .to-bottom01").css("left",$("#share").width()/2-11 +"px");
		$(".mask").show();
		$("#correct").slideUp(100);
	});
	$(".mask").click(function(){
		$("#share, #correct, .mask").hide();
	});
})
function clickkimil(){
	$("#share").slideToggle(100);
}

//tab点击跳转
function headClickEvent(index){
	if(index==0){
		//self.location="<%=basePath%>index/goodsDetailService?id=${shopid}";
		querySearch('<%=basePath%>index/goodsDetailService?id=${shopid}&goods=2');
	}
	else if(index==1){
		//self.location="<%=basePath%>index/goodsDetailComment?id=${shopid}";
		querySearch('<%=basePath%>index/goodsDetailComment?id=${shopid}&goods=2');
	}
	else if(index==2){
		//self.location="<%=basePath%>index/goodsDetailShop?id=${shopid}";
		querySearch('<%=basePath%>index/goodsDetailShop?id=${shopid}&goods=2');
	}
}

function querySearch(url){
	$("#facorAjax").attr("action",url).submit();
}


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
		        		alert("取消收藏成功");
	        		}else{
		        		alert("收藏成功");
	        		}
					$("#facorAjax").attr('action','<%=basePath%>index/goodsDetailComment').submit();
	        	}else if ("2" == data){
	        	}else{
	        	}
			}  
		});  
}

</script>