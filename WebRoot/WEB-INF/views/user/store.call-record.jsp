<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="myTags" uri="my-taglib" %>
<!-- 导入 -->
<script type="text/javascript" src="<%=basePath %>resources/js/common.js"></script>
<jsp:include page="../phone/is_phone.jsp"></jsp:include>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>拨号记录</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>

<script src="<%=basePath %>resources/js/zepto.min.js"></script>

<style type="text/css">
	/*content*/
	.content{ width: 100%; overflow: hidden;}
	.content ul{ overflow: hidden;}
	.content ul li{ position: relative; float: left; width: 100%; height: 115px; border-bottom: 1px solid #efefef; background-color: white;  transition:all 0.25s;-webkit-transition:all 0.25s; box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box;}
	.left_imgbox, .right_fontbox{ float: left; }
	.left_imgbox{ width: 80px; min-height: 80px; margin: 14px; text-align: center;}
	.left_imgbox img{  width: 80px; height: 80px; vertical-align: middle; border-radius: 30%; -webkit-border-radius: 30%; -moz-border-radius: 30%; -o-border-radius: 30%;}
	.right_fontbox{ width: 51%; min-height: 90px; color: #858585;}
	.right_fontbox .r_title{ width: 100%; padding: 14px 0 10px; color: #322c2c; font-size: 1.6rem; overflow: hidden;}
	.right_fontbox .r_title .renzheng{ width: 16px; margin-left: 3px; vertical-align: middle;}
	.right_fontbox .r_title .v_em{ padding-left: 5px; font-family: "MS Serif", "New York", serif; color: #e60012;}
	.right_fontbox .description{ width: 100%; padding-bottom: 5px;}
	.right_fontbox .description img { width: 15px; margin-right: 2px;}
	.right_fontbox .description span { margin-left: 3px; font-size: 1.2rem; color: #858386;} 
	.right_fontbox .sort { padding-bottom: 8px; font-size: 1.3rem; color: #f42a02;}
	.right_fontbox .store_category{ float: left; padding: 0 10px; border: 1px solid #eba123; border-radius: 5px; color: #eba123; font-size: 0.7em;}
	.calling{ position: absolute; bottom: 40%; right: 0; width: 50px; height: 50px; line-height: 50px; text-align: center; overflow: hidden;}
	.calling a{ display: block;}
	.calling img{ width: 25px; padding-top: 13px;}
	.right_fontbox .record{ position: absolute; bottom: 26px; right: 5px; width: 50%; text-align: right; overflow: hidden;}
	.record .map_span, .map_span1{ font-size: 1.2rem;}
	.record .map_span b, .map_span1 b{ padding: 5px;}
	.map_span1{ padding-right: 5px;border-right: 1px solid #d5d4d6;}
	.record .map_span img{ width: 15px; padding-left: 5px; vertical-align: bottom;}
	.right_fontbox .last_contact{ margin-bottom: 4px; font-size: 1.2rem; color: #858386;}
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
	.nothing_f { width: 80%; height: 30px; line-height:  30px; margin: 20px auto; font-size: 1.7rem; color: #322c2c; text-align: center;}
	/*sundry*/
	.mt50{ margin-top:50px;}
	.li_nothing{ margin-top:10px; text-align: center;}
	.li_nothing img { width: 55px;}
	.font_nothing{ margin-top:30px; padding-left: 30px; font-size:1.6rem; text-align: center; color:#272728;}
	.ui-loader h1{ display: none;}
</style>

<script type="text/javascript">
	function query(url,id){
		$("#id").val(id);
		$("#searchForm").attr("action",url).submit();
	}
</script>

</head>

<body>
	<header class="head">
        <a href="<%=basePath%>index/storeMe" target="_self" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
        <p>拨号记录</p>
    </header>
    <form action="" id="searchForm" name="searchForm" method="post" target="_self">
	    <div class="content">
	    	<c:choose>
    			<c:when test="${fn:length(calls)>0}">
		    		<c:forEach items="${calls}" var="call" varStatus="status">
				        <ul id="thelist2">
				            <li>
				            	<input type="hidden" name="shopIds" id="shopId${status.index+1 }" value="${call.shopId }">
				    			<input type="hidden" name="callIds" id="callId${status.index+1 }" value="${call.callId}">
				                <a href="<%=basePath%>index/goodsDetailShop?id=${call.shopId}&type=4" data-ajax="false">
				                	<div class="left_imgbox">
				                		<img src="${call.logo }">
				                	</div>
				                </a>
				                <a href="<%=basePath%>index/goodsDetailShop?id=${call.shopId}&type=4" data-ajax="false">
				                	<div class="right_fontbox">
					                    <p class="r_title">${fn:substring(call.name,0,10)}
					                    	<c:if test="${call.isAuth == 2 }">
						                    	<span>
						                    		<img class="renzheng" src="<%=basePath %>resources/images/merchantlist_6.png" alt="商家已认证">
						                    	</span>
					                    	</c:if>
					                    </p>
					                    
					                    <p class="description">
					                    	<c:choose>
												<c:when test="${call.evaluates != null && call.evaluates>0}">
													<c:set var="n" value="0"></c:set>
													<c:forEach begin="1" end="${call.score}">
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
					                        <span>${call.evaluates }评价</span>
					                    </p>
					                    <p class="sort">${call.category }</p>
					                    <p class="last_contact">最后拨打时间：<em><c:choose><c:when test="${fn:length(call.callTime)<10}">${call.callTime}</c:when><c:otherwise>${fn:substring(call.callTime,0,10)}</c:otherwise></c:choose></em></p>
					                    <div class="record">
					                         <span class="map_span1"><b>${call.distance}</b></span>
					                         <c:if test="${call.phoneTimes != 0}">
						                        <span class="map_span"><b id="phoneTimes_${call.shopId}"  >${call.phoneTimes}</b>人拨打</span>
					                    	</c:if>
					                    </div>
					                </div>
				                </a>
				                <p class="calling">
				                	<a href="javascript:phoneCalls2(${call.shopId},'<%=basePath%>call/addCall');" id="phoneTel_${call.shopId}">
				                		<img src="<%=basePath %>resources/images/call.png">
				                	</a>
				                </p>
					            <div class="list_delete"><img src="<%=basePath %>resources/images/shopping_11.png"/></div>
				            </li>
				        </ul>
				     </c:forEach>
				 </c:when>
			 	<c:otherwise>
					<div class='li_nothing'>
						<img class='mt50' src='/resources/images/none-call.png'>
						<p class='font_nothing'>您还没有拨打过商家的电话哦！</p>
					</div>
			   	</c:otherwise>
			</c:choose>
	    </div>
		<div class="message_info">
			<div class="title_info">确定删除此消息？</div>
			<div class="content_info">
				<input type="button" class="cancel" value="取消" />
				<input type="button" class="ensure" value="确定" />
			</div>
		</div>
		<div class="mark"></div>
    </form>
</body>
<jsp:include page="../head/hideHead.jsp"></jsp:include>

</body>
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
        //删去记录
		$('.content li').on({
			'swipeLeft':function(){
				$('.content li').removeClass('li_swipeleft');
				$(this).addClass('li_swipeleft');
				var this_ = $(this).closest("li");
				var call_id = $(this).children("input[name=callIds]").val();
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
					      url: "<%=basePath%>call/delCall",
					      data: {"call_id":call_id,"shop_id":shop_id},
					      success: function(data) {
					      	if(data){
					          $(".message_info, .mark").hide();
							  this_.hide();
							  if($('.content li:visible').length == 0){
									$("#thelist2").html("<div class='li_nothing'><img class='mt50' src='/resources/images/none-call.png'><p class='font_nothing'>您还没有拨打过商家的电话哦！</p></div>");
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
</script>
