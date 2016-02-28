<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>我的猪仔</title>
        <script src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/swiper.min.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
	
	<script type="text/javascript">
 $(function(){
   $("#hb").click(function(){
   alert("温馨提示：2015年10月1日之前在财大狮平台购买仔猪的用户，请到购买页面选择相应回报方式。2015年10月1日后在本平台购买的用户，可在本平台选择收益方式！");
   });
   
 
 });


</script>
	
	
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<c:choose>
			<c:when test="${fn:length(dataMap) > 0}">
				<div class="z_bg">
					<!-- Swiper -->
				    <div class="swiper-container">
				        <div class="swiper-wrapper">
				        	<c:forEach items="${sessionScope.all_i_join_project }" var="m">
					            <div class="swiper-slide">
					            	<a href="<%=basePath %>wpnv/ixpigGrow?queryProjectId=${m.paincbuyProjectId}"
					            		<c:if test="${queryProjectId eq  m.paincbuyProjectId}">class="thsi_slide"</c:if> >
					            		${m.paincbuyProjectName }
					            	</a>
					            </div>
				        	</c:forEach>
				        </div>
				        <!-- Add Pagination -->
				        <div class="swiper-pagination"></div>
				    </div><!-- end Swiper-->
				    
				    <!-- pay_back-->
				    <div class="my_piglets_status mb10">
				    	<div class="piglets_status_box f_l">
				    		<p class="z_status_tit mb10">猪仔总数</p>
				    		<p class="z_status_value">${dataMap.list[0].num - dataMap.list[0].presentNum}<em>只</em></p>
				    	</div>
				    	<div class="piglets_status_box f_l">
				    		<p class="z_status_tit mb10">养殖天数</p>
				    		<p class="z_status_value">${dataMap.list[0].days }<em>天</em></p>
				    	</div>
				    	<div class="piglets_status_box f_l">
				    		<p class="z_status_tit mb10">养殖期</p>
				    		<p class="z_status_value">${dataMap.list[0].remark }</p>
				    	</div>
				    	
				    	
				    	
				    	            <c:choose>
             <c:when test="${dataMap.list[0].beginTime gt begTime}">
				    	<a href="<%=basePath %>wpv/orchooseRepayType?queryProjectId=${dataMap.list[0].paincbuyProjectId}&endModifyTime=<fmt:formatDate value="${dataMap.list[0].endModifyTime}" pattern='yyyy-MM-dd' />" class="piglets_pay_back f_l">选择回报方式</a>
				    </c:when>
				   <c:otherwise>
				
		<a href="javascript:void(0)" id="hb" class="piglets_pay_back f_l">选择回报方式</a>
				   
				   </c:otherwise>
				   
				   
				    </c:choose>
				    
				    
				    
				    </div>
				    
				    <!-- growth record -->
				    <div class="piglets_growth_record">
				    	<div class="growth_record_top">
				    		<p class="left_top_word f_l">成长记录</p>
				    		<a href="<%=basePath %>wpv/urmyFriends?operate=sendPig&pageSource=10005&projectId=${dataMap.list[0].paincbuyProjectId}" class="right_top_get f_r">赠送猪仔</a>
				    	</div>
				    	<c:choose>
				    		<c:when test="${dataMap.groupRecordList != null }">
						    	<ul class="piglets_growth_record_list" id="growth_record_list">
						    		<c:forEach items="${ dataMap.groupRecordList}" var="l" varStatus="status">
							    		<li <c:if test="${status.index == 0 }">class="z_active_2"</c:if>>
							    			<c:choose>
							    				<c:when test="${status.index == 0 }">
									    			<img src="<%=basePath %>resources/images/circle-1.png" alt="" class="circle_img f_l" />
							    				</c:when>
							    				<c:otherwise>
									    			<img src="<%=basePath %>resources/images/circle-2.png" alt="" class="circle_img f_l" />
							    				</c:otherwise>
							    			</c:choose>
							    			
							    			<p class="growth_record_detail">${l.remark }</p>
							    			<p class="growth_record_time">${l.extend }</p>
							    		</li>
						    		</c:forEach>
						    	</ul>
				    		</c:when>
				    		<c:otherwise>
				    		</c:otherwise>
				    	</c:choose>
				    </div>
				</div>
			</c:when>
			<c:otherwise>
				<jsp:include page="../user/next_prenotify.jsp"></jsp:include>
			</c:otherwise>
		</c:choose>
	</body>
	<jsp:include page="../common/commonTip.jsp"></jsp:include>
	<jsp:include page="../back.jsp">
		<jsp:param value="wpnv/ixhome" name="backUrl"/>
	</jsp:include>
</html>
<script src="<%=basePath %>resources/js/swiper.min.js"></script>
<script>
	 var swiper = new Swiper('.swiper-container', {               
        slidesPerView: 3.5 //三个半
        //loop: true,
		//autoplay: 1000
	 })
	 $(function(){
		$('.swiper-slide a').click(function(){
			$('.swiper-slide a').removeClass('thsi_slide');
			$(this).addClass('thsi_slide');
		})
	 });
</script>
