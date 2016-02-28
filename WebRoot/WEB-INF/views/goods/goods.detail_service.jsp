<%@page import="com.bjwg.main.util.ToolKit"%>
<%@page import="com.bjwg.main.util.RenderUtils"%>
<%@page import="com.bjwg.main.model.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
	String source = request.getParameter("source");
	request.setAttribute("source",source);
	String tag = request.getParameter("tag");
	request.setAttribute("tag",tag);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/module.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/swiper3.07.min.css">
		
		<script src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
		<script src="<%=basePath %>resources/js/fastclick.js"></script>
		<script type="text/javascript" src="<%=basePath %>resources/js/common.js"></script>
		<script type="text/javascript" src="<%=basePath %>resources/js/swiper3.07.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>resources/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="<%=basePath %>resources/js/gouwuche.js"></script>
		
		
		<title>好站点，您身边的上门服务!</title>
		<style type="text/css">
        	/*content*/
        	h6,h2,h3,h4,h6,h6{
				font-weight:normal;
				font-size:1.4rem;
			}
			html,body{
				width:100%;
			}
			*{
				box-sizing: border-box;
				-webkit-box-sizing: border-box;
				-moz-box-sizing: border-box;
			}
			html,body{height:100%;overflow:hidden;}
			.d_deader,.d_footer{position:absolute;}
			.d_content{padding:0;}
			.details_merchant_footer{z-index:200;}
			.details_merchant_serve{position:relative;}
			.merchant_left{width:33%;height:100%;text-align:center;background:#ecedf1;float:left;}
			.merchant_left span{position:relative;display:block;font-size:1.6rem;height:50px;line-height:50px;border-bottom:1px solid #d8d9dd;}
			.merchant_left span.current_color{background:#fff;color:#ffb402;}
			.merchant_left span.current_color:before{content:'';display:inline-block;position:absolute;top:0;left:0;width:5px;height:inherit;background:#ffb402;}
			.merchant_right{width:67%;float:left;padding-left:10px;overflow:auto;-webkit-overflow-scrolling: touch;position:absolute;top:0;right:0;bottom:0;}
			.d_h6{height:30px;line-height:30px;background:#ecedf1;font-size:1.4rem;text-indent:12px;border-left:5px solid #dadadc;}
			.merchant_right_list{position:relative;padding:10px 10px 10px 0;background:#fff;border-bottom:1px solid #d9d9d9;color:inherit;font-size:inherit;display:block;overflow:hidden;}
			.merchant_right_list div{float:left;}
			.merchant_right_list .right_img{width:64px;height:64px;}
			.merchant_right_list .right_img img{width:100%;height:100%;}
			.merchant_right_list .right_text{width:60%;height:64px;position:relative;margin-left:10px;font-size:1.4rem;}
			.merchant_right_list .right_text p:nth-child(2){font-size:1.1rem;color:#858386;}
			.merchant_right_list .right_text p:last-child{color:#ffb402;position:absolute;bottom:0;}
			.right_add{position:absolute;right:0;top:10px;height:64px;}
			.right_add span{display:block;width:40px;height:inherit;float:left;text-align:center;line-height:64px;}
			.right_add .num{width:20px;}
			.right_add .add{background:url(/resources/images/details/add.png) no-repeat center center;background-size:24px auto;float:right;}
			.merchant_right_list .right_add .sub{display:none;}
			.merchant_right_list .right_add .num{display:none;}
			.merchant_right_list .right_add_show .sub{display:block;}
			.merchant_right_list .right_add_show .num{display:block;}
			.right_add .sub{background:url(/resources/images/details/sub.png) no-repeat center center;background-size:24px auto;}
			.details_merchant_footer a:nth-child(1n){background:#414149;}
			.details_merchant_footer a:nth-child(1) span:before{
					width: 30px;
				  height: 27px;
				  background: url(/resources/images/details/shopping_car2.png) no-repeat center center;
				  background-size: cover;
			}
			.details_merchant_footer a:nth-child(2) span:before{background:none;}
			.d_share{
				position:absolute;height:100%;width:100%;z-index:999;top:0;left:0;background:rgba(0,0,0,.3);
				display:-webkit-box;
				-webkit-box-align:center;
				-webkit-box-pack:center;
			}
			.d_share ul{background:#fff;width:90%;padding-bottom:24px;}
			.d_share .share_title{height:40px;line-height:40px;padding-left:8px;color:#322c2c;}
			.d_share .share_title span{display:inline-block;float:right;color:#767676;}
			.d_share .share_title span:before{content:'';position:relative;display:inline-block;height:40px;width:30px;
				background:url(/resources/images/details/collect_2.png) no-repeat center center;background-size:18px auto;vertical-align: top;
			}
			.d_share .share_img{position:relative;height:170px;text-align:center;background-color:#f4f4f4;overflow:hidden;}
			.d_share .share_img img{width:122px;height:122px;margin-top:8px;}
			.d_share .share_img span{display:block;position:absolute;bottom:0;right:0;width:100%;height:28px;line-height:28px;color:#fff;font-size:1.2rem;text-align:center;background:rgba(0,0,0,.6);}
			.d_share .p1{padding:0 10px 0;margin-bottom:24px;font-size:1.2rem;} 
			.d_share .share_intro{margin-top:18px;}
			.d_share .share_num{height:30px;line-height:30px;vertical-align: top;}
			.d_share .share_price span{color:#ffb200;margin-left:10px;}
			.d_share .right_add{position:relative;display:inline-block;top:0;left:0;height:30px;}
			.d_share .right_add span{height:30px;line-height:30px;}
			.d_share .share_num span{display:inline-block;height:30px;line-height:30px;vertical-align: top;}
			.d_share .right_add .num{margin:0 10px;}
			.d_shopping_car{
				position:fixed;width:54px;height:54px;border-radius:50%;left:10px;bottom:16px;z-index:201;
				background:url(/resources/images/details/shopping_car.png) no-repeat;
				background-size:cover;
				opacity:0;
				-webkit-transform:translate3D(0,-200%,0);
				transition:all 0.25s cubic-bezier(0.63, -1.12, 0, 1.65);
			}
			.d_shopping_car span{display:block;position:absolute;min-width:15px;height:15px;border-radius:7px;top:8px;right:0;color:#fff;background:#ffb200;font-size:1.2rem;line-height:15px;text-align:center;}
			.d_shopping_car_show{opacity:1;-webkit-transform:translate3D(0,0,0);}
			.d_shopping_list{
				position:absolute;width:100%;height:100%;left:0;top:0;background:rgba(0,0,0,.3);
				opacity:0;z-index:-2;transform:translate3D(0,0,0);
			}
			.d_shopping_list_show{opacity:1;z-index:200;transform:translate3D(0,0,0);}
			.d_shopping_list ul{position:absolute;bottom:55px;width:100%;background:#fff;}
			.d_shopping_list li{overflow:hidden;position:relative;height:30px;line-height:30px;margin:15px 10px;}
			.d_shopping_list .list_title{height:38px;line-height:38px;padding:0 10px;color:#757577;margin:0;background:#ecedef;}
			.d_shopping_list .list_title span{float:right;position:relative;}
			.d_shopping_list .list_title span:before{
				content:'';display:inline-block;width:15px;height:20px;background:url(images/shopdetails_10.png) no-repeat;
				background-size:cover;position:relative;right:5px;top:-2px;vertical-align:middle;
			}
			.d_shopping_list .shop_name{float:left;}
			.d_shopping_list .shop_price{float:left;color:#ffb200;margin-left:30px;}
			.d_shopping_list .right_add{position:static;float:right;height:30px;}
			.d_shopping_list .right_add span{height:inherit;line-height:30px;}
			.d_shopping_list .list_footer{position:absolute;left:0;bottom:0;width:100%;}
			.d_shopping_list .list_footer a{display:block;float:left;height:55px;line-height:55px;color:#fff;background:#414149;text-align:center;font-size:1.6rem;}
			.d_shopping_list .list_footer a:first-child{width:59%;}
			.d_shopping_list .list_footer a:last-child{width:41%;}
			.d_shopping_list .list_footer a:last-child{background:#707070;}
			.d_shopping_list_2{  height: 55px;bottom: 0;top: inherit;}
			.d_shopping_list_2 ul{display:none;}
			.share_close1 { float: right; width: 50px; height: 40px; text-align: center;}
			.share_close1 img { width: 15px; padding-top: 12px;}
			
			.details_merchant_footer_2 a:nth-child(1) span:before{
				display:none;
			}
			.details_merchant_footer_2 a:first-child{width:59%;}
			.details_merchant_footer_2 a:last-child{width:41%;background: #707070;}
			
			.merchant_right_list .li_add{background: url(/resources/images/details/add.png) no-repeat center center;background-size: 24px auto;float: right;
			display: block;width: 40px;height: inherit;text-align: center;line-height: 64px;}
			.merchant_right_list .li_sub{background: url(/resources/images/details/sub.png) no-repeat center center;background-size: 24px auto;}
			.merchant_right_list .right_add .li_sub{display:none;}
			.merchant_right_list .right_add .li_num{display:none;}
			.merchant_right_list .right_add_show .li_sub{display:block;}
			.merchant_right_list .right_add_show .li_num{display:block;}
			@media only screen and (min-width: 200px) and (max-width: 360px) {
				.merchant_right_list .right_add span{
					width:26px;
				}
			}
			.details_nav span.current_color { color: #ffb402; border-bottom: 4px solid #ffb402;}
			.details_nav span { color: #322c2c; display: inline-block; padding: 0 16px;}
			.right_call_c { display: inline-block; position: absolute; top: 0; right: 0; height: 50px; width: 40px; margin: 0 1px; text-align: center; border-radius: 50%;}
			.right_call_c img { width: 28px; padding-top: 13px;}
			.share_close1, .right_add .sub, .right_add .add, .right_call_c { -webkit-tap-highlight-color: transparent;}
		</style>
	</head>
	<body class="details_merchant_serve">
	
		<form id="facorAjax" action="<%=basePath%>index/goodsDetailShop" method="post">
			<input type="hidden" name="id" value="${shop.shopId}" >
			<input type="hidden" name="type" value="2" >
			<input type="hidden"   name="keyword" id="keyword" value="${keyword}"></a>
			<input type="hidden" name="orderby" id="orderby" value="${orderby}">
			<input type="hidden" name="class_id" id="class_id" value="${class_id}">
			<input type="hidden" name="city_id" id="city_id" value="${city_id}">
		</form>
	
		<form id="payform" method="post" action="<%=basePath%>userAddress/confirmOrder">
	    	<input id="order" name="order" type="hidden"/>
	    </form>
	
		<div class="head d_head details_merchant_head">
            <a href="javascript:querySearch('<%=basePath%>index/getShopSearchList');" class="head_back"></a>
            <p class="details_nav">
            	<span class="current_color">服务</span>
            	<!--<a href="javascript:headClickEvent(1);">评价</a>-->
            	<span onclick="headClickEvent(1);">评价</span>
            	<span onclick="headClickEvent(2);">商家</span>
			</p>
			<c:choose>
          		<c:when test="${requestScope.isFavorite eq 'yes' }">
	            	<span onclick="favoritesShop('${session_manager.userId}','${shop.shopId}','${shop.name}',${requestScope.favoriteId});" class="right_call_c">
	                    <img src="<%=basePath %>resources/images/details_31.png" alt="取消收藏店铺" />
                </c:when>
                <c:otherwise>
                	<span onclick="favoritesShop('${session_manager.userId}','${shop.shopId}','${shop.name}',null);" class="right_call_c">
	                    <img src="<%=basePath %>resources/images/details_3.png" alt="收藏店铺" />
           		</c:otherwise>
           	</c:choose>
   			</span><!--已收藏-->
        </div>
        
        <div class="content d_content details_merchant_center">
        	<div class="merchant_left">
<%--        		<a href="javascript:clickCategoryEvents();">--%>
<%--        			<span class="<c:if test="${empty categoryId }">current_color</c:if>">全部</span>--%>
<%--        		</a>--%>
        		<c:forEach items="${category }" var="goods" varStatus="g" >
        			<a href="javascript:clickCategoryEvents('${goods.categoryId}');">
        			<span class="<c:choose><c:when test="${not empty categoryId && goods.categoryId == categoryId }">current_color</c:when><c:when test="${empty categoryId && g.index ==0}">current_color</c:when></c:choose>">${goods.name}</span>
        			</a>
	    		</c:forEach>
        	</div>
        	<div class="merchant_right">
        	
        	<%
        			List<ServiceCategory> category=(List<ServiceCategory>)request.getAttribute("category");
        			List<Service> list=(List<Service>)request.getAttribute("services");
        			List<Favorite> favorites=(List<Favorite>)request.getAttribute("favorites");
        			Long id=null;
        			for(int i=0;i<list.size();i++){
        			if(i==0){
        				id=list.get(i).getCategoryId();
        				%>
        				<div class="merchant_right_box merchant_right_<%=i+1 %>">
        				<h6 class="d_h6"><%=RenderUtils.CategoryNameRender(category,list.get(i).getCategoryId()) %></h6><%
        			}else{
        				if(list.get(i).getCategoryId()!=list.get(i-1).getCategoryId()){
        					id=list.get(i).getCategoryId();
        					%>
        					</div>
        					<div class="merchant_right_box merchant_right_<%=i+1 %>">
        					<%
        					if(list.get(i).getCategoryId().intValue()!=list.get(i-1).getCategoryId()){%>
        						<h6 class="d_h6"><%=RenderUtils.CategoryNameRender(category,list.get(i).getCategoryId()) %></h6>
        					<%		
        					}%>
        				<%
        				}
        			}
        			%>
        			<a href="javascript:;" class="merchant_right_list" onclick="right_list_Click('<%=list.get(i).getServiceId()%>');">
	        			<div class="right_img"><img src="<%=list.get(i).getPath() %>" alt="红色法式" /></div>
	        			<div class="right_text">
	        				<p><%=list.get(i).getName().length() > 8 ? list.get(i).getName().substring(0,8) : list.get(i).getName()%></p>
	        				<p>销量:<%=list.get(i).getSalesNum() %>&nbsp;&nbsp;</p>
	        				<p>￥<span class="price"><%=list.get(i).getPrice() %></span></p>
	        			</div>
	        			
	        			<div id="right_add<%=list.get(i).getServiceId()%>" class="right_add">
	        				<span id="add<%=list.get(i).getServiceId()%>" class="li_add" onclick="addAmount('<%=list.get(i).getServiceId()%>')"></span>
	        				<span id="sub<%=list.get(i).getServiceId()%>" class="li_sub" onclick="subAmount('<%=list.get(i).getServiceId()%>')"></span>
	        				<span id="num<%=list.get(i).getServiceId()%>" class="li_num">0</span>
	        			</div>
	        			<%
						Favorite f=RenderUtils.FavoriteServiceRender(favorites,list.get(i).getServiceId());
						if(f!=null){
							%>
							<input id="favorite<%=list.get(i).getServiceId() %>" type="hidden" value="<%=f.getFavoriteId() %>"/>
							<%
						}else{
							%>
							<input id="favorite<%=list.get(i).getServiceId() %>" type="hidden" />
							<%
						}
						%>
	        			<input id="summary<%=list.get(i).getServiceId() %>" type="hidden" value="<%=list.get(i).getSummary()==null?"":list.get(i).getSummary() %>"/>
	        			<input id="name<%=list.get(i).getServiceId() %>" type="hidden" value="<%=list.get(i).getName() %>"/>
	        			<input id="path<%=list.get(i).getServiceId() %>" type="hidden" value="<%=list.get(i).getPath()==null?"":list.get(i).getPath() %>"/>
	        			<input id="price<%=list.get(i).getServiceId() %>" type="hidden" value="<%=list.get(i).getPrice() %>"/>
	        		</a>
        			<%
	        			if(i==(list.size()-1)){
	        				%></div><%
	        			}
        			} %>	
        		</div>	
        </div>
        
        
        
        <footer id=d_footer  class="d_footer det_app_footer details_merchant_footer">
        	<a href="javascript:;"><span id="footTxt">购物车是空的</span></a>
        	<a href="javascript:phoneCalls2(${shop.shopId},'<%=basePath%>call/addCall');"  id="phoneTel_${shop.shopId}" "><span>联系商家</span></a>
        	<a id="footPay" href="javascript:pay();" style="display:none;">选好了</a>
        </footer>
        
        <div class="d_shopping_car"><span>0</span></div>
        
        <div class="d_shopping_list">
        	<ul id="shopping_list">
        	</ul>
        	<div class="list_footer">
        		<a href="javascript:;">共￥<span id="total"></span></a>
        		<a href="javascript:pay();">选好了</a>
<%--        		<a href="<%=basePath%>userAddress/confirmOrder" target="self">选好了</a>--%>
        	</div>
        </div>
        
<%--        <div class="d_share">--%>
<%--        	<ul>--%>
<%--        		<li class="share_title">红色法式美甲<span>收藏</span></li>--%>
<%--        		<li class="share_img"><img src="<%=basePath %>resources/images/banner_3.jpg"/><span>图片仅供参考</span></li>--%>
<%--        		<li class="share_intro p1">美甲类型：小粉蝶妆，带砖石装饰，带细微点翠。颜色：红色黑色，星空色、裸色自选，也可多色搭配或渐变色。</li>--%>
<%--        		<li class="share_price p1">价格：<span class="price">￥499</span></li>--%>
<%--        		<li class="share_num p1">数量--%>
<%--        			<div class="right_add">--%>
<%--	        				<span class="sub"></span>--%>
<%--	        				<span class="num">1</span>--%>
<%--	        				<span class="add"></span>--%>
<%--	        		</div>--%>
<%--        		</li>--%>
<%--        	</ul>--%>
<%--        </div>--%>
	</body>
	
	<script>
	
	$(function(){
		FastClick.attach(document.body);
	})
	
	$(function(){
		var shopid=${shopid};
		var url="<%=basePath%>index/serviceList";
		loadTrolley(shopid,url,refreshTrolley);//加载购物车
	});
		
	
	/**数量选择*/
	$('.merchant_right_list .right_add').on('click', function(e){
		var _this = this;
		if($(_this).hasClass('num')){
			//fn_add_sub();
		}else{
			//$('.merchant_right_list .right_add').removeClass('right_add_show');
			//$(_this).addClass('right_add_show');
		}
		return false;
	});
	
	
	function addAmount(serviceId){
		var shopId=${shopid};
		changeAmount(shopId,serviceId,"add",refreshTrolley);
	}
	
	function subAmount(serviceId){
		var shopId=${shopid};
		changeAmount(shopId,serviceId,"less",refreshTrolley);
	}
	
	
		function right_list_Click(serviceId){
		
			var shopId=${shopid};
		
			var favoriteId=$("#favorite"+serviceId).val();
			var name=$("#name"+serviceId).val();
			var path=$("#path"+serviceId).val();
			var summary=$("#summary"+serviceId).val();
			var price=$("#price"+serviceId).val();
		
			var t=getTrolley(shopId);
			var s=null;
			for(var i in t.list){
				if(t.list[i].serviceId==serviceId){
					s=t.list[i];
				}
			}
			
			var fav="";
			if(favoriteId){
				fav="<a href='javascript:;'><span id=\"favspan\">取消收藏</span></a>";
			}
			else{
				fav="<a href='javascript:;'><span id=\"favspan\">收藏</span></a>";
			}
		
			var html = [];
			html.push('<div class="d_share"><ul>');
			//html.push('<li class="share_title">'+name+fav+'</li>');
			html.push('<li class="share_title">'+name+'<em class="share_close1"><img src="<%=basePath %>resources/images/close.png" alt="关闭" /></em></li>');
			html.push('<li class="share_img"><img src="'+path+'"/><span>图片仅供参考</span></li>');
			html.push('<li class="share_intro p1">'+summary+'</li>');
			html.push('<li class="share_price p1">价格：<span class="price">￥'+price+'</span></li>');
			html.push('<li class="share_num p1"><span>数量</span><div class="right_add">');
			//html.push('<span class="sub" onclick="fn_sub('+shopId+',\''+serviceId+'\',this)"></span><span class="num">'+(s?s.num:0)+'</span><span class="add" onclick="fn_add('+shopId+',\''+serviceId+'\',this)"></span></div></li>');
			html.push('<span class="sub"></span><span class="num">'+(s?s.num:0)+'</span><span class="add"></span></div></li>');
			html.push('</ul></div>');
	    	$('body').append(html.join(''));
	    	
	    	$('.d_share').on('click', function(e){
	    		 if($(e.target).hasClass("d_share")){
				  	$(this).remove();
				  }
	    		 return false;
			})
			$('.share_close1').on('click', function(){
				 $(".d_share").remove();
        		 return false;
			});
			
			$('#favspan').on('click', function(e){
				 var fStr=$("#favorite"+serviceId).val();
				 favorites(serviceId,name,fStr);
	    		 return false;
			})
			
			
	    	//购物车
			fn_add_sub(shopId,serviceId);
	    	return false;
		}
	
		//加减
		function fn_add_sub(shopId,serviceId){
		//	var intro = [];
			
			$('.add').on('click',function(e){
				var $num = $(this).parent().find('.num'),
					num = parseInt($num.text());
				
				changeAmount(shopId,serviceId,"add",refreshTrolley);
				
				num++;
				$num.text(num);
				console.log(num);
				e.stopPropagation();
				
				return false;
			})
			
			$('.sub').on('click',function(e){
				var $num = $(this).parent().find('.num'),
					num = parseInt($num.text());
				
				if(num>0)changeAmount(shopId,serviceId,"less",refreshTrolley);
				
				num--;
				if(num <= 0){
					num = 0;
				}
				if(num == 0){
					$('.d_shopping_car span').text(getTotalNum());
				}
				$num.text(num);
				
				e.stopPropagation();
				return false;
			})
			
		}
		/*导航自动切换*/
		(function(){
			var $span = $('.merchant_left span');
			var top = parseInt($('.merchant_right').offset().top);
			$('.merchant_right').on('scroll', function(){
				var sum = $('.merchant_right_box').size();
				var tops = new Array(sum - 1);
				for(var i = 1;i <= 3;i ++){
					tops[i - 1]  = parseInt($('.merchant_right' + '_' + i).offset().top);
				}
				$.each(tops, function(index, item){
					if(item <= top ){
						$span.removeClass('current_color');
						$span.eq(index).addClass('current_color');
					}
				})
				return false;
			})
			
			var tops = [],
				len = $('.merchant_right_box').size();
			for(var i = 1;i <= len;i ++){
				(function(i){
				//	var t = parseInt($('.merchant_right_' + i).offset().top);
				//	tops.push(t);
				})(i)
			}
			$span.on('click', function(){			
				var index = $(this).index();
				var top = tops[index] - 54;
				$('.merchant_right').scrollTop(top);
				$span.removeClass('current_color');
				$span.eq(index).addClass('current_color');
			})
		})()
		
		/*购物车清单*/
		$('.d_shopping_car').on('click', function(){
			if($('.d_shopping_list').hasClass('d_shopping_list_show')){
				$('.d_shopping_list').toggleClass('d_shopping_list_2');
			}else{
				$('.d_shopping_list').addClass('d_shopping_list_show')
				$('.d_shopping_list').removeClass('d_shopping_list_2');
			}
		
		})
		
		/*清除全部*/
		$('.d_shopping_list .clear').on('click', function(){
			$('.d_shopping_list .list_intro').remove();
			$('.d_shopping_list').removeClass('d_shopping_list_show');
		})

		//点击遮罩层去掉遮罩
		$('.d_shopping_list').on('touchend', function(e){
			$('.d_shopping_list').removeClass('d_shopping_list_show');
			return false;
		})
		
		$('#shopping_list').on('touchend', function(e){
			e.stopPropagation();
		})
		
		$('.list_footer').on('touchend', function(e){
			e.stopPropagation();
		})
		
		
//收藏服务
function favorites(shop_id,name,obj){
	var user_id='${userDetail.userId}';
	//var favoriteId =$(obj).attr("favoriteId");
	var favoriteId =obj;
	var shopUserId = '${shop.userId}';
	if(user_id == ''){
		alert('收藏失败，请授权登录后操作');
		return ;
	}
	var url = '';
	if(favoriteId && favoriteId != null && favoriteId != '' && favoriteId > 0){
		url = 'collect_id=' + favoriteId + '&user_id='+user_id+'&shop_id='+shop_id+'&favorite_type=2';
	}else{
		if(user_id == shopUserId ){
			alert('自己不能收藏自己的服务');
			return ;
		}
		url = 'fav_name=' + name + '&user_id='+user_id+'&shop_id='+shop_id+'&favorite_type=2';
	}
	$.ajax({  
	   		type: "POST",  
	        url: '<%=basePath%>favorite/collect2',  
	        data: url,
	        success: function(data){
	        	if(data.respCode==200){
	        		if($("#favspan").text()=='取消收藏'){
						$("#favspan").html("收藏");
						$("#favorite"+shop_id).val('');
					}else{
						$("#favspan").html("取消收藏");
						$("#favorite"+shop_id).val(data.result);
					}
	        		/*
	        		if($(obj).text()=='取消收藏'){
						$(obj).html("收藏");
						$(obj).attr("favoriteId","");
						$("#favorite"+shop_id).val('');
					}else{
						$(obj).html("取消收藏");
						$(obj).attr("favoriteId",data.result);
						$("#favorite"+shop_id).val(data.result);
					}
	        		*/
	        	}else if(data.respCode==201){
	        		alert(data.reason);
	        	}else{
	        		alert(data.reason);
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

//点击类目
function clickCategoryEvents(categoryId){
	if(categoryId)self.location="<%=basePath%>index/goodsDetailService?categoryId="+categoryId+"&id=${shopid}";
	else self.location="<%=basePath%>index/goodsDetailService?id=${shopid}";
}
function clickkimil(){
	$("#share").slideToggle(100);
}

//tab点击跳转
function headClickEvent(index){
	if(index==0){
		//self.location="<%=basePath%>index/goodsDetailService?id=${shopid}";
		querySearch('<%=basePath%>index/goodsDetailService?id=${shopid}&goods=3');
	}
	else if(index==1){
		//self.location="<%=basePath%>index/goodsDetailComment?id=${shopid}";
		querySearch('<%=basePath%>index/goodsDetailComment?id=${shopid}&goods=3');
	}
	else if(index==2){
		//self.location="<%=basePath%>index/goodsDetailShop?id=${shopid}";
		querySearch('<%=basePath%>index/goodsDetailShop?id=${shopid}&goods=3');
	}
}

//打开/关闭购物车列表
var listStatue=false;
function trolleyListEvent(status){
	if(!status){
		if(listStatue){
			listStatue=false;
			$("#swiper-container-trolley").hide();
			$("#swiper-container-left").show();
			$("#swiper-container-right").show();
		}else{
			listStatue=true;
			loadTrolleyList();
			$("#swiper-container-trolley").show();
			$("#swiper-container-left").hide();
			$("#swiper-container-right").hide();
		}
	}else{
		if(status=="spen"){
			listStatue=true;
			loadTrolleyList();
			$("#swiper-container-trolley").show();
			$("#swiper-container-left").hide();
			$("#swiper-container-right").hide();
		}else if(status=="close"){
			listStatue=false;
			$("#swiper-container-trolley").hide();
			$("#swiper-container-left").show();
			$("#swiper-container-right").show();
		}	
	}
	
}

//选好了
function pay(){
	if('${shop.userId}' == '${session_manager.userId}'){
		alert("不能订购自己店铺的服务");
		return;
	}
	var shopId=${shopid};
	var t=getTrolley(shopId);
	var str=JSON.stringify(t);
	$("#order").val(str);
	document.getElementById("payform").submit();
	//$("#payform").submit();
}

//停止冒泡事件
function subClick(e){
	e.stopPropagation();
}

//更新购物车显示
function refreshTrolley(shopId){
	$(".li_num").html(0);
	$('.merchant_right_list .right_add').removeClass('right_add_show');
	
	if(displayList.length==0){
		$(".d_shopping_car").removeClass("d_shopping_car_show");
		$(".d_shopping_list").removeClass("d_shopping_list_show");
		$("#d_footer").removeClass("details_merchant_footer_2");
		$("#footTxt").text("购物车是空的");
		$("#phoneTel_"+shopId).show();
		$("#footPay").hide();
		return;
	}else{
		$('.d_shopping_car').addClass('d_shopping_car_show');
		$("#phoneTel_"+shopId).hide();
		$("#footPay").show();
	}
	$(".d_shopping_car>span").text(getTotalNum());
	$("#shopping_list").empty();
	var html="";
	html+='<li class="list_title">购物车<a href="javascript:clearTrolley('+shopId+',refreshTrolley);"><span class="clear">清除全部</span></a></li>';
	$.each(displayList,function(i,o){
		html+='<li class="list_intro">'
			+'<div class="shop_name">'+o.name+'</div>'
			+'<div class="shop_price">￥<span class="price">'+o.price+'</span></div>'
			+'<div class="right_add">'
			+'<span class="sub" onclick="changeAmount('+shopId+',\''+o.serviceId+'\',\'less\',refreshTrolley);"></span>'
			+'<span class="num">'+o.num+'</span>'
			+'<span class="add" onclick="changeAmount('+shopId+',\''+o.serviceId+'\',\'add\',refreshTrolley);"></span>'
			+'</div>'
			+'</li>';
		$("#num"+o.serviceId).html(o.num);
		if(o.num>0){
			$("#right_add"+o.serviceId).addClass('right_add_show');
		}else{
			$("#right_add"+o.serviceId).removeClass('right_add_show');
		}
	});
	$("#shopping_list").append(html);
	var total=getTotal();
	if(total>0){
		$("#d_footer").addClass("details_merchant_footer_2");
		$("#footTxt").text("共￥"+total);
		$("#total").text(total);
	}else{
		$("#d_footer").removeClass("details_merchant_footer_2");
		$("#footTxt").text("共￥"+total);
		$("#total").text(0);
	}
}


function favoritesShop(user_id,shop_id,name,favoriteId){
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
	        		$("#facorAjax").attr('action','<%=basePath%>index/goodsDetailService?id=${shop.shopId}');
	        		//收藏后刷新
	        		location.reload();
	        	}else if ("2" == data){
	        		
	        	}else{
	        	}
			}  
		});
}

function querySearch(url){
	$("#facorAjax").attr("action",url).attr("target","_self").submit();
}

	

	</script>
	<!--<jsp:include page="../head/hideHead2.jsp"></jsp:include>
	 
--></html>
