<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" href="<%=basePath %>resources/css/skins/all.css" >
	<script language="javascript" src="<%=basePath %>resources/js/icheck.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/order.js"></script>
	<style type="text/css">
		/*refund*/
       	.mark2 { position: fixed; left: 0; right: 0; top: 0; bottom: 0; display: none; width: 100%; height: 100%; background: rgba(0,0,0,.45); z-index: 10002;}
       	.z_refundbox, .refund_title { box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box;}
       	.refund_common:nth-child(1), .refund_common:nth-child(7), .refund_common2 { height: 55px; line-height: 55px;}
       	.refund_cancel, .refund_affirm, .refund_cancel2, .refund_affirm2 { width: 75px; height: 35px; font-size: 1.6rem; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px;}
       	.z_refundbox, .z_othersbox { position: fixed; top: 50%; left: 50%; display: none; width: 90%; height: auto; border: 1px solid #efefef; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; transform: translate(-50%,-50%); -webkit-transform: translate(-50%,-50%); -moz-transform: translate(-50%,-50%); background-color: #fff; z-index: 10003;}
       	.refund_common { width: 100%; height: 45px; line-height: 45px; border-bottom: 1px solid #efefef;}
       	.refund_common2 { width: 100%; margin-top: 11px; text-align: center;}
       	.refund_common:nth-child(7) { margin-top: 1px; text-align: center; border-bottom: none;}
       	.refund_title, .refund_others { padding-left: 15px; font-size: 1.6rem; color: #322c2c; text-align: left;}
       	.refund_reason { float: left; width: 65%; padding-left: 15px; font-size: 1.6rem; color: #858386;}
       	.refund_check { float: right; width: 20%; text-align: center;}
       	.refund_cancel, .refund_cancel2 { margin-right: 15px; color: #322c2c; border: 1px solid #dedede; background-color: #fff; }
       	.refund_affirm, .refund_affirm2 { margin-left: 15px; color: #fff; border: none; background-color: #ffb400; }
       	.others_reason { width: 100%;}
       	.reason_content { display: block; width: 85%; min-height: 70px; margin: 20px auto 0; padding: 10px 0 0 5px; border: 1px solid #dedede;}
       	/*checkbox*/
		.icheckbox_square-yellow, .iradio_square-yellow { top: 15px; margin: -4px 0 0; vertical-align: middle;}
		.iradio_square-yellow.checked { top: 15px;}
		
		
		/*refund*/
		.refund_cancel3, .refund_affirm3 { width: 75px; height: 35px; font-size: 1.6rem; border: 1px solid #dedede; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px;}
       	.mark3 { position: fixed; left: 0; right: 0; top: 0; bottom: 0; display: none; width: 100%; height: 100%; background: rgba(0,0,0,.45); z-index: 10002;}
       	.z_othersbox3 { position: fixed; top: 50%; left: 50%; display: none; width: 90%; height: auto; border: 1px solid #efefef; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; transform: translate(-50%,-50%); -webkit-transform: translate(-50%,-50%); -moz-transform: translate(-50%,-50%); background-color: #fff; z-index: 10003;}
       	.refund_common3 { width: 100%; height: 55px; line-height: 55px; margin-top: 11px; text-align: center;}
       	.others_reason3 { width: 100%;}
       	.reason_content3 { display: block; width: 85%; min-height: 70px; margin: 20px auto 0; padding: 10px 0 0 5px; border: 1px solid #dedede;}
       	.refund_cancel3 { margin-right: 15px; color: #322c2c; background-color: #fff; }
       	.refund_affirm3 { margin-left: 15px; color: #fff; background-color: #ffb400; }
	</style>

  </head>
  
  <body>
  		<input type="hidden" id="refundReason" name="refundReason" value="">
  		<!-- refund -->
        <div class="z_refundbox">
        	<div class="refund_common">
        		<p class="refund_title">请选择申请退款的理由</p>
        	</div>
        	<div class="refund_common">
        		<div class="refund_reason">店家一直未服务</div>
        		<div class="refund_check">
        			<input type="radio" checked="checked" class="refund_one" name="refundReasonRadio" value="店家一直未服务">
        		</div>
        	</div>
        	<div class="refund_common">
        		<div class="refund_reason">买卖双方已达成退款协议</div>
        		<div class="refund_check">
        			<input type="radio" class="refund_two" name="refundReasonRadio" value="买卖双方已达成退款协议">
        		</div>
        	</div>
        	<div class="refund_common">
        		<div class="refund_reason">不想买了</div>
        		<div class="refund_check">
        			<input type="radio" class="refund_three" name="refundReasonRadio" value="不想买了">
        		</div>
        	</div>
        	<div class="refund_common">
        		<div class="refund_reason">拍错了</div>
        		<div class="refund_check">
        			<input type="radio" class="refund_four" name="refundReasonRadio" value="拍错了">
        		</div>
        	</div>
        	<div class="refund_common">
        		<p class="refund_others">其他原因</p>
        	</div>
        	<div class="refund_common">
        		<input type="button" class="refund_cancel" value="取消" />
        		<input type="button" class="refund_affirm" value="确认" onclick="refundSubmit();"/>
        	</div>
        </div>
        <!-- others reason -->
        <div class="z_othersbox">
        	<div class="others_reason">
        		<textarea class="reason_content" placeholder="请输入您申请退款的理由。" id="reason_content" name="reason_content" onchange="$('#refundReason').val(this.value);"></textarea>
        	</div>
        	<div class="refund_common2">
        		<input type="button" class="refund_cancel2" value="取消" />
        		<input type="button" class="refund_affirm2" value="确认" onclick="refundSubmit2();"/>
        	</div>
        </div>
        <div class="mark2"></div>
        
        
        
        <!-- refund -->
	    <div class="z_othersbox3">
        	<div class="others_reason3">
        		<input type="hidden" id="agreeType" name="agreeType" value="">
        		<textarea class="reason_content3" placeholder="请输入您不同意退款的理由。" id="noagreeRefundReason" name="noagreeRefundReason"></textarea>
        	</div>
        	<div class="refund_common3">
        		<input type="button" class="refund_cancel3" value="取消" />
        		<input type="button" class="refund_affirm3" value="确认" onclick="refundAuditSubmit(0);"/>
        	</div>
        </div>
        <div class="mark3"></div><!-- end refund -->
        
  </body>
  
  <script type="text/javascript">
	//点击退款按钮显示申请理由
	  $(function(){
	  	$('.refund_others').on('click',function(){
	  		$('.z_refundbox').hide();
	  		$('.z_othersbox').show();
	  	});
	  	$('.refund_cancel, .refund_cancel2').on('click',function(){
	  		$('.z_refundbox, .z_othersbox, .mark2').hide();
	  		//清空值
	  		$("#refundReason").val("");
	  	});
	  	/*$('.mark2').on('click',function(){
	  		$('.z_refundbox, .z_othersbox, .mark2').hide();
	  	});*/
	  });
	
	  //显示div
	  function chooseRefundReason(){
	  	 $('.z_refundbox, .mark2').show();
	  }
	  
	//点击退款按钮显示不同意理由
	$(function(){
		$('.refund_cancel3').on('click',function(){
			$('.z_othersbox3, .mark3').hide();
			//清空
			$("#noagreeRefundReason").val('');
		});
		/*$('.mark3').on('click',function(){
			$('.z_othersbox, .mark3').hide();
		});*/
	});
	
	//点击不同意退款弹出反对理由填写框
	function fillNoAgreeReason(){
		$('.z_othersbox3, .mark3').show();
	}
	  
	  //选择申请退款理由
	  $(".refund_one, .refund_two, .refund_three, .refund_four").iCheck({
	  	labelHover : false,
	  	cursor : true,
	  	checkboxClass : 'icheckbox_square-yellow',
	  	radioClass : 'iradio_square-yellow',
	  	increaseArea : '20%'
	  });
  </script>
</html>
