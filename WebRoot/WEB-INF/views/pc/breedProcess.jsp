<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="__page_name__" value="关于我们" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="./meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/public.css"/>
	<style>
		h4{
			border-left:5px solid #97be0d;
			margin-left:-35px;
			margin-bottom:10px;
			display:inline;
			padding-left:10px;
			color: blue;
		}
        .section p{
            text-indent: 2em;
            font-size: 16px;
            color: #666;

        }
        .section img{
            display: block;
            margin: 10px auto;
        }
    </style>
</head>
<body>

	<!--banner_box -->
	<jsp:include page="header.jsp"></jsp:include>
	<!--banner_box -->
	<!--导航栏-->
	<jsp:include page="nav.jsp">
		<jsp:param value="6" name="nav"/>
	</jsp:include>
	<!-- 导航栏-->
		
	<div class="d-banner">
		<img src="resources/images/pc/about-banner-1.jpg" alt="亚洲最大单体生态养猪基地" />
	</div>
	
		<div class="d-wrap of-hide">
			<div class="d-contain">
				<div class="d-nav fl-left of-hide">
					<div class="nav-cnt fl-right">
						<h2 class="title">关于我们</h2>
						<div class="list">
							<a href="pc/pnv/runminIntro">润民简介<i class="d-icon"></i></a> 
							<a href="pc/pnv/platfarmIntro">平台说明<i class="d-icon"></i></a> 
							<a href="pc/pnv/breedProcess" class="current">养猪工艺<i class="d-icon"></i></a>
							<a href="pc/pnv/question">常见问题<i class="d-icon"></i></a>
							<a href="pc/pnv/protocol">用户协议<i class="d-icon"></i></a>
							<a href="pc/pnv/connect">联系我们<i class="d-icon"></i></a>
						</div>
					</div>
				</div>
			
			<div class="d-content fl-left of-hide">
				<div class="of-hide"style="width:968px; float: right;">
					<div class="d-contain about-cont" style="width:960px;">
					
						<div class="section">
							<h2 class="title">养猪工艺</h2>
						</div>
						
						<div class="section">
					        <h4>润民国际标准化养猪工艺流程</h4>
					        <img src="resources/images/breedProcess-1.png" style="width: 577px;height: 259px">
					    </div>
					
					    <div class="section">
					        <h4>润民“八戒王国”商品猪生长周期费用明细</h4>
					        <img src="resources/images/breedProcess-2.png" style="width: 563px;height: 215px">
					        <img src="resources/images/breedProcess-3.png" style="width: 573px;height: 761px">
					    </div>
					
					    <div class="section">
					        <h4>润民“八戒王国”商品猪不同阶段猪只的营养标准</h4>
					        <img src="resources/images/breedProcess-4.png" style="width: 596px;height: 226px">
					    </div>
					
					    <div class="section">
					        <h4>润民“八戒王国”商品猪饲料使用标准</h4>
					        <img src="resources/images/breedProcess-5.png" style="width: 595px;height: 258px">
					    </div>
					       <div class="section">
					     <h4>&nbsp;&nbsp;注：</h4>
					       </div>
					    <p>&nbsp;&nbsp;&nbsp;A-夏天可酌减饲喂量。<p>
                         <p>&nbsp;&nbsp;&nbsp;B-哺乳母猪分娩前喂3.0kg/头，分娩后按产仔数多少确定喂量。除产后1周及断奶前3天外，哺乳期间一般不限喂。<p>
                         <p>&nbsp;&nbsp;&nbsp;C-怀孕母猪重胎期84天至临产前喂给妊娠料与泌乳料各半的饲粮。<p>
					</div>
				</div>
			</div>
		</div>
		
		<div class="bd-left wrap-bd"></div>
		<div class="bd-right wrap-bd"></div>
	</div>
	

	<jsp:include page="footer_new.jsp"></jsp:include>
</body>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script>
	(function(){
		/*字号选择*/
		var $i = $('.d-article .title i');
		$i.on('click',function(){
			var index = $(this).index();
			
			$i.removeClass('current');
			$(this).addClass('current');
			$('.d-article .content p').css({
				'font-size': index*2 + 14 + 'px',
			});
		})
		
		/**/
		
	})()
</script>
</html>