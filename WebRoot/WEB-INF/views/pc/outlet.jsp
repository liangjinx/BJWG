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
						<a href="pc/pnv/about">公司简介<i class="d-icon"></i></a> 
						<a href="pc/pnv/about2">平台说明<i class="d-icon"></i></a> 
						<a href="pc/pnv/question" >常见问题<i class="d-icon"></i></a> 
						<a href="pc/pnv/outlet" class="current">实体门店<i class="d-icon"></i></a> 
						<a href="pc/pnv/connect">联系我们<i class="d-icon"></i></a>
					</div>
				</div>
			</div>
		
		<div class="d-content fl-left of-hide">
			<div class="of-hide"style="width:968px; float: right;">
	
	<div class="d-contain about-cont" style="width:960px;">
		<div class="row">
			<h2 class="title">实体门店</h2><br/>
			<p>1.社区店/东升店</p>
			<p>地址：深圳市宝安区桃源居12区16号商铺--东升生鲜店</p><br/>
			<p>2.社区店/顾家店</p>
			<p>地址：深圳市宝安区中心区裕安一路3076-78号顾家生活超市</p><br/>
			<p>3.社区店/乐百家</p>
			<p>地址：深圳市福田区景田南小区综合楼一层乐百家超市</p><br/>
			<p>4.社区店/优鲜100</p>
			<p>地址：深圳市沙头角盐田三家店优鲜100生活超</p><br/>
			<p>5.社区店/美新龙华民塘店</p>
			<p>地址：深圳市龙华民塘路莱蒙水榭春天5期大门口</p><br/>
			<p>6.社区店/美新龙华人民路店</p>
			<p>地址：深圳市龙华人民路莱蒙水榭春天1期大门口</p><br/>
			<p>7.社区店/美新南山港城店</p>
			<p>地址：深圳市南山港城店恒立心海湾花园平安银行旁</p><br/>
			<p>8.社区店/美新宝安坪洲店</p>
			<p>地址：深圳市宝安坪洲圣拿威花园南门首铺</p><br/>
			<p>9.社区店/美新宝安富通城店</p>
			<p>地址：深圳市宝安富通城一期大门市场</p><br/>
			<p>10.社区店/美新宝安果岭店</p>
			<p>深圳市宝安西乡招商果岭花园1123-1124铺</p><br/>
			<p>11.社区店/成富超市</p>
			<p>深圳市宝安区富通城三期三栋105-115号成富超市内</p><br/>
			<p>12.美宜多生活超市科技园店</p>
			<p>南山区科技园高新中四道科艺路13-3</p><br/>
			<p>13.美宜多大冲店</p>
			<p>南山区科发路科技园30区4栋首层</p><br/>
			<p>14.美宜多固戍店</p>
			<p>宝安区西乡固戍地铁站文浩商务大厦旁边</p><br/>
			<p>15.新一佳富通店</p>
			<p>深圳市宝安区龙华新区和平西路新一佳购物广场2层16.新一佳沙河店</p><br/>
			<p>16.新一佳沙河店</p>
			<p>深圳市南山区深南大道9030号世纪假日广场负一层新一佳超市</p><br/>
			<p>17.新一佳宝安店</p>
			<p>深圳市南山区宝安22区公园路21号</p><br/>
			<p>18.新一佳中心店</p>
			<p>深圳市龙岗区布吉镇布吉中心广场新一佳商场</p><br/>
			<p>19.新一佳信义店</p>
			<p>深圳市布吉镇罗岗工业区信义假日名城</p><br/>
			<p>20.新一佳御景店</p>
			<p>深圳市福田区滨河路华强南1号</p><br/>
			<p>21.新一佳碧海店</p>
			<p>深圳市盐田区沙头角深沙路碧海蓝天名苑三楼</p><br/>
			<p>22.新一佳风格店</p>
			<p>深圳市罗湖区宝安南路与红桂路交汇处</p><br/>
			<p>23.新一佳田贝店</p>
			<p>深圳市罗湖区贝丽南路59号合正星园大厦裙楼</p><br/>
			<p>24.新一佳园岭店</p>
			<p>深圳市罗湖区园岭中路园中花园C、D、E座裙楼</p><br/>
			<p>25.龙华百佳华店</p>
			<p>深圳市宝安区人民北路291号</p>
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