

//平台介入
function askForHelp(id,shopId,url){
	$("#a_"+id)[0].click();
	$.ajax({
		type: "POST",
		data:{"orderId":id,"shopId":shopId},
		url:url,
		success:function(data){
			if(data == '1'){
				$("#div_status_"+id).html("平台介入中");
				$("#askForHelpBtn"+id).hide();
			}
		}
	});
}

//退款申请
function refund(id,url){
	$("#orderId").val(id);
	//是否选择了退款原因
	var refundReason = $("#refundReason").val();
	$("#personalForm").attr("action",url);
	//if($("#refundReason").val() == ''){
		//alert("请选择退款原因");
		chooseRefundReason();
		return false;
	//}
	//$("#personalForm").submit();
}
//退款申请
function refundSubmit(){
	$("#refundReason").val($(":radio:checked").val());
	if($("#refundReason").val() == ''){
		alert("请选择退款原因");
		chooseRefundReason();
		return false;
	}
	$("#personalForm").submit();
}
//退款申请
function refundSubmit2(){
	$("#refundReason").val($("#reason_content").val());
	if($("#refundReason").val() == ''){
		alert("请填写退款原因");
		return false;
	}
	$("#personalForm").submit();
}

//商家选择是否同意退款
function refundAudit(type,orderId,shopId,url){
	$("#shopId").val(shopId);
	$("#orderId").val(orderId);
	$("#agreeType").val(type);
	$("#personalForm").attr("action",url);
	if(type == 0){
		fillNoAgreeReason();
		return false;
	}
	$("#personalForm").submit();
}
//商家选择是否同意退款
function refundAuditSubmit(type){
	$("#agreeType").val(type);
	if(type == 0 && $("#noagreeRefundReason").val() == ''){
		alert("请填写不同意退款的原因");
		return false;
	}
	$("#personalForm").submit();
}
