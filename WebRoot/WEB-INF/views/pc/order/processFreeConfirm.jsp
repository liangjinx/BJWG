<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>处理费用提交</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script language="JavaScript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
		
	</head>

	<body>
		<h3>
			处理费用提交
		</h3>
		<div>
			<form action="" method="post" id="allProjectForm">
			<input type="hidden" name="payback" id="repayTypeId" value="${payback }">
			<input type="hidden" name="projectId" id="queryProjectId" value="${projectId }">
			<input type="hidden" name="divisionType" id="divisionType" value="${divisionType }">
			<input type="hidden" name="divisionTypeDetail" id="divisionTypeDetail" value="${divisionTypeDetail }">
			<input type="hidden" name="packageSpec" id="packageSpec" value="${packageSpec }">
			<!-- <input type="text" name="addressId" id="addressId" value="${dataMap.userAddress.addressId}"> -->
			选择收货地址:
			<table>
				<tr>
					<th>
						收货人
					</th>
					<th>
						收货地址
					</th>
					<th>
						电话/手机
					</th>
					<th>
						操作
					</th>
					<th>
						选择
					</th>
				</tr>
				<c:forEach items="${addressList}" var="userAddress">
					<tr>
						<td>
							<c:if test="${userAddress.isDefault == 1 }">
								<span style="color: red">默</span>
								<input type="hidden" id="default_addr_id" value="${userAddress.addressId}">
							</c:if>
							${userAddress.contactMan}
						</td>
						<td>
							${userAddress.address}
						</td>
						<td>
							${userAddress.contactPhone}
						</td>
						<td data-addr="${userAddress.addressId}">
							<a href="pv/address/edit?addressId=${userAddress.addressId}">修改</a>&nbsp;
							<a href="javascript:;" class="btnDelete">删除</a>
						</td>
						<td>
							<input type="radio" name="addressId"value="${userAddress.addressId}" <c:if test="${userAddress.isDefault == 1 }">checked</c:if> />
						</td>
					</tr>
				</c:forEach>
			</table>
			<hr>
			<c:if test="${payback eq 2 }">
				<div class="order_detail_way">
					委托深圳润民屠宰配送
				</div>
				<div class="order_pig_number mb15">
					生猪数量：${dataMap.myEarnings.num }只
				</div>
				<div class="order_detail_parameter">
					<div class="detail_settle_accounts">
						结算
					</div>
					<p class="segmentation_1 f_l">
						分割费用（精细分割） ￥${dataMap.divisionMoney }
					</p>
					<p class="freight_1 f_l">
						运费 ￥${dataMap.sendMoney }
					</p>
					<p class="vacuum_package_1 f_l">
						真空包装 ￥${dataMap.packageMoney }
					</p>
					<div class="shopping_address_amount_payable">
						应付总额：
						<span>￥${dataMap.totalMoney }</span>
					</div>
				</div>
				<div class="order_price_time">
					<div class="z_shopping_address_confirm">
						<a href="javascript:submitOrder(1);">提交订单</a>
					</div>
				</div>
			</c:if>
			<c:if test="${payback eq 3 }">
				<div class="order_price_time">
					无需费用
					<div class="z_shopping_address_confirm">
						<a href="javascript:submitOrder(2);">提交订单</a>
					</div>
				</div>
			</c:if>
			</form>
		</div>
	</body>
	<script type="text/javascript">
	function submitOrder(t){
		var addressId = $("[name=addressId]").val();
		if(addressId == ''){
			alert("请选择收货地址");
			return false;
		}
		if(t == 1){
			$("#allProjectForm").attr("action","<%=basePath%>wpv/orslaughterOrderSubmit");return;
		} else {
			$("#allProjectForm").attr("action","<%=basePath%>pv/order/payback3OrderSubmit");
		}
		$("#allProjectForm").submit();
	}
	</script>
</html>
