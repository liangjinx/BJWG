<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>选择回报方式</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
    </head>
	<body>
	<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
	<form method="post" name="allProjectForm" id="allProjectForm" action="<%=basePath %>wpv/orsaveRepayType">
		<input type="hidden" name="repayTypeId" id="repayTypeId" value="${repayTypeId }">
		<input type="hidden" name="queryProjectId" id="queryProjectId" value="${queryProjectId }">
		<input type="hidden" name="endModifyTime" id="endModifyTime" value="${endModifyTime }">
		<div class="z_pay_back">
			<c:choose>
				<c:when test="${repayTypeId eq 1}">
					<!-- 回报方式1 -->
					<div class="pay_back_title">委托深圳润民销售，获得收益</div>
					<div class="pay_back_content">
						${configList[0].remark }
					</div>
					<div class="pay_back_charge_list">
						<a href="<%=basePath %>wpv/orFeeDetail">费用清单</a>
					</div>
					<div class="pay_back_b"><a href="<%=basePath %>wpv/orsaveRepayType?repayTypeId=1&queryProjectId=${queryProjectId}&endModifyTime=${endModifyTime }">选择此回报方式</a></div>
					<!-- 回报方式1 -->
				</c:when>
				<c:when test="${repayTypeId eq 2}">
					
					<c:set var="thickFee" value="0"></c:set>
					<c:set var="thinFee" value="0"></c:set>
					<c:set var="packageFee" value="0"></c:set>
					<c:set var="packageSpec" value="0"></c:set>
					<c:set var="description" value=""></c:set>
					<c:forEach items="${configList }" var="l">
						<c:choose>
							<c:when test="${l.code eq 'PAY_CONFIG.DIVISION_THICK_FEE' }">
								<c:set var="thickFee" value="${l.value }"></c:set>
							</c:when>
							<c:when test="${l.code eq 'PAY_CONFIG.DIVISION_THIN_FEE' }">
								<c:set var="thinFee" value="${l.value }"></c:set>
							</c:when>
							<c:when test="${l.code eq 'PAY_CONFIG.PACKAGE_FEE' }">
								<c:set var="packageFee" value="${l.value }"></c:set>
							</c:when>
							<c:when test="${l.code eq 'PAY_CONFIG.REPAY_TYPE_2' }">
								<c:set var="description" value="${l.remark }"></c:set>
							</c:when>
						</c:choose>
					</c:forEach>
				
					<!-- 回报方式2 -->
					<div class="pay_back_title">委托深圳润民屠宰配送</div>
					<div class="pay_back_content">
						${description }
					</div>
					<div class="pay_back_charge_list">
						<a href="<%=basePath %>wpv/orFeeDetail">费用清单</a>
					</div>
					<div class="pay_back_b_2">选择此回报方式</div>
					<!-- 回报方式2 -->
					
					<!-- 点击‘选择此回报方式’后弹出此层  暂时只有回报方式2提交以后有此弹层-->
					<div class="z_subdivide">
						<h4 class="z_subdivide_tit">注：粗分割和细分割只可选一种</h4>
						<div class="z_radio_box">
							<input type="radio" name="divisionType" value="PAY_CONFIG.DIVISION_THICK_FEE" class="z_exquisite" id="z_exquisite_1" />
							<label for="z_exquisite_1">粗分割（${thickFee }元/头）</label>
						</div>
						<div class="select_box_seg">
							<div class="pos_box position_r">
								<div class="select_show_seg">选择几分体</div>
								<select class="seg_select" name="divisionTypeDetail" id="divisionTypeDetail">
									<option value="">选择几分体</option>
									<c:forEach items="${dictList }" var="d">
										<option value="${d.value }">${d.name }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="z_radio_box">
							<input type="radio" name="divisionType" value="PAY_CONFIG.DIVISION_THIN_FEE" class="z_exquisite" id="z_exquisite_2" />
							<label for="z_exquisite_2">精细分割（${thinFee }元/头）</label>
						</div>
						<div class="z_radio_box" id="z_vacuo">
							<input type="radio" name="z_vacuo" value="2" class="z_vacuo" id="z_vacuo_1" />
							<label for="z_vacuo_1">真空包装（${packageFee }元/盒）</label>
						</div>
						<div class="select_box_vac">
							<div class="pos_box position_r">
								<div class="select_show_vac">选择几分体</div>
								<select class="vac_select" name="packageSpec" id="packageSpec">
									<option value="">选择包装规格</option>
									<c:forEach items="${specList }" var="s">
										<option value="${s }">${s }g</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<a href="javascript:save();">
							<input type="button" class="pay_back_save" value="提交" >
						</a>
					</div>
					
					<!-- end 点击‘选择此回报方式’后弹出此层 -->
				</c:when>
				<c:when test="${repayTypeId eq 3}">
					<!-- 回报方式3 -->
					<div class="pay_back_title">到养猪场领取活猪</div>
					<div class="pay_back_content">
						${configList[0].remark }
					</div>
					<div class="pay_back_charge_list">
						<a href="<%=basePath %>wpv/orFeeDetail">费用清单</a>
					</div>
					<div class="pay_back_b"><a href="<%=basePath %>wpv/orsaveRepayType?repayTypeId=3&queryProjectId=${queryProjectId}&endModifyTime=${endModifyTime }">选择此回报方式</a></div>
					<!-- 回报方式3 -->
				</c:when>
				<c:when test="${repayTypeId eq 4}">
					<c:set var="couponMoney" value="0"></c:set>
					<c:set var="description" value=""></c:set>
					<c:forEach items="${configList }" var="l">
						<c:choose>
							<c:when test="${l.code eq 'SYS_CONFIG.PIG_COUPON_MONEY' }">
								<c:set var="couponMoney" value="${l.value }"></c:set>
							</c:when>
							<c:when test="${l.code eq 'PAY_CONFIG.REPAY_TYPE_4' }">
								<c:set var="description" value="${l.remark }"></c:set>
							</c:when>
						</c:choose>
					</c:forEach>
				
					<!-- 回报方式4 -->
					<div class="pay_back_title">领取${couponMoney }元／头的猪肉券</div>
					<div class="pay_back_content">
						${description }
					</div>
					<div class="pay_back_charge_list">
						<a href="<%=basePath %>wpv/orFeeDetail">费用清单</a>
					</div>
					<div class="pay_back_b"><a href="<%=basePath %>wpv/orsaveRepayType?repayTypeId=4&queryProjectId=${queryProjectId}&endModifyTime=${endModifyTime }">选择此回报方式</a></div>
					<!-- 回报方式4 -->
				</c:when>
			</c:choose>
		</div>
		</form>
		<jsp:include page="../back.jsp">
			<jsp:param value="wpv/orchooseRepayType?queryProjectId=${queryProjectId}&endModifyTime=${ endModifyTime}" name="backUrl"/>
		</jsp:include>
	</body>
	<jsp:include page="../common/commonTip.jsp"></jsp:include>
