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
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
		
		<script src="<%=basePath %>resources/js/zepto.min.js"></script>
		<title>好站点，您身边的上门服务!</title>
		<style type="text/css">
		<style>
			/*content*/
        	h1,h2,h3,h4,h5,h6{ font-weight:normal; font-size:1.4rem;}
			html,body{ width:100%; height:100%;}
			*{ box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box;}
			.d_content{bottom:48px;}
			.d_content_of{overflow:hidden;}
			.d_head_right{position:absolute;display:block;top:0;right:15px;color:#fff;line-height:60px;}
			.cont_nav { background-color: #fff;}
			.cont_nav p{height:50px;line-height:50px;position:relative;text-align:center;border-bottom:1px solid #d6d6d6;}
			.cont_nav p span{display:inline-block;}
			.cont_nav p span:after{
				content:'';display:inline-block;width:12px;height:12px;background:url(/resources/images/personalcenter_131.png) no-repeat;
				background-size:12px auto;margin-left:5px;vertical-align: middle;
			}
			.cont_nav_list{position:absolute;top:100px;left:0;bottom:0;width:100%;z-index:99;background:rgba(0,0,0,.3);display:none;}
			.cont_nav_list_show{display:block;}
			.cont_nav_list li{height:40px;line-height:40px;padding:0 5px;border-bottom:1px solid d_manage_footer;text-indent:8px;background:#fff;}
			.cont_nav_list li:last-child{border:none;}
			.cont_nav_list .select_current a{position:relative;display: block;color:#ffb200 !important;font-size: 1.4rem;}
			.cont_nav_list .select_current a:after{
				content:'';display:block;width:15px;height:9px;background:url(/resources/images/sort/selected.png) no-repeat;
				background-size:cover;position:absolute;right:5px;top:50%;margin-top:-5px;
			}
			.cont_box_list{margin-top:12px;width:100%;background-color:#fff;overflow:hidden;}
			.cont_box_list li{padding:0 10px;border-top:1px solid #dedede;border-bottom:1px solid #dedede;width:100%;position:relative;transition:all 0.25s;}
			.cont_box_list .li_swipeleft{transform:translate3d(-122px,0,0);-webkit-transform:translate3d(-122px,0,0)}
			.cont_box_list .list_li_box1{position:relative;padding:15px 0;border-bottom:1px solid #d6d6d6;vertical-align: top;}
			.cont_box_list .list_text{position:absolute;top:15px;right:0;width:100%;padding-left:80px;}
			.cont_box_list .list_text .t_name { font-size: 1.4rem; color: #322c2c;}
			.cont_box_list .list_text .t_price{color:#ffb200;overflow:hidden;font-size:1.3rem;margin-top:8px;}
			.cont_box_list .list_text span{float:right;font-size:1.5rem;}
			.cont_box_list .list_text .t_time{font-size:1.2rem;color:#7e7e7e;}
			.cont_box_list .list_img{width:60px;height:60px;overflow:hidden;border-radius:6px;}
			.cont_box_list .list_img img{width:100%;min-height:60px;}
			.cont_box_list .list_li_box2{height:30px;}
			.cont_box_list .list_li_box2 span{display:inline-block;width:32.3333%;height:100%;}
			.cont_box_list .list_li_box2 .s1{background:url(/resources/images/manage_shop/mana_icon1.png) no-repeat center center;}
			.cont_box_list .list_li_box2 .s2{background:url(/resources/images/manage_shop/mana_icon2.png) no-repeat center center;}
			.cont_box_list .list_li_box2 .s3{background:url(/resources/images/manage_shop/mana_icon3.png) no-repeat center center;}
			.cont_box_list .list_li_box2 span:nth-child(1n){background-size:16px auto;}
			.cont_box_list .list_delete{height:122px;width:122px;position:absolute;left:100%;top:0;background:#fbb102;display:-webkit-box;-webkit-box-align:center;-webkit-box-pack:center;}
			.cont_box_list .list_delete img{width:26px;}
			.d_manage_footer{position:absolute;bottom:0;left:0;background:#fff;width:100%;height:48px;line-height:48px;text-align:center;border-top:1px solid #d6d6d6;color:#ffb200;}
			.d_manage_footer a{color:inherit;}
			.share_container { position: fixed; left: 50%; top:50%; display: none; width: 90%; height: auto; border: 1px solid #efefef; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; transform: translate(-50%,-50%) !important; -webkit-transform: translate(-50%,-50%) !important; -moz-transform: translate(-50%,-50%) !important; background-color: #fff; z-index: 100;}
			.z_just_pri { position: relative;}
			.z_just_picdown { position: absolute; bottom: 5px; left: 50%; width: 15px; height: 7px;}
			.shop_name { display: inline-block;}
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
			.cont_box_list .list_li_box2 .box_a:nth-child(1n) { background-size: 16px auto;}
			.cont_box_list .list_li_box2 .box_a { display: inline-block; width: 32.3333%; height: 100%;}
			.cont_nav_list_show a{display:block}
			.d_manage_footer { position: fixed;}
			.cont_box { padding-bottom: 60px;}
			.ui-loader { display: none;}
			
			.mark_content{
				position:absolute;width:248px;height:164px;top:50%;left:50%;margin-top:-82px;margin-left:-124px;border-radius:4px;text-align:center;
				background:#fff url(/resources/images/share-bd.png) no-repeat center center;background-size:147px auto;	
			}
			.mark_content .p1{line-height:164px;}
			.mark_content .p2{position:absolute;width:100%;left:0;bottom:0;overflow:hidden;}
			.mark_content .p2 a{display:block;color:inherit;width:50%;float:left;margin-bottom:30px;}
			.mark_content .p2 a:nth-child(1){color:#818682;}
			.mark_show{display:block;background:rgba(0,0,0,.3)}
			.nothing_goods { width: 90%; margin: 15px auto; font-size: 1.6rem; color: #858386; text-align: center;}
			.cont_nav_list li a:link, .cont_nav_list li a:visited { color: #322c2c;}
			.mark { background: rgba(0,0,0,.45)}
			/*Guide the instructions*/
			.mark2 { position: fixed; left: 0; right: 0; top: 0; bottom: 0; display: block; width: 100%; height: 100%; z-index: 99;}
			.mark2 img { width: 100%;}
			#img2, #img3, #img4, #img5 { display: none;}
			#area1, #area2, #area3, #area4, #area5, #area11, #area22, #area33, #area44 { -webkit-tap-highlight-color: transparent;}
		</style>
		
	<script type="text/javascript">
		function query(url,id){
			$("#id").val(id);
			$("#searchForm").attr("action",url).submit();
		}
	</script>
	<script type="text/javascript" src="<%=basePath %>resources/js/introduceSwitch.js"></script>

</head>
	<body class="management">
		
		<div class="head d_head d_header">
            <a href="<%=basePath%>index/manage" target="_self" class="head_back"></a>
            <p>服务管理</p>
            <a href="<%=basePath%>service/scategoryManage?shopId=${shopId}" class="d_head_right" target="_self" ><span style="color:#fff;">分类管理</span></a>
        </div>
		
		<div class="content d_content service_mana_content">
			
			<c:set var="cgroy" value="全部分类"></c:set>
			<c:forEach items="${scategoryList}" var="gory">
				<c:if test="${gory.categoryId eq queryCategoryId}">
					<c:set var="cgroy" value="${gory.name }"></c:set>
				</c:if>
			</c:forEach>
			
			<div class="cont_nav">
				<p><span>${cgroy }</span></p>
					<ul class="cont_nav_list">
					<li <c:if test="${empty queryCategoryId}">class="select_current"</c:if>><a href="<%=basePath%>service/listGoods?id=${shopId}&type=3" target="_self"><em class="color_322">全部分类</em></a></li>
						<c:forEach items="${scategoryList}" var="gory">
							<li <c:if test="${queryCategoryId eq gory.categoryId}">class="select_current"</c:if>><a href="<%=basePath%>service/listGoods?id=${shopId}&type=3&queryCategoryId=${gory.categoryId }" target="_self"><em class="color_322">${gory.name}</em></a></li>
						</c:forEach>
					</ul>
			</div>
			
<form action="" id="searchForm" name="searchForm" method="post" target="_self">
	<input type="hidden" id="id" name="id" value="">
	<input type="hidden" id="shopId" name="shopId" value="">			
	<input type="hidden" id="type" name="type" value="">			
			<div class="cont_box">
				<ul class="cont_box_list">
					<c:forEach items="${list}" var="goods" >
						<li>
							<a href="javascript:query('<%=basePath%>service/goodsEdit',${goods.serviceId });">
								<div class="list_li_box1">
									<div class="list_img">
										<c:if test="${goods.path != null}">
					                		<img src="${goods.path}" onclick="query('<%=basePath%>service/goodsEdit',${goods.serviceId });">
					                	</c:if>
					                	<c:if test="${goods.path == null}">
					                		<img src="<%=basePath %>resources/images/goods_picture.png" onclick="query('<%=basePath%>service/goodsEdit',${goods.serviceId });" > 
					                	</c:if>
									</div>
									<div class="list_text">
										<p class="t_name">${fn:substring(goods.name,0,10)}</p>
										<p class="t_price">${goods.categoryName}<span>￥${goods.price}</span></p>
										<c:choose>
											<c:when test="${goods.status == 0 }">
												<p class="t_time">已下架</p>
											</c:when>
											<c:otherwise>
												<p class="t_time"><fmt:formatDate value='${goods.ctime}' pattern='yyyy-MM-dd HH:mm:ss' /></p>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</a>
							<div class="list_li_box2">
								<a href="javascript:query('<%=basePath%>service/goodsEdit',${goods.serviceId});"  class="s1 box_a" data-ajax="false"></a>
								<c:choose>
									<c:when test="${goods.status == 0 }">
										<%-- 下架 - 上架 --%>
										<a href="javascript:shelf('${goods.serviceId}','${goods.shopId}',1);"class="s2 box_a d_del" data-ajax="false"></a>
									</c:when>
									<c:otherwise>
										<%-- 上架 - 下架  --%>
										<a href="javascript:shelf('${goods.serviceId}','${goods.shopId}',0);"class="s2 box_a d_del" data-ajax="false"></a>
									</c:otherwise>
								</c:choose>
								<a class="s3 box_a share_bton" data-ajax="false"></a>	
							</div>
							<div class="list_delete" serviceId="${goods.serviceId}" shopId="${goods.shopId}" shelfStatus="${goods.status }"><img src="<%=basePath %>resources/images/details/shopping_11.png"/></div>
						</li>
					</c:forEach>
					<c:if test="${fn:length(list) == 0 }">
						<p class="nothing_goods">赶紧添加服务吧！</p>
					</c:if>
				</ul>
			</div>
		</div>
		<a href="javascript:query('<%=basePath%>service/addGoods','${shopId}');">
			<div class="d_manage_footer">添加服务</div>
		</a>
		<div class="share_container">
        	<p class="share_title">分享到<span class="share_close"><img src="<%=basePath %>resources/images/close.png" alt="关闭" /></span></p>
        	<div class="share_content">
        		<a href="javascript:void(0);" class="jiathis_button_qzone"><em class="right_call2"><img src="<%=basePath %>resources/images/share_01.png" alt="分享店铺" /><p>QQ空间分享</p></em></a>
        		<a href="javascript:void(0);" class="jiathis_button_tsina"><em class="right_call3"><img src="<%=basePath %>resources/images/share_02.png" alt="分享店铺" /><p>新浪微博分享</p></em></a>
        	</div>
        </div>
        <div class="mark"></div>
        
        <%-- 关闭调用 troggleThisIntroduceSwitch('<%=basePath%>') --%>
	 	<c:if test="${introduceSwitch }">
	        <div class="mark2">
		        <img src="<%=basePath %>resources/images/guidance/service_management_01.jpg" alt="分类管理" usemap="#Map1" class="img1" />
	            <map name="Map1">
	              <area shape="poly" coords="5,3,7,53,164,53,164,3" href="javascript:void(0);" class="area1" >
	              <area shape="poly" coords="3,341,3,378,1503,376,1504,338" href="javascript:void(0);" class="area11" >
	            </map>
	            
	            <img src="<%=basePath %>resources/images/guidance/service_management_02.jpg" alt="全部分类" usemap="#Map2" class="img2" />
	            <map name="Map2">
	            	<area shape="poly" coords="5,3,7,53,164,53,164,3" href="javascript:void(0);" class="area2" >
	              	<area shape="poly" coords="3,341,3,378,1503,376,1504,338" href="javascript:void(0);" class="area22" >
	            </map>
	            
	            <img src="<%=basePath %>resources/images/guidance/service_management_03.jpg" alt="左划删除" usemap="#Map3"  class="img3 height_4" />
	            <map name="Map3">
	            	<area shape="poly" coords="5,3,7,53,164,53,164,3" href="javascript:void(0);" class="area3" >
	              	<area shape="poly" coords="3,341,3,378,1503,376,1504,338" href="javascript:void(0);" class="area33" >
	            </map>
	            
	            <img src="<%=basePath %>resources/images/guidance/service_management_04.jpg" alt="添加服务" usemap="#Map4" class="img4 height_4" />
	            <map name="Map4">
	            	<area shape="poly" coords="5,3,7,53,164,53,164,3" href="javascript:void(0);" class="area4" >
	              	<area shape="poly" coords="3,341,3,378,1503,376,1504,338" href="javascript:void(0);" class="area44" >
	            </map>
	            
	            <img src="<%=basePath %>resources/images/guidance/service_management_05.jpg" alt="编辑、上下架、分享服务" usemap="#Map5"  class="img5" />
	            <map name="Map5">
	            	<area shape="poly" coords="5,3,7,53,164,53,164,3" href="javascript:void(0);" class="area5" >
	              	<area shape="poly" coords="3,341,3,378,1503,376,1504,338" href="javascript:void(0);" class="area55" >
	            </map>
	            
	    	</div>
	     </c:if>
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
				url: "http://m.hzd.com/index/goodsDetailShop?id=${shop.shopId}&type=1", 
			//	url: "http://m.hzd.com/index/indexhome" , 
				title:"好站点",//"我在好站点看到一个"+categoryName+"的商铺，非常棒，你也来看看"
				summary:"分享好站点" 
			};
         
			//var jiathis_config = {
				/*url: "http://m.hzd.com/index/goodsDetail?id=${shop.shopId}&type=1", */ //当前网页链接，可自定义
				/*title:"我在好站点看到一个"+categoryName+"的商铺，非常棒，你也来看看"*/   //categoryName可以为当前店铺名称或者分类名称，但必须是在以这个格式格式引用: <div id="categoryName"></div>
				/*summary: 摘要，没有设置定制的内容是会直接调取头部<meta name="description">内的content的内容，设置同title一样，上面title没有设置指定的值也是同summary一样调取头部meta里面的默认title值*/
				//title: document.getElementById("shop_name").innerText || document.getElementById("shop_name").textContent,
				//summary: document.getElementById("shop_description").innerText || document.getElementById("shop_description").textContent,
			//}
			
		</script>
</form>
	<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
	<script type="text/javascript">
		/*导航*/
		$('.cont_nav p').on('click', function(){
			$('.cont_nav_list').toggleClass('cont_nav_list_show');
			$('.d_content').toggleClass('d_content_of');
		});
		/*删去服务*/
		$('.cont_box_list li').on({
			'swipeLeft':function(){
				$('.cont_box_list li').removeClass('li_swipeleft');
				$(this).addClass('li_swipeleft');
			},
			'swipeRight': function(){
				$(this).removeClass('li_swipeleft');
			}
		});
	
		$('.cont_nav_list').on('click', function(e){
			$('.cont_nav_list').removeClass('cont_nav_list_show');
			$('.d_content').removeClass('d_content_of');
			e.stopPropagation();
		})
		$('.cont_nav_list li').on('click', function(e){
			e.stopPropagation();
		})
		
		$('.cont_box_list .list_delete').on('tap', function(){
			del();
			$(this).parent().remove();
		});
		 //删除
		 function del(id,shopId){
			if(confirm('确认删除吗?')){
				$("#id").val(id);
				$("#shopId").val(shopId);
				$("#searchForm").attr("action","<%=basePath%>service/del").submit();
			}
		 }	
		 //删除
		 function shelf(id,shopId,type){
			var tip = "是否将当前服务";
			if(type == 1){
				tip+="上架？";
			}else{
				tip+="下架？";
			}
			if(confirm(tip)){
				$("#id").val(id);
				$("#shopId").val(shopId);
				$("#type").val(type);
				$("#searchForm").attr("action","<%=basePath%>service/shelf").submit();
			}
		 }	
		 /**分享*/
		$(".mark").on("click",function(){
			$(".share_container, .mark").hide();
		});
		$(".share_bton").on("click",function(){
			//console.log(123123);
			$(".share_container, .mark").show();
		});
		$(".share_close").on("click",function(){
			$(".share_container, .mark").hide();
		});	

	/*遮罩*/
		//添加
        function add_mark(str1,str2,str3){
        	var html = [];
        	html.push('<div class="mark mark_show"><div class="mark_content"><p class="p1">'+str1+'!</p>');
        	html.push('<p class="p2"><a href="javascript:;" class="a1 cancel">'+ str2 +'</a><a href="javascript:;" class="a1 m_sure">'+ str3 +'</a></p></div></div>');
        	$('body').append(html.join(''));
        	$('.content').addClass('d_content_of');
        }
        //删除
        function remove_mark(){
        	$('body').find('.mark').remove(); 
        	$('.content').removeClass('d_content_of');
        } 
        
      	$('.a1').on('touchend', function(e){
        	remove_mark();
        	e.stopPropagation();
        	return false;
        })
       
       /**事件*/
       $('.cont_box_list li .list_delete').on('touchend', function(e){
	    	var this_ = $(this).closest("li .list_delete");
	    	var shelfStatus=$(this_).attr("shelfStatus");
       		//遮罩显示内容自定义，如下
	    	if(shelfStatus == 0){
	       		add_mark('确定删除该服务信息？','取消','确定');
		    	var serviceId=$(this_).attr("serviceId");
		    	var shopId=$(this_).attr("shopId");
		    	$(".m_sure").off("touchend");
	       		$('.m_sure').on('touchend', function(e){
			    	remove_mark();
			    	e.stopPropagation();
			    	$("#id").val(serviceId);
	 				$("#shopId").val(shopId);
	 				$("#searchForm").attr("action","<%=basePath%>service/del").submit();
			    	return false;
			    });
	    	}else{
	    		
	       		add_mark('只有下架了的服务才能删除哦！','取消','确定');
	    	}
       		//取消遮罩
	       $('.mark_show').on('touchend', function(e){
	       		if(!$(e.target).hasClass('p1')){
	       			remove_mark();
	        		e.stopPropagation();
	        		return false;
	       		}
	       })
	       e.stopPropagation();
       })
       //删除商品事件
	    // var goods_id = null;
	    $('body').on('tap', '.delete_goods_btn', function() {
	        show_confirm(this, '.confirm_alert p', '.confirm_alert,.mask', "确认下架此商品？");
	        return false;
	    });
	    $('.goods-listbox li').on("swipeleft", function(e) {
	        var html = " <div class='del_fav'></div>";
	        $(this).append(html);
	        $(this).stop().animate({
	            "margin-left": "-200px"
	        }, 100);
	        $(this).siblings().animate({
	            "margin-left": "0"
	        }, 100);
	        e.stopPropagation();
	        return false;
	    });
	    $(".goods-listbox li").on("swiperight", function(e) {
	        $(this).stop().animate({
	            "margin-left": "0"
	        }, 100);
	        e.stopPropagation();
	    });
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
			
			//1、分类管理；2、全部分类；3、左划删除；4、添加服务；5、编辑、上下架、分享服务
			$('.area1, .area2, .area3, .area4, .area5').attr('coords',x1 +','+ y1 +','+ x2 +','+ y2 +','+ x3 +','+ y3 +','+ x4 +','+ y4);
			$('.area11, .area22, .area33, .area44, .area55').attr('coords',x2 +','+ y2 +','+ x2 +','+ y +','+ w+','+ y +','+ x3 +','+ y3);
		});
		
		$(function(){
	    	$('.mark2').show();
		});
		$(function(){
			$('.area1, .area2, .area3, .area4, .area5').on('click',function(){
	    		$('.mark2').hide();
	    		troggleThisIntroduceSwitch('<%=basePath%>',2);
	    	});
	    	$('.area11').on('click',function(){
	    		$('.img1').hide();
	    		$('.img2').show();
	    	});
	    	$('.area22').on('click',function(){
	    		$('.img2').hide();
	    		$('.img3').show();
	    	});
	    	$('.area33').on('click',function(){
	    		$('.img3').css('display','none');
	    		$('.img4').css('display','block');
	    	});
	    	$('.area44').on('click',function(){
	    		$('.img4').css('display','none');
	    		$('.img5').css('display','block');
	    	});
	    	$('.area55').on('click',function(){
	    		$('.mark2, .img4').css('display','none');
	    		troggleThisIntroduceSwitch('<%=basePath%>',2);
	    	});
		});//end 热点
</script>
<!--<jsp:include page="../head/hideHead.jsp"></jsp:include>-->
</body>
</html>