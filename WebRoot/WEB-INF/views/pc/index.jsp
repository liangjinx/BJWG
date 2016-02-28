<%@ page language="java" import="java.util.*,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="__page_name__" value="我的猪场" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="./meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/idangerous.swiper.css" />
<link rel="stylesheet" href="resources/css/pc/main.css"/>
 	
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/idangerous.swiper.min.js" ></script>
<script src="resources/js/pc/public.js"></script>
<style>
	.swiper-container { height: 560px;min-width: 1200px;}
	.swiper-slide{}
	.swiper-slide, .swiper-slide img { width: 100%; height: 540px;}
	.pagination { position: absolute; z-index: 20; bottom: 10px; width: 100%; text-align: center;}
	.swiper-pagination-switch { width: 100px; height: 5px; display: inline-block; margin: 0 5px; border-radius: 8px; background: #000; opacity: 0.2;}
	.swiper-active-switch { opacity: 1; background: #f1732e;}
	.pigfarm_but{ width:240px; height:60px; position:absolute; margin-left:870px; margin-top:380px;}
	.pigfarm_but img{width:240px; height:60px; display:block; text-align:center; cursor:pointer;}
	.mt15 { margin-top: 15px;}
	.p_father {position: absolute; bottom: 1px; width: 360px; height: 130px; background-color: white; z-index: 10;}
	.pigfarm_but_z { width: 150px; height: 150px; position: absolute; margin-left: 870px; margin-top: 30px;}
	.pigfarm_but_z img { width: 150px; height: 150px;}
	.banner_right { margin-right: 60px;}
	.banner_right .banner_code_box { right: -24px;}
	
	#red{
	color: red;
	}
</style>
</head>
<body>


<a id="ibangkf" href="http://www.ibangkf.com">在线客服系统</a>
<script type="text/javascript" src="http://c.ibangkf.com/i/c-lizhiliang.js"></script>

<!--banner_box -->
<jsp:include page="header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="nav.jsp">
	<jsp:param value="1" name="nav"/>
</jsp:include>
<!-- 导航栏-->
<!--中间部分 -->
   
<!-- Swiper -->
    <%-- <div class="swiper-container">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
            
            	<div class="bubble_box">bubble_box
                	<div class="bubble_main">
            		<div class="bubble">
                    	<p class="m_top30">总数</p>
                       <div class="bubble_tit"><p>3<span>只</span></p></div>
            		</div>
                    <div class="bubble m_left60">
                    	<p class="m_top20">成长<br>状态</p>
                        <div class="bubble_tit"><p>0%</p></div>
            		</div>
                    <div class="bubble m_left60">
                    	<p class="m_top20">成长<br>状态</p>
                        <div class="bubble_tit"><p>0.00</p></div>
            		</div>
                    <div class="clear"></div>
                    </div>
                </div>bubble_box
                
            <img src="resources/images/pc/banner01.png"/>
            </div>
            <c:forEach items="${slides}" var="s" varStatus="status">
            	<div class="swiper-slide"><img src="${s.path }"/></div>
            </c:forEach>
        </div>
         <div class="swiper-pagination"></div>
    </div> --%>
    
    <%-- 29 --%>
    <%-- <div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<div class="bubble_box"><!--bubble_box -->
					<div class="bubble_main">
					<div class="bubble">
						<p class="m_top30">总数</p>
					   <div class="bubble_tit"><p>3<span>只</span></p></div>
					</div>
					<div class="bubble m_left60">
						<p class="m_top20">成长<br>状态</p>
						<div class="bubble_tit"><p>0%</p></div>
					</div>
					<div class="bubble m_left60">
						<p class="m_top20">成长<br>状态</p>
						<div class="bubble_tit"><p>0.00</p></div>
					</div>
					<div class="clear"></div>
					</div>
				</div><!--bubble_box-->
				<img src="resources/images/pc/banner01.png"/>
			</div>
			<c:forEach items="${slides}" var="s" varStatus="status">
            	<div class="swiper-slide"><img src="${s.path }"/></div>
            </c:forEach>
		</div>
		<div class="pagination"></div>
	</div>
	<a href="pc/pnv/mobileFarm">进入猪场</a> --%>
	
	<div class="swiper-container">
		<div class="swiper-wrapper">
			
			<c:forEach items="${slides}" var="s" varStatus="status">
				<c:if test="${status.index == 0 }">
	            	<div class="swiper-slide">
	            		<c:if test="${s.link!=null and s.link!='' }">
	            			<a href="${s.link }" target="_blank"><img src="${s.path }" alt="广告"/></a>
	            		</c:if>
	            		<c:if test="${s.link==null or s.link=='' }">
	            			<img src="${s.path }" alt="广告"/>
	            		</c:if>
	            	</div>
            	</c:if>
            </c:forEach>
            
            <div class="swiper-slide">
				<div class="bubble_box"><!--bubble_box -->
					<div class="bubble_main">
					<div class="bubble">
						<p class="m_top30">总数</p>
					   <div class="bubble_tit"><p>3<span>只</span></p></div>
					</div>
					<div class="bubble m_left60">
						<p class="m_top20">成长<br>状态</p>
						<div class="bubble_tit"><p>0%</p></div>
					</div>
					<div class="bubble m_left60">
						<p class="m_top20 z_img"><img alt="收益" src="resources/images/pc/z-money.png"></p>
						<div class="bubble_tit"><p>0.00</p></div>
					</div>
					<div class="clear"></div>
					</div>
				</div><!--bubble_box-->
				<a class="pigfarm_but_z" href="javascript:;">
					<img src="resources/images/pc/z_sun.png" alt="" />
				</a>
                <a class="pigfarm_but" href="pc/pnv/mobileFarm">
                	<img src="resources/images/pc/pigfarm_but.png" alt="进入猪场"/>
                </a>
				<img src="resources/images/pc/banner011.png" />
			</div>
			
			<c:forEach items="${slides}" var="s" varStatus="status">
				<c:if test="${status.index > 0 }">
	            	<div class="swiper-slide">
	            		<c:if test="${s.link!=null and s.link!='' }">
	            			<a href="${s.link }" target="_blank"><img src="${s.path }" alt="广告"/></a>
	            		</c:if>
	            		<c:if test="${s.link==null or s.link=='' }">
	            			<img src="${s.path }" alt="广告"/>
	            		</c:if>
	            	</div>
				</c:if>
            </c:forEach>
			
		</div>
		<div class="pagination"></div>
	</div>
<!-- 中间部分-->
<div class="center">
	<p class="p_36 t_center m_top50">打造一套强大的互联网养殖体系</p>
    <p class="p_18_tit t_center m_top10">无后顾之忧，轻松体验线上养猪乐趣</p> 
    <div class="clear"></div>   
    	<ul class="cultivation_ul">
        	<li class="this_li zxyz_but"><a>在线养殖</a></li>
            <li class="xzgc_but"><a>现场观察</a></li>
            <li class="wdsy_but"><a>稳定收益</a></li>
            <li class="jtxf_but"><a>家庭消费</a></li>
            <li class="yhtq_but"><a>用户特权</a></li>
        </ul> 
     <div class="clear"></div>
     <!-- 用户特权-->
     <ul class="pig_show_ul pig_ul2" id="yhtq_ul">
     	<li><a>
        	<img src="resources/images/pc/pig_show8.png" class="img" alt="2100元的猪肉券">
        	<div class="p_father">         
            	<div class="p_show"><p>用户可自行到深圳润民旗下的任何“八戒王国”社区店和专卖店凭猪肉券领取猪肉</p></div></div></a>
        </li>
        <li><a>
        	<img src="resources/images/pc/pig_show9.png" class="img" alt="在线下单购买">
        	<div class="p_father">           
            	<div class="p_show"><p>用户可在润民商城和微商城下单购买，并按约定时间和地点凭猪肉券领取猪肉。</p></div></div></a>
        </li>        
     </ul> 
     <!-- 家庭消费-->
     <ul class="pig_show_ul pig_ul2" id="jtxf_ul">
     	<li><a>
        	<img src="resources/images/pc/pig_show6.png" class="img" alt="新鲜猪仔">  
        	<div class="p_father">          
            	<div class="p_show"><p>用户可到养猪场领取活猪</p></div></div></a>
        </li>
        <li><a>
        	<img src="resources/images/pc/pig_show7.png" class="img" alt="鲜猪肉">
        	<div class="p_father">           
            	<div class="p_show"><p>可根据用户要求屠宰配送到家，农场直达餐桌。确保新鲜。</p></div></div></a>
        </li>        
     </ul> 
     <!-- 稳定收益-->
     <ul class="pig_show_ul pig_ul1" id="wdsy_ul">
     	<li><a>
        	<img src="resources/images/pc/pig_show5.png" class="img" alt="委托深圳润民">
        	<div class="p_father">            
            	<div class="p_show"><p>用户委托深圳润民销售生猪，养殖周期结束，收入自动转入用户账户</p></div></div></a>
        </li>               
     </ul> 
     <!-- 现场观察-->
     <ul class="pig_show_ul pig_ul2" id="xcgc_ul">
     	<li><a>
        	<img src="resources/images/pc/pig_show3.png" class="img" alt="实时猪场">
        	<div class="p_father">            
            	<div class="p_show"><p>饲养猪仔过程中，可以通过实时远程监控系统，随时查看猪仔饲养状况</p></div></div></a>
        </li>
        <li><a>
        	<img src="resources/images/pc/pig_show4.png" class="img" alt="八戒王国高空俯瞰">
        	<div class="p_father">           
            	<div class="p_show"><p>养殖期间经提前预约，用户可到养猪场查看猪仔生长状况和养殖模式</p></div></div></a>
        </li>        
     </ul> 
     <!-- 在线养殖-->
     <ul class="pig_show_ul" style="display:block;" id="zxyz_ul">
     	<li><a href="pc/pnv/inShopping">
        	<img src="resources/images/pc/pig_show1.png" class="img" alt="主人你好">
        	<c:choose>
        		<c:when test="${curProj!=null }">
        			<div class="p_father">
	        			<div class="p_tit"><p>火热进行中......</p></div>
	            		<div class="p_show"><p><fmt:formatDate value='${curProj.beginTime }' pattern='E（MM月dd日） a hh：mm' /></p></div>
	            		<div class="p_none"><p>仅开放${curProj.num }只，请养殖主准时关注</p></div></div></a>
        		</c:when>
        		<c:otherwise>
        			<div class="p_father">
	        			<div class="p_tit"><p>当前没有活动哦, 尽请期待</p></div>
	            		<div class="p_show"><p></p></div></div></a>
        		</c:otherwise>
        	</c:choose>
        </li>
        <li><a href="pc/pnv/nextShopping">
        	<img src="resources/images/pc/pig_show11.png" class="img" alt="主人你好">
            <c:choose>
        		<c:when test="${nextProj!=null }">
        			<div class="p_father">
	        			<div class="p_tit"><p>${nextProj.name }抢猪预告</p></div>
	            		<div class="p_show"><p><fmt:formatDate value='${nextProj.beginTime }' pattern='E（MM月dd日） a hh：mm' /></p></div>
	            		<div class="p_none"><p>仅开放${nextProj.num }只，请养殖主准时关注</p></div></div></a>
        		</c:when>
        		<c:otherwise>
        			<div class="p_father">
	        			<div class="p_tit"><p>当前没有活动哦, 尽请期待</p></div>
	            		<div class="p_show"><p></p></div></div></a>
        		</c:otherwise>
        	</c:choose>
        </li>
        <li style="margin-right:0px;"><a href="pc/pnv/inShopping?select=rating">
     
     
   
        	<img src="resources/images/pc/pig_show2.png" class="img" alt="本期排行">
     
        	<c:choose>
        		<c:when test="${curProj!=null }">
        			<div class="p_father">
	         	 		<div class="p_tit"><p>已成功抢购猪仔名单</p></div>
	        	    	<div class="p_show"><p><fmt:formatDate value='${curProj.beginTime }' pattern='E（MM月dd日） a hh：mm' /></p></div>
	        		</div></a>
        		</c:when>
        		<c:otherwise>
        			<div class="p_father">
	        			<div class="p_tit"><p>当前没有活动哦, 尽请期待</p></div>
	            		<div class="p_show"><p></p></div>
	            	</div></a>
        		</c:otherwise>
        	</c:choose>
        	
        </li>
     </ul> 
     
     <div class="clear"></div> 
        
</div>   
<div class="earnings_box"><img src="resources/images/pc/earnings_img.png" alt=""/></div>
<div class="news_box">
	<div class="clear"></div> 
	<p class="p_36 t_center">资讯导航</p>
    <p class="p_18_tit t_center m_top10">坚持科技创新，树立行业标杆</p>
    <div class="center news_main">
    	<c:set var="newsCount" value="${fn:length(news)}"/>
    	<ul class="news_left_ul">
    		<c:forEach items="${news}" var="nw" varStatus="status">
    			<c:if test="${status.index+1 != newsCount }">
    				<li><a href="pc/pnv/newsDetail?newsId=${nw.infoId }"><img src="${nw.path }" alt="" class="news_img"/><p class="p_18 t_center f_l p_0_5">${nw.title }</p></a></li>
    			</c:if>
    		</c:forEach>
        </ul>
        <div class="news_right_box">
        	<div class="left_main"><img src="${news[newsCount-1].path }" alt="" class=""/>            
            <p class="p_18 t_center">${news[newsCount-1].title }</p>
            </div>
            <div class="news_body">
            	 <p class="p_18 m_top30">${news[newsCount-1].title }</p>
                 <p class="p_12 m_top20">       ${news[newsCount-1].summary }</p>
            	 <a class="news_but_details" href="pc/pnv/newsDetail?newsId=${news[newsCount-1].infoId }">资讯详情</a>
            </div>
            <div class="clear"></div> 
        </div>
        <div class="clear"></div> 
    </div>
    <div class="clear"></div> 
</div>
<!-- 中间部分-->

<!--底部 -->
<jsp:include page="footer.jsp"></jsp:include>
<!--底部 -->
</body>
<script>
$(function(){
	
	
	//滑块
	/*  var swiper = new Swiper('.swiper-container', {               
        slidesPerView:'auto' ,
		pagination : '.swiper-pagination',
		paginationClickable :true,		
		scrollbarHide:false,
		mousewheelControl : false,
		autoplayDisableOnInteraction: false,
        loop: true,
		autoplay: 5000,
		touchRatio : 0.5,
	 }) */
	
	 var mySwiper = new Swiper('.swiper-container',{
			pagination : '.pagination',
			paginationClickable :true,
			loop: true,
			autoplay : 5000
		})
	 
	//中间导航
	var this_li_a = $('.cultivation_ul').find('.this_li');
	$('.cultivation_ul li').click(function(){
		$('.cultivation_ul li').removeClass('this_li');
		$(this).addClass('this_li');
		})
		
 
	})
	
	// 
	$('.pig_show_ul li').hover(function(){
		$(this).find('.p_father').animate({'height':'145px'},200);
		$(this).find('.p_none').css('display','block');	
		},function(){
		$(this).find('.p_father').animate({'height':'130px'},200);
		$(this).find('.p_none').css('display','none');			
	})
	
	//收藏
	function AddFavorites(title, url) {
        try {
              window.external.addFavorite(url, title);
              }
        catch (e) {
            try {
                   window.sidebar.addPanel(title, url, "");
            }
            catch (e) {
                 alert("抱歉，您所使用的浏览器无法完成此操作。\n\n加入收藏失败，请使用Ctrl+D进行添加");
            }
          }
	}
</script>

</html>
