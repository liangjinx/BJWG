<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="__page_name__" value="回报订单确认 " scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/public.css"/>
</head>
<body>

<!--banner_box -->
<jsp:include page="../header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="../nav.jsp">
	<jsp:param value="5" name="nav"/>
</jsp:include>
<!-- 导航栏-->
<!-- content start -->
<div class="d-wrap">
	<div class="shop-order-cont">
		<div class="d-tips of-hide">
			<i class="fl-left"></i>
			<p class="fl-left">安全提醒： 请不要将银行卡、密码、手机验证码提供给他人，八戒王国online不会通过任何非官方电话、QQ、微博、微信与您联系。任何以”订单异常、系统升级“等为由要求
您点击链接进行退款、重新付款、额外付款或取消订单的都是骗子！请认准八戒王国online电话 0755-83579888</p>
		</div>
		<div class="d-addrs pack-up">
			<h2 class="title">选择收货地址<a href="<%=basePath%>pc/pv/address/addressManage" target="_blank"><span class="add-addrs">+新增收货地址</span></a></h2>
			<div class="addrs-list clearfix">
				<c:forEach items="${addressList}" var="userAddress">
					<div class="item <c:if test="${userAddress.isDefault == 1 }">current</c:if>" data-addr="${userAddress.addressId}">
						<ul class="cnt">
							<li class="top clearfix">
								<span class="s1 fl-left">${userAddress.contactMan}&nbsp;&nbsp;收</span>
								<span class="s2 fl-right">
									<a href="javascript:;">
										<c:if test="${userAddress.isDefault == 1 }">
											默认地址
											<input type="hidden" id="default_addr_id" value="${userAddress.addressId}">
										</c:if>
										<%--<c:if test="${userAddress.isDefault != 1 }">
											设为默认
										</c:if>--%>
									</a>
								</span>
							</li>
							<li class="midd">
								<!--<p>广东省  深圳市  龙岗区</p>
								<p>港湾创业大厦8楼全层</p>
								-->
								<p>${userAddress.address}</p>
								<p>${userAddress.contactPhone}</p>
							</li>
							<%--<li class="bott">
								<a href="javascript:;" class="d-amend" >修改</a>
								<a href="javascript:;" class="d-delete" >删除</a>
							</li>--%>
						</ul>
					</div>
				</c:forEach>
			</div>
			
			<div class="btn-more visibi" id="addrs-more">更多地址<i class="dib"></i></div>
		</div>
		
		<div class="d-orders">
			<h2 class="title">确认商品信息</h2>
			<div class="d-order-tab">
				<div class="ord-tr ord-head-tr clearfix">
					<div class="tr-td tr-td-1">商品信息</div>
					<div class="tr-td tr-td-2">数量</div>
					<div class="tr-td tr-td-2">分割费用（精细分割）</div>
					<div class="tr-td tr-td-3">运费</div>
					<div class="tr-td tr-td-4">真空包装</div>
				</div>
				
				<div class="ord-tr ord-body-tr clearfix">
					<div class="tr-td tr-td-1">
						<a href="javascript:;">
							<img src="${dataMap.proj_this.imgs }" alt="苏联大白猪" />
							${dataMap.proj_this.name }
						</a>
					</div>
					<div class="tr-td tr-td-2">${dataMap.myEarnings.num }</div>
					<div class="tr-td tr-td-2">￥${dataMap.divisionMoney!=null?dataMap.divisionMoney:0 }</div>
					<div class="tr-td tr-td-3">￥${dataMap.sendMoney!=null?dataMap.sendMoney:0 }</div>
					<div class="tr-td tr-td-4">￥${dataMap.packageMoney!=null?dataMap.packageMoney:0 }</div>
				</div>
			</div>
			
			<div class="d-pub-btn">
				<p>
					<form action="" method="post" id="form">
						<input type="hidden" name="payback" id="repayTypeId" value="${payback }">
						<input type="hidden" name="projectId" id="queryProjectId" value="${projectId }">
						<input type="hidden" name="divisionType" id="divisionType" value="${divisionType }">
						<input type="hidden" name="divisionTypeDetail" id="divisionTypeDetail" value="${divisionTypeDetail }">
						<input type="hidden" name="packageSpec" id="packageSpec" value="${packageSpec }">
						<input type="hidden" name="addressId" id="addressId" value="">
					</form>
					应付总额：<span>￥${dataMap.totalMoney!=null?dataMap.totalMoney:0 }</span>
					<c:if test="${payback eq 2 }">
						<input type="button" value="提交订单" class="orders-pub-btn d-sub-btn" id="submit" onclick="submitOrder(1);"/>
					</c:if>
					<c:if test="${payback eq 3 }">
						<input type="button" value="提交订单" class="orders-pub-btn d-sub-btn" id="submit" onclick="submitOrder(2);"/>
					</c:if>
				</p>
				<p>
					<input type="checkbox" checked="checked" class="order-pub-protocol" id="protocol"/>
					<a href="javascript:;" class="agreement-btn">本人同意并接受《服务协议》</a>
				</p>
			</div>
		</div>
		
	</div>
	
	
	<div class="d-shade"></div>
	
	<!-- 删除  -->
	<div class="shade-delete shade-cont">
		<div class="shade-main">
			<div class="title clearfix">
				<span class="dib fl-left">提示</span>
				<span class="d-close dib fl-right"></span>
			</div>
			<div class="info">
				确认要删除该收货地址吗？
			</div>
			<div class="btn">
				<input type="submit" class="sure" value="确定"/>
				<input type="button" class="cansel" value="取消"/>
			</div>
		</div>
	</div>
	
	<!-- 修改  -->
	<div class="shade-amend shade-cont">
		<div class="shade-main">
			<form>
				<div class="title clearfix">
					<span class="dib fl-left">修改收货地址</span>
					<span class="d-close dib fl-right"></span>
				</div>
				<div class="info">
					<div class="item">
						<label for="mayerName" class="dib label">
							<span>*</span>收货人姓名:
						</label>
						<input type="text" id="mayerName" datatype="s3-16" errormsg=""/>
						<i class="d-error"></i>
					</div>
					<div class="item">
						<label for="province" class="dib label">
							<span>*</span>所在地区:
						</label>
						<select name="province" id="province">
							<option value="广东省" selected>广东省</option>
						</select>
						<select name="city" id="city">
							<option value="深圳市" selected>深圳市</option>
							<option value="深圳市">深圳市</option>
						</select>
						<select name="district" id="district">
							<option value="龙岗区" selected>龙岗区</option>
						</select>
						<i class="d-error"></i>
					</div>
					<div class="item textarea-item">
						<label for="addrsDetail" class="dib label">
							<span>*</span>详细地址:
						</label>
						<textarea id="addrsDetail"></textarea>
						<i class="d-error"></i>
					</div>
					<div class="item">
						<label for="phone" class="dib label">
							<span>*</span>手机号码:
						</label>
						<input type="text" id="phone"/>
						<i class="d-error"></i>
					</div>
					<div class="item check-item">
						<input type="checkbox" id="defaultAddr"/>设为默认地址
					</div>
				</div>
				<div class="btn">
					<input type="submit" class="sure" value="保存"/>
					<input type="button" class="cansel" value="取消"/>
				</div>
			</form>
		</div>
	</div>
	
	<div class="agreement">
		<div class="agr-bd"></div>
		<div class="agr-main">
			<h2 class="title">“八戒王国online”协议书</h2>
			<div class="cont">
				<p>特别提示：任何一方通过平台网站页面点击确认或以其他方式选择接受本协议，即表示该方同意使用电子签名和数据电文，并表示该方已签署本协议，并同意接受本协议所载全部内容、条款和条件以及平台所列的与本协议所述事项相关的各项规则及其他文件。</p>
				<p>本《“八戒王国online”协议书》（简称“本协议”）由下列当事方（合称“各方”，单称“一方”）于__ __年_ _月__ __日在深圳市签订： 
