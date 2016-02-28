<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<title>理财标详情</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<meta name="keywords" content="八戒王国online">
<meta name="description" content="八戒王国online">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/enter.css"/>
<script src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
</head>
<body>
<div class="bodyheight"><!--bodyheight -->
	<div class="bid_details_box"><!--bid_details_box -->
    	<p class="p_top">&nbsp;</p>
    	<p class="bid_details_tit">预期年化
    		<br>
    		<span>
				<c:set var="percent" value="${list[0].intervalDays / list[0].days }"></c:set>
   				<fmt:formatNumber value="${list[0].rate }" type="number" pattern="#" />%
			</span>
    	</p>
        <p class="bid_details_tit">已售1000<%-- ${list[0].totalNum}--%>只&nbsp;&nbsp;|&nbsp;&nbsp;${list[0].days }天&nbsp;&nbsp;|&nbsp;&nbsp; 金额保证</p>
    	<div class="center80 pmgressbar_box">
        	<div class="pmgressbar"></div>
        </div>
        <div class="center80">
        	<div class="bid_count_tit">
            	<span class="f_lt">出售只数</span>
            	<span class="f_rt">剩余只数</span>
                <div class="clear"></div>
            </div>
            <div class="bid_count">
            	<span class="f_lt">1000<%--${list[0].num } --%>只</span>
            	<span class="f_rt">0<%--${list[0].leftNum}--%>只</span>
                <div class="clear"></div>
            </div>
        </div>
        <div class="b_bottom mt10 mb10"></div>
        <p class="bid_details_tit">我的合同</p>
        <div class="center80 p_16 l_boder5">&nbsp;我的购买数量：${list[0].purchaseNum}只</div>
        <div class="center80 p_16 l_boder5">&nbsp;我的花费金额：${list[0].money}元</div>
        <p class="p_top">&nbsp;</p><p class="p_top">&nbsp;</p>
        <p class="bid_details_tit">订单号</p>
        <c:forEach items="${list[0].orderList }" var="l" varStatus="status">
        	<c:if test="${status.index % 2 == 0 }">
        		<div class="center80">
        	</c:if>
        	${l.orderCode }
        	<c:if test="${status.index % 2 == 1 || status.index + 1 == fn:length(list[0].orderList)}">
	        	</div>
        	</c:if>
        </c:forEach>
        
        <div class="center80 b_bottom"></div>
        <div class="center80 p_16 l_boder5">&nbsp;相关说明</div>
        <div class="center80 p_14"><p class="mt10">&nbsp;&nbsp;饲养开始日期：<fmt:formatDate value='${list[0].beginTime}' pattern='yyyy-MM-dd' /></p></div>
        <div class="center80 p_14"><p class="mt10">&nbsp;&nbsp;饲养结束日期：<fmt:formatDate value='${list[0].endTime}' pattern='yyyy-MM-dd' /></p></div>
        <div class="center80 bid_ts">&nbsp;&nbsp;温馨提示：饲养期结束前会有短信提醒</div>
        <div class="clear"></div>
    </div> <!--bid_details_box -->
</div><!--bodyheight -->
<jsp:include page="../back.jsp">
	<jsp:param value="wpv/wlMyFinancing" name="backUrl"/>
</jsp:include>
</body>
<script>
var percent = ${percent * 100};//百分比
$(function(){
	 $(".pmgressbar").animate({width: (percent+'%')}, "slow");
	})

</script>
</html>
<!--





    
    <div class="bank_card_content">
    	<div class="bank_listbox">
   				<div class="wd_bank_img">
   					已售出：${list[0].totalNum}只|${list[0].days }天|金额保证
   					<c:set var="percent" value="${list[0].totalNum / list[0].num }"></c:set>
   					<fmt:formatNumber value="${percent}" type="number" pattern="0.00%" />
   				</div>
   				<div class="wd_customer_box">
   					<p>${list[0].paincbuyProjectName}</p>
   					出售只数：${list[0].num }，剩余只数${list[0].num - list[0].totalNum}
   				</div>
   				<div class="wd_customer_box">
   					我的合同
   					<p>我购买的数量${list[0].purchaseNum}</p>
   					<p>我花费的金额${list[0].money}</p>
   				</div>
   				<div class="wd_customer_box">
   					相关说明
   					<p>饲养开始时间<fmt:formatDate value='${list[0].beginTime}' pattern='yyyy-MM-dd' /></p>
   					<p>饲养结束时间<fmt:formatDate value='${list[0].endTime}' pattern='yyyy-MM-dd' /></p>
   				</div>
    	</div>
    </div>
  </body>
</html>
-->