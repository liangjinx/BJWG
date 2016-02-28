<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=0.5,minimum-scale=0.5,maximum-scale=0.5, user-scalable=no">
<title>店铺详情t</title>

<style type="text/css">	
	.back1{ float: left; width: 53px; height: 53px; background: url(/resources/images/back02.png) center center no-repeat; background-size: 100% 100%; position: fixed; top: 15px; left: 10px; z-index: 999;}
	/*store: information、evaluate、favorites*/
	.shop-information{ width: 100%; border: 1px solid #d5d4d6; background-color: white; overflow: hidden;}
	.left-box, .right-box{ float: left; margin: 5px 0;}
	.left-box{ width: 69%;}
	.right-box{ width: 31%; position: relative;}
	.right-box .l-border{ height: 101px; border-left: 1px solid #d5d5d5; box-sizing: border-box; position: absolute; left: 0; top: 14px;}
		/*left-box: information、evaluate*/
	.left-smallbox{ float: left; width: 102px; height: 102px; line-height: 50px; padding: 15px 24px 15px 27px;}
	.left-box .p-title{ margin: 28px 5px 5px; font-size: 26px; color: #272728; letter-spacing: 1px;}
	.left-box .p-title em{ padding-left: 3px; font-size: 28px; color: #e60012; font-family: "MS Serif", "New York", serif;}
	.left-box .starbox{ float: left; padding-top: 10px;}
	.left-box .starbox span{ display: inline-block; cursor: pointer;}
		/*right-box: favorites*/
	.right-smallbox{ float: left; width: 50px; height: 50px; margin: 40px 10px 0 30px;}
	.right-box .p-title1{ height: 50px; padding-top: 40px; line-height: 50px; font-size: 30px; color: #838a92; letter-spacing: 1px;}
	.right-box .p-title1 em{ padding-left: 5px;}
	/*store menus*/
	.menusbox{ width: 100%; margin: 5px auto; background: url(/resources/images/border-bg.png) 0 top no-repeat; background-size: 100% 100%; overflow: hidden;}
	.goods-listbox{ width: 100%; overflow: hidden;}
	.goods-listbox ul{ width: 100%; margin-bottom: 2px; padding-bottom: 5px; background-color: white;}
	.goods-listbox ul li{ width: 94%; margin: 0 auto; overflow: hidden;}
	.goods-listbox .list-top{ width: 100%; border-bottom: 1px solid #d5d4d6; position: relative;}
	.list-top img{ float: left; width: 122px; height: 122px; margin: 28px 26px 17px 14px;}
	.list-top .g-title, .list-top .g-price{ font-size: 26px;}
	.list-top .g-title, .list-top .g-content{ letter-spacing: 2px;}
	.list-top .g-title{ padding: 27px 0 5px; color: #272728;}
	.list-top .g-content{ font-size: 20px; color: #858585;}
	.list-top .g-price{ color: #e60012; position: absolute; top: 35px; right: 2%; letter-spacing: 1px;}
	.tabs{ height: 43px; line-height: 43px; text-align: center; background-color: white;}
	.tabs a{ display:inline-block; width: 20px; height: 20px; margin: 0 6px; line-height: 40px; border-radius: 32px; background-color: #757c86;}
	.tabs a.active{ background: #eba123; border-radius:32px;}
	.swiper-container{ background: #fff; height: 510px; border-radius: 0 0 5px 5px; width:100%; border-top:0;}
	.swiper-slide{  width:100%; height:510px; background: none; color: #fff;}
	/*shop hours, shop address(=shop hours01)*/
	.shop-hours, .shop-hours01{ width: 100%; margin-bottom: 5px; background: white; overflow: hidden;}
	.top-box, .bottom-box, .top-box01, .bottom-box01{ width: 90%; margin: 0 auto;}
	.top-box .left-title, .top-box01 .left-title01{ float: left; width: 40%; height: 40px; line-height: 40px; margin: 12px 0 23px;}
	.top-box .left-title img, .top-box01 .left-title01 img{ width: 40px; vertical-align: top;}
	.top-box .left-title span, .top-box01 .left-title01 span{ font-size: 26px; color: #272728; padding-left: 8px;}
	.top-box .right-time, .top-box01 .right-time01{ float: left; text-align: right;}
	.top-box .right-time .am, .top-box .right-time .pm{ font-size: 26px; color: #858585;}
	.top-box .right-time{  width: 60%; margin: 13px 0 23px;}
	.top-box01 .right-time01{  width: 30%;margin: 24px 0 23px;}
	.bottom-box{ padding-bottom: 20px;}
	.bottom-box ul{ width: 100%; text-align: center; overflow: hidden;}
	.bottom-box ul li{ display: inline-block; padding: 6px 8px; font-size: 26px; color: #eba123; border: 1px solid #eba123; border-radius: 12px; box-sizing: border-box; outline: none;}
	.bottom-box ul li a{ color: #eba123;}
	.bottom-box ul .hit li{ color: #272728;}
	.bottom-box01 p{ font-size: 24px; color: #858585; padding-left: 5px;}
	.page{ display: none; min-height: 24px; border: none;}
	.top-box01 .right-time01 span, .top-box01 .right-time01 em{ font-size: 20px; color: #858585;}
	.top-box01 .right-time01 em{ padding-left: 6px;}
	.bottom-box01{ margin-bottom: 5px;}
	.bottom-box01 .address-font{ display: inline-block; width: 98%; margin: 0 auto 30px; font-size: 25px; color: #757575; text-align: center; overflow: hidden;}
	/*intro*/
	.introbox{ width: 100%; padding-bottom: 10px; margin-bottom: 5px; background: white; overflow: hidden;}
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
	.bottom-box01 .fir-li{ float: left; width: 100%; height: 58px; line-height: 48px;}
	.bottom-box01 .fir-li img{ padding: 3px; vertical-align: bottom;}
	.bottom-box01 .fir-li .eva-name{ font-size: 24.72px; padding-left: 15px; color: #272728;}
	.bottom-box01 .fir-li .eva-time{ float: right; height: 33px; line-height: 33px; font-size: 17.98px; color: #858585;}
	.bottom-box01 .sec-li{ float: left; width: 100%; height: 37px; line-height: 37px;}
	.bottom-box01 .sec-li .eva-comment{ color: #392f3c;}
	.bottom-box01 .sec-li .mr3{ margin-right: 3px;}
	.bottom-box01 .sec-li .eva-imgbox{ float: right; width: 35px; height: 37px; margin-top: -3px;}
	.bottom-box01 .sec-li .eva-imgbox img{ vertical-align: middle;}
	.bottom-box01 .sec-li .eva-comment, .bottom-box01 .thr-li{ float: left; padding-left: 25px; font-size: 18px;}
	.bottom-box01 .thr-li{ width: 85%; color: #858585;}
	/*Bottom Navigation*/
	.nav{ width: 100%; background-color: #323641; position: fixed; bottom: -1px; z-index: 10;}
	.nav .foot-ul{ width: 100%; height: 88px; }
	.nav .foot-li{ float: left; width: 33.3333%; height: 88px; line-height: 88px; text-align: center;}
	.foot-li a{ display: block; font-size: 26px; color: #eba123;}
	.foot-li a img{ vertical-align: middle;}
	.position-re{ position: relative;}
	.nav .img-posi{ margin-top: -50px;}
	#correct, #share{ display: none; width: 33.3333%; line-height: 30px; border: none; position: absolute;}
	#correct ul, #share ul{ width: 100%;}
	#correct ul li, #share ul li{ width: 100%; font-size: 24px; text-align: center;  background-color: #eba123; overflow: hidden;}
	#correct ul li{ padding-top: 33px;}
	#correct ul .to-bottom, #share ul .to-bottom01{ display: block; width: 0; height: 0; margin-bottom: -10px; border: 10px solid #eba123; border-color: #eba123 #323641; border-width: 10px 10px 0 10px; position: absolute; right: 16.6666%; bottom: 0; overflow: hidden;}
	#share ul li{ padding-top: 10px;}
	#share ul li img{ width: 82px; vertical-align: text-top;}
	#share ul li p{ line-height: 30px;}
	/*sundry*/
	.main{ width: 100%; overflow: hidden;}
	.undisplay{ display: none;}
	.pabtom40{ padding-bottom: 40px;}
	.mr5{ margin-right: 5px;}
</style>
</head>

<body>
	<div class="main">
    	<a class="back1" href="javascript:history.back(-1)"></a>
        <div class="shop-information">
        	<div class="left-box">
            	<div class="left-smallbox">
                	<img src="<%=basePath %>resources/images/goods-img02.png">
                </div>
                <p class="p-title"> ${shop.name} <em>V</em></p>
                <div class="starbox">
                    <span><a href="javascript:;"><img src="<%=basePath %>resources/images/star-dark.png"></a></span>
                    <span><a href="javascript:;"><img src="<%=basePath %>resources/images/star-dark.png"></a></span>
                    <span><a href="javascript:;"><img src="<%=basePath %>resources/images/star-dark.png"></a></span>
                    <span><a href="javascript:;"><img src="<%=basePath %>resources/images/star-dark.png"></a></span>
                    <span><a href="javascript:;"><img src="<%=basePath %>resources/images/star-dark.png"></a></span>
                </div>
            </div>
            <div class="right-box">
            	<a href="javascript:;">
                    <div class="right-smallbox">
                        <img src="<%=basePath %>resources/images/goods-img03.png">
                    </div>
                    <p class="p-title1">收藏${fn:length(services)}<em> ${shop.favorites } </em></p>
                    <span class="l-border"></span></a>
            </div>
        </div>
        <div class="menusbox">
            <div class="goods-listbox">  
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <!-- 服务1-3 -->
                        <div class="swiper-slide">
                           <div class="content-slide">    
                              <ul>
                                <c:forEach items="${services }" var="goods" varStatus="g" >
                                 	<c:if test="${g.index < 3 }">
	                                    <a href="javascript:;">
		                                    <li>
		                                        <div class="list-top">
		                                            <img src="<%=basePath %>resources/images/goods-picture.png" width="80">
		                                            <p class="g-title">${goods.name }${g.index }</p>
		                                            <p class="g-content">${goods.summary }</p>
		                                            <span class="g-price">￥${goods.price }</span>
		                                        </div>
		                                    </li>
	                                    </a>
                                    </c:if>
                                 </c:forEach>
                              	</ul>
                         	</div>
                      	</div>
                        
                        <!-- 服务1-3 -->
                        <div class="swiper-slide">
                           <div class="content-slide">    
                              <ul>
                                <c:forEach items="${services }" var="goods" varStatus="g" >
                                 	<c:if test="${g.index >= 3 && g.index <6}">
	                                    <a href="javascript:;">
		                                    <li>
		                                        <div class="list-top">
		                                            <img src="<%=basePath %>resources/images/goods-picture.png" width="80">
		                                            <p class="g-title">${goods.name }${g.index }</p>
		                                            <p class="g-content">${goods.summary }</p>
		                                            <span class="g-price">￥${goods.price }</span>
		                                        </div>
		                                    </li>
	                                    </a>
                                    </c:if>
                                 </c:forEach>
                              	</ul>
                         	</div>
                      	</div>
                      	<!-- 服务1-3 -->
                        <div class="swiper-slide">
                           <div class="content-slide">    
                              <ul>
                                <c:forEach items="${services }" var="goods" varStatus="g" >
                                 	<c:if test="${g.index >= 6 && g.index <9 }">
	                                    <a href="javascript:;">
		                                    <li>
		                                        <div class="list-top">
		                                            <img src="<%=basePath %>resources/images/goods-picture.png" width="80">
		                                            <p class="g-title">${goods.name }${g.index }</p>
		                                            <p class="g-content">${goods.summary }</p>
		                                            <span class="g-price">￥${goods.price }</span>
		                                        </div>
		                                    </li>
	                                    </a>
                                    </c:if>
                                 </c:forEach>
                              	</ul>
                         	</div>
                      	</div>
                        
                     </div>
                 </div>
                 <div class="tabs">
                    <a href="javascript:;" hidefocus="true" class="active"></a>
                    <a href="javascript:;" hidefocus="true"></a>
                    <a href="javascript:;" hidefocus="true"></a>
                </div> 
            </div>
        </div>
        <div class="shop-hours">
        	<div class="top-box">
            	<div class="page" style="display: block;">        
                    <div class="left-title"><img src="<%=basePath %>resources/images/goods-clock.png"><span>营业时间</span></div>
                    <div class="right-time"><em class="am">上午09:00</em>-<em class="pm">下午09:00</em></div>
                </div>
                <div class="page">        
                    <div class="left-title"><img src="<%=basePath %>resources/images/goods-clock.png"><span>营业时间</span></div>
                    <div class="right-time"><em class="am">上午09:10</em>-<em class="pm">下午09:10</em></div>
                </div>
                <div class="page">        
                    <div class="left-title"><img src="<%=basePath %>resources/images/goods-clock.png"><span>营业时间</span></div>
                    <div class="right-time"><em class="am">上午09:20</em>-<em class="pm">下午09:20</em></div>
                </div>
                <div class="page">        
                    <div class="left-title"><img src="<%=basePath %>resources/images/goods-clock.png"><span>营业时间</span></div>
                    <div class="right-time"><em class="am">上午09:30</em>-<em class="pm">下午09:30</em></div>
                </div>
                <div class="page">        
                    <div class="left-title"><img src="<%=basePath %>resources/images/goods-clock.png"><span>营业时间</span></div>
                    <div class="right-time"><em class="am">上午09:40</em>-<em class="pm">下午09:40</em></div>
                </div>
                <div class="page">        
                    <div class="left-title"><img src="<%=basePath %>resources/images/goods-clock.png"><span>营业时间</span></div>
                    <div class="right-time"><em class="am">上午09:50</em>-<em class="pm">下午09:50</em></div>
                </div>
                <div class="page">        
                    <div class="left-title"><img src="<%=basePath %>resources/images/goods-clock.png"><span>营业时间</span></div>
                    <div class="right-time"><em class="am">上午10:00</em>-<em class="pm">下午10:00</em></div>
                </div>
            </div>
            <div class="bottom-box">
            	<ul>
                	<a href="javascript:;" class="hit"><li class="mr5">周一</li></a>
                    <a href="javascript:;"><li class="mr5">周二</li></a>
                    <a href="javascript:;"><li class="mr5">周三</li></a>
                    <a href="javascript:;"><li class="mr5">周四</li></a>
                    <a href="javascript:;"><li class="mr5">周五</li></a>
                    <a href="javascript:;"><li class="mr5">周六</li></a>
                    <a href="javascript:;"><li class="mr5">周日</li></a>
                </ul>
            </div>
        </div>
        <div class="shop-hours01">
        	<div class="top-box01">
            	<div class="left-title01"><img src="<%=basePath %>resources/images/goods-maps.png"><span>商家地址</span></div>
                <div class="right-time01"><span>距离 :</span><em>1.3km</em></div>
                <div class="right-time01"><span>服务范围 :</span><em>${shop.rangeStr }</em></div>
            </div>
            <div class="bottom-box01">
            	<span class="address-font">${shop.address }</span>
            </div>
        </div>
        <div class="introbox">
        	<div class="int-title">${shop.name }</div>
            <div class="int-detail">${shop.summary }具体的服务要求请电话咨询商家，致电商家时请告知是在"好站点"上发现的此商家。</div>
        </div>
      <div class="evaluatebox">
        	<div class="top-box01">
            	<p class="eva-font">评价<em>（${shop.evaluates == 0 ?"暂无评价":"shop.evaluates" }）</em></p>
                <a href="<%=basePath%>comment/getEvaluate?id=${shop.userId}"><span class="eva-write">去评价</span></a>
            </div>
            <div class="bottom-box01">
            	<p>成为第一个评价的用户吧!</p>
            </div>
      </div>
      <div class="nav">
        <ul class="position-re foot-ul" >
        	<div id="correct">
            	<ul class="position-re">
                	<li>电话无人接听</li>
                    <li>电话号码错误</li>
                    <li class="pabtom40">商家信息错误</li>
                    <em class="to-bottom"></em>
                </ul>
            </div>
            <li class="foot-li" id="correct-li">
                <a class="size2 "><img src="<%=basePath %>resources/images/goods-img07.png" />
                <span>纠错</span></a>
            </li>
            <li class="foot-li position-re">
                <a class="size2"><img class="img-posi" src="<%=basePath %>resources/images/goods-call.png" /></a>
            </li>
            <div id="share">
            	<ul class="position-re">
                	<li><img src="<%=basePath %>resources/images/goods-share01.png"><p>QQ空间</p></li>
                    <li><img src="<%=basePath %>resources/images/goods-share02.png"><p>新浪微博</p></li>
                    <li><img src="<%=basePath %>resources/images/goods-share03.png"><p>朋友圈</p></li>
                    <li class="pabtom40"><img src="<%=basePath %>resources/images/goods-share04.png"><p>微信</p></li>
                    <em class="to-bottom01"></em>
                </ul>
            </div>
            <li class="foot-li" id="share-li">
                <a class="size2"><img src="<%=basePath %>resources/images/goods-img08.png" />
                <span>分享</span></a>
            </li>
        </ul>
    </div>
    </div>
</body>
<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>
<script type="text/javascript">
//menusbox
$(function(){
	var tabsSwiper = new Swiper('.swiper-container',{
		speed:500,
		onSlideChangeStart: function(){
			$(".tabs .active").removeClass('active');
			$(".tabs a").eq(tabsSwiper.activeIndex).addClass('active');
		}
	});
	
	$(".tabs a").on('touchstart mousedown',function(e){
		e.preventDefault()
		$(".tabs .active").removeClass('active');
		$(this).addClass('active');
		tabsSwiper.swipeTo($(this).index());
	});
	
	$(".tabs a").click(function(e){
		e.preventDefault();
	});
});

//nav
$(function(){
	$("#correct-li").click(function(){
		$("#correct").slideToggle(600);
		$("#correct").css({"bottom":"100%","left":"0"});
		$("#correct ul .to-bottom").css("left",$("#correct").width()/2-11 +"px");
	});
	$("#share-li").click(function(){
		$("#share").slideToggle(600);
		$("#share").css({"bottom":"100%","right":"0"});
		$("#share ul .to-bottom01").css("left",$("#share").width()/2-11 +"px");
	});
})


//shop-information
$(function(){
	$(".right-box").css("height",$(".left-box").height() + "px");
});

//shop-hours
$(function(){
	$(".bottom-box ul a").click(function(){
		$(this).addClass("hit").siblings().removeClass("hit");
		$(".top-box>div:eq("+$(this).index()+")").show().siblings().hide();
	});
});
</script>
