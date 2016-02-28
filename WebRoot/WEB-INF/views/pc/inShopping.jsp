<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="__page_name__" value="抢猪仔" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="./meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/public.css"/>
<link rel="stylesheet" href="resources/css/pc/video-js.min.css" />
<script src="resources/js/pc/video.js"></script>
<script>
 
 function getD(){
 var myDate = new Date();
 
return myDate.getMinutes();
}

    videojs.options.flash.swf = "resources/flash/pc/video-js.swf";

	     window.setInterval(flash, 1000*60); 
	function flash(){
if(getD()==0){
	window.location.href="pc/pnv/inShopping";
}
	}; 

 
</script>


</head>
<body>
<input type="hidden" value="${param.cnav }" name="cnav"/>
<input type="hidden" value="${curProj.leftNum }" name="leftNum"/>

<!--banner_box -->
<jsp:include page="./header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="./nav.jsp">
	<jsp:param value="3" name="nav"/>
</jsp:include>
<!-- 导航栏-->
	
	
<div class="shop-banner" style="background:url(resources/images/pc/shop-ban-1.jpg) no-repeat center center;"></div>

<!-- content start -->

<div class="d-wrap">
	${flag}
	<div class="shop-cont">
		<div class="sub-nav row-1">
			<ul class="of-hide">
				<li class="now fl-left current"><a href="pc/pnv/inShopping">正在抢购的猪仔</a></li>
				<li class="ready fl-left"><a href="pc/pnv/nextShopping">下期准备抢的猪仔</a></li>
				<li class="ready fl-left"><a href="pc/pnv/judgeLogin">预抢的猪仔</a></li>
			</ul>
		</div>
		<c:choose>
			<c:when test="${curProj!=null }">
		<div class="row-2 of-hide summary now-sum">
			
			<div class="row-left fl-left">
				<img src="resources/images/pc/shop-row-2-2.png" alt="八戒" />
			</div>
			
			<!---- 售磐则添加 sell-out 类 ---->
			<!--<div class="row-right fl-right sell-out">-->
			<div class="row-right fl-right ${curProj.leftNum<=0 ? 'sell-out' :'' }">
				<div class="title of-hide">
					<span class="fl-left s1">基本信息</span>
					<span class="fl-right s2">开抢时间：&nbsp;<i>进行中</i></span>
				</div>
				<div class="icon-sell"><img src="resources/images/pc/shop-row-2-3.png" alt="已售磐" width="148" height="148"/></div>
				<ul class="info">
					<!--<li class="type">猪的品种：<span>苏联大白猪</span></li>
					-->
					<li class="num">
						已抢猪仔数：<span>${curProj.num - curProj.leftNum }只</span>
						<div class="bar of-hide" style="width:272px;">
							<div class="all">共${curProj.num }只</div>
							<div class="bar-now" style="clip:rect(0,272px,26px,${272 / curProj.num* curProj.leftNum}px);">共${curProj.num }只</div> <!--242为剩余数量-->
						</div>
					</li>
					<li class="revenue">预计年化收益率：<span>${yearRate }%</span></li>
					<li class="price">抢购单价金额：<span>${curProj.price }元</span></li>
				</ul>
				<form method="get" id="spForm" action="">
				<input type="hidden" name="projectId" value="${curProj.paincbuyProjectId }"/>
				<ul class="form">
					<li class="li-row1">购买数量</li>
					<li class="li-row2 of-hide">
						<div class="stock fl-left">
							<button type="button" class="cut d-btn">-</button>
							<input type="text" name="num" class="num" value="1" maxLength=4 onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>
							<button type="button" class="add d-btn">+</button>
						</div>
						<div class="sub-btn fl-left">
							<input type="button" value="立即抢购" class="d-btn" id="btnSub"/>
						</div>
					</li>
					<li class="li-row3">
						<label for="protocol"></label>
						<input type="checkbox" id="protocol" checked="checked"/>
						<a href="javascript:;" class="dib agreement-btn">同意《用户协议》</a>
					</li>
				</ul>
				</form>
			</div>
		</div>		
