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
					<a href="pc/pnv/about" class="current">公司简介<i class="d-icon"></i></a>
					<a href="pc/pnv/about2">平台说明<i class="d-icon"></i></a>
					<a href="pc/pnv/question">常见问题<i class="d-icon"></i></a>
					<a href="pc/pnv/outlet">实体门店<i class="d-icon"></i></a>
					<a href="pc/pnv/connect">联系我们<i class="d-icon"></i></a>
				</div>
			</div>
		</div>
		
		<div class="d-content fl-left of-hide">
			<div class="of-hide"style="width:968px; float: right;">
	
	<div class="d-contain about-cont" style="width:960px;">
		<div class="row">
			<h2 class="title">公司简介</h2>
			<p>深圳润民现代生态农业发展有限公司（简称润民科技或润民）是一家完全与国际接轨的、具备独立法人资格的现代农业企业，是中国生猪全产业链经营的倡导者和先行者。润民全产业链包含种植、饲料、草本兽药、生态养殖与育种、屠宰与猪肉深加工、生物制药、有机肥料生产、品牌连锁八大版块，把控从农场到餐桌的各个环节，确保食品优质安全。</p>
			<p>润民独创的“三零”（零疫情、零药残、零污染）创新养殖模式，养殖全程均使用中草药防疫保健，完全杜绝使用化学药品和抗生素。润民“三零”养殖技术水平国内领先，荣获省市科学技术奖。润民所有的生态养殖基地均自建自营，从生猪养殖的源头开始，牢牢把控每一个生产环节，逐步打造出完整的生猪全产业链，实现对猪肉产品的完全可溯源管理，形成了完善的可追溯体系。</p>
			<p class="img"><img src="resources/images/pc/about-cnt-1.jpg" alt="深圳润民" /></p>
			<p>润民通过良好农业规范（GAP）和ISO认证。润民已被认定为国家级无公害农产品、国家级生猪养殖综合标准化示范企业、省级农业龙头企业、省级农业科技园、省级民营科技企业、省级生猪标准化示范场、省一级扩繁场、供港澳活猪注册饲养场（JXS712）、江西省和深圳市菜篮子基地、深圳市无公害农产品示范基地。</p>
			<p>润民全资控股的江西润民农业生物科技发展有限公司（简称润民农科）成立于2008年6月，注册资本人民币1.2亿元，现固定资产超过10亿元人民币。八戒王国占地约3.8万亩（约25.8平方公里），其中养殖区占地12600亩，种植区占地超过25000亩。八戒王国是目前亚洲地区单体规模最大的生态养猪场，同时也是中国最大的丹系种猪场和规模最大的供港澳活猪注册饲养场，设计规模年出栏生猪超过100万头。</p>
			<p>润民旗下的生猪屠宰和猪肉深加工车间位于深圳市坪山新区坑梓办事处深圳市四号生猪定点屠宰场内。屠宰场总占地面积91366.46平方米，总建筑面积约17万平方米，采用国际一流的荷兰MPS公司斯托克屠宰加工设备。生产工艺、自动化控制和污水处理等关键技术，均采用欧盟标准，达到国际先进水平。润民生猪屠宰和猪肉深加工车间同时配套0~4℃排酸冷库、零下18℃冷冻库、恒温15℃分割加工车间、熟食生产车间、国际领先的气调包装设备和全程冷链物流运输车队。</p>
		</div>
	</div>
</div>
		</div>
	</div>
	
	<div class="bd-left wrap-bd"></div>
	<dvi class="bd-right wrap-bd"></dvi>
</div>


<jsp:include page="footer.jsp"></jsp:include>

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