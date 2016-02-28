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
        <title>银行卡详情</title>
        <link rel="stylesheet" href="<%=basePath%>resources/css/public.css"/>
        <link rel="stylesheet" href="<%=basePath%>resources/css/compilations_pz.css" />
        <style>
        	.bank_card_content { width: 100%; background-color: white; overflow: hidden;}
        	.bank_listbox { position: relative; width: 90%; padding: 10px 20px; margin: 15px auto; border: 1px solid #dedede; -webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; overflow: hidden;}
        	.bank_top, .bank_bottom { float: left; width: 100%; overflow: hidden;}
        	.bank_l_img { float: left; width: 45px; border: none; border-radius: 50%; -webkit-border-radius: 50%; -moz-border-radius: 50%;}
        	.bank_name, .bank_sort { width: 120px; margin-left: 50px; font-size: 1.4rem; color: #322c2c;}
        	.bank_sort { margin-top: 5px;}
        	.bank_bottom p { font-size: 1.6rem; color: #322c2c; text-align: right;}
        	.bank_pay_way { position: absolute; top: 20px; right: 20px; font-size: 1.6rem; color: #322c2c; text-align: center;}
        	.wd_record { width: 90%; height: 45px; line-height: 45px; margin: 25px auto; font-size: 1.6rem; color: #fff; text-align: center; -webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; background-color: #3dbd6d;}
        	/*.wd_record img { width: 5px; padding-top: 18px;}
        	.del_box { position: fixed; bottom: 0; left: 0; display: none; width: 100%; height: 135px; text-align: center; background-color: #ccc; z-index: 100;}
        	.card_del, .card_cancel { width: 90%; height: 40px; line-height: 40px; font-size: 1.6rem; border: none; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px;}
        	.card_del { margin: 20px auto; color: #fff; background-color: #f40a02;}
        	.card_cancel { margin: 0 auto 10px; color: #322c2c; background-color: #fff;}*/
        	
        </style>
	</head>
	<body>
		<form action="" id="allProjectForm" name="allProjectForm" method="post">
			<input type="hidden" name="cardId" id="cardId" value="${ bankCard.cardId}">
	        <div class="bank_card_content">
	        	<div class="bank_listbox">
	        		<div class="bank_top">
	        			<img src="<%=basePath%>resources/images/bank-${ bankCard.bankCode}.png" alt="中国银行" class="bank_l_img" />
	        			<p class="bank_name">${bankCard.bank }</p>
	        			<p class="bank_sort"></p>
	        			<p class="bank_pay_way">快捷支付</p>
	        		</div>
	        		<div class="bank_bottom">
	        			<p>**** ***** *****${fn:substring(bankCard.cardNo,fn:length(bankCard.cardNo)-4,fn:length(bankCard.cardNo))}</p>
	        		</div>
	        	</div>
	        </div>
	        <div class="wd_record">解绑银行卡</div>
	       	<!--<div class="del_box">
	       		<input type="button" class="card_del" value="解绑银行卡" />
	       		<input type="button" class="card_cancel" value="取消" />
	       	</div>-->
		</body>
		<jsp:include page="../wallet/input_pay_password.jsp">
			<jsp:param value="del" name="confirmFunc"/>
		</jsp:include>
	</form>
	<jsp:include page="../common/commonTip.jsp"></jsp:include>
	<jsp:include page="../back.jsp">
		<jsp:param value="wpv/wlbankCardList?s_type=1" name="backUrl"/>
	</jsp:include>
</html>
<script type="text/javascript">
	$(function(){
		/*选择删除操作时，需要先确认支付密码*/
		$(".wd_record").on("click",function(){
			if('${sessionScope.is_user_set_pay_pw}' == 'yes'){
				
				//显示输入密码框
				showPayPwd();
			}else{
			
				//window.location.href="<%=basePath%>wpv/wlbankCardDelete?cardId="+${ bankCard.cardId};
				$("#allProjectForm").attr("action","<%=basePath%>wpv/wlbankCardDelete").submit();
			}
			//$(".pay_password_box, .mark").show();
		});
	});
	
	function del(){
		
		$("#allProjectForm").attr("action","<%=basePath%>wpv/wlbankCardDelete").submit();
		//window.location.href="<%=basePath%>wpv/wlbankCardDelete?cardId="+${ bankCard.cardId};
	}
</script>