<!--lg -->
 <div class="clear"></div> 
 <!--二级导航 -->
<div class="lg_sp_nav_box"> 	 
 	<ul class="lg_sp_nav">
 		<li class="this_li _ck_6">项目详情</li>
 		<li class="_ck_1">其他费用详情</li>
    	<li class="_ck_2">回报展示</li>
    	<li class="_ck_3">评论</li>
    	<!-- <li class="_ck_4">本期排名</li> --> 
    	
    	<li class="_ck_5">本期排名</li>
    	 
 	</ul>
    <div class="clear"></div> 
		<div class="nav_bg"></div>  
 	<div class="clear"></div>  
</div><!--lg_sp_nav_box-->
<div class="clear"></div>   
	<div class="shopping_box"><!--shopping_box -->
    	<div class="clear"></div> 
        
        <!-- star 项目详情 -->
        <div class="lg_main" style="display:block;"> 
	    	<div class="z_xiangmu">${curProj.detail }</div>
		</div> <!-- end 项目详情 -->

        <!-- star 其他费用详情 -->
        <div class="lg_main">
        	<div class="z_xiangmu">${curProj.otherFeeDetail }</div>
        </div><!-- end 其他费用详情 -->
    

	<div class="lg_main">
    	<div class="clear"></div>
            <div class="lg_main_tit lg_top20">
            	<img src="resources/images/pc/point1.png" alt="点"/><p>回报展示</p><img src="resources/images/pc/point1.png" alt="点"/>
            </div><!--lg_main_tit -->
            <div class="clear"></div>
            	<div class="lg_hbzs"></div>
            <div class="clear"></div>
	</div> <!--lg_main -->   
    
    
  	<div class="lg_main">
    	<div class="clear"></div>
            <div class="lg_main_tit lg_top20">
            	<img src="resources/images/pc/point1.png" alt="点"/><p>全部评论</p><img src="resources/images/pc/point1.png" alt="点"/>
            </div><!--lg_main_tit -->
        <div class="clear"></div>
        <c:choose>
			<c:when test="${sessionScope[CommConstant.SESSION_MANAGER] != null and sessionScope[CommConstant.SESSION_MANAGER]!='session_manager'}">
				<div class="lg_pl_ts">最多输入140字</div>
        		<textarea placeholder="  有什么想对大家说的，快讲吧！" name="comment" class="lg_placeholder" maxlength="140"></textarea>
        		<div class="clear"></div> 
        		<input type="button" class="lg_but" value="发表评价" id="btnCmtSub"/>
        	</c:when>
       		<c:otherwise>
        		<div class="z_no_jilu">您暂未登录无法发布评论</div>
        	</c:otherwise>
		</c:choose> 
    	
        <div class="clear"></div>
        <c:choose>
        	<c:when test="${fn:length(commentList)>0 }">
        		<div class="d-comment">
        		<ul class="comm-list">
        			<c:forEach items="${commentList}" var="c">
        				<li class="row">
							<div class="top">
								<c:set var="nickLength" value="${fn:length(c.nickName)}"/>
								<%-- <span class="name fl-left">昵称：${fn:substring(c.nickName, 0, (nickLength>2)?nickLength-2:nickLength)}**</span>--%>
								<span class="name fl-left">昵称：${c.nickName }</span>
							<span class="time fl-right"><fmt:formatDate value='${c.ctime }' pattern='yyyy-MM-dd HH:mm:ss' /></span>
							</div>
							<div class="head-img"><img class="lazy" src="${c.img }" data-original="${c.img }" alt="头像" /></div>
							<div class="cnt">
								${c.content }
							</div>
						</li>
        			</c:forEach>
				</ul>
        		<jsp:include page="./pager.jsp">
					<jsp:param name="pagerConfigArg" value="pager_cmt"/>
					<jsp:param name="otherQueryArg" value="cnav=3"/>
				</jsp:include>
        		<div class="clear"></div>  
				</div>
        	</c:when>
        	<c:otherwise>
        		<div class="z_no_jilu">还没有人评论哦</div>
        	</c:otherwise>
        </c:choose>
    </div><!--lg_main -->
   	<div class="lg_main">
    	<div class="clear"></div>
            <div class="lg_main_tit lg_top20">
            	<img src="resources/images/pc/point1.png" alt="点"/><p>本期排名</p><img src="resources/images/pc/point1.png" alt="点"/>
            </div><!--lg_main_tit -->
    		<div class="clear"></div>
    			<c:choose>
    				<c:when test="${fn:length(ratings)>0 }">
    					<div class="tran-table lg_top20">
						<div class="tab-tr head-tr">
							<div class="tr-td tr-td-1">头像</div>
								<div class="tr-td tr-td-2">&nbsp;</div>
							<div class="tr-td tr-td-3">昵称</div>
								<div class="tr-td tr-td-4">&nbsp;</div>
							<div class="tr-td tr-td-5">数量</div>
							
						</div>
						<%-- <c:forEach items="${buyRdList}" var="rd">
							<div class="tab-tr body-tr">
								<div class="tr-td tr-td-1">
									<img class="lazy" src="${rd.headImg }" data-original="${rd.headImg }" alt="头像" />
								</div>
								<c:set var="nickLength" value="${fn:length(rd.nickName)}"/>
								<div class="tr-td tr-td-2">${fn:substring(rd.nickName, 0, (nickLength>2)?nickLength-2:nickLength)}**</div>
								<div class="tr-td tr-td-2">AA${rd.nickName}</div>
								<div class="tr-td tr-td-3">${rd.count }</div>
								<div class="tr-td tr-td-4">${rd.projectName }</div>
								<div class="tr-td tr-td-5"><fmt:formatDate value='${rd.gmtPayTime }' pattern='yyyy-MM-dd HH:mm:ss' /></div>
							</div>
						</c:forEach> --%>
							<c:forEach items="${top20}" var="status">
							<div class="tab-tr body-tr">
								<div class="tr-td tr-td-1">
									<img class="lazy" src="${status.headImg }" data-original="${status.headImg }" alt="头像" />
								</div>
								<c:set var="nickLength" value="${fn:length(status.username)}"/>
								<%-- <div class="tr-td tr-td-2">${fn:substring(rd.username, 0, (nickLength>2)?nickLength-2:nickLength)}**</div> --%>
								<div class="tr-td tr-td-2">&nbsp;</div>
								<div class="tr-td tr-td-3">${fn:substring(status.username, 0, (nickLength>2)?3:nickLength)}*****</div>
								<div class="tr-td tr-td-4">&nbsp;</div>
								<div class="tr-td tr-td-5">${status.extend1}</div>
								
								
							</div>
						</c:forEach>
						
					
						
						
						
						
						
			<%-- 		<c:forEach items="${ratings}" var="status">
							<div class="tab-tr body-tr">
								<div class="tr-td tr-td-1">
									<img class="lazy" src="resources/images/default.png" " data-original="" alt="头像" />
								</div>
							<c:set var="nickLength" value="${fn:length(status.phone)}"/>
			<div class="tr-td tr-td-2">${fn:substring(rd.username, 0, (nickLength>2)?nickLength-2:nickLength)}**</div>
								<div class="tr-td tr-td-2">&nbsp;</div>
								<div class="tr-td tr-td-3">${fn:substring(status.phone, 0, (nickLength>2)?3:nickLength)}*****</div>
								<div class="tr-td tr-td-4">&nbsp;</div> 
								<div class="tr-td tr-td-5">${status.count}</div>
								
								
							</div>
						</c:forEach> --%>
						
						
						<%-- <jsp:include page="./pager.jsp">
							<jsp:param name="pagerConfigArg" value="pager_buy"/>
							<jsp:param name="otherQueryArg" value="cnav=4"/>
						</jsp:include> --%>
					</div>
    				</c:when>
    				<c:otherwise>
    					<div class="z_no_jilu">暂时没有交易记录哦</div>
    				</c:otherwise>
    			</c:choose>
            <div class="clear"></div>
    </div><!--lg_main -->
    
   	<div class="lg_main">
    	<div class="clear"></div>
            <div class="lg_main_tit lg_top20">
            	<img src="resources/images/pc/point1.png" alt="点"/><p>本期排名</p><img src="resources/images/pc/point1.png" alt="点"/>
            </div><!--lg_main_tit -->
    		<div class="clear"></div>
    		<c:choose>
    			<c:when test="${fn:length(top20)>0 }">
    				<div class="tab-cont">
						<div class="cont-1 d-details">
						<ul class="ranking-list clearfix lg_ranking-list">
						<c:forEach items="${top20}" var="tp" varStatus="status">
							<li class="item front">
								<div class="num">${status.index+1 }</div>
								<div class="img"><a href="javascript:;"><img src="${tp.headImg }" alt="小猪仔" /></a></div>
								<div class="txt">
									<p>昵称：${tp.nickname }</p>
									<p>抢购数量：${tp.extend1 }只</p>
								</div>
							</li>
						</c:forEach>
						</ul>
						</div>
					</div>
    			</c:when>
    			<c:otherwise>
    				<div class="z_no_jilu">暂时没有交易记录哦</div>
    			</c:otherwise>
    		</c:choose>
    		<div class="clear"></div>
    </div><!--lg_main -->
    
	<div class="clear"></div>     
