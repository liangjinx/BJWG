<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>我的收益</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<meta name="keywords" content="八戒王国online">
<meta name="description" content="八戒王国online">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/enter.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/swiper.min.css"/>
</head>
 <style>
.swiper-container { width: 100%; height: 50px; margin-left: auto; margin-right: auto; background: #fff;}
.swiper-slide { text-align: center; font-size: 14px; font-family: 'Microsoft YaHei'; color:#615968; font-weight:bold;/* Center slide text vertically */ display: -webkit-box; display: -ms-flexbox; display: -webkit-flex; display: flex; -webkit-box-pack: center; -ms-flex-pack: center; -webkit-justify-content: center; justify-content: center; -webkit-box-align: center; -ms-flex-align: center; -webkit-align-items: center; align-items: center;}
.swiper-slide a{ cursor:pointer; height:50px; line-height:50px;}
.thsi_slide{ color:#3cbd6d;}
.balance_but a, .balance_but a:visited { color: #fff;}
.z_earning_nothing { width: 100%; height: 45px; line-height: 45px; padding: 40px 0; font-size: 20px; color: #615868; text-align: center;}
</style>
<body>
<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
<div class="bodyheight earning_bg">
	<c:choose>
		<c:when test="${dataMap != null }">
			<!--bodyheight -->
			<!-- Swiper -->
		    <div class="swiper-container">
		        <div class="swiper-wrapper">
		        	<c:forEach items="${sessionScope.all_i_join_project }" var="m">
		            	<div class="swiper-slide">
		            		<a <c:if test="${queryProjectId eq  m.paincbuyProjectId}">class="thsi_slide"</c:if> href="<%=basePath %>wpnv/ixRecentEarning?queryProjectId=${m.paincbuyProjectId }">${m.paincbuyProjectName }</a>
		            	</div>
		        	</c:forEach>
		        </div>
		        <!-- Add Pagination -->
		        <div class="swiper-pagination"></div>
		    </div>
			
			<p class="earning_tit mt10">我的现金收益</p>
			<div class="center80 earning_box"><!--earning_box -->
		    <p class="earning_p">${dataMap.earningMoney }</p>
		    
		    <div class="earning_tab"><!--earning_tab -->
		    	<table class="tab">
		        	<tr>
		            	<td class="b_right"><fmt:formatNumber value="${dataMap.yearRate }" type="number" pattern="#.##" />%<br><span>年化收益率</span></td>
		                <td>￥${dataMap.expectEarning }<br><span>预期收益</span></td>
		            </tr>
		        </table>
		    </div><!--earning_tab -->
		    <div class="container" id="container"></div> 
		    </div><!--earning_box -->
		    
		    <div class="center80 earning_box"><!--earning_box -->
		    	<p class="tab_tit"><a href="<%=basePath %>wpv/wlhistoryEarnings">历史收入记录&nbsp;&nbsp;>&nbsp;&nbsp;</a></p>
		    <div class="earning_tab earning_tab90"><!--earning_tab -->
		    	<table class="tab">
		        	<tr>
		            	<td class="b_right"><span>累计收益（元）</span><br>${dataMap.earningMoney }</td>
		                <td><span>账户余额（元）</span><br>${dataMap.walletMoney }</td>
		            </tr> 
		        </table>
		        <div class="earning_bottom"></div>
		        <table class="tab">       
		        	<tr>
		            	<td class="b_right"><span>养殖成本（元）</span><br>${dataMap.currentCost }</td>
		                <td><span>养殖数量（只）</span><br>${dataMap.currentNum }</td>
		            </tr>
		        </table>
		    </div><!--earning_tab -->
		    
		   		<button class="balance_but"><a href="<%=basePath %>wpv/wlbankCardList?s_type=2">余额提现</a></button>
		    </div><!--earning_box -->
		    
		    <p class="earning_tit mt10">我的猪仔</p>
		    <div class="center90 earning_box"><!--earning_box -->
		    	<p class="my_pig_tit"><a>可领取${dataMap.currentNum }只生猪</a><br><span>或选择如下方案</span></p>
		    <div class="earning_tab earning_tab90 my_pig_tab"><!--earning_tab -->
		    	<table class="tab">
		        	<tr>
		            	<td class="b_right"><a><img src="<%=basePath %>resources/images/pig01.png" alt=""/><span>到养猪场领<br>取活猪</span></a></td>
		                <td><a><img src="<%=basePath %>resources/images/wtxs_pig.png" alt=""/><span>委托深圳润民销<br>售，获得利益</span></a></td>
		            </tr> 
		        </table>
		        <div class="earning_bottom"></div>
		        <table class="tab">       
		        	<tr>
		            	<td class="b_right"><a><img src="<%=basePath %>resources/images/pstzc_pig.png" alt=""/><span>委托深圳润<br>民屠宰配送</span></a></td>
		                <td><a><img src="<%=basePath %>resources/images/pork_img.png" alt=""/><span>领取${dataMap['SYS_CONFIG.PIG_COUPON_MONEY'] } 元/头<br>的猪肉券</span></a></td>
		            </tr>
		        </table>
		    </div><!--earning_tab -->
		    
		    </div><!--earning_box -->
		    <p class="earning_tit mt10">我的猪肉券</p>
		    <div class="center80 earning_box"><!--earning_box -->
		    	<c:set var="totalmoney" value="${dataMap['SYS_CONFIG.PIG_COUPON_MONEY'] * dataMap.currentNum}"></c:set>
		    	<p class="pig_coupon_p">可兑换价值为${totalmoney }元（${dataMap['SYS_CONFIG.PIG_COUPON_MONEY'] } X ${dataMap.currentNum } = ${totalmoney }元）的猪肉券</p>
		    </div>
		    <p class="p_top">&nbsp;</p>
		    
		</c:when>
		<c:otherwise>
			<jsp:include page="../user/next_prenotify.jsp"></jsp:include>
		</c:otherwise>
	</c:choose>
</div><!--bodyheight -->
	<jsp:include page="../back.jsp">
		<jsp:param value="wpnv/ixhome" name="backUrl"/>
	</jsp:include>
</body>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
<script src="<%=basePath %>resources/js/highcharts.js"></script>
<script src="<%=basePath %>resources/js/swiper.min.js"></script>
<script>
$(function () {
    $('#container').highcharts({
        title: {
            text: '',//主标题
            x:-20//center
        },
		credits:{
	     enabled:false // 禁用版权信息
		},
		chart : {
		  style : {
		    fontFamily:"Microsoft YaHei",
		    fontSize:'14px',
		    fontWeight:'bold',
		    color:'#615968'	
		  },
		  backgroundColor:""
		  
		} ,
        subtitle: {
            text: '',//副标题
            x:-20
        },
        xAxis: {//x轴
//            categories: ['9.1', '9.2', '9.3', '9.4', '9.5', '9.6','9.7']
            categories: [${dataMap.weeks }]
        },
        yAxis: {//y轴
            title: {
                text: ''
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#ff6600'
            }]
        },
        tooltip: {
            valueSuffix: '元'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [{
            name: '收益',
			color: '#ff6600',
            //data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 3.2610]
            data: [${dataMap.weeksValue}]
        }]
    });
});
	
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
	 })
				
</script>

</html>
