<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 导入 -->
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>轮播图设置</title>

<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/js/scroll.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/js/uploadFile.js"></script>

<style type="text/css">
	.main_banner { float: left; width: 100%; margin: 0 auto; position: relative; overflow: hidden;}
	.gallery{ overflow: hidden;}
	.swipe-box{ float: left; overflow: hidden;}
	.swipe-box img{ display: block;}
	.dotlist{ height: 20px; line-height: 5px; -webkit-border-radius: 12px; z-index: 11; text-align: center; margin-top: -22px;}
	.dotlist #swipe-dot{ text-align: center; margin: 2px 0 0 0;}
	.dotlist #swipe-dot span{ display: inline-block; width: 12px; height: 12px;  margin: 0 5px;border-radius: 6px; vertical-align: middle; -webkit-border-radius: 6px; background: #fff;}
	.dotlist #swipe-dot .selected{ background: #eba123;}
	.b_contant{ float: left; width: 100%; border-bottom: 1px solid #efefef; background-color: white; overflow: hidden;}
	.b_contant ul{ width: 94%; margin: 0 auto;}
	.b_contant ul span{ position: relative; display: inline-block; float: left; width: 18%; height: 70px; margin-top: 25px; margin-bottom: 20px; border: 1px solid #dedede; border-radius: 12px; box-sizing: border-box; overflow: hidden;}
	.b_contant ul span:last-child{ margin-right: 0 !important;}
	.b_contant .w100{ width: 100%; height: 122px;}
	.posi_rel{ position: relative;}
	.b_close{ position: absolute; top: 3px; right: 3px; display: inline-block; width: 20px; height: 20px; background: url(/resources/images/shopmanage_22.png) no-repeat; background-size: 100% 100%; z-index: 100;}
	.b_contant .b_p, .b_contant .b_p1{ text-align: center;}
	.b_p{ padding-top: 25px;}
	.b_p1{ font-size: 1.2rem;}
	.tijiao{ width: 100%; border: none; background-color: #f4f4f4; overflow: hidden;}
	.tijiao li{ width: 90%; margin: 25px auto 10px; color: #858386;}
	.txt_center{ text-align: center; z-index: 99;}
	.mr10{ margin-right: 10px;}
	.bg_color{ background-color: #eceaeb;}
	#goods_pic a{ color: #392f3c;}
	.inputfile{ height: 70px;width:100%;opacity: 0; position: absolute;left: 0;top: 0;}
    .ui-loader h1{ display: none;}
    .mr15{ margin-right: 2%;}
    .w_img{ position: absolute; left: 0; width: 100%; height: 70px;}
    .text_center{ text-align: center;}
    .save1{ width: 80%; margin: 0 auto; padding: 8px 0; font-size: 1.7rem; color: #fff; border: none; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; background-color: #ffb400;}
</style>

<script type="text/javascript">
$(document).ready(function(){
 	var fail = '${fail}';
	if(fail != null && fail != ""){
		if(fail == "-1"){
			alert("上传的图片只能在5M以内");
		}
	}
	//点击空白处关闭分享弹窗
    $('.mask').click(function(){
        $('.mask,.share_li1').hide();
    });
});
</script>

</head>


<body>
	<div class="head">
        <a href="<%=basePath%>index/manage" target="_self" class="head_back">
        	<img src="<%=basePath %>resources/images/back.png" alt="返回" />
        </a>
        <p>轮播图设置</p>
    </div>
    <div class="main_banner" >
        <div class="gallery" id="gallery">
        	<c:forEach items="${requestScope.shopslides}" var="s">
	            <c:if test="${s.path != null }">
		        	<div class="swipe-box"><a href="javascript:;"><img src="${s.path}" width="100%;" alt="展示服务大图" /></a></div>
	            </c:if>
        	</c:forEach>
        </div>
        <div class="dotlist">
            <div id="swipe-dot"></div>
        </div>
    </div>
    
    <form id="shopSlide_form" action="<%=basePath%>shopSlide/shopSlidesEdit" method="post" enctype="multipart/form-data">
    	<input type="hidden" name="shop_id" value="${shopId}" />
	    <div class="b_contant">
	    	<ul id="goods_pic">
	    	
	    		<c:set var="size" value="0"></c:set>
	    		<c:forEach items="${requestScope.shopslides }" var="s">
	    			<c:set var="size" value="${size + 1}"></c:set>
		      		<span class="bg_color mr15">
		      			<p class="text_center">
			      			<img class="w_img" id="w-img${size}" src="${s.path}">
		      				<img class="b_p" id="img${size}" src="<%=basePath %>resources/images/plus.png">
		      			</p>
		      			<p class="b_p1">720*640px</p>
		      			<input type="hidden" name="existedId" id="existedId${size}" value="${s.shopslideId }">
		      			<input type="file" accept="image/*" capture="camera" id="inputfile${size}" name="slide1" class="inputfile" disabled="disabled">
		      			<p class="b_close" id="close${size}" onclick="removeClose(this,${size})"></p>
		      		</span>
	    		</c:forEach>
	    		
	    		<c:if test="${ size < 5}">
	    			<c:forEach begin="1" end="${ 5 - size }">
	    				<c:set var="size" value="${size + 1}"></c:set>
		    			<span class="bg_color mr15">
			      			<p class="text_center">
				      			<img class="w_img" id="w-img${size}" src="">
			      				<img class="b_p" id="img${size}" src="<%=basePath %>resources/images/plus.png">
			      			</p>
			      			<p class="b_p1">720*640px</p>
			      			<input type="hidden" name="existedId" id="existedId${size}" value="">
			      			<input type="file" accept="image/*" capture="camera" id="inputfile${size}" name="slide1" class="inputfile">
			      			<p class="b_close" id="close${size}" onclick="removeClose(this,${size})" style="display: none;"></p>
			      		</span>
	    			</c:forEach>
	    		</c:if>
	        </ul>
	    </div>
	    <ul class="tijiao">
	        <li class="txt_center">
				<input type="submit" value="保存修改" class="save1">
	        </li>
	    </ul>
	</form>
	<jsp:include page="../head/hideHead.jsp"></jsp:include>
<%--
	<div class="head">
    	<a class="head-back" href="<%=basePath%>index/manage" target="_self"><img src="<%=basePath %>resources/images/head-back.png"></a>
        <p>轮播图设置</p>
    </div>
    <div class="main-banner" >
    
        <div class="gallery" id="gallery">
        	<c:forEach items="${requestScope.shopslides}" var="s">
	            <c:if test="${s.path != null }">
	            	<div class="swipe-box"><a href=""><img src="${s.path}" width="100%;" /></a></div>
	            </c:if>
        	</c:forEach>
        	
        	<c:if test="${requestScope.shopslides == '[]'}">
        		<div class="swipe-box"><a href=""><img src="<%=basePath %>resources/images/default_empty.png" width="100%;" /></a></div>
        	</c:if>
        </div>
        
        <div class="dotlist">
            <div id="swipe-dot"></div>
        </div>
    </div>
<form id="shopSlide_form" action="<%=basePath%>shopSlide/shopSlidesEdit" method="post" enctype="multipart/form-data">
	
	<input type="hidden" name="shop_id" value="${shopId}" />
	
    <div class="b-contant">
    	<ul id="goods_pic">
    		
    		<c:set var="size" value="0"></c:set>
    		<c:forEach items="${requestScope.shopslides }" var="s">
    			<c:set var="size" value="${size + 1}"></c:set>
	      		<span class="bg-color mr15">
	      			<p class="text-center">
		      			<img class="w-img" id="w-img${size}" src="${s.path}">
	      				<img class="b-p" id="img${size}" src="<%=basePath %>resources/images/plus.png">
	      			</p>
	      			<p class="b-p1">720*640px</p>
	      			<input type="hidden" name="existedId" id="existedId${size}" value="${s.shopslideId }">
	      			<input type="file" accept="image/*" capture="camera" id="inputfile${size}" name="slide1" class="inputfile" disabled="disabled">
	      			<p class="b_close" id="close${size}" onclick="removeClose(this,${size})"></p>
	      		</span>
    		</c:forEach>
    		
    		<c:if test="${ size < 5}">
    			<c:forEach begin="1" end="${ 5 - size }">
    				<c:set var="size" value="${size + 1}"></c:set>
	    			<span class="bg-color mr15">
		      			<p class="text-center">
			      			<img class="w-img" id="w-img${size}" src="">
		      				<img class="b-p" id="img${size}" src="<%=basePath %>resources/images/plus.png">
		      			</p>
		      			<p class="b-p1">720*640px</p>
		      			<input type="hidden" name="existedId" id="existedId${size}" value="">
		      			<input type="file" accept="image/*" capture="camera" id="inputfile${size}" name="slide1" class="inputfile">
		      			<p class="b_close" id="close${size}" onclick="removeClose(this,${size})" style="display: none;"></p>
		      		</span>
    			</c:forEach>
    		</c:if>
    		
        </ul>
    </div>
    <ul class="tijiao">
        <li class="txt-center">
<!--            <a class="finish" href="javascript:save();" >保存修改</a>
			<input type="submit" value="保存修改" class="save1">
        </li>
    </ul>
    <div class="mask"></div>
	<div class="share_li1">
	    <div class="share_txt" id="msg">-</div>
	    
	     --%>
	</div>
</form>    

</body>
</html>

<script type="text/javascript">
//
function save(){
	var path = '';
 	$('#shopSlide_form').attr("action", path).submit();
}

function removeClose(obj,i){
	$("#close"+i).hide();
	$("#inputfile"+i).remove();
	var html = "<input type=\"file\"  id=\"inputfile"+i+"\" name=\"slide1\" class=\"inputfile\" >";
	$(obj).parent().append(html);
	$("#w-img"+i).attr("src","").hide();
    $("#img"+i).show();
    $("#existedId"+i).val("");
    $("#inputfile"+i).change(function(){
    	if(fileChange(this,'inputfile'+i,'broadcasting',i)){
    	
    	}
        /*var url=window.webkitURL.createObjectURL(this.files[0]);
        if (url) {
            $("#w-img"+i).attr("src",url).show();
            $("#img"+i).hide();
            $("#close"+i).show();
        }*/
    });
	//alert($(obj).parent().html());
}

function changeUrl(obj){
	
}

$(function(){
	//$(".b-contant ul li").css("height",$(".b-contant ul li img").height());
	$(".b_contant ul li:last").css({"width":"70px","height":"70px"});

	//add by oyja
	var pic_count = $('#goods_pic span').length;
	if (pic_count > 5) {
		$('span.bg-color').hide();
	};
	$("#inputfile1").change(function(){
		if(fileChange(this,'inputfile1','broadcasting',1)){
			/* var url=window.webkitURL.createObjectURL(this.files[0]);
	        if (url) {
	            pic_count = $('#goods_pic li').length;
	            $("#w-img1").attr("src",url).show();
	            $("#w-img1").attr("style","height:70px");
//	            $("#gallery").html('<div class="swipe-box"><a href=""><img src="'+url+'" width="100%;" /></a></div>');
	            $("#img1").hide();
	            $("#close1").show();
	            if (pic_count >4) {
	                $(this).closest('.bg_color').hide();
	            };
	        }*/
		}
    });
    
    $("#inputfile2").change(function(){
    
   	 	if(fileChange(this,'inputfile2','broadcasting',2)){
	        /*var url=window.webkitURL.createObjectURL(this.files[0]);
	        if (url) {
	        	$("#w-img2").attr("src",url).show();
	        	$("#w-img2").attr("style","height:70px");
	            $("img2").hide();
	            $("#close2").show();
	            pic_count = $('#goods_pic li').length;
	            if (pic_count >4) {
	                $(this).closest('.bg_color').hide();
	            };
	        }*/
	     }
    });
    
     $("#inputfile3").change(function(){
     
	     if(fileChange(this,'inputfile3','broadcasting',3)){
	     	/*var url=window.webkitURL.createObjectURL(this.files[0]);
	        if (url) {
	            pic_count = $('#goods_pic li').length;
	            $("#w-img3").attr("src",url).show();
	            $("#w-img3").attr("style","height:70px");
	            $("img3").hide();
	            $("#close3").show();
	            if (pic_count >4) {
	                $(this).closest('.bg_color').hide();
	            };
	        }*/
	     }
    });
    
     $("#inputfile4").change(function(){
     
     	 if(fileChange(this,'inputfile4','broadcasting',4)){
	        /*var url=window.webkitURL.createObjectURL(this.files[0]);
	        if (url) {
	        	$("#w-img4").attr("src",url).show();
	        	$("#w-img4").attr("style","height:70px");
	            $("img4").hide();
	            $("#close4").show();
	            pic_count = $('#goods_pic li').length;
	            if (pic_count >4) {
	                $(this).closest('.bg_color').hide();
	            };
	        }*/
	      }
    });
     $("#inputfile5").change(function(){
     
     	 if(fileChange(this,'inputfile5','broadcasting',5)){
	        /*var url=window.webkitURL.createObjectURL(this.files[0]);
	        if (url) {
	        	$("#w-img5").attr("src",url).show();
	        	$("#w-img5").attr("style","height:70px");
	            $("img5").hide();
	            $("#close5").show();
	            pic_count = $('#goods_pic li').length;
	            if (pic_count >4) {
	                $(this).closest('.bg_color').hide();
	            };
	        }*/
	     }
    });
    //add by oyja end
});
$(function() {
	var da = $(window).width();
	var xiao = $(".head").width();
	if (da > 720) {
		$(".swipe-box").css("width",document.documentElement.clientWidth);
		$(".swipe-box img").css("width",document.documentElement.clientWidth);
	} else {

		$(".swipe-box").css("width", $(window).width());
		$(".swipe-box img").css("width", $(window).width());
	}

	if (document.getElementById("gallery")) {
		var gallery = new ScrollPic();
		gallery.scrollContId = "gallery";
		//内容容器ID
		gallery.dotListId = "swipe-dot";
		//点列表ID
		gallery.dotOnClassName = "selected";
		gallery.arrLeftId = "sw-left";
		//左箭头ID
		gallery.arrRightId = "sw-right";
		//右箭头ID
		gallery.frameWidth = xiao;
		gallery.pageWidth = xiao;
		gallery.upright = false;
		gallery.speed = 5;
		gallery.space = 30;
		gallery.initialize();
		//初始化
	}
});

/*function alertMsg(msg){
	$("#msg").html(msg);
	$(".share_li1, .mask").show();
}
*/
</script>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
