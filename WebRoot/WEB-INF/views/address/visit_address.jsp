<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html" charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
        <meta name="keywords" content="八戒王国online">
		<meta name="description" content="八戒王国online">
        <title>上门地址</title>
        <style>
			.nothing_adres{ width: 100%; height: 30px; line-height: 30px; padding: 25px 0; font-size: 1.6rem; color: #322c2c; text-align: center;}
		</style>
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<div class="head">
            <a href="<%=basePath %>wpv/uaconfirmOrder" class="head_back">
            	<img src="<%=basePath %>resources/images/back.png" alt="返回">
            </a>
            <p>上门地址</p>
            
            <c:if test="${addressList != null }">
	            <a href="<%=basePath %>wpv/uamanageList" >
	            	<div class="m_new">
	            		管理
	            	</div>
	            </a>
            </c:if>
            <c:if test="${addressList == null }">
	            <a href="<%=basePath %>wpv/uanewsAddress" >
	            	<div class="m_new">
	            		新增
	            	</div>
	           	</a>
           </c:if>
        </div>
        
        
    	<div class="visi_content">
    		<c:choose>
    			<c:when test="${fn:length(addressList)>0}">
		    		<c:forEach items="${addressList}" var="userAddress" >
		    		
			    		<div class="visi_info_content" onclick="chooseAddress(${userAddress.addressId},'<%=basePath %>wpv/uaconfirmOrder?1=1');">
			        		<h4>${userAddress.contactMan}<span>${userAddress.contactPhone}</span>
			        			<c:if test="${userAddress.isDefault == 1 }"> <em>默认</em> </c:if> 
			        		</h4>
			        		
			        		<div class="visi_concreteness_adres">
			        			${userAddress.address}
			        		</div>
			        		
			        		<c:if test="${userAddress.isDefault == 1 }">
				            	<div class="visi_tick">
				            		<img src="<%=basePath %>resources/images/cart/shopping_15.png" alt="点击添加/更换地址" />
				            	</div>
			            	</c:if>
			        	</div>
		    			
		    		</c:forEach>
    			</c:when>
    			<c:otherwise>
		        	<p class="nothing_adres">赶紧添加您的收货地址吧</p>
    			</c:otherwise>
    		</c:choose>
    	</div>
	</body>
	<script type="text/javascript">
		function chooseAddress(addressId,url){
			window.location.href=url+"&addressId="+addressId;
		}
	</script>
</html>

