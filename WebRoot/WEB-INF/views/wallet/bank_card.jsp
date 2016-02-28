<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta name="keywords" content="八戒王国online">
	<meta name="description" content="八戒王国online">
	<meta http-equiv="Pragma" content="no-cache" />
	<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
	<link rel="stylesheet" href="<%=basePath %>resources/css/mybankcard.css"/>
	<title>我的银行卡-列表 </title>
</head>
<body class="bg-gray">
	<form action="<%=basePath %>wpv/wlbankCardEditInit" id="allProjectForm" name="allProjectForm" method="post">
	
		<input type="hidden" id="s_type" name="s_type" value="${s_type }"/>
	    <c:if test="${not empty validatePw && validatePw eq 'yes' }">
	    	<input type="hidden" id="needPw" name="needPw" value="yes"/>
	    </c:if>
	    
		<div class="myBankCard">
			<div class="bank-card-container">
				<ul class="bank-card-list">
					<li class="card-list-area">
						<c:choose>
							<c:when test="${fn:length(list)>0}">	
								<c:forEach items="${list}" var="l">
									<a <c:choose>
				    					<c:when test="${s_type ==2}">
				    						href="<%=basePath %>wpv/wltakeCashPage?cardId=${l.cardId }"</c:when>
				    					<c:otherwise>
				    						href="<%=basePath %>wpv/wlbankCardDetail?cardId=${l.cardId }"</c:otherwise>
				    				</c:choose>
					    			>
										<div class="card-item table-type">
											<div class="tbl-cell-mid"><img class="bank-logo" src="<%=basePath %>resources/images/bank-${l.bankCode}.png" alt="" /></div>
											<div class="tbl-cell-mid">
												<h6 class="bank-name">${l.bank }</h6>
												<p class="bank-end-num c-gray">尾号${fn:substring(l.cardNo,fn:length(l.cardNo)-4,fn:length(l.cardNo))}</p>	
											</div>
										</div>
									</a>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="z_no_bank_caed">还没有添加银行卡.</div>
							</c:otherwise>
						</c:choose>
					</li>
					<li class="add-card-handle">
						<a href="javascript:showPasswordBox();"><i class="ico i-arr fr"></i><i class="ico i-plus"></i>添加银行卡</a>
					</li>
				</ul>
			</div>
			<div class="btn-container mt25">
				<a href="<%=basePath %>wpv/urstoreMe" class="btn full-btn btn-default">返回我的猪场</a>
			</div>
		</div>
		
		
		<jsp:include page="../wallet/input_pay_password.jsp">
			<jsp:param value="addBankCardInit" name="confirmFunc"/>
		</jsp:include>
	</form>
</body>
<jsp:include page="../common/commonTip.jsp"></jsp:include>

<jsp:include page="../back.jsp">
	<jsp:param value="wpv/wlmyWallet" name="backUrl"/>
</jsp:include>
</html>
<script type="text/javascript">
<!--
	function showPasswordBox(){
		if($("#needPw") && $("#needPw").val() == 'yes'){
			
			showPayPwd();
			
			confirmBtn();
		}else{
			
  			$("#allProjectForm").attr("action","<%=basePath %>wpv/wlbankCardEditInit").submit();
		}
	}
	function addBankCardInit(){
		
		$("#allProjectForm").submit();
	}
//-->
</script>

