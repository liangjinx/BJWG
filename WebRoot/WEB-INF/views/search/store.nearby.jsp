<%@page import="com.bjwg.main.util.MyUtils"%>
<%@page import="com.bjwg.main.util.StringUtils"%>
<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
	boolean isIPhone = MyUtils.isIosPhone2(request);
	request.setAttribute("isIPhone",isIPhone);
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 导入 -->
<jsp:include page="../phone/is_phone.jsp"></jsp:include>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/swiper3.07.min.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/module.css">
		
		<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
		<script language="javascript" src="<%=basePath %>resources/js/zepto.min.js"></script>
		<script type="application/javascript" src="<%=basePath %>resources/js/touchmove.js"></script>
		<script language="javascript" src="<%=basePath %>resources/js/fastclick.js"></script>
		
		<title>好站点，您身边的上门服务!</title>
		<style type="text/css">
        	h1,h2,h3,h4,h5,h6{
				font-weight:normal;
				font-size:1.4rem;
			}
			html,body{
				width:100%;
				height:100%;
				overflow:hidden;
			}
			*{
				box-sizing: border-box;
				-webkit-box-sizing: border-box;
				-moz-box-sizing: border-box;
			}
			.footer a:nth-child(2):before{
				background:url(/resources/images/home_20.png) no-repeat center center;
				background-size:cover;
			}
			
			.d_content{height:100%;}
			#scroller:after{content:'';display:block;height:55px;width:100%;visibility: hidden;}
			.content ul{ overflow: hidden;}
			.sort_hot_app li,.sort_serve li{ float: left; width: 100%; min-height: 60px; border-bottom:1px solid #d8d8d8;/* margin-bottom: 2px;  border-top: 1px solid #dbd6d6; box-sizing: border-box; */background-color: white; position: relative; z-index: 50;}
			.left_imgbox, .right_fontbox{ float: left; }
			.left_imgbox{ width: 80px; min-height: 80px; margin: 14px; text-align: center;}
			.left_imgbox img{  width: 80px; height: 80px; vertical-align: middle; border-radius: 30%; -webkit-border-radius: 30%; -moz-border-radius: 30%; -o-border-radius: 30%;}
			.right_fontbox{min-height: 90px; color: #858585;}
			.right_fontbox .r_title{ width: 100%; padding: 14px 0 10px; color: #322c2c; font-size: 1.6rem; overflow: hidden;}
			.right_fontbox .r_title .renzheng{ width: 16px; margin-top: 4px; vertical-align: top;}
			.right_fontbox .description{ width: 100%; padding-bottom: 5px;}
			.right_fontbox .description img { width: 15px; margin-right: 2px;}
			.right_fontbox .description span { margin-left: 3px; font-size: 1.2rem; color: #858386;} 
			.right_fontbox .sort { padding-bottom: 8px; font-size: 1.3rem; color: #f42a02;}
			.right_fontbox .sort span{color:#858386;margin-left:15px;}
			.right_fontbox .store_category{ float: left; padding: 0 10px; border: 1px solid #eba123; border-radius: 5px; color: #eba123; font-size: 0.7em;}
			.calling{ /*position: absolute; bottom: 25%; right: 6%;*/ width: 50px; height: 40px; padding-top: 7px; text-align: center; overflow: hidden; z-index: 51;}
			.calling a{ display: inline-block;}
			.calling a:last-child img{ width: 60px;}
			.calling a:first-child img{ width: 25px;}
			.hot_app_list .calling a:last-child:before{content:'';position:relative;top:5px;display:inline-block;width:20px;height:15px;border-left:1px solid #d8d8d8;vertical-align:top;}
			.hot_app_list .calling a:first-child{padding-right:10px;}
			.right_fontbox .record{ position: absolute; bottom: 5px; right: 6px; overflow: hidden;}
			.record .map_span, .map_span1{ font-size: 1.2rem;}
			.record .map_span b, .map_span1 b{ padding: 5px;}
			.map_span1{ padding-right: 5px;border-right: 1px solid #d5d4d6;}
			.record .map_span img{ width: 15px; padding-left: 5px; vertical-align: bottom;}
			.right_fontbox .last_contact{ font-size: 1.2rem; color: #858386;}
			.content .del_fav{  position: absolute; right: -100px; width: 100px; height: 100%; /*line-height: 140px;*/ text-align: center; color:#000; background: #eba124;}
			.content .del_fav img{ padding-top: 45px; vertical-align: middle;}
			.mt100{ margin-top:100px;}
			.li_nothing{ margin-top:10px; text-align: center; background-color: #dfdfdd !important;}
			.font_nothing{ margin-top:30px; padding-left: 30px; font-size:24px; text-align: center; color:#272728;}
			.ui-loader h1{ display: none;}
			#wrapper{ position:absolute; z-index:1; top:0; bottom:55px; left:-9999px; width:100%;  background:#fff; overflow:auto;}
			#scroller{ position:absolute; z-index:1; -webkit-tap-highlight-color:rgba(0,0,0,0); width:100%; padding:0; margin-top: 90px;}
			#myFrame{ position:absolute;  top:0; left:0;}
			#pullUp{ background:#fff;  height:40px; line-height:40px; padding:5px 10px; border-bottom:1px solid #ccc; font-weight:bold; font-size:14px; color:#888;}
			#pullDown .pullDownIcon, #pullUp .pullUpIcon{ display:block; margin: auto; width:40px; height:40px; background:url(/resources/images/pull-icon@2x.png) 0 0 no-repeat;  -webkit-background-size:40px 80px; background-size:40px 80px;  -webkit-transition-property:-webkit-transform;  -webkit-transition-duration:250ms;}
			#pullUp .pullUpIcon{ -webkit-transform:rotate(-180deg) translateZ(0);}
			#pullDown.flip .pullDownIcon{  -webkit-transform:rotate(-180deg) translateZ(0);}
			#pullUp.flip .pullUpIcon{ -webkit-transform:rotate(0deg) translateZ(0);}
			#pullDown.loading .pullDownIcon, #pullUp.loading .pullUpIcon{ background-position:0 100%; -webkit-transform:rotate(0deg) translateZ(0); -webkit-transition-duration:0ms; -webkit-animation-name:loading; -webkit-animation-duration:2s; -webkit-animation-iteration-count:infinite; -webkit-animation-timing-function:linear;}
			@-webkit-keyframes loading {
				from { -webkit-transform:rotate(0deg) translateZ(0); }
				to { -webkit-transform:rotate(360deg) translateZ(0); }
			}
			@media only screen and (min-width: 300px) and (max-width: 350px) {
				 .left_imgbox{margin: 15px 5px 0 5px;}
				 .content ul li{min-height: 50px;}
				.left_imgbox{width:60px;height:60px;}
				.left_imgbox img {width: 60px;height: 60px;}
				.right_fontbox .r_title{padding: 14px 0 2px;}\
				.right_fontbox .description{padding:bottom:0;}
				.hot_app_list .calling a:first-child {padding-right: 2px;}
				.hot_app_list .calling a:last-child:before{width:2px;}
			}
			.head .search_input_box { margin: 0 8px auto 100px; box-sizing: initial; -webkit-box-sizing: initial; -moz-box-sizing: initial; -o-box-sizing: initial;}
			.city_list {visibility:hidden; z-index: 97;}
			.city_list_show {visibility:visible;}
			.list_level_2 { overflow: initial !important;}
			.list_level_2 li{ float: initial !important; width: initial  !important; min-height: initial  !important; background-color: #f4f4f4  !important; position: initial  !important; height:40px !important; line-height:40px !important; text-indent:18px !important;}
			.list_level_2_isshow{display:none;}
			.home_feature .home_feature_img{display:block;width:100%;height:200px;overflow:hidden;}
			.home_feature .home_feature_img img{min-height:200px;width:100%;}
			.home_feature p{font-size:1.4rem;color:#858386;height:32px;line-height:32px;text-indent:10px;}
			.home_h3{margin-bottom:8px;}
			.city_list{top:50px}
			.city_list .h6 { height: 40px; line-height: 40px;}
			.city_list .list_close { background-size: 20px 12px;}
			
			.store_none { font-size: 1.8rem; color: #322c2c; text-align: center; margin: 10px 0 5px;}
			.store_none2 { font-size: 1.5rem; color: #858386; text-align: center;}
			.z_calling {  position: absolute; bottom: 15%; right: 6%; height: 50px; text-align: center; overflow: hidden; z-index: 51;}
			.z_calling a{ display: inline-block;}
			.z_calling a:last-child:before { content: ''; position: relative; top: 5px; display: inline-block; width: 15px; height: 15px; border-left: 1px solid #dedede; vertical-align: top;}
			.z_calling .call_img { width: 25px; margin-right: 5px;}
			.z_calling .down_img { width: 55px;}
			.z_callbox { position: absolute; bottom: 30%; right: 6%; height: 40px; width: 50px;}
			.z_callbox img { width: 25px;}
			.top_city { -webkit-tap-highlight-color: transparent;}
			/*.nav_list {   position: absolute; width: 100%; left: 0; height: auto; top: 91px; bottom: 0;   z-index: 3; background-color: rgba(0,0,0,.6);}*/
        </style>
        
 <script type="text/javascript">
		function query(class_id , orderby){
			if(orderby > -1){
				$("#orderby").val(orderby);
			}
			$("#class_id").val(class_id);
			$("#searchForm").submit();
		}
		function query2(url){
			$("#searchForm3").attr("action",url).submit();
		}
//搜索
function findSearch(){
    //接口
	$('#searchForm').submit();
 }		
function findGoodsDetail(id){
	$("#id").val(id);
    //接口
	$('#searchForm').attr("action","<%=basePath%>index/goodsDetailShop").submit();
 }	
function findGoodsDetail2(id){
	$("#id").val(id);
    //接口
	$('#searchForm').attr("action","<%=basePath%>index/goodsDetailApp").submit();
}	
</script>        
        
	</head>
	<body class="fangle">
		
		<div class="head d_header d_head">
            <div class="top_city">${fn:substring(areaName,0,3)}</div>
	            <div class="search_input_box">
		    		<form action="<%=basePath%>index/getShopSearchList" id="searchForm" method="post">	
		    		
		    			<input type="text" name="keyword" id="keyword" class="form_search" placeholder="搜索附近服务/店家"  value="${map['keyword'] }" />
		    			
			    		<input type="hidden" id="id" name="id" value="">
						<input type="hidden" id="type" name="type" value="2">
						<input type="hidden" id="orderby" name="orderby" value="${map['orderby'] }">
						<input type="hidden" id="class_id" name="class_id" value="${map['categoryId'] }">
						<input type="hidden" id="city_id" name="city_id" value="${map['city_id'] }">
					</form>
		    	</div>
            <a href="javascript:;" onclick="findSearch()" class="top_search"></a>
        </div>
        
        <div class="content d_content sort_content">
        	<div class="city_list">
	    		<h6 class="h6"><a href="javascript:;" class="list_close"></a>选择城市</h6>
	    		<p class="list_current">当前定位：${areaName}</p>
	    		<ul>
	    			<c:forEach items="${provinceList}" var="list" >
		    			<li>
		    				<a href="javascript:;" class="list_level_1" data-id="${list.areaId}" >${list.name}</a>
		    				
		    				<ul class="list_level_2 list_level_2_isshow" id="cityMap_${list.areaId}">
		    					
		    				</ul>
		    			</li>
	    			</c:forEach>
	    		</ul>
	    	</div>
	    	
        	<div class="sort_nav">
    			<div class="nav_sale">
    				<a href="javascript:void(0);" class="nav_select">
    					<c:set var="cid" value="${map['categoryId']}"></c:set>
    					<c:choose>
    						<c:when test="${cid > -1 }">
    							${cmap[cid]}
    						</c:when>
    						<c:otherwise>
		    					全部分类
    						</c:otherwise>
    					</c:choose>
    				</a>
    			</div>
    			<div class="nav_rank">
    				<a href="javascript:;" class="nav_select">
    					<c:choose>
							<c:when test="${map['orderby'] == 0}">
		    					智能排序
							</c:when>
							<c:when test="${map['orderby'] == 1}">
								离我最近
							</c:when>
							<c:when test="${map['orderby'] == 2}">
								好评优先
							</c:when>
							<c:when test="${map['orderby'] == 3}">
								拨号最多
							</c:when>
							<c:otherwise>
								智能排序
							</c:otherwise>
						</c:choose>
    				</a>
    			</div>
    		</div>
    		
    		<div class="nav_list">
				<div class="nav_sale_list list_bd_img1">
					<a href="javascript:query(-1,-1);" <c:if test="${map['categoryId'] == null}">class="sale_selected"</c:if>>
						<div class="list_icon"></div>
						<span>全部分类</span>
					</a>
					<c:forEach items="${session_category}" var="cate" >
						<c:if test="${cate.categoryId != 16 }">
							<a href="javascript:query(${cate.categoryId},-1);" <c:if test="${cate.categoryId == map['categoryId']}">class="sale_selected"</c:if>>
								<div class="list_icon"></div>
								<span>${cate.name}</span>
							</a>
						</c:if>
					</c:forEach>
				</div>
				<div class="nav_rank_list">
					<a href="javascript:query(${categoryId},0);" 
						${map['orderby'] == 0}
						<c:choose>
							<c:when test="${map['orderby'] == 0}">class="rank_selected"</c:when>
							<c:otherwise>class="j_text"</c:otherwise>
						</c:choose>
						><span>智能排序</span></a>
					<a href="javascript:query(${categoryId},1);" 
						<c:choose>
							<c:when test="${map['orderby'] == 1}">class="rank_selected"</c:when>
							<c:otherwise>class="j_text"</c:otherwise>
						</c:choose>
					><span>离我最近</span></a>
					<a href="javascript:query(${categoryId},2);" 
						<c:choose>
							<c:when test="${map['orderby'] == 2}">class="rank_selected"</c:when>
							<c:otherwise>class="j_text"</c:otherwise>
						</c:choose>
					><span>好评优先</span></a>
					<a href="javascript:query(${categoryId},3);"
						<c:choose>
							<c:when test="${map['orderby'] == 3}">class="rank_selected"</c:when>
							<c:otherwise>class="j_text"</c:otherwise>
						</c:choose>
					><span>拨号最多</span></a>
				</div>
			</div>
			
      <div id="wrapper">
			<div id="scroller">
			<div id="pullDown"></div>
        	<div class="sort_hot_app fn_box_isshow">
        		<h2 class="sort_h2 sort_h2_hot sort_h2_anima">热门应用</h2>
        		<ul class="hot_app_list isshow" id="thelist1">
        		
        			 <c:forEach items="${session_apps_manager}" var="hot" varStatus="te">
	        			 <li>
							<a href="javascript:findGoodsDetail2(${hot.shopId});" data-ajax="false" >
								<div class="left_imgbox">
								<c:choose>
				        			 <c:when test="${hot.logo == null}">
										<c:choose>
											<c:when test="${hot.categoryId >= 14}">
												<img src="<%=basePath %>resources/images/index_sort15.png" />
											</c:when>
											<c:otherwise>
												<img src="<%=basePath %>resources/images/index_sort${hot.categoryId}.png"/>
											</c:otherwise>
										</c:choose>
									 </c:when>
									 <c:otherwise>
									 		<img src="${hot.logo }"/>
									 </c:otherwise>
								</c:choose>
								</div> 
							</a>
		                    <a href="javascript:findGoodsDetail2(${hot.shopId});" data-ajax="false">
		                    	<div class="right_fontbox">
			                        <p class="r_title">${fn:substring(hot.name,0,10)}</p>
			                        <p class="description">
			                        	<c:choose>
											<c:when test="${hot.score != null && hot.score>0}">
												<c:set var="n" value="0"></c:set>
												<c:forEach begin="1" end="${hot.score}">
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
			                        <p class="sort">${cmap[hot.categoryId] == null ? '其它' : cmap[hot.categoryId]}<span>${hot.downSize }</span></p>
		                    	</div>
		                    </a>
		                    
		                    <p class="z_calling">
		                    	<a href="javascript:phoneCalls2(${hot.shopId},'<%=basePath%>call/addCall');" id="phoneTel_${hot.shopId}">
		                    		<img class="call_img" src="<%=basePath %>resources/images/call.png"></a>
		                    	
		                    	<c:choose>
		                    		<c:when test="${isIPhone }">
				                    	<c:if test="${not empty hot.androidPath}">  
				                    		<a href="javascript:download(${hot.shopId});"  id="download_${hot.shopId}">
				                    			<img class="down_img" src="<%=basePath %>resources/images/sort_2.png"/></a>
				                    	</c:if>
		                    		</c:when>
		                    		<c:otherwise>
				                    	<c:if test="${not empty hot.iphonePath}">  
				                    		<a href="javascript:download(${hot.shopId});"  id="download_${hot.shopId}">
				                    			<img class="down_img" src="<%=basePath %>resources/images/sort_2.png"/></a>
				                    	</c:if>
		                    		</c:otherwise>
		                    	</c:choose>
		                    </p>
		                </li>
		             </c:forEach> 

        		</ul>
        	</div>
        	
        	<div class="sort_serve">
        		<h2 class="sort_h2">服务商家</h2>
		        	<ul id="thelist2" class="nearbybox">
		        	
		              <c:forEach items="${session_shop_manager}" var="hot" varStatus="te">
		        		<c:if test="${te.index < 15 }">
		                <li>
		                	<c:if test="${hot.logo == null}" >
		                		<a href="javascript:findGoodsDetail(${hot.shopId});" data-ajax="false">
		                			<div class="left_imgbox">
		                				<c:choose>
					         				<c:when test="${hot.categoryId >= 14}">
							         			<img src="<%=basePath %>resources/images/index_sort15.png" width="131">
					         				</c:when>
					         				<c:otherwise>
							         			<img src="<%=basePath %>resources/images/index_sort${hot.categoryId}.png" width="131">
					         				</c:otherwise>
					         			</c:choose>
		                			</div>
		                		</a>
			         		</c:if>
			         		<c:if test="${hot.logo != null}">
			            		<a href="javascript:findGoodsDetail(${hot.shopId});">
			            			<div class="left_imgbox"><img src="${hot.logo}" width="131"></div></a>
			            	</c:if>
				                    
		                    <a href="javascript:findGoodsDetail(${hot.shopId});" data-ajax="false"><div class="right_fontbox">
		                        <p class="r_title">${fn:substring(hot.name,0,10) }
			                        <span>
			                        	<c:if test="${hot.isAuth==2}">
			                        		<img class="renzheng" src="<%=basePath %>resources/images/my_favorite/merchantlist_6.png" alt="商家已认证">
			                        	</c:if>
			                        </span>
			                    </p>
		                        <p class="description">
		                        	<c:choose>
										<c:when test="${hot.evaluates != null && hot.evaluates>0}">
											<c:set var="n" value="0"></c:set>
											<c:forEach begin="1" end="${hot.score}">
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
		                            <span>${hot.evaluates}评价</span>
		                        </p>
		                        <p class="sort">${cmap[hot.categoryId] }</p>
		                        <div class="record">
		                            <span class="map_span1"><b>${hot.distance}</b></span>
		                            <c:if test="${hot.phoneTimes != 0}">
	                    				<span class="map_span"><b id="phoneTimes_${hot.shopId}" >${hot.phoneTimes}</b>人拨打</span>
	                    			</c:if>
		                        </div>
		                    </div></a>
		                    <a href="javascript:phoneCalls2(${hot.shopId},'<%=basePath%>call/addCall');"   id="phoneTel_${hot.shopId}" class="z_callbox">	
		                    	<p class="calling">
		                    		<img src="<%=basePath %>resources/images/call.png">
		                    	</p>
		                    </a>
		                </li>
		                </c:if>
				        </c:forEach>
				        <c:if test="${session_shop_manager == null || fn:length(session_shop_manager)<=0}">
				        	<li>
				        		<div class="store_none">
					        		暂时没有此类商家哦！
				        		</div>
				        		<div class="store_none2">
				        			看看其他的吧
				        		</div>
				        	</li>
				        </c:if>
		                
		            </ul>
           		</div>
	           	<div id="pullUp">
				      <span class="pullUpIcon"></span>
				 </div>
			</div>
		</div>
        	
        </div>
        
        <form action="<%=basePath%>index/manage" id="searchForm3" method="post">
		</form>
		
		<jsp:include page="../footer.jsp"></jsp:include>
		
	</body>

<script>
//防点透
/*$(function(){
	FastClick.attach(document.body);
})*/

$('.d_content').removeClass('centent_overflow_hide');


function phoneCalls2(shopId,url){
	$.ajax({
		   type: "POST",
		   url: url,
		   data:{"shop_id":shopId},
		   success: function(data)
		   {
			   $("#phoneTel_"+shopId).attr('href','tel:'+ data);
			   $("#phoneTel_"+shopId)[0].click(function(e){return false;}); 
			   var phone = $('#phoneTimes_'+shopId).html();
			   $('#phoneTimes_'+shopId).html( Number(phone) + Number(1) );
	       },
	       error: function() {
	       		alert('获取下载地址失败');
	       }
	});
}

function download(shopId){
	//$.ajax({
		   //type: "POST",
		   //url: "<%=basePath%>index/download",
		   //data:{"shopId":shopId},
		   //success: function(dat)
		   //{	
			//   if(dat.respCode==200){
				   //self.location=dat.result;
				//   self.location='<%=basePath%>downloadPage.jsp?downloadUrl='+encodeURIComponent(encodeURIComponent(dat.result));
			  // }else{
				//   alert(dat.reason);
			  // }
	       //},
	      // error: function() {
	       	//	alert('error');
	       //}
	//});
	self.location="<%=basePath%>index/download?shopId="+shopId;
}

		/**分类搜索*/
		$(function(){
			
			/**顶部导航*/
		$('.top_city').on('click',function(){
		
			$('.city_list').toggleClass('city_list_show');
			
			if($('.city_list').hasClass('city_list_show')){
				$('.d_content').addClass('centent_overflow_hide');
			}else{
				$('.d_content').removeClass('centent_overflow_hide');
			}
			return false;
		});
		
		$('.list_close').on('click', function(){
			$('.city_list').removeClass('city_list_show');
			$('.d_content').removeClass('centent_overflow_hide');
			return false;
		});
		
		/*背景点击隐藏导航*/
		$('.nav_list').on('click', function(){
			
		})
		
		//下
		$('.city_list .list_level_1').on('click', function(){
			$(this).next().toggleClass('list_level_2_isshow');
			//赋值城市
			var areaId = $(this).data("id");
			var _this = this;
			$.ajax({  
		   		type: "POST",  
		        url: '<%=basePath %>index/areaMap',  
		        data: "areaId="+areaId,
		        success: function(data){
			        var json = eval("("+data+")"); 
		 			var option = "";
			        $.each(json.des, function (i, item) {  
		                   //循环获取数据      
		                   var id = item.areaId; 
		                   var name = item.name;  
		                   option += "<li data-areaid="+id+">"+name+"</li>";
		               });  
					$("#cityMap_"+areaId).html(option);
					if(option == ""){
						$('.top_city').text($(_this).html());
						$('.city_list').removeClass('city_list_show');
						$('.d_content').removeClass('centent_overflow_hide');
						$("#city_id").val(areaId);
						$("#searchForm").submit();
					} 
					//赋值
					$('.city_list .list_level_2 li').on('touchend', function(e){
//						alert($(this).html());
						var id = $(this).data("areaid");
//						alert(id);
						$('.top_city').text($(this).text());
						$('.city_list').removeClass('city_list_show');
						$('.d_content').removeClass('centent_overflow_hide');
						
						$("#city_id").val(id);
						$("#searchForm").submit();
						return false;
					});
				}  
			}); 
			return false;
		});
		
		//
			$(document).on('click','.nav_sale,.nav_rank',function(){
				var _class = $(this).attr('class');
				var _this = this;
				var $nav_list = $('.' + _class + '_list');
				
				$('.sort_content').toggleClass('centent_overflow_hide');
				$nav_list.toggleClass('scale_isshow');
				if($($nav_list.siblings()[0]).hasClass('scale_isshow')){
					$($nav_list.siblings()[0]).removeClass('scale_isshow');
					$('.sort_content').addClass('centent_overflow_hide');
					$nav_list.addClass('scale_isshow');
				}
				
				$nav_list.children().on('click', function(){
					if(_class == 'nav_sale'){
						$nav_list.find('.list_icon').removeClass('list_icon2');
						$(this).find('.list_icon').addClass('list_icon2');
					}else{
						$nav_list.children().removeClass('rank_selected');
						$(this).addClass('rank_selected');
					}
					fn_nav_list();
				});
				
				function fn_nav_list(){
				//	var on_this = this_;
				//	$(_this).find('a').text($(this_).find('span').text());
					$nav_list.removeClass('scale_isshow');
					$('.nav_list').removeClass('nav_list_show');
					$('.sort_content').removeClass('centent_overflow_hide');
					return false;
				}
				
				$('.nav_list').off('touchend');
				$('.nav_list').on('touchend', function(e){
					if($(e.target).hasClass('nav_list')){
						fn_nav_list();
						return false; 
					}
				})
			});
		/*	
			$('.fn_box_isshow').on('tap',function(){
				$('.hot_app_list').toggleClass('isshow');
			})
			*/
});
		
	var myScroll,
	pullDownEl, pullDownOffset,
	pullUpEl, pullUpOffset,
	generatedCount = 0;
	var currentPage = 2;
function pullUpAction () {
	    setTimeout(function () {
		 $.ajax({
	            type: "post",
	            url: "<%=basePath%>index/getAjax",
	            data: {page:currentPage,class_id:"${categoryId}",city_id:"${map['city_id']}",keyword:"${map['keyword']}"}, //form的序列化
	            success: function(data) {
	            	currentPage++;
//					$('#serviceshop').append(data);
					$('.nearbybox').append(data);
					myScroll.refresh(); 
	            },
	            error: function() {
	
	            }
	        });
	        
	        myScroll.refresh();     
	    }, 200);   
	    
	   
	}
 //热门应用显示开关
/* var app=true;
 function appClickEvents(){
	if(app){
		app=false;
		$("#appList").hide();
	}else{
		app=true;
		$("#appList").show();
	}
 }*/
	
function loaded() {
	    pullDownEl = document.getElementById('pullDown');
	    pullDownOffset = pullDownEl.offsetHeight;
	
	    pullUpEl = document.getElementById('pullUp');
	    pullUpOffset = pullUpEl.offsetHeight;
	    myScroll = new iScroll('wrapper', {
	        useTransition: true,
	        topOffset: "0",
	        onRefresh: function () {
	           if (pullUpEl.className.match('loading')) {
	                pullUpEl.className = '';
	            }else if (pullDownEl.className.match('loading')) {
	                pullDownEl.className = '';
	            }
	        },
	        onScrollMove: function () {
	          if (this.y > 5 && !pullDownEl.className.match('flip')) {
	                this.minScrollY = 0;
	            } else if (this.y < 5 && pullDownEl.className.match('flip')) {
	                pullDownEl.className = '';
	                this.minScrollY = -pullDownOffset;
	            } else if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
	                pullUpEl.className = 'flip';
	                this.maxScrollY = this.maxScrollY;
	            } else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
	                pullUpEl.className = '';
	                this.maxScrollY = pullUpOffset;
	            }
	        },
	        onScrollEnd: function () {
	            if (pullUpEl.className.match('flip')) {
	                pullUpEl.className = 'loading';
	                pullUpAction(); 
	            }
	        }
	    });
	    setTimeout(function () { 
			document.getElementById('wrapper').style.left = '0';
		 }, 800);
		//热门应用
		$('.sort_h2_hot').on('click',function(e){
			$('.hot_app_list').toggleClass('isshow');
			$('.sort_hot_app .sort_h2').toggleClass('sort_h2_anima');
			myScroll.refresh();
			return false;
		});
	}
		
		document.addEventListener('DOMContentLoaded', function () { setTimeout(function(){
			loaded();
		}, 200); }, false);
		
	</script>
</html>

