<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="回报方式选择" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script src="resources/js/layer/layer.js"></script>
<style>
.show_div{ margin:0 auto; position:relative; display:none;}
.show_div_tit{ width:400px;margin-top:36px; margin-left:80px; position:relative; float:left;}
.show_div_tit img ,.show_div_tit p{ float:left;}
.show_div_tit p{ font-size:18px; margin-top:7px; margin-left:20px;}
.show_div_tit span{ margin-left:5px;font-size:16px;}
.show_left{ margin-left:150px;}
.show_top{margin-left:150px; margin-top:10px;}
.show_select{ float:left; margin-left:175px; width:170px; height:36px; line-height:36px;font-family: "Microsoft YaHei" ! important; background:none; border:1px solid #ccc; outline:0px; border-radius:3px; margin-top:10px; font-size:16px;}
.show_but{ float:left;  margin-left:175px; margin-top:30px;width:100px; height:36px; line-height:36px; text-align:center; cursor:pointer; color:#fff; background:#ff6600; font-size:16px;font-family: "Microsoft YaHei" ! important; border:0px; outline:0px; border-radius:3px;}
</style>
</head>
<body class="body_bg">
<div id="show_div" class="show_div">
			<form method="get" name="" id="form">
				<input type="hidden" name="payback" value="1">
				<input type="hidden" name="lastPayback" value="${way}">
				<input type="hidden" name="projectId" value="${projectId }">
				<input type="hidden" name="endTime" value="${endTime }"/>
				<div class="show_div_tit">
					<img src="resources/images/pc/ts_img.png" alt="注意！" />
					<p>
						注：粗分割和精细分割只可选一种
					</p>
				</div>
				<div class="show_div_tit show_left">
					<input type="radio" name="divisionType" class=""
						value="PAY_CONFIG.DIVISION_THICK_FEE" />
					<span> 粗分割（ ${divi_big_price }元/头）</span>
				</div>
				<select class="show_select" name="divisionTypeDetail">
					<c:forEach items="${diviList }" var="divi">
						<option value="${divi.value }">
							${divi.name }
						</option>
					</c:forEach>
				</select>
				<div class="show_div_tit show_top">
					<input type="radio" name="divisionType" class="" value="PAY_CONFIG.DIVISION_THIN_FEE" checked/>
					<span> 精细分割（${divi_small_price }元/头）</span>
				</div>

				<div class="show_div_tit show_left">
					<input type="radio" name="fenges" class="jxfg_b" checked readonly />
					<span class="jxfg_b"> 真空包装（${divi_pkg_price }元/盒）</span>
				</div>
				<select class="show_select jxfg_b" name="packageSpec">
					<c:forEach items="${packageList }" var="pkg" varStatus="status">
						<option value="${pkg}">
							${pkg}g
						</option>
					</c:forEach>
				</select>
				<div class="clear"></div>
				<input type="button" value="保存" class="show_but" id="btnWay2Sub"/>
			</form>
</div>

<div class="clear"></div>
<!--banner_box -->
<jsp:include page="../header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="../nav.jsp">
	<jsp:param value="3" name="nav"/>
</jsp:include>
<!-- 导航栏-->
<!--中间部分 -->
<div class="center mypig_center" style="z-index:1">
<!--mypig_left_nav -->
<jsp:include page="../user/nav.jsp">
	<jsp:param value="1" name="nav"/>
</jsp:include>
<!--mypig_left_nav -->
<div class="right_main">
	<div class="my_pig_tit"><!--my_pig_tit -->
    	<img src="resources/images/pc/nav_tit_bg.png" alt="选择回报方式"/>
        <div class="pig_tit"><p>选择回报方式</p></div>
    </div><!--my_pig_tit -->
    <div class="mypig_body">
    	<div class="left_nav"><!--left_nav -->
        	<div class="line"></div>
        	<div class="round_tit"><div class="p_tit">1</div><div class="p_span">回报方式</div></div>
            <div class="round_tit"><div class="p_tit">2</div><div class="p_span">回报方式</div></div>
            <div class="round_tit"><div class="p_tit">3</div><div class="p_span">回报方式</div></div>
            <div class="round_tit" style="margin-bottom:0px;">
            	<div class="p_tit">4</div><div class="p_span">回报方式</div>
            </div>
        </div><!--left_nav -->
        <ul class="mian_way">
        	<li data-type="1">
            	<div class="lg_pig_back" style="display:none;">
                	<p class="p1">《委托深圳润民销售，获得收益》详细说明</p>
                    <p class="p2">1.深圳润民以自己的名义代用户出售活猪，并按照不低于2,079.00元/头（扣除应交税费后，以下称“指导价”）的价格出售，按照指导价出售所得价款全部归属于用户；</p>
                    <p class="p2">2.若深圳润民高于指导价出售的，则超出部分的收益归深圳润民所有；若市场价低于指导价的，则由深圳润民按指导价收购；</p>
                    <p class="p2">3.深圳润民应在养殖周期结束后3个工作日内，将用户所拥有的生猪全部售出，并将用户应得货款支付给用户；若深圳润民未在规定时间内将生猪全部售出，则由深圳润民按照指导价收购未售出的生猪，并将收购款支付给用户。   </p>
                </div>
            	<div class="select_pig ${way==1?'checked':'' }"></div>
            	<div class="mian_way_tit">委托深圳润民销售，获得收益</div>
                <div class="mian_way_time">请截止至${endTime }前选择</div>               	
            </li>
            <li data-type="2">
            	<div class="lg_pig_back" style="display:none;height:180px; bottom:-189px;">
                	<p class="p1">《委托润深圳民屠宰配送》详细说明</p>
                    <p class="p2">1.深圳润民应当在养殖周期结束后3个工作日内负责代为屠宰，并按照用户的要求（包括分割要求、配送地址）进行配送；配送的猪肉重量以实际宰割净重为准；</p>
                    <p class="p2">2.用户应当向深圳润民支付屠宰费用和物流配送费用</p>
                </div>
            	<div class="select_pig ymps_but ${way==2?'checked':'' }"></div>
            	<div class="mian_way_tit">委托深圳润民进行屠宰配送</div>
                <div class="mian_way_time">请截止至${endTime }前选择</div>                
            </li>
            <li data-type="3">
            	<div class="lg_pig_back" style="display:none;bottom:-239px; height:230px;"">
                	<p class="p1">《到养猪场领取活猪》详细说明</p>
                    <p class="p2">1.用户应在养殖周期结束后3个工作日内，自行到到养猪场领取活猪。用户也可委托养猪场运送到其指定的地方，物流费用由用户承担。</p>
                    <p class="p2">2.如用户未及时领取，每延期1天，养猪场收取饲料等综合费人民币10元；逾期5天未领取，视为用户选择“委托深圳润民销售，获得收益”，由深圳润民公司按照上述约定方式和程序处理，并扣除50元/头的逾期领取综合费用。</p>
                </div>
            	<div class="select_pig ${way==3?'checked':'' }"></div>
            	<div class="mian_way_tit">到养猪场领取活猪</div>
                <div class="mian_way_time">请截止至${endTime }前选择</div>               
            </li>
            <li style="margin-bottom:0px;" data-type="4">
            	<div class="lg_pig_back" style="display:none;bottom:109px; height:180px;">
                	<p class="p1">《领取${ticketMoney }元／头的猪肉券》详细说明</p>
                    <p class="p2">1.用户可自行到深圳润民旗下的任何“八戒王国”社区店和专卖店凭猪肉券领取猪肉；</p>
                    <p class="p2">2.用户可在润民商城和微商城上下单购买，预定猪肉种类和数量，并按约定时间和地点凭猪肉券领取猪肉。</p>
                </div>
            	<div class="select_pig ${way==4?'checked':'' }"></div>
            	<div class="mian_way_tit">领取${ticketMoney }元/头的猪肉券<span>（仅限${limitCity }地区）</span></div>
                <div class="mian_way_time">请截止至${endTime }前选择</div>               
            </li>
        </ul>
    </div>
</div>


<div class="clear"></div>
</div>

<!-- 中间部分-->
<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->
</body>
<script>
	function openBox(){
		var layer_height = 420;
		var window_heigit = $(window).height();
		var offset = 'auto';
		if(window_heigit <= layer_height) offset = "0px";
		layer.open({
		    type: 1,
		    title:'',
		    skin: 'layui-layer-rim',
		    area: ['570px', layer_height+'px'],
		    offset: offset,
		    scrollbar:true,
			shift: 1, //0-6的动画形式，-1不开启
		    content: $("#show_div") 
		});	
	}
	$('.show_but').click(function(){
		layer.closeAll();
		})
	$(function(){
		$('input[name=divisionType]').change(function(){
		  	showVac();
		});
		
		})
	function showVac(){
		var check_ = $('input:radio[name="divisionType"]:checked').val(); // 判断选中状态
		//alert(check_);
		if(check_ == 'PAY_CONFIG.DIVISION_THICK_FEE'){
			$('#z_vacuo, .jxfg_b').hide();
		}else{
			$('#z_vacuo, .jxfg_b').show();
		}
	}
	$('.mian_way>li').click(function(){
		var self=$(this);
		var way = self.attr('data-type');
		var lastPayback = $('[name=lastPayback]').val();
		$('[name=payback]').val(self.attr('data-type'));
		/*if(lastPayback=='2' || way=='2'){
				//alert('回报方式已处理,无法更改!');
				return;
		}*/
		if(lastPayback!='2' && way=='2'){
			openBox();
			return;
		}
		$('#form').attr('action',__base_path__+'pc/pv/order/savePaybackChoose').submit();
	});
	$('#btnWay2Sub').click(function(){
		$('#form').attr('action',__base_path__+'pc/pv/order/savePaybackChoose').submit();
	});
</script>
<script>
$('.mian_way li').hover(function(){
	$('.mian_way li').find('.lg_pig_back').css('display','none');
	$(this).find('.lg_pig_back').css('display','block');
	},function(){
	$('.mian_way li').find('.lg_pig_back').css('display','none');
		})
</script>
<jsp:include page="../../common/commonTip.jsp"></jsp:include>
</html>


