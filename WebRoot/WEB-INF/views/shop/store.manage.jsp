<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../phone/is_phone.jsp"></jsp:include>
<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
<title>店铺管理</title>
<script type="text/javascript">
//
$(document).ready(function(){
 	var success = '${success}';
	if(success){
		alert("你已开店成功，你的店铺信息需要好站点审核!");
		success = false;
	}
	var messsageCode = '${requestScope.messageCode}';
	var messsage = '${requestScope.message}';
	if(messsage != ''){
		alert(messsage);
	}
});
</script>
</head>
<style type="text/css">
	.banner { width:100%; height:145px; background-color:#ffcc01;}
	.user_box { width:100%; text-align:center; position:relative; top:6px;}
	.user_name { display:block; color:white;}
	.user_name .touxiang,.user_name .tx_edit { display:inline-block;}
	.user_name .touxiang { position:relative; top:15px; width:87px; height:87px; -webkit-border-radius:50%; -moz-border-radius:50%;}
	.user_name .touxiang .bigimg { width:87px; height:87px; border-radius:50%; -webkit-border-radius:50%; -moz-border-radius:50%;}
	.user_name .touxiang .smallimg { display: none; width:20px;}
	.user_name .tx_edit { position:absolute; bottom: -5px; right: -5px;}
	.user_name p { margin-top: 22px; font-size:1.5rem; color:#322c2c; text-align:center;}
	.user_name .att_img { width: 18px; margin-top: -4px; margin-left: 5px; vertical-align: middle;}
	.managebox { width:100%; overflow:hidden;}
	.managebox ul { width:96%; margin:10px auto;}
	.managebox ul li { float:left; width:29%; margin-left:3%; margin-bottom:14px; text-align:center; border:none; border-radius:2px; background-color:white; overflow:hidden;}
	.managebox ul li img { width:60px; margin-top:20px; vertical-align:middle;}
	.managebox ul li p { margin:10px auto 25px; color:#858386; font-size:1.2rem;}
	#shop_avator { opacity:0; position:absolute; height:100px; width:100px; right:-6px; bottom:1px; cursor:pointer;}
	.mt10 { margin-top:10px !important;}
	.f_size { font-size:1.5em; text-align:center;}
	.c_858585 { color:#858585;}
	.charts_box { width: 100%; background-color: white; overflow: hidden;}
	.line_box1 { height: 130px;}
	.line_box2 { height: 200px;}
	.tab_top { float: right; margin-top: 20px; margin-bottom: 10px; text-align: right; border: 1px solid #dedede; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; box-sizing: border-box;}
	.tab_top li { float: right; height: 30px; line-height: 30px; padding: 0 20px; color: #858386; text-align: center; cursor:  pointer;}
	.m_avtive { color: #f42a02 !important;}
	/* chart
	 #pangzi a:nth-child(1) li { border-left: 1px solid #dedede;}
	#pangzi1 { float: left; width: 100%; margin-bottom: 20px; }
	#pangzi1 li { display: none; width: 100%; height: 170px; background: none;}
	#pie_1, #pie_2, #pie_3 { float:left; width: 30%; height: 80px; margin-left: 3.33%; margin-top: 20px;}
	#line_box1, #line_box2 { width: 100%;}
	#line_1, #line_2 { height: 200px;} */
	.tips_message { width: 100%; margin-bottom: 10px; background-color: #fff; overflow: hidden;}
	.tips_message p { width: 94%; padding: 10px 0; margin: 0 auto;}
	.tips_message p img { width: 20px; margin-top: -2px; vertical-align: middle;}
	.tips_message p em { font-size: 1.4rem; color: #322c2c;}
	/*Guide the instructions*/
	.mark2 { position: fixed; left: 0; right: 0; top: 0; bottom: 0; display: block; width: 100%; height: 100%; z-index: 99;}
	.mark2 img { width: 100%;}
	.img2 { display: none;}
	.area1, .area2, .area11, .area22 { -webkit-tap-highlight-color: transparent;}
</style>
<script type="text/javascript" src="<%=basePath %>resources/js/uploadFile.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/js/introduceSwitch.js"></script>
<script type="text/javascript">
	function query(url,id,type){
		$("#id2").val(id);
		$("#type_3").val(type);
		$("#searchForm").attr("action",url).submit();
	}
	function query(url,id){
		$("#id2").val(id);
		$("#searchForm").attr("action",url).submit();
	}
</script>

<body>
	<div class="head">
        <a href="<%=basePath%>index/storeMe" class="head_back">
        	<img src="<%=basePath %>resources/images/back.png" alt="返回" />
        </a>
        <p>店铺管理</p>
        <a href="<%=basePath%>shop/getError?id=${shop.shopId}">
        	<div class="m_new">
        		查看纠错
        	</div>
        </a>
    </div>
    <div class="banner">
	 	<div class="user_box">
	         <a class="user_name">
	             <div class="touxiang">
	             	 <img class="bigimg" src="${shop.logo}">
	                 <span class="tx_edit">
	                 	<img class="smallimg" src="<%=basePath %>resources/images/shopmanage_12.png">
	                 	<form id='allProjectForm' name='allProjectForm' method="post" action="<%=basePath%>shop/uploadImg" target='frameFile'   enctype="multipart/form-data">
	                 		<input type="hidden" id="id" name="id" value="${shop.shopId}">
	                     	<input type="file" accept="image/*" capture="camera" name="imgFile" id="shop_avator">
	                     	<iframe id='frameFile' name='frameFile' style='display: none;'></iframe>
	                    </form>
	                  </span>
	             </div>
	             <p>
	             	<span id="title_name">${shop.name}</span>
	             	<c:choose>
		             	<c:when test="${authStatus == -9 || authStatus==-1 || authStatus==3}">
			             	<!--<img src="<%=basePath %>resources/images/merchantlist_61.png" alt="未认证" class="att_img" />
		             	--></c:when>
		             	<c:otherwise>
			             	<img src="<%=basePath %>resources/images/merchantlist_6.png" alt="已认证" class="att_img" />
		             	</c:otherwise>
	             	</c:choose>
	             </p>
	         </a>
	     </div>
	 </div>
	 <c:if test="${authStatus == -9 || authStatus==3 || authStatus == -1}">
		 <div class="tips_message">
		 	<p>
		 		<c:choose>
		 			<c:when test="${authStatus == -1 }">
		 				<img src="<%=basePath %>resources/images/personalcenter_23.png" alt="" />
		 				<em>亲，您的店铺正在审核认证中，请耐心等待审核结果！&nbsp;&gt;&gt;</em>
		 			</c:when>
		 			<c:otherwise>
		 				<a href="<%=basePath%>auth/gotoAuthEntrance?shopId=${shop.shopId }&re=1&redirectUri=index/manage">
						  	<img src="<%=basePath %>resources/images/personalcenter_23.png" alt="点击进行认证" />
						  	<c:choose>
						  		<c:when test="${authStatus==3}">
								  	<em>亲，您的店铺认证失败了，请重新认证吧&nbsp;&gt;&gt;</em>
						  		</c:when>
						  		<c:otherwise>
								  	<em>您还没有进行店铺认证哦！完成认证生意会更火呢！&nbsp;&gt;&gt;</em>
						  		</c:otherwise>
						  	</c:choose>
					  	</a>
		 			</c:otherwise>
		 		</c:choose>
		 		
			</p>
		 </div>
	 </c:if>
	 <%--
	 <div class="charts_box">
	     <div id="line_box1">
	     	<div id="pie_1"></div>
	     	<div id="pie_2"></div>
	     	<div id="pie_3"></div>
	     </div>
	     <div id="line_box2">
	     	<ul class="tab_top" id="pangzi">
	     		<a href="javascript:void(0);">
	     			<li>月</li>
	     		</a>
	     		<a href="javascript:void(0);">
	     			<li class="m_avtive">周</li>
	     		</a>
	     	</ul>
	     	<ul id="pangzi1">
	     		<li>
	      		<div id="line_1"></div>
	      	</li>
	      	<li style="display:block;">
	      		<div id="line_2"></div>
	      	</li>
	     	</ul>
	     	
	     </div>
	 </div>
	  --%>
	 <div class="managebox">
	 	<ul>
	 		<a href="<%=basePath%>service/listGoods?id=${shop.shopId}&type=3"><li class="mr4"><img src="<%=basePath %>resources/images/shopmanage_5.png"><p>服务管理</p></li></a>
	         <a href="<%=basePath%>order/shopOrderList?shopId=${shop.shopId}&type=3"><li class="mr4"><img src="<%=basePath %>resources/images/shopmanage_6.png"><p>订单管理</p></li></a>
	         <a href="<%=basePath%>shop/setUp?id=${shop.shopId}&type=3"><li><img src="<%=basePath %>resources/images/shopmanage_7.png"><p>店铺设置</p></li></a>
	         <a href="<%=basePath%>shopSlide/addSlide?id=${shop.shopId}&type=3"><li class="mr4"><img src="<%=basePath %>resources/images/shopmanage_8.png"><p>轮播图设置</p></li></a>
	         <a 
	         	<c:choose>
					<c:when test="${isPhone }">
						<c:choose>
							<c:when test="${isIosPhone }">
								href="OC://tag=42"
							</c:when>
							<c:otherwise>
								href="javascript:window.xxxx;"
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
								href="<%=basePath%>index/goodsDetailShop?id=${shop.shopId}&type=3"
					</c:otherwise>
				</c:choose>
	         ><li class="mr4"><img src="<%=basePath %>resources/images/shopmanage_9.png"><p>店铺预览</p></li></a>
	         <a href="<%=basePath%>shop/waiterManage?shopId=${shop.shopId}&type=3"><li class="share_store"><img src="<%=basePath %>resources/images/shopmanage_10.png"><p>服务人员管理</p></li></a>
	 	</ul>
	 </div>
	 
	 <%-- 关闭调用 troggleThisIntroduceSwitch('<%=basePath%>') --%>
	 <c:if test="${introduceSwitch }">
		 <div class="mark2">
		       <img src="<%=basePath %>resources/images/guidance/manage_shop.jpg" alt="修改店标" usemap="#Map1" class="img1" />
		       <map name="Map1">
		         <area shape="poly" coords="5,3,7,53,164,53,164,3" href="javascript:void(0);" class="area1" >
		         <area shape="poly" coords="3,341,3,378,1503,376,1504,338" href="javascript:void(0);" class="area11" >
		       </map>
		       
		       <img src="<%=basePath %>resources/images/guidance/manage_shop_02.jpg" alt="查看纠错" usemap="#Map2" class="img2" />
		       <map name="Map2">
		       	<area shape="poly" coords="5,3,7,53,164,53,164,3" href="javascript:void(0);" class="area2" >
		         	<area shape="poly" coords="3,341,3,378,1503,376,1504,338" href="javascript:void(0);" class="area22" >
		       </map>
	     </div>
	 </c:if>

<script type="text/javascript">
  // add by oyja
$(function(){
    $('.share_store').click(function(){
        $('.share_li,.mask').show();
        var good_content =$(this).closest('li').find('.g-content').html();
    });
    //点击空白处关闭分享弹窗
    $('.mask,.cancel').click(function(){
        $('.share_li,.mask,.confirm,.share_li1').hide();
    });
 	$("#shop_avator").change(function(){
		fileChange(this,'shop_avator','store_manage');
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
		
		//1、修改店标；2、查看纠错
		$('.area1, .area2').attr('coords',x1 +','+ y1 +','+ x2 +','+ y2 +','+ x3 +','+ y3 +','+ x4 +','+ y4);
		$('.area11, .area22').attr('coords',x2 +','+ y2 +','+ x2 +','+ y +','+ w+','+ y +','+ x3 +','+ y3);
	});
	
	$(function(){
    	$('.mark2').show();
    	$('.area1, .area2, .area22').on('click',function(){
    		$('.mark2').hide();
    		troggleThisIntroduceSwitch('<%=basePath%>',1);
    	});
    	$('.area11').on('click',function(){
    		$('.img1').hide();
    		$('.img2').show();
    		troggleThisIntroduceSwitch('<%=basePath%>',1);
    	});
	});//end 热点
});
  
</script>
    
</body>
<%--<jsp:include page="../head/hideHead.jsp"></jsp:include>--%>
<%--公共提示框 --%>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
</html>

