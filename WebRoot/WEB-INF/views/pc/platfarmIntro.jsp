﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="__page_name__" value="关于我们" scope="request" />
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="./meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css" />
<link rel="stylesheet" href="resources/css/pc/public.css" />
	<style type="text/css">
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
        .section .customized-img1{
            float: left;
            margin-left: 200px;
        }
        .section .customized-img2{
            float: left;
            margin-left: 100px;
        }
	</style>
</head>
<body>

	<!--banner_box -->
	<jsp:include page="header.jsp"></jsp:include>
	<!--banner_box -->
	<!--导航栏-->
	<jsp:include page="nav.jsp">
		<jsp:param value="6" name="nav" />
	</jsp:include>
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
						<a href="pc/pnv/platfarmIntro" class="current">平台说明<i class="d-icon"></i></a> 
						<a href="pc/pnv/breedProcess">养猪工艺<i class="d-icon"></i></a> 
						<a href="pc/pnv/question">常见问题<i class="d-icon"></i></a>
						<a href="pc/pnv/protocol">用户协议<i class="d-icon"></i></a>
						<a href="pc/pnv/connect">联系我们<i class="d-icon"></i></a>
					</div>
				</div>
			</div>
			
			<div class="d-content fl-left of-hide">
				<div class="of-hide" style="width:968px; float: right;">
					<div class="d-contain about-cont" style="width:960px;">
					
						<div class="section">
							<h2 class="title">平台说明</h2>
						</div>
						
						<div class="section">
					        <h4>引言</h4>
					        <p>“八戒王国online”是啥？简单说，“八戒王国online”就是一个网上养猪平台，把线下的实体养猪场搬到了网上。您出钱购买仔猪，我们负责养大，确保您吃上您专属的高端生态猪肉。如果猪养大后，您选择不要成猪或者猪肉，我们不但不扣您预付款，我们还给年化9.6%的固定收益。加入“八戒王国online”，有肉吃，有钱挣！</p>
					        <img src="resources/images/platfarmIntro-1.jpg" style="width: 242px;height: 192px">
					    </div>
					
					    <div class="section">
					        <h4>平台简介</h4>
					        <p>“八戒王国online”是由润民集团旗下的深圳润民互联网生态农业科技有限公司（简称“润民科技”）推出的全透明化、专注于农业领域的“互联网+养猪”生猪运营服务平台。</p>
					        <p>本平台充分运用互联网技术，整合国内传统养猪场，改造、完善和提升传统养猪行业，使生猪全产业链经营扁平化、细节透明化、流程数据化，为用户（或者投资者，以下简称用户）提供安全、透明、可信的社交化网络生猪预订投资交易服务。</p>
					        <p>“八戒王国online”能让用户以最便捷的途径获得稳定、丰厚的养猪投资回报；同时，用户也能成为猪场主人，参与养猪，监控从农场到餐桌的生产全过程，享受专属的放心优质的高端生态猪肉。</p>
					    </div>
					
					    <div class="section">
					        <h4>平台发展</h4>
					        <p>目前平台2.0版已经上线了，用户可在微信平台或者电脑端网站上预订仔猪，随时查看仔猪生长阶段和账户收益情况。</p>
					        <p>平台2.0版还增加了农场实时远程监控，可随时查看仔猪的饲喂状况、生长情况；增加了成猪领取、猪肉配送、提现、兑换猪肉券（目前限深圳区域）和分享评比等。</p>
					        <p>继微信和电脑端网站后，手机APP端（iOS、Android版）也即将上线。</p>
					        <img src="resources/images/platfarmIntro-3-1.png" style="width: 187px;height: 332px" class="customized-img1">
					        <img src="resources/images/platfarmIntro-3-2.png" style="width: 188px;height: 334px" class="customized-img2">
					        <div class="clear" style="clear: both"></div>
					    </div>
					
					    <div class="section">
					        <h4>平台原理</h4>
					        <img src="resources/images/platfarmIntro-4.jpg" style="width: 600px;height: 330px">
					    </div>
					
					    <div class="section">
					        <h4>运营模式</h4>
					        <p>“八戒王国online”是“互联网+养猪”生猪运营服务平台，能够为用户带来无缝的参与养猪的全新体验，为用户提供参与养猪行业投资与经营的机会。平台整合生猪全产业链的各环节，实现猪肉产品从农场直接到用户餐桌，确保用户享受专属的放心优质的高端生态猪肉。</p>
					        <p>用户在“八戒王国online”平台预订仔猪，平台委托各生态养猪场均按照“三零”标准养殖，用户在线查看猪只的生长情况。养殖期限届满，用户即可从平台获得约220斤重的成猪，或者79.2元/头的收益回报。</p>
					        <p>当然，用户也可以支付物流运输、屠宰加工费用后，要求平台把活猪、猪肉配送到家；或者直接领取平台猪肉券2100元，凭券到润民集团旗下的各“八戒王国”社区店、专卖店和网上商城消费（目前仅限深圳地区）。</p>
					        <p>平台根据各猪场仔猪数量决定当期可供抢购数目。已经被抢购成功的仔猪的饲养、出栏生猪的运输、屠宰和猪肉配送均由平台自行或者委托第三方完成。</p>
					        <img src="resources/images/platfarmIntro-5.png" style="width: 437px;height: 298px">
					    </div>
					
					    <div class="section">
					        <h4>抢购流程</h4>
					        <p>“八戒王国online”平台每周（一、三、五）会根据猪场仔猪存栏情况，发布可供用户抢购的仔猪数目等情况 。</p>
					        <p>用户成功抢购到仔猪，并及时付款，仔猪预订过程即完成，用户正式成为仔猪主人。饲养过程中，用户可以通过实时远程监控系统，随时查看仔猪饲养状况。经提前预约（考虑到养猪场的防疫要求），用户也可亲临养猪场现场查看猪只生长情况和养殖模式。</p>
					        <p>平台选择的是断奶仔猪，饲养到出栏，仍需约150天。饲养期限届满（150天，不含断奶前28天）之后，平台将约220斤重的成猪交付给用户。</p>
					        <p>平台也可根据用户的要求，自行或者委托第三方提供活猪运送、生猪屠宰、猪肉配送等服务；用户还可以委托平台出售成猪，获得2059.2元/头的货款收入，或者领取2100元/头的猪肉券。</p>
					        <img src="resources/images/platfarmIntro-6.jpg" style="width: 821px;height: 65px">
					    </div>
					
					    <div class="section">
					        <h4>平台特点</h4>
					        <p>1、安全可靠，放心</p>
					        <p>专款专用，最大限度保障用户的资金安全。由于猪肉需求市场巨大， 收益不能达成的风险极低。</p>
					        <p>2、透明投资，风险小</p>
					        <p>”八戒王国online“平台将用户投资过程通过互联网全程透明化。仔猪饲养过程中，用户可以通过实时远程监控系统，随时查看仔猪饲养状况。经提前预约（考虑到养猪场的防疫要求），用户也可亲临养猪场现场查看猪只生长情况和养殖模式。</p>
					        <p>3、低门槛，高收益</p>
					        <p>任何用户都可以在平台投资“养猪”项目。花费1980元参与“养猪”投资，5个月（150天）后可回收全部本息，单轮收益率5%，投资年化收益率9.6%。</p>
					        <p>4、投资周期短，回本快</p>
					        <p>”八戒王国online“平台选择的是断奶仔猪，预订后5个月（150天）即可回收全部本息。相比其他一年期的投资产品，较短的投资周期，也大大降低了投资风险。</p>
					        <p>5、回报方式多样</p>
					        <p>饲养期限届满（150天，不含断奶前28天）之后，平台将约220斤重的成猪交付给用户。平台也可根据用户的要求，自行或者委托第三方提供活猪运送、生猪屠宰、猪肉配送等服务，享用专属的高端生态猪肉；用户还可以委托平台出售成猪，获得2059.2元/头货款收入，或者领取2100元/头的猪肉券。</p>
					        <img src="resources/images/platfarmIntro-7.jpg" style="width: 705px;height: 100px">
					    </div>
					
					    <div class="section">
					        <h4>风险控制</h4>
					        <p>1.市场风险</p>
					        <p>平台定位于生猪全产业链运营平台， 整合饲料、种植、育种、养殖、屠宰、加工和配送等从猪场到餐桌的各环节，确保猪肉食品优质安全放心的同时，也避免了“猪周期”导致肉价不稳定而发生的不确定性。</p>
					        <p>2.养殖风险</p>
					        <p>平台选择自然生态环境和自然防疫条件良好的养猪场，按照“三零”标准进行生态养殖。“三零”养殖技术处于国内领先水平。且养猪场实现信息化数据化管理，全程监控养猪过程。</p>
					        <p>3.信用风险</p>
					        <p>全程可远程监控、全程数据电子化，打造完全透明的“互联网+养猪”平台。中国人民保险公司为饲养生猪提供保险保障。</p>
					    </div>		
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
	(function() {
		/*字号选择*/
		var $i = $('.d-article .title i');
		$i.on('click', function() {
			var index = $(this).index();

			$i.removeClass('current');
			$(this).addClass('current');
			$('.d-article .content p').css({
				'font-size' : index * 2 + 14 + 'px',
			});
		})

		/**/

	})()
</script>
</html>