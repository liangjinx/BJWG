<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<meta name="keywords" content="八戒王国">
	<meta name="description" content="八戒王国">
	<meta http-equiv="Pragma" content="no-cache" />
	<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
	<link rel="stylesheet" href="<%=basePath %>resources/css/mybankcard.css"/>
	<title> 添加银行卡 </title>
</head>
<body class="bg-gray">
	<div class="myBankCard">
		<form class="add-bank-card-fm pt10" action="<%=basePath %>wpv/wlbankCardSave" id="allProjectForm" name="allProjectForm" method="post">
			<input type="hidden" name="cardId" id="cardId" value="${bankCard.cardId }">
        	<input type="hidden" name="s_type" id="s_type" value="${s_type }">
			<div class="bank-card-container">
				<ul class="list-panel add-bank-card">
					<li>
						<div class="block-panel">
							<label class="fm-label" for="">持卡人</label>
							<input class="fm-input" type="text" name="accountName" id="accountName" value="${bankCard != null ? bankCard.accountName : bankPersonInfo.name }" maxlength="55" 
								<c:if test="${bankCard.cardId >0 || bankPersonInfo!=null }">readonly="readonly"</c:if> 
								placeholder="填写持卡人姓名" />
						</div>
						<div class="block-panel">
							<label class="fm-label" for="">身份证号</label>
							<input class="fm-input" type="text" name="idCard" id="idCard" value="${bankCard != null ? bankCard.idCard : bankPersonInfo.idCard}" maxlength="18" placeholder="持卡人身份证号" />
						</div>
						<div class="block-panel">
							<label class="fm-label" for="">银行卡号</label>
							<input class="fm-input" type="tel" name="cardNo" id="cardNo" value="${bankCard.cardNo}" maxlength="19" placeholder="绑定银行卡卡号" onchange="getBank(this)"/>
						</div>
					</li>
					<li>
						<div class="block-panel">
							<label class="fm-label" for="">卡类型</label>
							<input class="fm-input" type="text" name="bank" id="bank" value="${bankCard.bank }" placeholder="" readonly="readonly"/>
							<input type="hidden" name="bankCode" id="bankCode" value="">
	        				<input type="hidden" name="cardType" id="cardType" value="1">
						</div>
					</li>
					<li>
						<div class="block-panel">
							<label class="fm-label" for="">开户省</label>
							<select class="fm-select" id="province" name="province" onchange="cityName2('${address.city}')">
                                <option value="" selected="selected">请选择</option>
                                <c:forEach items="${province}" var="pr" >
                    				<OPTION value="${pr.areaId}" <c:if test="${address.province == pr.areaId}">selected="selected"</c:if> >${pr.name}</OPTION>
                    			</c:forEach>
                            </select>
						</div>
						<div class="block-panel">
							<label class="fm-label" for="">开户市</label>
							<select class="fm-select" id="city" name="city">
                                <option value="" selected="selected">选择市</option>
                            </select>
						</div>
					</li>
				</ul>
			</div>
			<div class="btn-container mt25">
				<a href="javascript:save();" class="btn full-btn btn-default">确认</a>
			</div>
		</form>
	</div>
</body>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
<jsp:include page="../back.jsp">
	<jsp:param value="wpv/wlbankCardList?s_type=${s_type }" name="backUrl"/>
</jsp:include>
</html>
<script type="text/javascript" src="<%=basePath %>resources/js/city.js"></script>
<script type="text/javascript">
<!--
	function save(){
		var cardNo = $.trim($("#cardNo").val());
		var bank = $.trim($("#bank").val());
		var accountName = $.trim($("#accountName").val());
		var idCard = $.trim($("#idCard").val());
		var link = $.trim($("#link").val());
		if(accountName == ''){
			alert("请填写持卡人名");
			return ;
		}
		if(idCard == '' || idCard.length > 18 || idCard.length < 15){
			alert("请填写正确的15位或18位身份证号");
			return false;
		}
		var myreg = /^[0-9+]\d{13,17}|[0-9+]\d{13,16}x/;
		if(!myreg.test($.trim(idCard))){
			alert("请填写正确的15位或18位身份证号");
			return ;
		}
		if(cardNo == '' || cardNo.length < 8 || cardNo.length > 19 || isNaN(cardNo)){
			alert("请填写有效的卡号");
			return ;
		}
		if(bank == '' || bank < 0){
			alert("请填写正确的卡号");
			return ;
		}
		var province = $("#province").find("option:selected");
		if(province.length <=0 || province.val() == ''){
			alert("请选择省份");
			return;
		}
		var city = $("#city").find("option:selected");
		if((city.length <=0 || city.val() == '') && $("#city").find("option").length > 0){
			alert("请选择城市");
			return;
		}
		/*if($(":input[name=ck]:checked").length < 1){
			alert("请确认您是否已阅读并同意《用户服务协议》");
			return ;
		}*/
		$("#allProjectForm").submit();
	}
	
	//获取银行	
	function getBank(obj){
		if($(obj).val() == ''){
			return;
		}
		if($(obj).val() != '' && $(obj).val().length < 15){
			alert("请输入正确的卡号");
			return ;
		}
		$.ajax({  
		   		type: "POST",  
		        url: '<%=basePath %>wpv/urbankByCode',  
		        data: "cardNo="+$(obj).val(),
		        dataType:"json",
		        success: function(data){
		        	if(data.status == 1){
		        		$("#bank").val(data.name);
		        		$("#bankCode").val(data.value);
		        	}else{
		        		alert("请输入正确的卡号");
		        		return;
		        	}
				}  
		});  
	}	
	
	function formatBankNo (BankNo){
	    if (BankNo.val() == "") return;
	    var account = new String (BankNo.val());
	    account = account.substring(0,22); /*帐号的总数, 包括空格在内 */
	    if (account.match (".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}") == null){
	        /* 对照格式 */
	        if (account.match (".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" + ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" +
	        ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" + ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}") == null){
	            var accountNumeric = accountChar = "", i;
	            for (i=0;i<account.length;i++){
	                accountChar = account.substr (i,1);
	                if (!isNaN (accountChar) && (accountChar != " ")) accountNumeric = accountNumeric + accountChar;
	            }
	            account = "";
	            for (i=0;i<accountNumeric.length;i++){    /* 可将以下空格改为-,效果也不错 */
	                if (i == 4) account = account + " "; /* 帐号第四位数后加空格 */
	                if (i == 8) account = account + " "; /* 帐号第八位数后加空格 */
	                if (i == 12) account = account + " ";/* 帐号第十二位后数后加空格 */
	                account = account + accountNumeric.substr (i,1);
	            }
	        }
	    }
	    else
	    {
	        account = " " + account.substring (1,5) + " " + account.substring (6,10) + " " + account.substring (14,18) + "-" + account.substring(18,25);
	    }
	    if (account != BankNo.val()) BankNo.val(account);
	}
//-->
</script>


