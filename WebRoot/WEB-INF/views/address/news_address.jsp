<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <title>新增收货地址</title>
        <link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
        <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/compilations_pz.css">
	</head>
	<body>
		<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
		<p class="z_h20"></p>
		<form method="post" action="<%=basePath %>wpv/uasaveNews">
			<input type="hidden" name="pageSource" id="pageSource" value="${pageSource}"> 
	        <div class="edit_content">
				<ul>
					<li>
						<input type="text" class="e_change_name" value="姓名" name="contactMan" />
					</li>
					<li>
						<input type="tel" class="e_change_phone" value="电话" name="contactPhone" maxlength="11" />
					</li>
					<li>
						<label class="e_customer_area">地区 </label>
						<div class="province_r">
                            <select id="province" class="province_select" name="province" onchange="cityName()">
                                <option value="1" selected="selected">选择省份</option>
                                <c:forEach items="${province}" var="pr" >
                    				<OPTION value="${pr.areaId}" >${pr.name}</OPTION>
                    			</c:forEach>
                            </select>
                            <div class="province_txt">选择省份</div>
                        </div>
                        <div class="city_r">
                            <select id="city" class="city_select">
                                <option value="1" selected="selected">选择市</option>
                            </select>
                            <div class="city_txt">选择市</div>
                        </div>
					</li>
					<li class="position_r">
						<input type="text" class="e_change_street" value="请输入详细地址" name="address" />
						<!--<span class="e_location">
							<img src="images/shopping_10.png" alt="定位到当前地址" />
						</span>-->
					</li>
				</ul>	
	        </div>
			<input type="submit" class="e_save_bton" value="保存"  />
        </form>
        <jsp:include page="../common/commonTip.jsp"></jsp:include>
	</body>
</html>
<script language="JavaScript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
<script language="JavaScript">
	$(function(){
		
		// 输入消除文字
		 var inputE1 = $('.e_change_name'),
		 	 inputE2 = $('.e_change_phone'),
		 	 inputE3 = $('.e_change_street'),
		 	 defVa1 = inputE1.val(),
		 	 defVa2 = inputE2.val(),
		 	 defVa3 = inputE3.val();
		 inputE1.bind({
		    focus: function() {
			    var _this = $(this);
			    if(_this.val() == defVa1) {
			    	_this.val('');
			    }
			 },
			 blur: function() {
			 	var _this = $(this);
			    if (_this.val() == '') {
			    	_this.val(defVa1);
			    }
			 }
		 }); 
		 inputE2.bind({
		    focus: function() {
			    var _this = $(this);
			    if(_this.val() == defVa2) {
			    	_this.val('');
			    }
			 },
			 blur: function() {
			 	var _this = $(this);
			    if (_this.val() == '') {
			    	_this.val(defVa2);
			    }
			 }
		 }); 
		 inputE3.bind({
		    focus: function() {
			    var _this = $(this);
			    if(_this.val() == defVa3) {
			    	_this.val('');
			    }
			 },
			 blur: function() {
			 	var _this = $(this);
			    if (_this.val() == '') {
			    	_this.val(defVa3);
			    }
			 }
		 });
		 
		 // 下拉列表赋值 
		$('.province_r .province_select').on('change',function(){
		 	$('.province_txt').text($(".province_select option:selected").text());
		});
		
		$('.city_r #city').on('change',function(){
			$('.city_txt').text($(".city_select option:selected").text());
		});
		
		// 提交
		$(".e_save_bton").on("click",function(){
			var change_name = $('.e_change_name').val();
			var change_phone = $('.e_change_phone').val();
			var province = $('.province_select option:selected').text();
			var city = $('.city_select option:selected').text();
			var change_street = $('.e_change_street').val();
			if (!$.trim(change_name)) {
				alert('请填写姓名');
				return false;
			}
			if (!$.trim(change_phone)) {
				alert('电话不能为空');
				return false;
			}
			var myreg = /^((1)+\d{10})$/;
			if(!myreg.test($.trim(change_phone)))
			{
				alert('请输入有效的电话号码！');
				return false;
			}
			if (!$.trim(province)) {
				alert('请选择省份');
				return false;
			}
			var city = $("#city").find("option:selected");
			if((city.length <=0 || city.val() == '') && $("#city").find("option").length > 0){
				alert("请选择城市");
				return;
			}
			if (!$.trim(change_street)) {
				alert('请填写详细地址');
				return false;
			}
		});
	});
	//获取城市	
function cityName(){
	var areaId = $("#province").val();
	$.ajax({  
	   		type: "POST",  
	        url: '/wpv/uajsonCityV2',  
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
					//$("#city_txt").html("<option value='1' selected='selected'>选择市</option>");
					$(".city_txt").html("");
					$("#city").attr("disabled",true);
				}else{
					$(".city_txt").html("<option value='1' selected='selected'>选择市</option>")
					$("#city").attr("disabled",false);
				}
			}  
	});  
}
</script>