（1）甲方<br>
法定名称：润民（深圳）金融信息服务有限公司<br>
法定代表人：黄邦银<br>
住所：深圳市福田区深南大道1006号深圳国际创新中心A座18楼  <br>
联系电话：0755-83571111</p><br>
				<p>（2）乙方<br>
指本协议附件一所列用户</p>
				<p>鉴于：<br>
1、甲方是一家依据中国法律合法成立并有效存续的有限责任公司，开发并运营一个专注于“互联网＋ 养猪”的农业互联网服务的网站——“八戒王国online”（www.bajiewg.com），并合法运营多个为实现网站功能的移动终端软件（如APP）和手机网页终端（m.bajiewg.com）（合称“平台”）；
“八戒王国online“是由甲方推出的全透明化、专注于农业领域的“互联网+ 养猪“生猪运营服务平台。本平台运用互联网金融手段，整合国内传统养猪场，改造、完善和提升传统养猪行业，使生猪全产业链扁平化、细节透明化、流程数据化，为用户（或者投资者，以下简称用户）提供安全、透明、可信的社交化网络生猪预定投资交易平台。“八戒王国online“能让用户以最便捷的途径获得稳定、丰厚的养猪投资回报；同时，用户也能成为猪场主人，参与养猪的全过程，从农场直接到餐桌，享受专属的放心优质的高端生态猪肉。
2、乙方是具有完全民事行为能力和权利能力的中国公民，且为平台的注册用户；</p>
				<p>双方经友好协商，就上述“八戒王国online”产品交易的相关事宜达成如下协议条款，以兹共同遵照执行：<br>
