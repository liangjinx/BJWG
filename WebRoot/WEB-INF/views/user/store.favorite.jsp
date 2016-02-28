<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="myTags" uri="my-taglib" %>
<!-- 导入 -->
<script type="text/javascript" src="<%=basePath %>resources/js/common.js"></script>
<jsp:include page="../phone/is_phone.jsp"></jsp:include>

<!doctype html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html" charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
	<title>我的收藏</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<script src="<%=basePath %>resources/js/zepto.min.js"></script>

	<script language="javascript">
		/*$(function(){
			if(/MicroMessenger/i.test(navigator.userAgent)){
				$(".head").css('display','none');
			}else if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
			
							
			}else {
				$(".head").css('display','none');
			}
		});*/
	
		function query(url,id){
			$("#id").val(id);
			$("#searchForm").attr("action",url).submit();
		}
	</script>
	
	<c:choose>
	   	<c:when test="${favoriteType != null && favoriteType ==2 }">
	   		<style type="text/css">
				.content{ width: 100%; overflow: hidden;}
				.content ul{ overflow: hidden;}
				.content ul li{ position: relative; float: left; width: 100%; height: 110px; border-bottom: 1px solid #efefef; background-color: white;}
				.left_imgbox, .right_fontbox{ float: left; }
				.left_imgbox{ width: 80px; min-height: 80px; margin: 14px; text-align: center;}
				.left_imgbox img{  width: 80px; height: 80px; vertical-align: middle; }
				.right_fontbox{ width: 64%; min-height: 90px; margin-top: 14px; color: #858585;}
				.right_fontbox .r_title{ width: 100%; color: #322c2c; font-size: 1.6rem; overflow: hidden;}
				.content .del_fav{  position: absolute; right: -100px; width: 100px; height: 100%; text-align: center; color:#000; background: #eba124;}
				.content .del_fav img{ padding-top: 40px; vertical-align: middle;}
				.mt100{ margin-top:100px;}
				.li_nothing{ margin-top:10px; text-align: center; background-color: #dfdfdd !important;}
				.font_nothing{ margin-top:30px; padding-left: 30px; font-size:24px; text-align: center; color:#272728;}
				.ui-loader h1{ display: none;}
				.favorite_sort { width: 100%; height: 50px; line-height: 50px; margin-bottom: 15px; background-color: #fff;}
				.favorite_merchant, .favorite_serve { float: left; width: 50%; height: 40px; line-height: 40px; margin-top: 5px; font-size: 1.6rem; text-align: center;}
				.favorite_merchant { color: #322c2c; border-right: 1px solid #dedede; box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box;}
				.favorite_serve { color: #ffb402;}
				.favorito_price { padding-top: 15px; font-size: 1.6rem; color: #ffb402;}
				.li_swipeleft{transform:translate3d(-122px,0,0);-webkit-transform:translate3d(-122px,0,0)}
				.list_delete{position:absolute;left:100%;top:0;height:109px;width:122px;text-align:center;border-bottom: 1px solid #ccc;background:#fbb102;display:-webkit-box;-webkit-box-align:center;-webkit-box-pack:center;}
				.list_delete img{width:26px;}
				.message_info { position: fixed; left: 50%; top:50%; display: none; width: 80%; height: auto; border: 1px solid #efefef; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; transform: translate(-50%,-50%); -webkit-transform: translate(-50%,-50%); -moz-transform: translate(-50%,-50%); background: url(/resources/images/share-bd.png) #fff center center no-repeat; background-size: 140px auto; z-index: 100;}
				.title_info,
				.content_info { width: 90%; /*font-size: 1.6rem; color: #322c2c;*/ text-align: center;}
				.title_info { /*padding-bottom: 20px;*/ margin: 57px auto 0; font-size: 1.6rem; color: #322c2c; /*border-bottom: 1px solid #efefef; box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box;*/}
				.content_info { margin: 10px auto 24px; text-align: center;}
				.cancel,
				.ensure { width: 80px; height: 40px; line-height: 40px; font-size: 1.4rem; border: none; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; background: none;}
				.cancel { margin-right: 15px; color: #858386;}
				.ensure { margin-left: 15px; color: #322c2c;}
				.no_thing { width: 80%; height: auto; margin: 20px auto; text-align: center;}
				.no_thing img { display: block; margin: 0 auto 30px;}
				.no_thing em { font-size: 1.7rem; color: #322c2c;}
			</style>
			</c:when>
		<c:otherwise>
			<style type="text/css">
				.content{ width: 100%; overflow: hidden;}
				.content ul{ overflow: hidden;}
				.content ul li{ position: relative; float: left; width: 100%; height: 110px; border-bottom: 1px solid #efefef; background-color: white; transition:all 0.25s;-webkit-transition:all 0.25s; box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box;}
				.left_imgbox, .right_fontbox{ float: left; }
				.left_imgbox{ width: 80px; min-height: 80px; margin: 14px; text-align: center;}
				.left_imgbox img{  width: 80px; height: 80px; vertical-align: middle; border-radius: 30%; -webkit-border-radius: 30%; -moz-border-radius: 30%; -o-border-radius: 30%;}
				.right_fontbox{ width: 52%; min-height: 90px; color: #858585;}
				.right_fontbox .r_title{ width: 100%; padding: 14px 0 10px; color: #322c2c; font-size: 1.6rem; overflow: hidden;}
				.right_fontbox .r_title .renzheng{ width: 16px; margin-left: 3px; vertical-align: middle;}
				.right_fontbox .description{ width: 100%; padding-bottom: 5px;}
				.right_fontbox .description img { width: 15px; margin-right: 2px;}
				.right_fontbox .description span { margin-left: 3px; font-size: 1.2rem; color: #858386;} 
				.right_fontbox .sort { padding-bottom: 8px; font-size: 1.3rem; color: #f42a02;}
				.right_fontbox .store_category{ float: left; padding: 0 10px; border: 1px solid #eba123; border-radius: 5px; color: #eba123; font-size: 0.7em;}
				.calling{ position: absolute; bottom: 35%; right: 0; width: 50px; height: 50px; text-align: center; overflow: hidden;}
				.calling a{ display: block;}
				.calling img{ width: 25px; padding-top: 13px;}
				.right_fontbox .record{ position: absolute; bottom: 5px; right: 6px; overflow: hidden;}
				.record .map_span, .map_span1{ font-size: 1.2rem;}
				.record .map_span b, .map_span1 b{ padding: 5px;}
				.map_span1{ padding-right: 5px;border-right: 1px solid #d5d4d6;}
				.record .map_span img{ width: 15px; padding-left: 5px; vertical-align: bottom;}
				.right_fontbox .last_contact{ font-size: 1.2rem; color: #858386;}
				.mt100{ margin-top:100px;}
				.li_nothing{ margin-top:10px; text-align: center; background-color: #dfdfdd !important;}
				.font_nothing{ margin-top:30px; padding-left: 30px; font-size:24px; text-align: center; color:#272728;}
				.ui-loader h1{ display: none;}
				.favorite_sort { width: 100%; height: 50px; line-height: 50px; margin-bottom: 15px; background-color: #fff;}
				.favorite_merchant, .favorite_serve { float: left; width: 50%; height: 40px; line-height: 40px; margin-top: 5px; font-size: 1.6rem; text-align: center;}
				.favorite_merchant { color: #ffb402; border-right: 1px solid #dedede; box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box;}
				.favorite_serve { color: #322c2c;}
				.li_swipeleft{transform:translate3d(-122px,0,0);-webkit-transform:translate3d(-122px,0,0)}
				.list_delete{position:absolute;left:100%;top:0;height:109px;width:122px;text-align:center;border-bottom: 1px solid #ccc;background:#fbb102;display:-webkit-box;-webkit-box-align:center;-webkit-box-pack:center;}
				.list_delete img{width:26px;}
				.message_info { position: fixed; left: 50%; top:50%; display: none; width: 80%; height: auto; border: 1px solid #efefef; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; transform: translate(-50%,-50%); -webkit-transform: translate(-50%,-50%); -moz-transform: translate(-50%,-50%); background: url(/resources/images/share-bd.png) #fff center center no-repeat; background-size: 140px auto; z-index: 100;}
				.title_info,
				.content_info { width: 90%; /*font-size: 1.6rem; color: #322c2c;*/ text-align: center;}
				.title_info { /*padding-bottom: 20px;*/ margin: 57px auto 0; font-size: 1.6rem; color: #322c2c; /*border-bottom: 1px solid #efefef; box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box;*/}
				.content_info { margin: 10px auto 24px; text-align: center;}
				.cancel,
				.ensure { width: 80px; height: 40px; line-height: 40px; font-size: 1.4rem; border: none; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; background: none;}
				.cancel { margin-right: 15px; color: #858386;}
				.ensure { margin-left: 15px; color: #322c2c;}
				.no_thing { width: 80%; height: auto; margin: 20px auto; text-align: center;}
				.no_thing img { display: block; margin: 0 auto 30px;}
				.no_thing em { font-size: 1.7rem; color: #322c2c;}
			</style>
		</c:otherwise>
	</c:choose>

</head>

 <c:choose>
   	<c:when test="${favoriteType != null && favoriteType ==2 }">
   		<!-- 服务 -->
        <body>
	    	<header class="head">
	            <a href="<%=basePath%>index/storeMe" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
	            <p>我的收藏</p>
	        </header>
	        <div class="content">
	        	<!--<div class="favorite_sort">
	        		<a 
	        			<c:choose>
							<c:when test="${isPhone }">
								<c:choose>
									<c:when test="${isIosPhone }">
										href="OC://tag=17&r=<myTags:paging urlEncode="${basePath }favorite/favoriteList?favoriteType=1" />"
									</c:when>
									<c:otherwise>
										href="javascript:window.O2OHOME.SkipOutWebview('<myTags:paging urlEncode="${basePath }favorite/favoriteList?favoriteType=1"/>','我的收藏',17,null);"
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								href="<%=basePath%>favorite/favoriteList?favoriteType=1"
							</c:otherwise>
						</c:choose>
	        		data-ajax="false">
	        			<div class="favorite_merchant">商家</div>
	        		</a>
	        		<a 
	        			<c:choose>
							<c:when test="${isPhone }">
								<c:choose>
									<c:when test="${isIosPhone }">
										href="OC://tag=18&r=<myTags:paging urlEncode="${basePath }favorite/favoriteList?favoriteType=2" />"
									</c:when>
									<c:otherwise>
										href="javascript:window.O2OHOME.SkipOutWebview('<myTags:paging urlEncode="${basePath }favorite/favoriteList?favoriteType=2"/>','我的收藏',17,null);"
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								href="<%=basePath%>favorite/favoriteList?favoriteType=2"
							</c:otherwise>
						</c:choose>
	        		data-ajax="false">
	        			<div class="favorite_serve">服务</div>
	        		</a>
	        	</div>
	            --><ul id="thelist2">
	            	<c:choose>
  						<c:when test="${fn:length(favorites)>0}">
			            	<c:forEach items="${favorites }" var="fa" varStatus="status">
				                <li>
				                    <a 
				                    	<c:choose>
											<c:when test="${isPhone }">
												<c:choose>
													<c:when test="${isIosPhone }">
														href="OC://tag=42"
													</c:when>
													<c:otherwise>
														href="javascript:window.O2OHOME.SkipOutWebview('<myTags:paging urlEncode="${basePath }index/goodsDetailShop?id=${fa.shopId}&type=5"/>','店铺详情',42,null);"
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
														href="<%=basePath%>index/goodsDetailShop?id=${fa.shopId}&type=5"
											</c:otherwise>
										</c:choose>
				                    data-ajax="false">
				                    	<div class="left_imgbox">
				                    		<c:choose>
				                    			<c:when test="${fa.path != null}">
						                    		<img src="${fa.path }">
				                    			</c:when>
				                    			<c:otherwise>
						                    		<img src="<%=basePath %>resources/images/goods_picture.png">
				                    			</c:otherwise>
				                    		</c:choose>
				                    	</div>
				                    	<div class="right_fontbox">
					                        <p class="r_title">${fn:substring(fa.serviceName,0,10)}</p>
					                        <p>
					                        	<span>销量：${fa.salesNum }</span>
					                        </p>
					                        <p class="favorito_price">￥${fa.price }</p>
				                    	</div>
				                    </a>
									<div class="list_delete"><img src="<%=basePath %>resources/images/shopping_11.png"/></div>
				                </li>
			            	</c:forEach>
			            </c:when>
			            <c:otherwise>
			            	<p class="no_thing">
								<img src="<%=basePath %>resources/images/my_favorite/no_favorite.png" alt="没有收藏" />
								<em>您还没有任何收藏服务记录</em>
							</p>
			            </c:otherwise>
			        </c:choose>
	            </ul>
	        </div>
			<div class="message_info">
        	<div class="title_info">确定删除此消息？</div>
        	<div class="content_info">
            	<input type="button" class="cancel" value="取消" />
            	<input type="button" class="ensure" value="确定" />
        	</div>
        </div>
	    </body>
   	</c:when>
   	<c:otherwise>
   		<!-- 商家 -->
   		<body>
			<header class="head">
	            <a href="<%=basePath%>index/storeMe" class="head_back" data-ajax="false"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
	            <p>我的收藏</p>
	        </header>
	        <div class="content">
	        	<!--<div class="favorite_sort">
	        		<a 
	        			<c:choose>
							<c:when test="${isPhone }">
								<c:choose>
									<c:when test="${isIosPhone }">
										href="javascript:window.MyCollectionsViewController.addWebViewWithURL_('<myTags:paging urlEncode="${basePath }favorite/favoriteList?favoriteType=1"/>')"
									</c:when>
									<c:otherwise>
										href="javascript:window.O2OHOME.SkipOutWebview('<myTags:paging urlEncode="${basePath }favorite/favoriteList?favoriteType=1"/>','我的收藏',17,,'${fa.shopId}');"
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
										href="${basePath }favorite/favoriteList?favoriteType=1;"
							</c:otherwise>
						</c:choose>
	        		data-ajax="false">
	        			<div class="favorite_merchant">商家 
	        				
	        				<a href="javascript:window.controller.addWebViewWithURL('<myTags:paging urlEncode="${basePath }favorite/favoriteList?favoriteType=1"/>')">测</a>
	        				<a href="javascript:document.location=objc://addWebViewWithURL:/<myTags:paging urlEncode='${basePath }favorite/favoriteList?favoriteType=1'/>">测</a>
	        				<a href="#" onclick="iosTest()">测</a>
	        				
	        			</div>
	        		</a>
	        		<a 
	        			<c:choose>
							<c:when test="${isPhone }">
								<c:choose>
									<c:when test="${isIosPhone }">
										href="javascript:window.MyCollectionsViewController.addWebViewWithURL_('<myTags:paging urlEncode="${basePath }favorite/favoriteList?favoriteType=1"/>')"
									</c:when>
									<c:otherwise>
										href="javascript:window.O2OHOME.SkipOutWebview('<myTags:paging urlEncode="${basePath }favorite/favoriteList?favoriteType=2"/>','我的收藏',18,null);"
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
										href="${basePath }favorite/favoriteList?favoriteType=2"
							</c:otherwise>
						</c:choose>
	        		data-ajax="false">
	        			<div class="favorite_serve">服务</div>
	        		</a>
	        	</div>
	            --><ul id="thelist2">
	            	<c:choose>
			  			<c:when test="${fn:length(favorites)>0}">
				    		<c:forEach items="${favorites }" var="fa" varStatus="status">
				                <li>
					    			<input type="hidden" name="favoriteIds" id="favoriteId${status.index+1 }" value="${fa.favoriteId}" />
								    <input type="hidden" name="shopIds" id="shopId${status.index+1}" value="${fa.targetId}" />
								    
				                    <a 
				                    	<c:choose>
									    	<c:when test="${fa.shopType == 2}">
									    		href="<%=basePath%>index/goodsDetailApp?id=${fa.shopId}&type=5"
									    	</c:when>
									    	<c:otherwise>
									    		href="<%=basePath%>index/goodsDetailShop?id=${fa.shopId}&type=5"
									    	</c:otherwise>
									    </c:choose>
				                    data-ajax="false">
				                    	<div class="left_imgbox">
				                    		<img src="${fa.logo }">
				                    	</div>
				                    	<div class="right_fontbox">
					                        <p class="r_title">${fn:substring(fa.name,0,10)}
					                        	<c:if test="${fa.isAuth == 2 }">
						                        	<span><img class="renzheng" src="<%=basePath %>resources/images/merchantlist_6.png" alt="商家已认证"></span>
					                        	</c:if>
					                        </p>
					                        <p class="description">
					                        	<c:choose>
													<c:when test="${fa.evaluates != null && fa.evaluates>0}">
														<c:set var="n" value="0"></c:set>
														<c:forEach begin="1" end="${fa.score}">
															<c:set var="n" value="${n + 1}"></c:set>
															<span><a href="javascript:;"><img src="<%=basePath %>resources/images/star_bright.png"></a></span>
														</c:forEach>
														<c:if test="${n < 5}">
															<c:forEach begin="1" end="${5-n}">
																<span><a href="javascript:;"><img src="<%=basePath %>resources/images/star_dark.png"></a></span>
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
					                            <span>${fa.evaluates }评价</span>
					                        </p>
					                        <p class="sort">${fa.category }</p>
					                        <div class="record">
					                        	<c:if test="${fa.shopType == 1}">
						                            <span class="map_span1"><b>${fa.distance}</b></span>
					                        	</c:if>
					                            <span class="map_span"><b>${fa.favorites }</b>人拨打</span>
					                        </div>
				                    	</div>
				                    </a>
				                    <p class="calling">
				                    	<a href="javascript:phoneCalls2(${fa.shopId},'<%=basePath%>call/addCall');" id="phoneTel_${fa.shopId}">
				                    		<img src="<%=basePath %>resources/images/call.png">
				                    	</a>
				                    </p>
									<div class="list_delete"><img src="<%=basePath %>resources/images/shopping_11.png"/></div>
				                </li>
				             </c:forEach>
				          </c:when>
				          <c:otherwise>
				          	<p class="no_thing">
								<img src="<%=basePath %>resources/images/my_favorite/no_favorite.png" alt="没有收藏" />
								<em>您还没有任何收藏服务记录</em>
							</p>
				          </c:otherwise>
				      </c:choose>
	            </ul>
	        </div>
			<div class="message_info">
				<div class="title_info">确定删除此消息？</div>
				<div class="content_info">
					<input type="button" class="cancel" value="取消" />
					<input type="button" class="ensure" value="确定" />
				</div>
			</div>
			<div class="mark"></div>
        </div>
    	</body>		    	
	</c:otherwise>
</c:choose>			    	
				    	
<jsp:include page="../head/hideHead.jsp"></jsp:include>		    	
</html>
<!-- add by oyja -->
<script>
function phoneCalls2(shopId,url){
	$.ajax({
		   type: "POST",
		   url: url,
		   data:{"shop_id":shopId},
		   success: function(data)
		   {
		   	   if('${isPhone }' == 'true'){
					if('${isIosPhone }' == 'true'){
						self.location="OC://tag=43";
					}else{
						self.location="javascript:window.O2OHOME.CallPhone('"+data+"')";
					}
				}else{
				   $("#phoneTel_"+shopId).attr('href','tel:'+ data);
				   $("#phoneTel_"+shopId)[0].click(); 
				}
			   var phone = $('#phoneTimes_'+shopId).html();
//			   alert(phone);
			   $('#phoneTimes_'+shopId).html( Number(phone) + Number(1) );
	       },
	       error: function() {
	       		alert('error');
	       }
	});
}

    $(function(){
         //删去收藏
		$('.content li').on({
			'swipeLeft':function(){
				$('.content li').removeClass('li_swipeleft');
				$(this).addClass('li_swipeleft');
				var this_ = $(this).closest("li");
				var collect_id = $(this).children("input[name=favoriteIds]").val();
	            var shop_id = $(this).children("input[name=shopIds]").val();
				$(".list_delete").on("tap",function(){
					$(".message_info, .mark").show();
				});
				$(".cancel, .mark").on("tap",function(){
					$(".message_info, .mark").hide();
				});
				$(".ensure").off("tap");
				$(".ensure").on("tap",function(){
					$.ajax({
					      type: "post",
					      url: "<%=basePath%>favorite/collect",
					      data: {"collect_id":collect_id,"shop_id":shop_id},
					      success: function(data) {
					      	if(data){
								$(".message_info, .mark").hide();
								this_.hide();
								if($('.content li:visible').length == 0){
									$("#thelist2").html("<p class=\"no_thing\"><img src=\"/resources/images/my_favorite/no_favorite.png\" alt=\"没有收藏\" /><em>您还没有任何收藏服务记录</em></p>");
								}
					      	}else{
					      		return false;
					      	}
					      },
					      error: function() {
							 alert("取消失败");
					      }
					});
				});
				
			},
			'swipeRight': function(){
				$(this).removeClass('li_swipeleft');
			}
		})
    });
    
    function iosTest(){
    	//alert(111);
    	//window.MyCollectionsViewController.addWebViewWithURL('favorite/favoriteList?favoriteType=1');
    	document.location='objc://addWebViewWithURL:/1';
    }
</script>
