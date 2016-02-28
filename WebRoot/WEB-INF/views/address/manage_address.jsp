<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
		<meta http-equiv="Pragma" content="no-cache" />
        <title>收货地址管理</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath %>resources/css/skins/all.css" >
        <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/compilations_pz.css">
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<form id="allProjectForm" name="allProjectForm" method="post">
			<%-- 目前只有在屠宰配送中会传30001过来 --%>
			<input type="hidden" name="pageSource" id="pageSource" value="${pageSource }">
     		<input type="hidden" name="queryAddressId" id="queryAddressId" value="${queryAddressId }" >
	        <div class="m_content">
	        	<ul>
	        		<c:choose>
	        			<c:when test="${fn:length(addressList) > 0}">
				        	<c:forEach items="${addressList}" var="userAddress">
				        		<li>
				        			<input type="hidden" name="addressIdXg" id="addressIdXg" value="" >
				        			<input type="hidden" name="addressIdIs" id="addressIdIs" value="" >
				        			<div class="m_topinfo" <c:if test="${pageSource != null && pageSource != '50001' }">onclick="returnToOrder(${userAddress.addressId})"</c:if>>
				        				<p class="m_customer">${userAddress.contactMan}&nbsp;&nbsp;<em>${userAddress.contactPhone}</em>
				        				<c:if test="${userAddress.isDefault == 1 }">
				        						<span class="m_default">默认</span>
				        						<input type="hidden" name="addressId" id="addressId" value="${userAddress.addressId}">
				        				</c:if>
				        				</p>
				        				<p class="m_detail">${userAddress.address}</p>
				        			</div>
				        			<div class="m_operation">
				        				<div class="l_operation" onclick="xgisDefault('${userAddress.addressId}')">
				        					<input type="radio" class="z_manage_address_radio" name="isDefault" id="isDefault" value="1"  <c:if test="${userAddress.isDefault == 1}">checked="checked"</c:if>/>
				        					<span class="radio_font">设为默认地址</span>
				        				</div>
				        				<div class="r_operation">
				        					<input type="button" class="edit_bton" value="编辑" onclick="edit('<%=basePath %>wpv/uagetEdit','${userAddress.addressId}')" />
				        					<input type="button" class="remove_bton" value="删除" onclick="edit('<%=basePath %>wpv/uadel','${userAddress.addressId}')"/>
				        				</div>
				        			</div>
				        		</li>
				        	</c:forEach>
				        </c:when>
				        <c:otherwise>
				        	<div class="z_no_address">还没有添加收货地址哦！</div>
				        </c:otherwise>
				    </c:choose>
	        	</ul>
	        	<a href="javascript:edit('<%=basePath %>wpv/uanewsAddress','')">
		        	<div class="submit_box2">新增收货地址</div>
	        	</a>
	        </div>
	    </form>
	   	<c:choose>
	   		<c:when test="${pageSource eq '50001' }">
	   	 		<jsp:include page="../back.jsp">
					<jsp:param value="wpv/ursetting" name="backUrl"/>
				</jsp:include>
    		</c:when>
    		<c:when test="${pageSource eq '30001' }">
    			<jsp:include page="../back.jsp">
					<jsp:param value="wpv/orsaveRepayType?repayTypeId=${wlsaveRepayTypeSessionMap.repayTypeId }&queryProjectId=${wlsaveRepayTypeSessionMap.queryProjectId }&endModifyTime=${wlsaveRepayTypeSessionMap.endModifyTime }" name="backUrl"/>
				</jsp:include>
    		</c:when>
    	</c:choose>
	</body>
</html>
<script language="JavaScript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
<%-- <script language="javascript" src="<%=basePath %>resources/js/icheck.min.js"></script> --%>
<script>
	$(function(){
		$(".remove_bton").on("click",function(){
			if(confirm('确定要删除这个地址吗？')){
				$(this).closest("li").remove();
				return true;
			}else{
				return false;
			}
		});
		
		//选择
		/* $(".z_manage_address_radio").iCheck({
	    	labelHover : false,
			cursor : true,
			checkboxClass : 'icheckbox_square-yellow',
			radioClass : 'iradio_square-yellow',
			increaseArea : '25%'
	    }); */
	});
	
	//提交
function edit(url,id){
	$("#addressIdXg").val(id);
	$("#allProjectForm").attr("action",url).submit();
}

function save(url){
	$("#allProjectForm").attr("action",url).submit();
}
//赋值
function xgisDefault(id){
	$.ajax({  
   		type: "POST",  
        url: '<%=basePath%>wpv/uaeditDefaultJson',  
        data: "addressIdIs="+id,
        dataType: "json",
        success: function(data){
        	if(data.status == 1){
        		alert("设置默认收货地址成功");
        	}else{
        		alert(data.data.text);
        	}
        },error:function(){
        	alert("服务器繁忙，请稍后再试");
        }
	});
}
//返回屠宰和领活猪选择收货地址的页面
function returnToOrder(id){
	$("#queryAddressId").val(id);
	$("#allProjectForm").attr("action","<%=basePath %>wpv/orbackSlaughterOrder").submit();
}

</script>