</div><!--shopping_box -->
<div class="clear"></div>       
<!--lg -->
</c:when>
<c:otherwise>
	<!-- 暂时没有项目在进行中哦 -->
	<div class="row-2 of-hide summary ready-sum">
		<div class="z_no_shoppingnew"></div>
	</div>
</c:otherwise>
</c:choose>	
<div >
抢猪仔说明：

</div>

</div>

<!-- content end -->

<!--底部 -->
<jsp:include page="./footer.jsp"></jsp:include>
<!--底部 -->

	<div class="agreement">
		<div class="agr-bd"></div>
		<div class="agr-main">
			<h2 class="title">“八戒王国”协议书</h2>
			<div class="cont">
				${protocol.content}
			</div>
			<div class="btn-sure">
				<button class="btn-submit">同意并继续</button>
			</div>
		</div>
	</div>
</div>

</body>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/jquery.lazyload.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script>
	$(function(){
		
		(function(){
			/*图片懒加载*/
			$("img.lazy").lazyload({ 
				threshold : 200
			});
			
			/*商品加减*/
			$('.stock .add').on('click', function(){
				var num = parseInt($('.stock .num').val());
				if(!num && num!==0){
					num=0;
				}
				++num;
				num = (num>9999) ? 9999 : num;
				
				var leftNum = parseInt($('[name=leftNum]').val());
				
				num = (num>leftNum) ? leftNum : num;
				
				$('.stock .num').val(num);
			})
			$('.stock .cut').on('click', function(){
				var num = parseInt($('.stock .num').val());
				if(!num && num!==0){
					num=0;
				}
				--num;
				num = (num <= 1) ? 1 : num;
				 $('.stock .num').val(num);
			})
			
			/*协议*/
			$('.agreement-btn').on('click', function(){
				$('.agreement').fadeIn('fast');
			})
			$('.agreement .btn-submit').on('click', function(){
				$('.agreement').fadeOut('fast');
			})
			
			/*同意协议才能抢购*/
			/*$('#protocol').on('change', function(){
				if($('#protocol').is(':checked')){
					$('#btnSub').removeAttr('disabled');
				}else{
					$('#btnSub').attr('disabled','disabled');
				}
			})*/
			
			/*详情评论tab切换*/
			var numb = 1;
			$('.lg_sp_nav li').on('click', function(){
				var index = $(this).index();
				var left_ = index*168
				$('.shopping_box .lg_main').css('display','none');
				$('.shopping_box .lg_main').eq(index).css('display','block');
				$('.lg_sp_nav li').css('color','#333');
				$(this).css('color','#fff');
				$('.lg_sp_nav_box .nav_bg').css('margin-left',(left_+'px'));
			})
			
			
				/*详情评论tab切换*/
			if('<%=request.getAttribute("flag")%>'=='s'){
				$('._ck_5').trigger("click");
			}
			
				
			
			/*售磐后按钮不可点*/
			$('.sell-out .sub-btn .d-btn').attr('disabled','disabled');
			
			
		})()
		
		$('#btnSub').click(function(){
			if(!$('#protocol').is(':checked')){
				alert('请先同意用户协议');
				return;
			}
			var num = parseInt($('.stock .num').val());
			var leftNum = parseInt($('[name=leftNum]').val());
			if(!$('.stock .num').val() || $('.stock .num').val()==0){
				alert('请输入抢购数量!');
				return;
			}
			if(num>leftNum){
				alert('抢购数量超出!');
				return;
			}
			$('#spForm').attr('action',__base_path__+'pc/pv/order/submitConfirm').submit();
		})
		
		$('#btnCmtSub').click(function(){
		var self = $(this);
		var content = $('[name=comment]').val().trim();
		
		if(content == ''){
			alert('请输入必填项');
			return;
		}
		
		self.attr('disabled','disabled');
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/addComment',
		    cache: false,
		    data: {content:content},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('评论成功')
		    		window.location.href=__base_path__+'pc/pnv/inShopping';
		    	} else {
		    		alert(data.data.text);
		    		self.removeAttr('disabled');
		    	}
		    },
		    error: function(){
		    	alert('error');
		    }
		});
		})
		
		
		if($('[name=cnav]').val()=='3'){
			$('._ck_3').trigger('click');
		}
		if($('[name=cnav]').val()=='4'){
			$('._ck_4').trigger('click');
		}
	})
