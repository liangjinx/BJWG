<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="银行卡编辑" scope="request"/>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<jsp:include page="../meta.jsp"></jsp:include>
	 	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" href="resources/css/pc/base.css"/>
		<link rel="stylesheet" href="resources/css/pc/main.css"/>
		<link rel="stylesheet" href="resources/css/pc/pangzi_overview.css" />
        <style>
			.l_payword_p{ width:150px; text-align:right; float:left; margin-right:10px; line-height: 35px; font-size:16px; color:#333;}
			.z_inputbox{ margin-bottom: 15px;}
			.l_select{ height:35px; line-height:30px; background:none; outline:0px; border:1px solid #ccc; width:142px; margin-right:10px;font-size:16px; color:#333;font-family: "Microsoft YaHei" ! important;}
			.l_but{ width:150px; height:40px; line-height:40px; text-align:center; outline:0px; border:0px; background:#ff6600; color:#fff;font-family: "Microsoft YaHei" ! important;font-size:16px; border-radius:3px; margin-left:160px; margin-top:40px; cursor:pointer; }
			.l_check_p { margin-left:160px; margin-top:5px;float:left;}
			.l_check_p a{ font-size:16px;float:left; width:150px; line-height:1; margin-left:5px;}
			.l_check_p input{ float:left; margin-top:3px;}
			.z_letter_spacing { letter-spacing: 3px;}
        </style>
	</head>
	<body class="body_bg">
		<!--banner_box -->
		<jsp:include page="../header.jsp"></jsp:include>
		<!--banner_box -->
		<!--导航栏-->
		<jsp:include page="../nav.jsp">
			<jsp:param value="5" name="nav"/>
		</jsp:include>
		<!-- 导航栏-->	
		
		
		<!--中间部分 -->
		<div class="center mypig_center">
			<!--mypig_left_nav -->
			<jsp:include page="../user/nav.jsp">
				<jsp:param value="1" name="nav"/>
			</jsp:include>
			<!--mypig_left_nav -->
			<div class="right_main">
			    <div class="mypig_body">
			    	
			    	<!-- 添加银行卡 -->
			    	<div class="z_fir">
			    		<div class="z_fir_title f_l clearfix">
			    			<div class="z_green_point f_l"></div>
			    			<div class="z_fir_title_word f_l">添加银行卡</div>
			    			<div class="z_green_point f_l"></div>
			    		</div>
			    		
			    		<form action="" method="post" id="form">
				    		<div class="z_payword_box f_l">
				    			<h4 class="z_payword_h4">请填写真实信息，保障您的账户安全。(提示:只能绑定首次绑定的个人信息)</h4>
				    			<div class="z_payword_content">
	                            
			    				  	<div class="z_inputbox">
				    					<p class="l_payword_p">持卡人姓名:</p>
				    					<input type="text" class="z_payword z_letter_spacing" name="accountName" maxlength="64" value="${bankPersonInfo.name }" ${bankPersonInfo!=null? 'readonly':''}/>			    					
				    				</div>
	                                
	                                <div class="clear"></div>
				    				<div class="z_inputbox">
				    					<p class="l_payword_p">身份证号:</p> 
				    					<input type="text" class="z_payword z_letter_spacing" maxlength="18" ${bankPersonInfo!=null?'readonly':''} name="idCard" value="${bankPersonInfo.idCard }" onkeyup="this.value=this.value.replace(/[^a-z0-9]+$/g,'');" />
				    				</div>
	                                
	                                <div class="clear"></div>
			    				  	<div class="z_inputbox">
				    					<p class="l_payword_p">银行卡号:</p> 
				    					<input type="tel" class="z_payword z_letter_spacing" maxlength="19" name="cardNo" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
				    				</div>
				    				
				    				<div class="clear"></div>
			    				  	<div class="z_inputbox">
				    					<p class="l_payword_p">卡类型:</p> 
				    					<select name="bankCode" id="bankCode" class="l_select" style="width: 300px;" onchange="bankName(this)">
						                	<option value="">请选择</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="1">中国建设银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="2">交通银行</option>
                         			       	<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="3">上海银行</option>
                    			            <option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="4">中国邮政储蓄</option>
                   			            	<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="5">北京银行</option>
                      			          	<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="6">中国银行</option>
                  			              	<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="7">中国工商银行</option>
                        			        <option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="8">广东发展银行</option>
                   			             	<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="9">宁波银行</option>
                          			      	<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="10">民生银行</option>
                         			       	<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="11">浦东发展银行</option>
                         			       	<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="13">光大银行</option>
                         			       	<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="14">深圳平安银行</option>
                     			           	<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="15">华夏银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="16">招商银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="17">中信银行</option>
                    			            <option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="18">兴业银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="19">农业银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="20">南京银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="21">恒丰银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="22">珠海华润银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="23">北京农商银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="24">天津银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="24">上海农商银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="25">上海农商银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="26">杭州银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="27">江苏银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="28">深圳农商银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="29">温州银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="30">青岛银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="31">成都银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="32">哈尔滨银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="33">重庆农商银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="34">花旗中国银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="35">渣打银行中国</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="36">美国运通银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="37">东亚银行中国</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="38">徽商银行</option>
                               				<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="39">齐鲁银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="40">河北银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="41">大连银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="42">莱商银行</option>
                                			<option <c:if test="${bankCard.bankCode}">selected="selected"</c:if> value="0">其它</option>
						                </select>
				    				</div>
	                                
	                                <div class="clear"></div>
			    				  	<div class="z_inputbox">
				    					<p class="l_payword_p">开户地:</p>
				    					<select class="l_select" name="province" id="province" onChange="cityName();">
						                    <c:forEach items="${provinceList}" var="p">
						                        <option value=${p.areaId}>${p.name}</option>
						                    </c:forEach>
						                </select>
						                <select name="city" id="city" class="l_select"></select>
			    				  	</div>
	                                <div class="clear"></div>
				    				<input type="button" class="l_but" id="btnSub" value="同意协议并确定"/>
		    					  	<p class="l_check_p">
		    					  		<input type="checkbox" checked/>
		    					  		<a>同意《用户协议》</a>
		    					  		<!--<div style="float:left; width:120px; height:50px; line-height:50px; font-size:18px; color:#fff; text-align:center; background-color:#3dbd6d;" onclick="zShowPayBox();">设置支付密码</div>
		    					  	--></p>
				    				<div class="clear"></div>
			    			  </div>
				    		</div>
				    		<input type="hidden" name="bank" id="bank" value="">
	        				<input type="hidden" name="cardType" id="cardType" value="1">
			    		</form>
			    	</div><!-- 添加银行卡 -->
			    	
			    </div>
			</div>
			<div class="clear"></div>
		</div><!-- end mypig_center -->
		<!-- 中间部分-->
		
		<!-- star 设置支付密码 -->
		<div class="z_payword_mark">
			<div class="z_payword_fir">
				<div class="z_pw_titlebox">
					<div class="z_friend_shares_l f_left">请设置支付密码：</div>
					<div class="z_friend_shares_r f_right" onclick="zHidePayBox();"></div>
				</div>
				<div class="z_pw_contentbox">
					<div class="z_inputbox">
    					<label class="z_payword_label">支付密码:</label>
    					<input type="password" name="newpwd" class="z_payword" maxlength="6" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
    					<div class="z_hint z_pw_tips">请输入6位数字支付密码</div>
    				</div>
    				<div class="z_inputbox">
    					<label class="z_payword_label">确认密码:</label>
    					<input type="password" name="newpwd2" class="z_payword" maxlength="6" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
    				</div>
				</div>
				<div class="z_pw_btns">
					<input type="button" class="z_pw_cancel" value="取消" onclick="zHidePayBox();" />
					<input type="button" class="z_pw_ensure" value="确定" />
				</div>
			</div>
		</div>
		<!-- end 设置支付密码 -->
		
		
		<!--底部 -->
		<jsp:include page="../footer.jsp"></jsp:include>
		<!--底部 -->
	</body>
</html>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>

<script>

function zShowPayBox(){
	$('.z_payword_mark').show();
}
function zHidePayBox(){
	$('.z_payword_mark').hide();
}


function cityName(){
        var areaId = $("#province").val();
        $.ajax({  
            type: "POST",  
            url: '<%=basePath%>pc/pv/address/jsonCityV2',
            data: "areaId="+areaId,
            success: function(data){
            var json = eval("("+data+")"); 
            var option = "";
            $.each(json.des, function (i, item) {  
                   //循环获取数据      
                   var id = item.areaId; 
                   var name = item.name;  
                   option += "<option value='"+id+"'>"+name+"</option>";
               });  
                $("#city").html(option); 
                var cityNa = $("#city").val();
                if(null == cityNa ){
                    $("#city_txt").html("<option value='1' selected='selected'>选择市</option>");
                    $("#city").attr("disabled",true);
                }else{
                    $("#city").attr("disabled",false);
                }
            }  
    });  
}
function bankName(obj){
	$("[name=bank]").val($(obj).find("option:selected").text());
}
$(function(){
	$('#btnSub').click(function(){
		var self = $(this);
	
		var cardNo = $.trim($("[name=cardNo]").val());
		var bank = $.trim($("[name=bank]").val());
		var accountName = $.trim($("[name=accountName]").val());
		var idCard = $.trim($("[name=idCard]").val());
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
		if(bank == '' || bank < 0 || bank == '请选择'){
			alert("请选择卡类型");
			return ;
		}
		var province = $("[name=province]").find("option:selected");
		if(province.length <=0 || province.val() == ''){
			alert("请选择省份");
			return;
		}
		var city = $("[name=city]").find("option:selected");
		if((city.length <=0 || city.val() == '') && $("#city").find("option").length > 0){
			alert("请选择城市");
			return;
		}
		
		self.attr('disabled','disabled');
		$('#form').attr('action',__base_path__+'pc/pv/wallet/bankCardSave').submit();
		
		/*$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: 'pc/pv/user/updateEmail',
		    cache: false,
		    data: {email:email},
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('修改成功')
		    		window.location.reload();
		    	} else {
		    		alert(data.data.text);
		    		self.removeAttr('disabled');
		    	}
		    },
		    error: function(){
		    	alert('error');
		    }
		});*/
	})
})
</script>
















