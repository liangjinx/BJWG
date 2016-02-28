<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>我的猪仔-确认收货地址</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/compilations_pz.css" />
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<form action="<%=basePath %>wpv/orslaughterOrderSubmit" id="allProjectForm" name="allProjectForm" method="post">
			<input type="hidden" name="repayTypeId" id="repayTypeId" value="${repayTypeId }">
			<input type="hidden" name="queryProjectId" id="queryProjectId" value="${queryProjectId }">
			<input type="hidden" name="divisionType" id="divisionType" value="${divisionType }">
			<input type="hidden" name="divisionTypeDetail" id="divisionTypeDetail" value="${divisionTypeDetail }">
			<input type="hidden" name="packageSpec" id="packageSpec" value="${packageSpec }">
			<input type="hidden" name="addressId" id="addressId" value="${dataMap.userAddress.addressId}">
		
			<div class="z_shopping_address">
				<div class="shopping_address_empty">
					<c:choose>
						<c:when test="${dataMap.userAddress != null }">
							<a href="<%=basePath %>wpv/uamanageList?pageSource=30001">
								<div class="exist_address position_r">
									<div class="customer_info">
										<span class="customer_info_name">${dataMap.userAddress.contactMan}</span>
										<span class="customer_info_phone">${dataMap.userAddress.contactPhone}</span>
									</div>
									<div class="customer_info_adress">${dataMap.userAddress.address}</div>
									<div class="shopping_address_edit"></div>
								</div>
							</a>
						</c:when>
						<c:otherwise>
							<a href="<%=basePath %>wpv/uamanageList?pageSource=30001">
								<div class="empty_address">
									<img src="<%=basePath %>resources/images/shopping-address-add.png" class="add_address_img" alt="新建收货地址" />
									<span class="empty_address_info">新建收货地址</span>
								</div>
							</a>
						</c:otherwise>
					</c:choose>
				</div>
				<c:if test="${repayTypeId eq 2 }">
					<div class="order_info mb5">
						<div class="order_detail_way">委托深圳润民屠宰配送</div>
						<div class="order_pig_number mb15">生猪数量：${dataMap.myEarnings.num -  dataMap.myEarnings.presentNum}只</div>
					</div>
					<div class="order_detail_parameter">
						<div class="detail_settle_accounts">结算</div>
						<div class="z_segmentation">
							<p class="segmentation_1 f_l">分割费用（精细分割）</p>
							<p class="segmentation_2 f_r">￥${dataMap.divisionMoney }</p>
						</div>
						<div class="z_freight">
							<p class="freight_1 f_l">运费</p>
							<p class="freight_2 f_r">￥${dataMap.sendMoney }</p>
						</div>
						<div class="z_vacuum_package">
							<p class="vacuum_package_1 f_l">真空包装</p>
							<p class="vacuum_package_2 f_r">￥${dataMap.packageMoney }</p>
						</div>
					</div>
					<div class="order_price_time">
						<div class="shopping_address_amount_payable">
							应付总额：
							<span>￥${dataMap.totalMoney }</span>
						</div>
						<div class="z_shopping_address_confirm"><a href="javascript:submitOrder(1);">提交订单</a></div>
					</div>
				</c:if>
				<c:if test="${repayTypeId eq 3 }">
					<div class="order_price_time">
						<div class="shopping_address_amount_payable">
						</div>
						<div class="z_shopping_address_confirm"><a href="javascript:submitOrder(2);">提交订单</a></div>
					</div>
				</c:if>
			</div>
		</form>
	</body>
	<jsp:include page="../common/commonTip.jsp"></jsp:include>
	<jsp:include page="../back.jsp">
		<jsp:param value="wpv/orchooseRepayType?repayTypeId=${repayTypeId }&queryProjectId=${queryProjectId }&endModifyTime=${endModifyTime }" name="backUrl"/>
	</jsp:include>
</html>
<script type="text/javascript">
<!--
function submitOrder(t){
	var addressId = $("#addressId").val();
	if(addressId == ''){
		alert("请选择收货地址");
		return false;
	}
	if(t == 1){
		$("#allProjectForm").attr("action","<%=basePath %>wpv/orslaughterOrderSubmit");
	}else{
		$("#allProjectForm").attr("action","<%=basePath %>wpv/wlpigOrderSubmit");
	}
	$("#allProjectForm").submit();
}
//-->
</script>