</script>


</html>



<%-- 
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>抢猪仔</title>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/public.css"/>

</head>
<body>

banner_box 
<jsp:include page="./header.jsp"></jsp:include>
banner_box 
导航栏
<jsp:include page="./nav.jsp">
	<jsp:param value="3" name="nav"/>
</jsp:include>
 导航栏
	
<div class="shop-banner" style="background:url(resources/images/pc/shop-ban-1.jpg) no-repeat center center;"></div>

 content start 

<div class="d-wrap">
	<input type="hidden" value="${param.cnav }" name="cnav"/>
	<div class="shop-cont">
		<div class="sub-nav row-1">
			<ul class="of-hide">
				<li class="now fl-left current"><a href="pc/pnv/inShopping">正在抢购的猪仔</a></li>
				<li class="ready fl-left"><a href="pc/pnv/nextShopping">预热中准备抢的猪仔</a></li>
			</ul>
		</div>
		
		<div class="row-2 of-hide summary now-sum">
			
			<div class="row-left fl-left">
				<img src="resources/images/pc/shop-row-2-2.png" alt="八戒" />
			</div>
			
			-- 售磐则添加 sell-out 类 --
			<div class="row-right fl-right sell-out">
			<div class="row-right fl-right ${curProj.leftNum<=0 ? 'sell-out' :'' }">
				<div class="title of-hide">
					<span class="fl-left s1">基本信息</span>
					<span class="fl-right s2">开抢时间：&nbsp;<i>进行中</i></span>
				</div>
				<div class="icon-sell"><img src="resources/images/pc/shop-row-2-3.png" alt="已售磐" width="148" height="148"/></div>
				<ul class="info">
					<li class="type">猪的品种：<span>${nextProj.variety }</span></li>
					<li class="num">
						已抢猪仔数：<span>${curProj.num - curProj.leftNum }只</span>
						<div class="bar of-hide" style="width:272px;">
							<div class="all">共${curProj.num }只</div>
							<div class="bar-now" style="clip:rect(0,272px,26px,${272 / curProj.num* curProj.leftNum}px);">共${curProj.num }只</div> 272为进度条总px量
						</div>
					</li>
					<li class="revenue">预计年化收益率：<span>${yearRate }%</span></li>
					<li class="price">抢购单价金额：<span>${curProj.price }元</span></li>
				</ul>
				<form method="get" action="pc/pv/order/submitConfirm">
				<input type="hidden" name="projectId" value="${curProj.paincbuyProjectId }"/>
				<ul class="form">
					<li class="li-row1">购买数量</li>
					<li class="li-row2 of-hide">
						<div class="stock fl-left">
							<button type="button" class="cut d-btn">-</button>
							<input type="text" name="num" class="num" value="1"/>
							<button type="button" class="add d-btn">+</button>
						</div>
						<div class="sub-btn fl-left">
							<input type="submit" value="立即抢购" class="d-btn" id="submit"/>
						</div>
					</li>
					<li class="li-row3">
						<label for="protocol"></label>
						<input type="checkbox" id="protocol" checked="checked"/>
						<a href="javascript:;" class="dib agreement-btn">同意《用户协议》</a>
					</li>
				</ul>
				</form>
			</div>
		</div>
		
		<div class="row-3">
			
			<div class="row-tab">
				<div class="d-hr"></div>
				<div class="tab-bd">
					<div></div>
					<div></div>
					<div></div>
					<div></div>
				</div>
				<div class="tab-nav clearfix tab-change tab-nav-bd1" id="tabNav">
					<a href="javascript:;" class="tab-1 tab-item">详情介绍</a>
					<a href="javascript:;" class="tab-2 tab-item">回报展示</a>
					<a href="javascript:;" class="tab-3 tab-item">评论</a>
					<a href="javascript:;" class="tab-4 tab-item">交易记录</a>
				</div>		
			</div>
			
			<div class="tab-cont" id="tabCont">
				详情介绍
				<div class="cont-1 d-details item">
					<img class="lazy" src="resources/images/pc/grey.gif" data-original="resources/images/pc/details-img-1.jpg" alt="详情" />
				</div>
				
				回报展示
				<div class="cont-2 d-return item d-hide">
					<h5 class="title">
						<img src="resources/images/pc/d-icons-yuan6.png" alt="icons" />
						回报展示
						<img src="resources/images/pc/d-icons-yuan6.png" alt="icons" />
					</h5>
					<div class="img"><img class="lazy" src="resources/images/pc/grey.gif" data-original="resources/images/pc/d-return-1.jpg" alt="回报展示" /></div>
					<p class="d-info">可选回报方式：（1）年化9.6%的收益；（2）猪肉配送到家（重约220斤的活猪，不足重量按9元／斤增减价款，超重不另收费）；
