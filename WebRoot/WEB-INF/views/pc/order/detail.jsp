<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="__page_name__" value="订单详情" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script src="<%=basePath %>resources/js/pc/order/detail.js"></script>
</head>
<body class="body_bg">
<!--banner_box -->
<jsp:include page="../header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="../nav.jsp">
	<jsp:param value="5" name="nav"/>
</jsp:include>
<!-- 导航栏-->
<!--中间部分 -->
<div class="center mypig_center">
<!--mypig_left_nav -->

  <c:if test="${empty path}">
<jsp:include page="../user/nav.jsp">

	<jsp:param value="3" name="nav"/>
</jsp:include>
</c:if>
 <c:if test="${!empty path}">
 <jsp:include page="../epuser/nav.jsp">
 
	<jsp:param value="3" name="nav"/>
</jsp:include>
           </c:if>



<!--mypig_left_nav -->
<div class="right_main">
	<div class="pig_tit_box">
        	<img src="resources/images/pc/point1.png" alt="点"/><p>订单详情</p><img src="resources/images/pc/point1.png" alt="点"/>
            <p class="pig_ordrrs_tit">当前位置：八戒王国online>个人中心>我的订单>订单详情</p>
    </div>
    <div class="mypig_body"> 
    		<div class="orders_details_box">
            	<div class="ordersimg_ts"><img src="resources/images/pc/orders_ts2.png" alt="提示！"/></div>
                <div class="o_details_p">
                	<c:choose>
                		<c:when test="${order.status == -1}">
                			<p>当前状态： 订单关闭<br><span></span></p>
                		</c:when>
                		<c:when test="${order.status == 1}">
                			<p>当前状态： 等待买家付款<br>
                				<span>
                					<c:choose>
                						<c:when test="${leftSecs!=null and leftSecs>0}">
                							还有<span id="leftSecs" data-time="${leftSecs }">00天00小时00分00秒</span>进行付款，若未及时付款，系统将自动取消订单
                						</c:when>
                						<c:otherwise>
                							订单支付已超时,无法支付
                						</c:otherwise>
                					</c:choose>
                					
                				</span>
                			</p>
                		</c:when>
                		<c:when test="${order.status == 2}">
                			<p>当前状态： 付款中<br>
                				<span>
                					<c:choose>
                						<c:when test="${leftSecs!=null and leftSecs>0}">
                							还有<span id="leftSecs" data-time="${leftSecs }">00天00小时00分00秒</span>进行付款，若未及时付款，系统将自动取消订单
                						</c:when>
                						<c:otherwise>
                							订单支付已超时,无法支付
                						</c:otherwise>
                					</c:choose>
                					
                				</span>
                			</p>
                		</c:when>
                		<c:when test="${order.status == 3}">
                			<p>当前状态： 已付款<br><span></span></p>
                		</c:when>
                		<c:when test="${order.status == 4}">
                			<p>当前状态： 待收货<br><span>商品已配送，请注意查收</span></p>
                		</c:when>
                		<c:when test="${order.status == 5}">
                			<p>当前状态： 已确认收货<br><span></span></p>
                		</c:when>
                	</c:choose>
                </div>
                
                <c:choose>
                		<c:when test="${order.status == -1}">
                			
                		</c:when>
                		<c:when test="${order.status == 1 and (leftSecs!=null and leftSecs>0)}">
                			<a type="button" class="o_details_but" href="pc/pv/order/choosePay?orderId=${order.orderId }">立即付款</a>
                			<a type="button" class="o_details_but qxdd_but cancel" data-order="${order.orderId }" >取消订单</a>
                		</c:when>
                		<c:when test="${order.status == 2}">
                			<a type="button" class="o_details_but" href="pc/pv/order/choosePay?orderId=${order.orderId }">立即付款</a>
                		</c:when>
                		<c:when test="${order.status == 3}">
                			
                		</c:when>
                		<c:when test="${order.status == 4}">
                			<a type="button" class="o_details_but confirm" data-order="${order.orderId }" >确认收货</a>
                			<a type="button" class="o_details_but qxdd_but cancel" data-order="${order.orderId }" >取消订单</a>
                		</c:when>
                		<c:when test="${order.status == 5}">
                			
                		</c:when>
                </c:choose>
                
             	<div class="o_tit_box"><p>订单信息</p></div>
                <div class="o_p_box m_top20">
                	<c:if test="${order.type ==2 || order.type == 3}">
                		收货地址：<span>${address.address }</span>
                	</c:if>
                </div>
                <div class="o_p_box">订单号：<span>${order.orderCode }</span></div>
                <div class="o_p_box">支付金额：<span>￥${order.totalMoney }</span></div>
                <div class="o_p_box">下单时间：<span><fmt:formatDate value="${order.ctime }" pattern="yyyy-MM-dd HH:mm:ss"/></span></div>
            </div> <!--orders_details_box -->
            <div class="clear"></div>
            <div class="orders_box_tab m_left10">
                <table class="orders_tab">
                 	<tr class="tab_tit">
                    	<td style="width:50%;">商品信息</td>                   
                        <td style="width:25%;">数量（只）</td>
                        <td style="width:25%;">单价（元）</td>                       
                    </tr>
                    <tr class="tab_main">                    	
                        <td style="width:50%;">
                        	<div class="z_center_detail" >
                        		<img src="${order.productImg }" alt=""/>
                        		<p class="tab_p2">${order.relationName }</p>
                        	</div>
                        	<c:choose>
                        		<c:when test="${order.type == 2 }">
                        			<p>(委托润民屠宰配送鲜肉)</p>
                        		</c:when>
                        		<c:when test="${order.type == 3 }">
                        			<p>(领取活猪)</p>
                        		</c:when>
                        	</c:choose>
                        </td>
              			<td style="width:25%;">${order.num }</td>
                        <td style="width:25%;">￥${order.price }</td>                       
                    </tr>                    
                 </table>
                 <p class="o_sjfk_p">实际付款：<span>￥${order.totalMoney }</span></p>
                </div>
        <div class="clear"></div>
    </div><!--mypig_body -->
