<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="我的收益" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script src="resources/js/pc/highcharts.js"></script>
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
<jsp:include page="../user/nav.jsp">
	<jsp:param value="1" name="nav"/>
</jsp:include>
<!--mypig_left_nav -->
<div class="right_main">
	<div class="my_pig_tit bg_f6"><!--my_pig_tit -->
    	<img src="resources/images/pc/nav_tit_bg.png" alt=""/>
        <div class="pig_tit"><p>我的现金收益</p></div>
    </div><!--my_pig_tit -->
    <div class="clear"></div>      
    <div class="mypig_body">
    
    	<div class="earnings">
        	<div class="earnings_adds">${data.earningMoney }</div>
            <table class="earnings_tab">
            	<tr>
                	<td><p><span><fmt:formatNumber value="${data.yearRate }" type="number" pattern="#.##" />%</span> 年化收益率</p></td><td><p><span>￥${data.expectEarning }</span> 预期收益</p></td>
                </tr>
            </table>
        </div>
        
        <div class="earnings earnings_container" id="container"></div>
        
        <div class="earnings earnings_count">
        	<div class="earnings_count_tit"><a href="pc/pv/user/earningHistory">查看历史收入记录</a></div>
            <table class="earnings_count_tab">
            	<tr>
                	<td>累计收益（元）<br><span>${data.earningMoney }</span></td><td>账户余额（元）<br><span>${data.walletMoney!=null?data.walletMoney:0 }</span></td>
                </tr>
                <tr>
                	<td>养殖成本（元）<br><span>${data.currentCost }</span></td><td>养殖数量（只）<br><span>${data.currentNum }</span></td>
                </tr>
            </table>
            <c:if test="${data.walletMoney!=null and data.walletMoney>0 }">
            	<a href="<%=basePath%>pc/pv/wallet/takeCash">
            		<input type="button" class="yetx_but" value="余额提现"/>
            	</a>
            </c:if>
            <c:if test="${data.walletMoney==null or data.walletMoney<=0 }">
            	<a href="javascript:alert('您没有余额可以体现哦');">
            		<input type="button" class="yetx_but" value="余额提现"/>
            	</a>
            </c:if>
        </div>
        
    </div><!--mypig_body -->
    <div class="pig_earnings_tit">
    	<img src="resources/images/pc/my_pig_tit.png" alt="我的猪仔" />
    </div>
    <p class="earnings_tit_p">可领取${data.currentNum }只生猪（或选择如下方案）</p>
    <table class="earnings_count_tab earnings_tab">
    <tr>
    	<td><img src="resources/images/pc/pig01.png"/><a>到养猪场<br>领取活猪</a></td><td><img src="resources/images/pc/pig04.png" alt="委托深圳润民" /><a>委托深圳润民销售，获得利益</a></td>
    </tr>
    <tr>
    	<td><img src="resources/images/pc/pig03.png"/><a>委托深圳润<br>民屠宰配送</a></td><td><img src="resources/images/pc/pig02.png" alt="领取猪肉券" /><a>领取2100元/头的猪肉券</a></td>
    </tr>
    </table>	     
<div class="clear"></div>  
	<div class="pig_earnings_tit">
    	<img src="resources/images/pc/my_count_tit.png" alt="我的猪肉券" />
    </div>
    
    <c:set var="totalmoney" value="${data['SYS_CONFIG.PIG_COUPON_MONEY'] * data.currentNum}"></c:set>
    <p class="earnings_tit_p">可兑换价值为${totalmoney }元（${data['SYS_CONFIG.PIG_COUPON_MONEY'] } X ${data.currentNum } = ${totalmoney }元）的猪肉券</p>
       <ul class="pig_coupons_ul">
         <li>
         	<div class="coupons_ul_tit"><p>电子券号码：XXXXXXXX</p></div>            
            <div class="coupons_yue"><p>余额￥</p><span>${totalmoney }</span></div>
            <div class="coupons_time"><p>使用有效期：XXXXXXXX</p></div>
         </li>
         </ul>
    
    <div class="clear"></div>   
</div>

<div class="clear"></div>
</div>

   
<!-- 中间部分-->
<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->
</body>
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
    color:'#615968'	,
	
  },
  backgroundColor:"",
  gridLineWidth:0,
} ,
        subtitle: {
            text: '',//副标题
            x:-20
        },
        xAxis: {//x轴
            categories: [${data.weeks }],
			tickmarkPlacement: String,
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
            data: [${data.weeksValue }]
        }],
    });
});
</script>
</html>



<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>我的收益</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	

  </head>
  
  <body>
    <h3>我的收益</h3>
    <div>
    	<div>累计收益:${data.earningMoney }</div>
    	<div>年化收益率:<fmt:formatNumber value="${data.yearRate }" type="number" pattern="#.##" /></div>
    	<div>预期收益:${data.expectEarning }</div>
    	<div>账户余额:${data.walletMoney }</div>
    	<div>养殖成本:${data.currentCost }</div>
    	<div>养殖数量:${data.currentNum }</div>
    	<div>
    		图表数据
    		<div>${data.weeks }</div>
    		<div>${data.weeksValue }</div>
    	</div>
    	<c:set var="totalmoney" value="${data['SYS_CONFIG.PIG_COUPON_MONEY'] * data.currentNum}"></c:set>
    	<div>可兑换价值为${totalmoney }元（${data['SYS_CONFIG.PIG_COUPON_MONEY'] } X ${data.currentNum } = ${totalmoney }元）的猪肉券</div>
    	<div><a href="pv/user/earningHistory">历史收益记录</a></div>
    </div>
  </body>
</html>
-->