（3）到猪场领取活猪；（4）价值2100元的猪肉券（仅限深圳地区）。</p>
				</div>
				
				评论
				<div class="cont-3 d-comment item d-hide">
					<h5 class="title">
						<img src="resources/images/pc/d-icons-yuan6.png" alt="icons" />
						全部评论
						<img src="resources/images/pc/d-icons-yuan6.png" alt="icons" />
					</h5>
					<c:choose>
						<c:when test="${sessionScope[CommConstant.SESSION_MANAGER] != null and sessionScope[CommConstant.SESSION_MANAGER]!='session_manager'}">
							<div class="comm-pub">
							<p>最多输入140字</p>
							<form action="#">
								<textarea name="comment" placeholder="有什么想对大家说的，快讲吧！" maxlength="140"></textarea>
								<div class="pub-btn">
									<input type="button" value="发表评论" id="btnCmtSub" class="pub-sub d-sub-btn" />
								</div>
							</form>
						</div>
        				</c:when>
        			<c:otherwise>
        				您暂未登录无法发布评论
        			</c:otherwise>
					</c:choose>
					<c:if test="${pager_cmt.pageCount>0 }">
					<ul class="comm-list">
						<c:forEach items="${commentList}" var="c">
							<li class="row">
							<div class="top">
								<c:set var="nickLength" value="${fn:length(c.nickName)}"/>
								<span class="name fl-left">昵称：${fn:substring(c.nickName, 0, (nickLength>2)?nickLength-2:nickLength)}**</span>
								<span class="time fl-right"><fmt:formatDate value='${c.ctime }' pattern='yyyy-MM-dd HH:mm:ss' /></span>
							</div>
							<div class="head-img"><img class="lazy" src="${c.img }" data-original="${c.img }" alt="头像" /></div>
							<div class="cnt">
								${c.content }
							</div>
							</li>
						</c:forEach>
					</ul>
					<jsp:include page="./pager.jsp">
							<jsp:param name="pagerConfigArg" value="pager_cmt"/>
							<jsp:param name="otherQueryArg" value="cnav=3"/>
						</jsp:include>
					</c:if>
				</div>
				
				
				交易记录
				<div class="cont-4 d-transaction item d-hide">
					<h5 class="title">
						<img src="resources/images/pc/d-icons-yuan6.png" alt="icons" />
						交易记录
						<img src="resources/images/pc/d-icons-yuan6.png" alt="icons" />
					</h5>
					<c:if test="${pager_buy.pageCount>0 }">
						<div class="tran-table">
						<div class="tab-tr head-tr">
							<div class="tr-td tr-td-1">头像</div>
							<div class="tr-td tr-td-2">昵称</div>
							<div class="tr-td tr-td-3">数量</div>
							<div class="tr-td tr-td-4">购买期数</div>
							<div class="tr-td tr-td-5">付款时间</div>
						</div>
						<c:forEach items="${buyRdList}" var="rd">
							<div class="tab-tr body-tr">
							<div class="tr-td tr-td-1">
								<img class="lazy" src="${rd.headImg }" data-original="${rd.headImg }" alt="头像" />
							</div>
							<c:set var="nickLength" value="${fn:length(rd.nickName)}"/>
							<div class="tr-td tr-td-2">${fn:substring(rd.nickName, 0, (nickLength>2)?nickLength-2:nickLength)}**</div>
							<div class="tr-td tr-td-3">${rd.count }</div>
							<div class="tr-td tr-td-4">${rd.projectName }</div>
							<div class="tr-td tr-td-5"><fmt:formatDate value='${rd.gmtPayTime }' pattern='yyyy-MM-dd HH:mm:ss' /></div>
						</div>
						</c:forEach>
						</div>
						<jsp:include page="./pager.jsp">
							<jsp:param name="pagerConfigArg" value="pager_buy"/>
							<jsp:param name="otherQueryArg" value="cnav=4"/>
						</jsp:include>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	
	<div class="agreement">
		<div class="agr-bd"></div>
		<div class="agr-main">
			<h2 class="title">“八戒王国online”协议书</h2>
			<div class="cont">
				<p>特别提示：任何一方通过平台网站页面点击确认或以其他方式选择接受本协议，即表示该方同意使用电子签名和数据电文，并表示该方已签署本协议，并同意接受本协议所载全部内容、条款和条件以及平台所列的与本协议所述事项相关的各项规则及其他文件。</p>
				<p>本《“八戒王国online”协议书》（简称“本协议”）由下列当事方（合称“各方”，单称“一方”）于__ __年_ _月__ __日在深圳市签订： 
				（1）甲方<br>
				法定名称：深圳润民金融信息服务有限公司<br>
				法定代表人：黄邦银<br>
				住所：深圳市福田区深南大道1006号深圳国际创新中心A座18楼  <br>
				联系电话：0755-83571111</p><br>
								<p>（2）乙方<br>
				指本协议附件一所列用户</p>
								<p>鉴于：<br>
				1、甲方是一家依据中国法律合法成立并有效存续的有限责任公司，开发并运营一个专注于“互联网＋ 养猪”的农业互联网服务的网站——“八戒王国online”（www.bajiewg.com），并合法运营多个为实现网站功能的移动终端软件（如APP）和手机网页终端（m.bajiewg.com）（合称“平台”）；
				“八戒王国“是由甲方推出的全透明化、专注于农业领域的“互联网+ 养猪“生猪运营服务平台。本平台运用互联网金融手段，整合国内传统养猪场，改造、完善和提升传统养猪行业，使生猪全产业链扁平化、细节透明化、流程数据化，为用户（或者投资者，以下简称用户）提供安全、透明、可信的社交化网络生猪预定投资交易平台。“八戒王国“能让用户以最便捷的途径获得稳定、丰厚的养猪投资回报；同时，用户也能成为猪场主人，参与养猪的全过程，从农场直接到餐桌，享受专属的放心优质的高端生态猪肉。
				2、乙方是具有完全民事行为能力和权利能力的中国公民，且为平台的注册用户；</p>
								<p>双方经友好协商，就上述“八戒王国”产品交易的相关事宜达成如下协议条款，以兹共同遵照执行：<br>
				第1条  产品标的<br>
				本期“八戒王国”的标的详情如下：<br>
				商品名称：外三元猪；<br>
				规格：断奶仔猪；<br>
				价格：人民币1,980.00元/头；</p>
			</div>
			<div class="btn-sure">
				<button class="btn-submit">同意并继续</button>
			</div>
		</div>
	</div>