</div>


<div class="clear"></div>
</div>

   
<!-- 中间部分-->
<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->


<script>
		/*倒计时*/
		console.log(new Date().getTime() + 1000*60*60*10);
		$(function(){
				
			 var d_date = parseInt($('#leftSecs').data('time'));

			 if(d_date){
			 	var $count = $('#leftSecs');
				var clear_time = setInterval(function(){
				 	var obj = timer(clear_time,d_date);
				 	d_date-=1;
				 	if(obj){
				 		$count.html(obj.dd+'<em>天</em>'+obj.hh+'<em>小时</em>'+obj.mm +'<em>分</em>'+ obj.ss + '<em>秒</em>');   //自定义输出格式
				 	}else{
				 		$count.html('00秒'); //自定义结束语
				 	};

				},1000);
			 }
			function timer(timeid,timestamp){
					var nowTime = new Date().getTime();
					if(timestamp <= 0){
						clearInterval(timeid);
						return null;
					}else{
						//var ts = ((new Date(timestamp)) - (new Date()));//计算剩余的毫秒数  
						var ts = timestamp * 1000;
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
		                	clearInterval(timeid);
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
</body>

</html>
<!--



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>订单详情</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	

  </head>
  
  <body>
    <h3>订单详情</h3>
    <div>
    	<div>
    		当前状态:
    		<c:choose>
				<c:when test="${order.status == 1}">
					等待付款, 还有${leftSecs}
				</c:when>
			</c:choose>
    	</div>
    	<hr>
    	<div>名称:${order.relationName }</div>
    	<div>数量:${order.num }</div>
    	<div>img:${order.productImg }</div>
    	<div>收货地址:</div>
    	<div>订单号:${order.orderCode }</div>
    	<div>支付金额:${order.totalMoney }</div>
    	<div>下单时间:${order.ctime }</div>
    	<div>单价:${order.price }</div>
    	<div></div>
    	<div></div>
    </div>
  </body>
</html>
-->