第1条  产品标的<br>
本期“八戒王国online”的标的详情如下：<br>
商品名称：外三元猪；<br>
规格：断奶仔猪；<br>
价格：人民币1,980.00元/头；</p>
			</div>
			<div class="btn-sure">
				<button class="btn-submit">同意并继续</button>
			</div>
		</div>
	</div>

</div>

<!-- content end -->

<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->

</body>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script>
	$(function(){
		
		(function(){
			
			/*协议*/
			$('.agreement-btn').on('click', function(){
				$('.agreement').fadeIn('fast');
			})
			$('.agreement .btn-submit').on('click', function(){
				$('.agreement').fadeOut('fast');
			})
			
			/*同意协议才能抢购*/
			$('#protocol').on('change', function(){
				if($('#protocol').is(':checked')){
					$('#submit').removeAttr('disabled');
				}else{
					$('#submit').attr('disabled','disabled');
				}
				return false;
			})
			
			/*地址收放及隐藏*/
			if($('.d-addrs .item').length > 2){
				$('#addrs-more').removeClass('visibi');
				$('#addrs-more').on('click', function(){
					$('.d-addrs').toggleClass('pack-up');
					return false;
				})
			}
			
			/*删除地址*/
			$('.d-delete').on('click', function(){	
				$('.d-shade').fadeIn('fast');
				$('.shade-delete').fadeIn('fast');	
				return false;
			});
			$('.shade-cont .d-close,.shade-cont .cansel,.d-shade').on('click',function(){
				$('.d-shade').fadeOut('fast');
				$('.shade-delete').fadeOut('fast');
				return false;
			});
			
			/*修改地址*/
			$('.d-amend').on('click', function(){	
				$('.d-shade').fadeIn('fast');
				$('.shade-amend').fadeIn('fast');	
				return false;
			});
			$('.shade-cont .d-close,.shade-cont .cansel,.d-shade').on('click',function(){
				$('.d-shade').fadeOut('fast');
				$('.shade-amend').fadeOut('fast');
				return false;
			});
			//表单验证
			$('#mayerName').blur(function(){
				$(this).nextAll('.d-error').html('');
				var name = $(this).val();
				if(!checkName(name)){
					$(this).nextAll('.d-error').html('*姓名不能为空');
				};
			})
			$('#addrsDetail').blur(function(){
				$(this).nextAll('.d-error').html('');
				var addrsDetail = $(this).val();
				if(!checkaddrsDetail(addrsDetail)){
					$(this).nextAll('.d-error').html('*地址不能为空');
				}
			})
			$('#phone').blur(function(){
				$(this).nextAll('.d-error').html('');
				var phone = $(this).val();
				if(!checkPhone(phone)){
					$(this).nextAll('.d-error').html('*联系电话格式不正确');
				};
			})
			$('.shade-amend .sure').on('click', function(){
				var name = $('#mayerName').val(),
					addrsDetail = $('#addrsDetail').val(),
					phone = $('#phone').val();
				if(checkName(name) && checkaddrsDetail(addrsDetail) && checkPhone(phone)){
					return true;
				}else{
					return false;
				}
			})
			/*
			 * 验证非空
			 * name姓名  addrsDetail详细地址  phone手机号
			 */
			function checkName(name){
				if(name == ''){
					return false;
				}
				return true;
			}
			function checkaddrsDetail(addrsDetail){
				if(addrsDetail == ''){
					return false;
				}
				return true;
			}
			function checkPhone(phone){
				if( phone == ''){
					return false;
				}else if(!!!(/^1\d{10}$/.test(phone))){
					return false;
				}
				return true;
			}

			
		})()
		
		$('.addrs-list>div').click(function(){
			$('.addrs-list>div').removeClass('current');
			$(this).addClass('current');
		});
	})
	
	function submitOrder(t){
		var addressId = $(".addrs-list>.current").attr('data-addr');
		if(addressId == ''){
			alert("请选择收货地址");
			return false;
		}
		$('[name=addressId]').val(addressId);
		if(t == 1){
			$("#form").attr("action",__base_path__+"pc/pv/order/payback2OrderSubmit");
		} else {
			$("#form").attr("action",__base_path__+"pc/pv/order/payback3OrderSubmit");
		}
		$("#form").submit();
	}
</script>


</html>




<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>处理费用提交</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		
	<link rel="stylesheet" type="text/css" href="styles.css">
	
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
			<input type="text" name="addressId" id="addressId" value=""> 
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
							<input type="radio" name="addressId" value="${userAddress.addressId}" <c:if test="${userAddress.isDefault == 1 }">checked</c:if> />
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
			$("#allProjectForm").attr("action","pc/pv/order/payback2OrderSubmit");return;
		} else {
			$("#allProjectForm").attr("action","pc/pv/order/payback3OrderSubmit");
		}
		$("#allProjectForm").submit();
	}
	</script>
</html>
-->