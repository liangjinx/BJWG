<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="产品介绍" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="./meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/public.css"/>
<link rel="stylesheet" href="resources/css/slick.css"/>
</head>
<body>
	
<!--banner_box -->
<jsp:include page="header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="nav.jsp">
	<jsp:param value="2" name="nav"/>
</jsp:include>
<!-- 导航栏-->
	
<div class="d-banner">
	<div class="slick">
	    <div><img src="resources/images/pc/products-banner-1.jpg" alt="什么是“八戒王国online”？" border="0"/></div>
	    <div><img src="resources/images/pc/products-banner-2.jpg" alt="“八戒王国online”有什么特点？" border="0"/></div>
	    <div><img src="resources/images/pc/products-banner-3.jpg" alt="如何加入“八戒王国online”？" border="0"/></div>
	</div>
</div>

<!-- content start -->

<div class="d-wrap of-hide">
	
	<div class="products-cont">
		
		<div class="row-1">
			<div class="row-cnt">
				<div class="title">
					<h2>抢猪仔流程</h2>
					<p class="sub">八戒王国online平台每周（一、三、五）会根据猪场仔猪存栏情况，发布可供用户抢购的仔猪数目等情况 。</p>
				</div>
				
				<ul class="procedure1 of-hide">
					<li>注册与登录</li>
					<li>抢购并付款</li>
					<li>等仔猪入栏</li>
					<li>饲养到出栏</li>
					<li>期满即获利</li>
				</ul>
				
				<ul class="procedure2" style="background:url(resources/images/pc/products-row-1.png) no-repeat right bottom;">
					<li><span>1.</span><p>注册成为平台用户并登录;</p></li>
					<li><span>2.</span><p>用户成功抢购到猪仔并及时付款，预订过程即完成，用户正式成为仔猪主人;</p></li>
					<li><span>3.</span><p>用户可随时查看断奶仔猪饲养状况，经提前预约也可亲临养猪场现场查看猪只生长情况和养殖模式;</p></li>
					<li><span>4.</span><p>饲养期限届满之后，平台将约220斤重的成猪交付给用户;</p></li>
					<li><span>5.</span><p>用户自主选择获利方式。</p></li>
				</ul>
			</div>
			
		</div>
		
		<div class="row-2">
			<img src="resources/images/pc/pro-row-2-1.jpg" alt="平台原理" />
		</div>
		
		<div class="row-3">
			<div class="row-cnt">
				<div class="title">
					<h2>八戒王国online平台特点---让您放心投资</h2>
					<p class="sub">由于猪肉需求市场巨大， 收益不能达成的风险极低。八戒王国安全可靠、让投资者放心的“互联网+ 养猪”产品。</p>
				</div>
				
				<ul class="list of-hide">
					<li>
						<div class="icon icon-1">在线看</div>
						<div class="txt">视频实时监控</div>
					</li>
					<li>
						<div class="icon icon-2">刚需品</div>
						<div class="txt">全国一年消费7亿头生猪</div>
					</li>
					<li>
						<div class="icon icon-3">生态猪</div>
						<div class="txt">“三零”养殖模式</div>
					</li>
					<li>
						<div class="icon icon-4">高收益</div>
						<div class="txt">投资年化收益率9.6%</div>
					</li>
					<li>
						<div class="icon icon-5">上保险</div>
						<div class="txt">中国人保承保您的猪仔</div>
					</li>
				</ul>
			</div>

		</div>
		
	</div>

</div>

<!-- content end -->

<!--底部 -->
<jsp:include page="footer.jsp"></jsp:include>
<!--底部 -->

</body>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script src="resources/js/pc/slick.min.js"></script>
<script>
	
	$(function(){
		
		$('.slick').slick({
	        dots: true,
	        autoplay: true,
	        autoplaySpeed:5000
	    });
		
	})
	
</script>

</html>
<!--




<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'products.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	

  </head>
  
  <body>
    This is my JSP page. <br>
  </body>
</html>
-->