</div>

 content end 

底部 
<jsp:include page="./footer.jsp"></jsp:include>
底部 

</body>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/jquery.lazyload.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script>
	$(function(){
		
		(function(){
			/*图片懒加载*/
			$("img.lazy").lazyload({ 
				threshold : 200
			});
			
			/*商品加减*/
			var num = parseInt($('.stock .num').val());
			$('.stock .add').on('click', function(){
				++num;
				 $('.stock .num').val(num);
			})
			$('.stock .cut').on('click', function(){
				--num;
				num = (num <= 1) ? 1 : num;
				 $('.stock .num').val(num);
			})
			
			/*协议*/
			$('.agreement-btn').on('click', function(){
				$('.agreement').fadeIn('fast');
			})
			$('.agreement .btn-submit').on('click', function(){
				$('.agreement').fadeOut('fast');
			})
			
			/*同意协议才能抢购*/
			$('#protocol').on('change', function(){
				if($('#protocol').is(':checked')){
					$('#submit').removeAttr('disabled');
				}else{
					$('#submit').attr('disabled','disabled');
				}
			})
			
			/*详情评论tab切换*/
			var numb = 1;
			$('#tabNav a').on('click', function(){
				var index = $(this).index() + 1;
				
				$('#tabNav').removeClass('tab-nav-bd' + numb);
				$('#tabNav').addClass('tab-nav-bd' + index);
				$('#tabCont .item').addClass('d-hide');
				$('#tabCont .item').eq(index - 1).removeClass('d-hide');
				
				numb = index;
			})
			
			/*售磐后按钮不可点*/
			$('.sell-out .sub-btn .d-btn').attr('disabled','disabled');
			
			
		})()
		
		$('#btnCmtSub').click(function(){
		var self = $(this);
		var content = $('[name=comment]').val().trim();
		
		if(content == ''){
			alert('请输入必填项');
			return;
		}
		
		self.attr('disabled','disabled');
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: 'pc/pv/addComment',
		    cache: false,
		    data: {content:content},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('评论成功')
		    		window.location.reload();
		    	} else {
		    		alert(data.data.text);
		    		self.removeAttr('disabled');
		    	}
		    },
		    error: function(){
		    	alert('error');
		    }
		});
		})
		if($('[name=cnav]').val()=='3'){
			$('.tab-3.tab-item').trigger('click');
		}
		if($('[name=cnav]').val()=='4'){
			$('.tab-4.tab-item').trigger('click');
		}
	})
</script>


</html>


--%>