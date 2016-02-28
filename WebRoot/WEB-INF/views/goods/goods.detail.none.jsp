<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
	String source = request.getParameter("source");
	request.setAttribute("source",source);
	String tag = request.getParameter("tag");
	request.setAttribute("tag",tag);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath %>resources/js/common.js"></script>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=0.5,minimum-scale=0.5,maximum-scale=0.5, user-scalable=no">
<title>店铺详情</title>

<style type="text/css">	
	body{ background-color: white;}
	.back1{ float: left; width: 53px; height: 53px; background: url(/resources/images/back02.png) center center no-repeat; background-size: 100% 100%; position: fixed; top: 15px; left: 10px; z-index: 999;}
	/*store: information、evaluate、favorites*/
	.shop-information{ width: 100%; border: 1px solid #d5d4d6; background-color: white; overflow: hidden; padding-top: 48px;}
	.left-box, .right-box{ float: left; margin: 5px 0;}
	.left-box{ width: 65%;}
	.right-box{ width: 35%; position: relative;}
	.right-box .l-border{ height: 101px; border-left: 1px solid #d5d5d5; box-sizing: border-box; position: absolute; left: 0; top: 14px;}
		/*left-box: information、evaluate*/
	.left-smallbox{ float: left; width: 102px; height: 102px; line-height: 50px; padding: 15px 24px 15px 27px;}
	.left-smallbox .tx_img{ width: 102px; height: 102px; border-radius: 50%; -webkit-border-radius: 50%; -moz-border-radius: 50%;}
	.left-box .sec-box{ float: left;}
	.left-box .sec-box .p-title{margin: 15px 0 5px; font-size: 26px; color: #272728; letter-spacing: 1px;}
	.left-box .sec-box .p-title em{ padding-left: 3px; font-size: 28px; color: #e60012; font-family: "MS Serif", "New York", serif;}
	.left-box .starbox{ float: left; padding-top: 5px;}
	.left-box .starbox span{ display: inline-block; cursor: pointer;}
		/*right-box: favorites*/
	.right-smallbox{ float: left; width: 50px; height: 50px; margin: 40px 8px 0 25px;}
	.right-box .p-title1{ height: 50px; padding-top: 40px; line-height: 50px; font-size: 28px; color: #838a92; letter-spacing: 1px;}
	.right-box .p-title1 em{ padding-left: 5px; font-size: 26px;}
	/*store menus*/
	.menusbox{ position: relative; width: 100%; margin: 5px auto; overflow: hidden;}
	.goods-listbox{ width: 100%; background: white; overflow: hidden;}
	.goods-listbox ul{ width: 100%; margin-bottom: 2px; padding-bottom: 5px; background-color: white;}
	.goods-listbox ul li{ width: 94%; margin: 0 auto; overflow: hidden;}
	.goods-listbox .list-top{ width: 100%; border-bottom: 1px solid #d5d4d6; position: relative;}
	.list-top img{ float: left; width: 122px; height: 122px; margin: 28px 26px 17px 14px;}
	.list-top .g-title, .list-top .g-price{ font-size: 26px;}
	.list-top .g-title, .list-top .g-content{ width: 60%; letter-spacing: 2px; overflow: hidden;}
	.list-top .g-title{ padding: 27px 0 5px; color: #272728;}
	.list-top .g-content{ font-size: 20px; color: #858585; height: 40px;}
	.list-top .g-price{ color: #e60012; position: absolute; top: 35px; right: 2%; letter-spacing: 1px;}
	.tabs{ height: 43px; line-height: 43px; text-align: center; background-color: white;}
	.tabs a{ display:inline-block; width: 20px; height: 20px; margin: 0 6px; line-height: 40px; border-radius: 32px; background-color: #757c86;}
	.tabs a.active{ background: #eba123; border-radius:32px;}
	.swiper-container{ background: #fff; height: 510px; border-radius: 0 0 5px 5px; width:100%; border-top:0;}
	.swiper-slide{  width:100%; height:510px; background: none; color: #fff;}
	.menusbox .dots { position: absolute; left: 0; right: 0; bottom: 20px; text-align: center;}  
	.menusbox .dots li { display: inline-block; width: 15px; height: 15px; margin: 0 4px; text-indent: -999em; border: 2px solid #fff; border-radius: 50%; cursor: pointer; opacity: .4; -webkit-transition: background .5s, opacity .5s; -moz-transition: background .5s, opacity .5s; transition: background .5s, opacity .5s; background: #333;}  
	.menusbox .dots li.active { background: #eba123; opacity: 1; }
	/*shop hours, shop address(=shop hours01)*/
	.shop-hours, .shop-hours01{ width: 100%; border-bottom: 5px solid #dfdfdd; background: white; overflow: hidden;}
	.top-box, .bottom-box, .top-box01, .bottom-box01{ width: 90%; margin: 0 auto;}
	.top-box .left-title, .top-box01 .left-title01{ float: left; width: 40%; height: 40px; line-height: 40px; margin: 12px 0 23px;}
	.top-box .left-title img, .top-box01 .left-title01 img{ width: 40px; vertical-align: top;}
	.top-box .left-title span, .top-box01 .left-title01 span{ font-size: 26px; color: #272728; padding-left: 8px;}
	.top-box .right-time, .top-box01 .right-time01{ float: right; text-align: right;}
	.top-box .right-time .am, .top-box .right-time .pm{ font-size: 26px; color: #858585;}
	.top-box .right-time{  width: 60%; margin: 13px 0 23px;}
	.top-box01 .right-time01{  width: 26%;margin: 24px 0 23px;}
	.bottom-box{ padding-bottom: 20px;}
	.bottom-box ul{ width: 100%; text-align: center; overflow: hidden;}
	.bottom-box ul li{ display: inline-block; padding: 6px 8px; font-size: 26px; color: #272728; border: 1px solid #eba123; border-radius: 12px; box-sizing: border-box; outline: none;}
	.bottom-box ul li a{ color: #eba123;}
	.bottom-box ul .hit li{ color: #eba123;}
	.bottom-box01 p{ font-size: 24px; color: #858585; padding-left: 5px;}
	.page{ display: none; min-height: 24px; border: none;}
	.top-box01 .right-time01 span, .top-box01 .right-time01 em{ font-size: 20px; color: #858585;}
	.top-box01 .right-time01 em{ padding-left: 6px;}
	.bottom-box01{ margin-bottom: 5px;}
	.bottom-box01 .address-font{ display: inline-block; width: 98%; margin: 0 auto 30px; font-size: 25px; color: #757575; overflow: hidden;}
	/*intro*/
	.introbox{ width: 100%; background: white; overflow: hidden;}
	.introbox .int-title, .int-detail{ width: 90%; line-height: 30px; font-size: 26px; letter-spacing: 1px;}
	.introbox .int-detail{ margin: 0 auto 24px; color: #858585;}
	.introbox .int-title{ margin: 25px auto 32px; color: #858585;}
	/*evaluate*/
	.evaluatebox{ width: 100%; padding-bottom: 150px; background: white; overflow: hidden;}
	.evaluatebox .top-box01{ width: 90%; margin: 15px auto 5px; padding-bottom: 5px; border-bottom: 2px solid #eeeeef;}
	.top-box01 .eva-font, .top-box01 .eva-write{ font-size: 26px; color: #272728;}
	.top-box01 .eva-font{ float: left; padding-top: 5px; padding-left: 10px;}
	.top-box01 .eva-write{ float: right; padding: 5px 10px; border-radius: 16px; background-color: #eba123;}
	.evaluatebox .bottom-box01{ width: 90%; margin: 3px auto 5px; overflow: hidden;}
	.bottom-box01 ul{ width: 100%; margin-top: 6px}
	.bottom-box01 .fir-li{ float: left; width: 100%; min-height: 58px; line-height: 48px;}
	.bottom-box01 .fir-li img{ height: 52px; width: 52px;padding: 3px; vertical-align: bottom; border-radius: 50%; -webkit-border-radius: 50%; -moz-border-radius: 50%;}
	.bottom-box01 .fir-li .eva-name{ font-size: 24.72px; padding-left: 15px; color: #272728;}
	.bottom-box01 .fir-li .eva-time{ float: right; height: 33px; line-height: 33px; font-size: 17.98px; color: #858585;}
	.bottom-box01 .sec-li{ float: left; width: 100%; height: 37px; line-height: 37px;}
	.bottom-box01 .sec-li .eva-comment{ color: #392f3c;}
	.bottom-box01 .sec-li .mr3{ margin-right: 3px;}
	.bottom-box01 .sec-li .eva-imgbox{ float: right; width: 35px; height: 37px; margin-top: -3px;}
	.bottom-box01 .sec-li .eva-imgbox img{ vertical-align: middle;}
	.bottom-box01 .sec-li .eva-comment, .bottom-box01 .thr-li{ float: left; padding-left: 25px; font-size: 18px;}
	.bottom-box01 .thr-li{ width: 85%; color: #858585;}
	/*up Navigation*/
	.navup{ width: 100%; background-color: #323641; position: fixed; top: -1px; z-index: 1000;}
	.navup .foot-ul{ width: 100%; height: 48px; }
	.navup .foot-li{ float: left; width: 33.3333%; height: 48px; line-height: 48px; text-align: center;}
	/*Bottom Navigation*/
	.nav{ width: 100%; background-color: #323641; position: fixed; bottom: -1px; z-index: 1000;}
	.nav .foot-ul{ width: 100%; height: 88px; }
	.nav .foot-li{ float: left; width: 33.3333%; height: 88px; line-height: 88px; text-align: center;}
	.foot-ul a{ display: block; font-size: 26px; color: #eba123;}
	.foot-ul a img{ vertical-align: middle;}
	.nav .img-posi{ margin-top: -55px;}
	#correct, #share{ display: none; width: 33.3333%; line-height: 30px; border: none; position: absolute; z-index: 1001;}
	#correct ul, #share ul{ width: 100%;}
	#correct-li, #share-li{ outline: none;}
	#correct ul li, #share ul li{ width: 100%; font-size: 24px; text-align: center;  background-color: #eba123; overflow: hidden; z-index: 1002;}
	#correct ul li{ padding-top: 33px; color: #272728;}
	#correct ul .to-bottom, #share ul .to-bottom01{ display: block; width: 0; height: 0; margin-bottom: -10px; border: 10px solid #eba123; border-color: #eba123 #323641; border-width: 10px 10px 0 10px; position: absolute; right: 16.6666%; bottom: 0; overflow: hidden;}
	#share ul li{ padding-top: 10px;}
	#share ul li img{ width: 82px; vertical-align: text-top;}
	#share ul li p{ line-height: 30px; color: #272728;}
	/*sundry*/
	.main{ width: 100%; overflow: hidden;}
	.position-re{ position: relative;}
	.undisplay{ display: none;}
	.pabtom40{ padding-bottom: 40px;}
	.pabtom160{ padding-bottom: 160px;}
	.mr5{ margin-right: 5px;}
	.mask{ width: 100%; height: 100%; position: fixed;  background: rgba(255,255,255,0.1); left:0; right: 0; top: 0; bottom: 0; z-index: 99; display: none;}
	
	#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;display: none;} 
	.claim { display: block;margin: 5px 0; font-size: 20px; color: #fff; letter-spacing: 1px; border: none; background: #ffb402; padding: 3px 5px; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; -o-border-radius: 5px;}
</style>
</head>

<body>

<!-- 百度地图 -->
<div id="allmap"></div>  

	<div class="main">
		<div class="navup">
			<ul class="foot-ul">
			<a href="javascript:headClickEvent(0);"><li class="foot-li">服务</li></a>
			<a href="javascript:headClickEvent(1);"><li class="foot-li">评价</li></a>
			<a href="javascript:headClickEvent(2);"><li class="foot-li">商家</li></a>
			</ul>
		</div>
	
		<div class="shop-information">
			<div class="left-box">
			
				<div class="left-smallbox">
					<c:if test="${shop.logo != null}">
                		<img src="${shop.logo}" class="tx_img">
                	</c:if>
                	<c:if test="${shop.logo == null}">
                		<img src="<%=basePath %>resources/images/goods_picture.png" class="tx_img"> 
                	</c:if>
				</div>
				
				<div class="sec-box">
					<p class="p-title" id="title_name" >${fn:substring(shop.name,0,9) }<em><c:if test="${shop.auth==1}">V</c:if></em></p>
					<div>
						<c:choose>
							<c:when test="${authStatus ==  -1}">
								<input type="button" class="claim" value="认证中">
							</c:when>
							<c:when test="${authStatus ==  2}">
								<input type="button" class="claim" value="已认证">
							</c:when>
							<c:otherwise>
								<a style="cursor: pointer;" href="javascript:checkShopIsAuth();"><input type="button" class="claim" value="认领该店铺"></a>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="starbox">
						<c:choose>
							<c:when test="${shop.evaluates != null && shop.evaluates>0}">
								<c:set var="n" value="0"></c:set>
								<c:forEach begin="1" end="${score}">
									<c:set var="n" value="${n + 1}"></c:set>
									<span><a href="javascript:;"><img src="<%=basePath %>resources/images/star-bright.png"></a></span>
								</c:forEach>
								<c:if test="${n < 5}">
									<c:forEach begin="1" end="${5-n}">
										<span><a href="javascript:;"><img src="<%=basePath %>resources/images/star-dark.png"></a></span>
									</c:forEach>
								</c:if>
							</c:when>
							<c:otherwise>
								<span><a href="javascript:;"><img src="<%=basePath %>resources/images/star-bright.png"></a></span>
								<span><a href="javascript:;"><img src="<%=basePath %>resources/images/star-bright.png"></a></span>
								<span><a href="javascript:;"><img src="<%=basePath %>resources/images/star-bright.png"></a></span>
								<span><a href="javascript:;"><img src="<%=basePath %>resources/images/star-dark.png"></a></span>
								<span><a href="javascript:;"><img src="<%=basePath %>resources/images/star-dark.png"></a></span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>	
			</div>
			<div class="right-box">
			
				<form id="facorAjax" action="<%=basePath%>index/goodsDetailShop" method="post">
            		<input type="hidden" name="id" value="${shop.shopId}" >
            	</form>
            
				<c:choose>
	          		<c:when test="${requestScope.isFavorite eq 'yes' }">
		            	<a href="javascript:favorites('${userDetail.userId}','${shop.shopId}','${shop.name}',${requestScope.favoriteId});">
		                    <div class="right-smallbox">
		                        <img src="<%=basePath %>resources/images/goods-img033.png">
		                    </div>
	                </c:when>
	                <c:otherwise>
	                	<a href="javascript:favorites('${userDetail.userId}','${shop.shopId}','${shop.name}',null);">
		                    <div class="right-smallbox">
	                        	<img src="<%=basePath %>resources/images/goods-img03.png">
	                        </div>
	           		</c:otherwise>
	           	</c:choose>
					<p class="p-title1">收藏<em>${shop.favorites }</em></p>
					<span class="l-border"></span>
				</a>
			</div>
		</div>
		<c:if test="${fn:length(services)>0}">
        <div class="menusbox">
            <ul class="goods-listbox">  
			<!-- 服务1-3 -->
			<li>
				<c:forEach items="${services }" var="goods" varStatus="g" >
					<c:if test="${g.index < 4 }">
						<a href="javascript:;">
							<div class="list-top">
								<c:if test="${goods.path != null}">
									<img src="${goods.path}" width="80">
								</c:if>
								<c:if test="${goods.path == null}">
									<img src="<%=basePath %>resources/images/goods_picture.png" width="80" > 
								</c:if>
								<p class="g-title">${fn:substring(goods.name,0,10) }</p>
								<p class="g-content">${fn:substring(goods.summary,0,20) }</p>
								<span class="g-price">￥${goods.price }</span>
							</div>
						</a>
					</c:if>
				 </c:forEach>
			</li>
			<c:if test="${fn:length(services)>4}">
			<!-- 服务1-3 -->
			  <li>
					<c:forEach items="${services }" var="goods" varStatus="g" >
						<c:if test="${g.index >= 4 && g.index <8}">
							<a href="javascript:;">
								<div class="list-top">
								   <c:if test="${goods.path != null}">
										<img src="${goods.path}" width="80">
									</c:if>
									<c:if test="${goods.path == null}">
										<img src="<%=basePath %>resources/images/goods_picture.png" width="80" > 
									</c:if>
									
									<p class="g-title">${fn:substring(goods.name,0,10) }</p>
									<p class="g-content">${fn:substring(goods.summary,0,20) }</p>
									<span class="g-price">￥${goods.price }</span>
								</div>
							</a>
						</c:if>
					 </c:forEach>
				</li>
			</c:if>
			<c:if test="${fn:length(services)>7}">
			<!-- 服务1-3 --> 
			<li>
				<c:forEach items="${services }" var="goods" varStatus="g" >
					<c:if test="${g.index >= 8 && g.index <11 }">
						<a href="javascript:;">
							<div class="list-top">
								<c:if test="${goods.path != null}">
									<img src="${goods.path}" width="80">
								</c:if>
								<c:if test="${goods.path == null}">
									<img src="<%=basePath %>resources/images/goods_picture.png" width="80" > 
								</c:if>
								<p class="g-title">${fn:substring(goods.name,0,10) }</p>
								<p class="g-content">${fn:substring(goods.summary,0,20) }</p>
								<span class="g-price">￥${goods.price }</span>
							</div>
						</a>
					</c:if>
				 </c:forEach>
			</li>
			</c:if>
			</div>
			</div>
                
            </ul>
        </div>
        </c:if>
		<div class="shop-hours">
			<div class="top-box">
				<div class="page" style="display: block;">        
                    <div class="left-title"><img src="<%=basePath %>resources/images/goods-clock.png"><span>营业时间</span></div>
                    <div class="right-time"><em class="am">上午${shop.sndtime == null ? '09:00' : shop.sndtime}</em>-<em class="pm">下午${shop.endtime == null ? '22:00' : shop.endtime}</em></div>
                </div>
			</div>
			<div class="bottom-box">
				<ul>
					<c:if test="${shop.w1 ==1 }">
            			<a href="javascript:;" class="hit"><li class="mr5">周一</li></a>
            		</c:if>
            		<c:if test="${shop.w1 ==0 }">
            			<a href="javascript:;" ><li class="mr5">周一</li></a>
            		</c:if>
            		
            		<c:if test="${shop.w2 ==1 }">
            			<a href="javascript:;" class="hit"><li class="mr5">周二</li></a>
            		</c:if>
            		<c:if test="${shop.w2 ==0 }">
            			<a href="javascript:;"><li class="mr5">周二</li></a>
            		</c:if>
            		
                	<c:if test="${shop.w3 ==1 }">
            			<a href="javascript:;" class="hit"><li class="mr5">周三</li></a>
            		</c:if>
            		<c:if test="${shop.w3 ==0 }">
            			<a href="javascript:;"><li class="mr5">周三</li></a>
            		</c:if>
            		
            		<c:if test="${shop.w4 ==1 }">
            			<a href="javascript:;" class="hit"><li class="mr5">周四</li></a>
            		</c:if>
            		<c:if test="${shop.w4 ==0 }">
            			<a href="javascript:;"><li class="mr5">周四</li></a>
            		</c:if>
            		
            		<c:if test="${shop.w5 ==1 }">
            			<a href="javascript:;" class="hit"><li class="mr5">周五</li></a>
            		</c:if>
            		<c:if test="${shop.w5 ==0 }">
            			<a href="javascript:;"><li class="mr5">周五</li></a>
            		</c:if>
            		
            		<c:if test="${shop.w6 ==1 }">
            			<a href="javascript:;" class="hit"><li class="mr5">周六</li></a>
            		</c:if>
            		<c:if test="${shop.w6 ==0 }">
            			<a href="javascript:;"><li class="mr5">周六</li></a>
            		</c:if>
            		
            		<c:if test="${shop.w7 ==1 }">
            			<a href="javascript:;" class="hit"><li class="mr5">周日</li></a>
            		</c:if>
            		<c:if test="${shop.w7 ==0 }">
            			<a href="javascript:;"><li class="mr5">周日</li></a>
            		</c:if>
				</ul>
			</div>
		</div>
		<div class="shop-hours01">
			<div class="top-box01">
				<!--<a href="javascript:baiduMap('${shop.longitude}','${shop.latitude}');">
					--><div class="left-title01"><img src="<%=basePath %>resources/images/goods-maps.png"><span>商家地址</span></div>
				<!--</a>
				--><div class="right-time01"><span>距离:</span><em>${shop.distance }</em></div>
				<div class="right-time01"><span>服务范围:</span><em>${shop.rangeStr }</em></div>
			</div>
			<div class="bottom-box01">
				<!--<a href="javascript:baiduMap('${shop.longitude}','${shop.latitude}');">
					--><span class="address-font">${shop.address}</span>
				<!--</a>
			--></div>
		</div>
		<div class="introbox pabtom160">
			<div class="int-title">${shop.name}</div>
			<div class="int-detail">
				<c:if test="${not empty shop.summary}">${shop.summary }</c:if>
				<c:if test="${empty shop.summary}">具体的服务要求请电话咨询商家，致电商家时请告知是在"好站点"上发现的此商家。</c:if>
			</div>
		</div>
	<%--	
		<div class="evaluatebox">
			<div class="top-box01">
				<p class="eva-font">评价<em>（${empty comments||fn:length(comments) == 0 ?"暂无评价":shop.evaluates }）</em></p>
<!--				<a href="/comment/getEvaluate?id=${shop.shopId}"><span class="eva-write">去评价</span></a>-->
			</div>
			<c:if test="${empty comments||fn:length(comments)==0}">
				<div class="bottom-box01">
					<p>成为第一个评价的用户吧!</p>
				</div>
			</c:if>
			<c:if test="${not empty comments&&fn:length(comments)>0}">
<!--			<a href="comment/evaluateAll?id=${shop.shopId}">-->
            <div class="bottom-box01">
            	<c:forEach items="${comments}" var="comment" varStatus="c_g" >
            	<ul>
                	<li class="fir-li">
                    	<img src="${comment.headImg }">
                        <span class="eva-name">${comment.username }</span>
                        <span class="eva-time"><fmt:formatDate value='${comment.ctime }' pattern='yyyy-MM-dd HH:mm:ss' /></span>
                    </li>
                    <li class="sec-li">
                    	<div class="eva-comment">
                        	<span class="mr3">质量<em>${comment.quality }</em></span>
                            <span class="mr3">速度<em>${comment.speed }</em></span>
                            <span class="mr3">服务<em>${comment.service }</em></span>
                            <span class="mr3">态度<em>${comment.attitude }</em></span>
                        </div>
                        <span class="eva-imgbox"><img src="<%=basePath %>resources/images/goods-img10.png"></span>
                    </li>
                    <li class="thr-li">${comment.content }</li>
                </ul>
                </c:forEach>
            </div>
<!--            </a>-->
            </c:if>
	  </div> 
	 --%>  
	  <div class="nav">
		<ul class="position-re foot-ul" >
			<div id="correct">
				<ul class="position-re">
					<a href="javascript:shopError('${shop.shopId}','1');"><li onclick="clickkim()">电话无人接听</li></a>
                    <a href="javascript:shopError('${shop.shopId}','2');"><li onclick="clickkim()">电话号码错误</li></a>
                    <a href="javascript:shopError('${shop.shopId}','3');"><li onclick="clickkim()" class="pabtom40">商家信息错误</li></a>
					<em class="to-bottom"></em>
				</ul>
			</div>
			<a href="javascript:;"><li class="foot-li" id="correct-li">
				<img src="<%=basePath %>resources/images/goods-img07.png" />
				<span>纠错</span>
			</li></a>
			<a href="javascript:phoneCalls2(${shop.shopId},'<%=basePath%>call/addCall');"  id="phoneTel_${shop.shopId}" >
				<li class="foot-li position-re">
					<img class="img-posi" src="<%=basePath %>resources/images/goods-call.png" />
				</li></a>
			<div id="share">
				<ul class="position-re">
					<a href="javascript:;" class="jiathis_button_qzone"><li onclick="clickkimil()"><img src="<%=basePath %>resources/images/goods-share01.png"><p>QQ空间</p></li></a>
					<a href="javascript:;" class="jiathis_button_tsina"><li onclick="clickkimil()" class="pabtom40"><img src="<%=basePath %>resources/images/goods-share02.png"><p>新浪微博</p></li></a>
<!--					<a href="javascript:;"><li><img src="<%=basePath %>resources/images/goods-share03.png"><p>朋友圈</p></li></a>-->
<!--					<a href="javascript:;"><li class="pabtom40"><img src="<%=basePath %>resources/images/goods-share04.png"><p>微信</p></li></a>-->
					<em class="to-bottom01"></em>
				</ul>
			</div>
			<a href="javascript:;"><li class="foot-li" id="share-li">
				<img src="<%=basePath %>resources/images/goods-img08.png" />
				<span>分享</span>
			</li></a>
		</ul>
	</div>
	</div>
	<div class="mask"></div>
	<jsp:include page="../head/hideHead.jsp"></jsp:include>
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
					$("#facorAjax").submit();
	        	}else if ("2" == data){
	        	}else{
	        	}
			}  
		});  
}

</script>
	
</body>
</html>
<script type="text/javascript" src="http://v2.jiathis.com/code/jia.js" charset="utf-8"></script> 
<script type="text/javascript" src="http://api.map.baidu.com/api?ak=DqTGazNxpb6tujm41W2ULrtb&v=2.0&services=true"></script>  

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
	        		$("#correct").slideToggle(100);
	        		alert('纠错成功');
	        	}else{
	        		alert('已有纠错记录，请等待修复！');
	        		$("#correct").slideToggle(100);
	        	}
			}  
		});  
}


//创建和初始化地图
function baiduMap(longitude,latitude){
	$("#allmap").show();
	$('.main').hide();
	 	createMap(longitude,latitude);//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
        addMarker();//向地图中添加marker
}
    //创建地图函数：
    function createMap(longitude,latitude){
        var map = new BMap.Map("allmap");//在百度地图容器中创建一个地图
        var point = new BMap.Point(longitude,latitude);//定义一个中心点坐标
        map.centerAndZoom(point,18);//设定地图的中心点和坐标并将地图显示在地图容器中
        window.map = map;//将map变量存储在全局
    }
    
    //地图事件设置函数：
    function setMapEvent(){
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom(true);//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }
    
    //地图控件添加函数：
    function addMapControl(){
        //向地图中添加缩放控件
        var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
        map.addControl(ctrl_nav);
                //向地图中添加比例尺控件
        var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
        map.addControl(ctrl_sca);
    }
//    alert('');
    //标注点数组
    var markerArr = [{title:"${shop.name}",content:"${mapSummary}...",point:"${shop.longitude}|${shop.latitude}",isOpen:0,icon:{w:23,h:25,l:46,t:21,x:9,lb:12}}];
    //创建marker
    function addMarker(){
        for(var i=0;i<markerArr.length;i++){
            var json = markerArr[i];
            var p0 = json.point.split("|")[0];
            var p1 = json.point.split("|")[1];
            var point = new BMap.Point(p0,p1);
                        var iconImg = createIcon(json.icon);
            var marker = new BMap.Marker(point,{icon:iconImg});
                        var iw = createInfoWindow(i);
                        var label = new BMap.Label(json.title,{"offset":new BMap.Size(json.icon.lb-json.icon.x+10,-20)});
                        marker.setLabel(label);
            map.addOverlay(marker);
            label.setStyle({
                        borderColor:"#808080",
                        color:"#333",
                        cursor:"pointer"
            });
                        
                        (function(){
                                var index = i;
                                var _iw = createInfoWindow(i);
                                var _marker = marker;
                                _marker.addEventListener("click",function(){
                                    this.openInfoWindow(_iw);
                            });
                            _iw.addEventListener("open",function(){
                                    _marker.getLabel().hide();
                            })
                            _iw.addEventListener("close",function(){
                                    _marker.getLabel().show();
                            })
                                label.addEventListener("click",function(){
                                    _marker.openInfoWindow(_iw);
                            })
                                if(!!json.isOpen){
                                        label.hide();
                                        _marker.openInfoWindow(_iw);
                                }
                        })()
        }
    }
    //创建InfoWindow
    function createInfoWindow(i){
        var json = markerArr[i];
        var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.title + "'>" + json.title + "</b><div class='iw_poi_content'>"+json.content+"</div>");
        return iw;
    }
    //创建一个Icon
    function createIcon(json){
        var icon = new BMap.Icon("http://app.baidu.com/map/images/us_mk_icon.png", new BMap.Size(json.w,json.h),{imageOffset: new BMap.Size(-json.l,-json.t),infoWindowOffset:new BMap.Size(json.lb+5,1),offset:new BMap.Size(json.x,json.h)})
        return icon;
    }



//menusbox
$(function(){
	/*
	$(".menusbox").unslider({
		speed: 500,               //  The speed to animate each slide (in milliseconds)
		delay: false,              //  The delay between slide animations (in milliseconds)
		complete: function() {},  //  A function that gets called after every slide animation
		keys: true,               //  Enable keyboard (left, right) arrow shortcuts
		dots: true,               //  Display dot navigation
		fluid: false              //  Support responsive design. May break non-responsive designs
	});
	*/
	
	var slides = jQuery('.menusbox'),
    		i = 0;
 	slides.on('swipeleft', function(e) {
		unslider.prev();
	}).on('swiperight', function(e) {
		unslider.next();
	});
});

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

//shop-information
$(function(){
	$(".right-box").css("height",$(".left-box").height() + "px");
});
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

$(function(){
	var messsageCode = '${requestScope.messageCode}';
	if(messsageCode != ''){
		if(messsageCode == '-204'){
			alert('您已有店铺，不能认证');
		}else if(messsageCode == '-205'){
			alert('店铺已认证');
		}else if(messsageCode == '-203'){
			alert('您已认证过，不能多次认证');
		}
	}
});

//tab点击跳转
function headClickEvent(index){
	if(index==0){
		self.location="<%=basePath%>index/goodsDetailService?id=${shop.shopId}";
	}
	else if(index==1){
		self.location="<%=basePath%>index/goodsDetailComment?id=${shop.shopId}";
	}
	else if(index==2){
		self.location="<%=basePath%>index/goodsDetailShop?id=${shop.shopId}";
	}
}
</script>