</html>
<script src="<%=basePath %>resources/js/layer/layer.js"></script>
<script>
	//提交，生成订单
	function save(){
		
		var divisionType = $(":radio[name=divisionType]:checked");
		if($(divisionType).length <= 0){
			alert("请选择分割方式");
			return false;
		}
		if($(divisionType).val() == 'PAY_CONFIG.DIVISION_THICK_FEE'){
			if($("#divisionTypeDetail").find("option:selected").length <= 0 || $("#divisionTypeDetail").find("option:selected").val() == ''){
				alert("您选择的是粗分割，请选择几分体 ");
				return false;
			}
		}
		if(($("#packageSpec").find("option:selected").length <=0 || $("#packageSpec").find("option:selected").val() == '') && $(divisionType).val() == 'PAY_CONFIG.DIVISION_THIN_FEE'){
			alert("请选择包装规格");
			return false;
		}
		$("#allProjectForm").attr("action","<%=basePath %>wpv/orsaveRepayType").submit();
	}

	$(function(){
		//点击‘选择此回报方式’显示弹层
		$('.pay_back_b_2').on('click',function(){
			var height_ = 350,
				layer_width = $(window).width()*80/100,
				window_heigit = $(window).height(),
				offset = 'auto';
				
			if(window_heigit <= height_) offset = "0px";
			if(layer_width>=640) layer_width = "640*90/100";
			
			var index = layer.open({
			    type: 1,
			    title:false,
			    shade: 0.6,
			    area: [layer_width+'px', height_+'px'],
			    offset: offset,
			    scrollbar: true,
			    closeBtn: true, // false:不显示关闭按钮
				shift:1, // 0-6的动画形式，-1不开启
			    content: $(".z_subdivide") 
			}); 
			layer.style(index,{
				'border-radius':'5px'// 修改layer最外层容器样式
			});
		});
		// $('.pay_back_save').on('click',function(){
		//	layer.closeAll();
		// });
		
		// 粗分、细分、真空select
		$('.select_box_seg .seg_select').on('change',function(){
			$('.select_show_seg').text($('.seg_select option:selected').text());
		 });
		 $('.select_box_vac .vac_select').on('change',function(){
			$('.select_show_vac').text($('.vac_select option:selected').text());
		 });
		// 粗分割、精细分割状态改变
		$('input[name=divisionType]').change(function(){
		  	showVac();
		});
	});
	
	// 粗分割、精细分割与真空包装绑定关系
	function showVac(){
		var check_ = $('input:radio[name="divisionType"]:checked').val(); // 判断选中状态
		//alert(check_);
		if(check_ == 'PAY_CONFIG.DIVISION_THICK_FEE'){
			$('#z_vacuo, .select_box_vac').hide();
		}else{
			$('#z_vacuo, .select_box_vac').show();
		}
	}
</script>

