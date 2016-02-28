<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="__page_name__" value="抢猪仔" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="./meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/public.css"/>
<link rel="stylesheet" href="resources/css/pc/pangzi_overview.css"/>
</head>
<body>

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
	
	<div class="shop-cont">
		<div class="sub-nav row-1">
			<ul class="of-hide">
				<li class="now fl-left"><a href="pc/pnv/inShopping">正在抢购的猪仔</a></li>
				<li class="ready fl-left current"><a href="pc/pnv/nextShopping">预热中准备抢的猪仔</a></li>
				<li class="ready fl-left"><a href="pc/pnv/judgeLogin">预抢的猪仔</a></li>
			
			</ul>
		</div>
		
		<div class="row-2 of-hide summary ready-sum">
			
			<div class="row-left fl-left">
				<img src="resources/images/pc/shop-row-2-2.png" alt="八戒" />
			</div>
			
			<c:choose>
				<c:when test="${null != nextProj }">
					<div class="row-right fl-right">
						<div class="title of-hide">
							<span class="fl-left s1">基本信息</span>
							<span class="fl-right s2" id="countDown" data-countdown="${leftTime }">倒计时：&nbsp;<i>进行中</i></span>
						</div>
						<ul class="info">
							<%--<li class="type">猪的品种：<span>苏联大白猪</span></li>
							--%><li class="num">
								猪仔数：<span>共${nextProj.num }只</span>
								<%--<div class="bar of-hide" style="width:272px;">
									<div class="all">共2000只</div>
									<div class="bar-now" style="clip:rect(0,272px,26px,272px);">共2000只</div>
								</div>
							--%></li>
							<li class="revenue">预计年化收益率：<span>${yearRate }%</span></li>
							<li class="price">抢购单价金额：<span>${nextProj.price }元</span></li>
						</ul>
						<ul class="form">
							<li class="li-row2 of-hide">
								<div class="sub-btn fl-left">
									<input type="submit" value="立即抢购" class="d-btn" name="submit" id="submit" disabled="disabled"/>
								</div>
							</li>
						</ul>
					</div>
				</c:when>
				<c:otherwise>
					<div class="z_no_next fl-left">暂无下期抢购活动</div>
				</c:otherwise>
			</c:choose>
		</div>
		
		
		
	</div>

</div>

<!-- content end -->

<!--底部 -->
<jsp:include page="./footer.jsp"></jsp:include>
<!--底部 -->

</body>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script>
		/*倒计时*/
		console.log(new Date().getTime() + 1000*60*60*10);
		$(function(){
				
			 var d_date = parseInt($('#countDown').data('countdown'));

			 if(d_date){
			 	var $count = $('#countDown').find('i');
				var clear_time = setInterval(function(){
				 	var obj = timer(clear_time,d_date);
				 	if(obj){
				 		$count.html(obj.dd +'<em>天</em>'+ obj.hh +'<em>时</em>'+ obj.mm +'<em>分</em>'+ obj.ss + '<em>秒</em>');   //自定义输出格式
				 	}else{
				 		$count.html('进行中'); //自定义结束语
				 		window.location.href=__base_path__+"pc/pnv/inShopping";
				 	};

				},1000);
			 }
			function timer(timeid,timestamp){
					var nowTime = new Date().getTime();console.log(timestamp +' '+ nowTime);
					if(timestamp <= nowTime){
						clearInterval(timeid);
						return null;
					}else{
						var ts = ((new Date(timestamp)) - (new Date()));//计算剩余的毫秒数  
		                var dd = parseInt(ts / 1000 / 60 / 60 / 24,10);//计算剩余的天数
		                var hh = parseInt(ts / 1000 / 60 / 60,10);//计算剩余的小时数  
		                var mm = parseInt(ts / 1000 / 60 % 60, 10);//计算剩余的分钟数  
		                var ss = parseInt(ts / 1000 % 60, 10);//计算剩余的秒数  
		                dd = checkTime(dd);
		                if(dd == 0){
		                	dd = '0';
		                }else {
		                	dd = dd;
		                }
		               //hh = checkTime(hh);
		                if(dd == ''){
		                	hh = checkTime(hh);
		                }else{
		                	hh = parseInt(hh)%24;
		                	hh = checkTime(hh);
		                }
		                mm = checkTime(mm);  
		                ss = checkTime(ss);
		                if(parseInt(hh) <= 0 && parseInt(mm) <= 0 && parseInt(ss) <= 0){
		                	//clearInterval(timeid);
		                }
		                return {
		                	dd : dd,		//天
		                	hh : hh,		//时
		                	mm : mm,		//分
		                	ss : ss			//秒
		                }
					}
	         
		    }
		    function checkTime(i){
		       if (i < 10) {    
		           i = "0" + i;    
		        }else if(i <= 0){
		        	i = '00';
		        }
		       return i;    
		    } 
		})
</script>

</html>

