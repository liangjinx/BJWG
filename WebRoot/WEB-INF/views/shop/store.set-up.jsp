<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>
<%@taglib prefix= "form" uri= "http://www.springframework.org/tags/form" %>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>店铺设置</title>

<style type="text/css">
	/*input、textarea placeholder color*/
	input::-webkit-input-placeholder{ color: #858388;}
	input::-moz-input-placeholder{ color: #858388;}
	input::-ms-input-placeholder{ color: #858388;}
	textarea::-webkit-input-placeholder{ color: #858388;}
	textarea::-moz-input-placeholder{ color: #858388;}
	textarea::-ms-input-placeholder{ color: #858388;}
	/*touxiang*/
	.shop_banner{ width: 100%; border-bottom: 1px solid #dedede; background-color: white; overflow: hidden;}
	.user_box{ position: relative; float: left; width: 102px; height: 102px; margin: 20px 15px; background-color: #ffb400;}
	.user_box .p1{ position: absolute; bottom: 0; right: 0; }
	.shop_banner .p1 img{ width: 13px; padding: 5px; vertical-align: middle;}
	.shop_banner .p2{ float: left; margin: 0 auto; line-height: 130px; font-size: 1.4rem; color: #858585;}
	/*set up store*/
	.set_content { margin-bottom: 60px;}
	.set_content ul{ width: 100%; margin-bottom: 60px; background-color: white;}
	.set_content ul li{ position: relative; line-height: 43px; padding: 0 5%; border-bottom: 1px solid #f3f3f3; overflow: hidden;}
	.set_content li .span_font{ display: inline-block; width: 75px; padding-left: 3px; color: #322c2c; font-size: 1.6rem;}
	.set_content li input, .set_content li textarea { color: #858386;}
	.set_content li input{ width: 65%; padding: 3px 0 3px 10px; font-size: 1.6rem; border: none;}
	.star_time, .end_time{ width: 75px !important; padding-left: 0 !important; border: 1px solid #d5d4d6 !important;}
	.star_time{ margin: 0 5px;}
	.end-_ime{ margin-left: 5px;}
	/*right icon*/
	.set_arrows, .set_arrows1 { position: absolute; top: 15px; right: 15px; text-align: center;}
	.set_arrows{ width: 8px; height: 13px; background: url(/resources/images/personalcenter_13.png) center center no-repeat; background-size: 100% 100%; }
	.set_arrows1{ width: 14px; height: 8px; background: url(/resources/images/personalcenter_131.png) center center no-repeat; background-size: 100% 100%; }
	/*submit button*/
	.submitbox{ position: fixed; bottom: 0; left: 0; width: 100%; margin: 0 auto; overflow: hidden; z-index: -1;}
	.set_save{ display: block; width: 100%; padding: 15px; font-size: 1.6rem; color: #ffb402; background-color: #fff; border:none;}
	/*sundry*/
	.posi_rel{ position: relative;}
	.ml9{ margin-left: 9px;}
	/*drop-down options*/
	.type_sort03{ display: block; width: 94%; padding: 0 3% 1%; margin: 0 auto; color: #868586; background-color: #f4f4f4;}
	.type_sort03 span{ display: inline-block; padding: 4px 8px; margin: 14px 5px 5px; font-size: 1.4rem; color: #fff; border: none; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; -o-border-radius: 3px; background-color: #cecfd3;}
	.type_sort03 .week_active{ background-color: #ffb400;}
	.inputfile{ position: absolute; top: 0; left: 0; width: 102px; height: 102px; opacity: 0;}
	.shop_type_list,.server_scope{ display: none; background-color: #f4f4f4;}
	.shop_type_list dd, .server_scope dd{ float: left; width: 25%; height: 40px; line-height: 40px; font-size: 1.5rem; color: #858386; text-align: center; cursor: pointer;}
	.set_content li:last-child { border-bottom: none;}
	.shop_address{display:none;padding:0 5%;}
	.shop_address p{line-height:30px;color: #858386;}
	.shop_des { width: 100%; height: 70px; padding-top: 5px; padding-left: 10px; margin: 0 auto; font-size: 1.6rem;}
	.province_box, .address { width: 100%;}
	.province_box { border-bottom: 1px solid #efefef;}
	.province_r { margin-left: 18px;}
	.address input { width: 100%; margin-left: 0; color: #858386;}
	.font_hidden { visibility: inherit;}
	.city_r { width: 32%;}
	.yellow { color: #ffb402 !important;}
	.shop_type_list dd, .server_scope dd, .type_sort03 span, .shop_des { -webkit-tap-highlight-color: transparent;}
</style>
</head>

<body>
	<div class="head">
        <a href="<%=basePath%>index/manage" class="head_back">
        	<img src="<%=basePath %>resources/images/back.png" alt="返回">
        </a>
        <p>店铺设置</p>
    </div>
    <form id="shopForm" action="" method="post" enctype="multipart/form-data">
        <input type="hidden" name="categoryId" id="categoryId" value="${shop.categoryId }">
        <input type="hidden" name="range" id="range" value="${shop.range }">
        <input type="hidden" name="shopId" id="shopId" value="${shop.shopId }">
        <div class="set_content">
            <ul>
                <li>
                    <span class="span_font">店铺名称*</span>
                    <input type="text" maxlength="28" type="text" class="" id="shop_name" name="name" value="${shop.name }" placeholder="必填">
                </li>
                <li class="posi_rel store_type">
                    <span class="span_font">店铺类型*</span>
                    <a href="javascript:void(0);">
                    	<input type="text" name="shop_type" id="" class="shop_type" readonly placeholder="选择店铺类型"
                    		<c:forEach items="${categorys}" var="cate" >
	                			<c:if test="${cate.categoryId == shop.categoryId}">
	                				value="${cate.name}"
		                		</c:if>
		                    </c:forEach>
                    	>
                    	<div class="set_arrows" id="weekly2"></div>
                    </a>
                </li>
                <div class="shop_type_list">
                    <dl>
                    	<c:forEach items="${categorys}" var="cate" >
	                		<c:if test="${cate.categoryId <= 13}">
	                			<dd vid="${cate.categoryId }" target="categoryId">${cate.name}</dd>
		                   		<!--<option value="${cate.categoryId}" <c:if test="${shop.categoryId == cate.categoryId }" >selected="selected"</c:if> >${cate.name}</option>
	                    	--></c:if>
	                    </c:forEach>
                    </dl>
                </div>
                <li class="posi_rel shop_address_box">
                    <span class="span_font">店铺地址*</span>
                    <a href="javascript:void(0);">
                    	<input type="text" class="" id="addressCity" placeholder="选择店铺地址" readonly>
                    	<input type="hidden" name="province" id="province" />
                       	<input type="hidden" name="city" id="city" />
                       	<input type="hidden" id="address" name="address" />
                       	<div class="set_arrows" id="weekly3"></div>
                    </a>
                </li>
                <div class="shop_address">
                	<div class="province_box">
                        <label class="province_l">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区:</label>
                        <div class="province_r">
                        	<c:set var="p_text" value=""></c:set>
                            <select name="province" id="select_province"  onchange="cityName(${shop.city});getarea();" class="" style="font-size: 1.3rem;">
                                <c:forEach items="${province}" var="pr" >
		                    		<OPTION value="${pr.areaId}" <c:if test="${shop.province == pr.areaId }">selected="selected"</c:if> >${pr.name }</OPTION>
		                    		<c:if test="${shop.province == pr.areaId }">
		                    			<c:set var="p_text" value="${pr.name }"></c:set>
		                    		</c:if>
		                    	</c:forEach>
                            </select>
                            <div id="province_txt">${p_text }</div>
                        </div>
                        <div class="city_r">
                            <select name="city" id="select_city" onchange="getarea();">
                            </select>
                            <div id="city_txt">选择市</div>
                        </div>
                    </div>
                    <div class="address">
                        <!-- <label class="font_hidden">街&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;道:</label>  -->
                        <input type="text" name="shop_addr_details" class="shop_addr_details" value="${shop.address }" onchange="getarea();" placeholder="请输入具体地址">
                    </div>
                	
                </div>
                <li>
                    <span class="span_font">服务电话*</span>
                    <a href="javascript:void(0);">
                    	<input type="tel" class="" maxlength="13" type="tel" id="shop_tel" name="phone" value="${shop.phone }" placeholder="请输入手机号或座机号">
                    </a>
                </li>
                <li class="posi_rel store_scope">
                    <span class="span_font">服务范围*</span>
                    <a href="javascript:void(0);">
                    	<input type="text" name="" id="" class="server_scope_input" readonly placeholder="选择服务范围"
                    			<c:choose>
                    				<c:when test="${shop.range == 1}">
                    					value="500M"
                    				</c:when>
                    				<c:when test="${shop.range == 2}">
                    					value="1KM"
                    				</c:when>
                    				<c:when test="${shop.range == 3}">
                    					value="3KM"
                    				</c:when>
                    				<c:when test="${shop.range == 4}">
                    					value="5KM"
                    				</c:when>
                    				<c:when test="${shop.range == 5}">
                    					value="全城"
                    				</c:when>
                    				<c:otherwise>
                    					value="不限"
                    				</c:otherwise>
                    			</c:choose>
                    			>
                    	<div class="set_arrows" id="weekly4"></div>
                    </a>
                </li>
                <div class="server_scope">
                    <dl>
                        <dd vid="1" target="range">500M</dd>
                        <dd vid="2" target="range">1KM</dd>
                        <dd vid="3" target="range">3KM</dd>
                        <dd vid="4" target="range">5KM</dd>
                        <dd vid="5" target="range">全城</dd>
                        <dd vid="6" target="range">不限</dd>
                    </dl>
                </div>
                <li class="posi_rel store_time">
                    <span class="span_font">营业时间*</span>
                    <a href="javascript:void(0);">
                    	<input type="time" name="sndtime" value="${shop.sndtime}" class="star_time ml7" id="">
                    </a>
                    <em>-</em>
                    <a href="javascript:void(0);">
                    	<input type="time" class="end_time" value="${shop.endtime}" name="endtime">
                    	<div class="set_arrows1" id="weekly"></div>
                    </a>
                </li>
                <div class="type_sort03">
                	<c:if test="${shop.w1 == 1}">
                		<span class="week_active" id="w1" >周一</span>
	            		<input type="hidden" name="w1" value="1" />
	            	</c:if>
	            	<c:if test="${shop.w1 == 0}"> 
	            		<span class="week" id="w1" >周一</span> 
	            	</c:if>
	            	<c:if test="${shop.w2 == 1}"> 
	            		<span class="week_active" id="w2" >周二</span>
	            		<input type="hidden" name="w2" value="1" />
	            	</c:if>
	            	<c:if test="${shop.w2 == 0}"> 
	            		<span class="week" id="w2" >周二</span>
	            	</c:if>
	            	<c:if test="${shop.w3 == 1}"> 
	            		<span class="week_active" id="w3" >周三</span>
	            		<input type="hidden" name="w3" value="1" />
	            	</c:if>
	            	<c:if test="${shop.w3 == 0}"> 
	            		<span class="week" id="w3" >周三</span>
	            	</c:if>
	            	<c:if test="${shop.w4 == 1}"> 
	            		<span class="week_active" id="w4" >周四</span>
	            		<input type="hidden" name="w4" value="1" />
	            	</c:if>
	            	<c:if test="${shop.w4 == 0}"> 
	            		<span class="week" id="w4" >周四</span>
	            	</c:if>
	            	<c:if test="${shop.w5 == 1}"> 
	            		<span class="week_active" id="w5" >周五</span>
	            		<input type="hidden" name="w5" value="1" />
	            	</c:if>
	            	<c:if test="${shop.w5 == 0}"> 
	            		<span class="week" id="w5" >周五</span>
	            	</c:if>
	            	<c:if test="${shop.w6 == 1}"> 
	            		<span class="week_active" id="w6" >周六</span>
	            		<input type="hidden" name="w6" value="1" />
	            	</c:if>
	            	<c:if test="${shop.w6 == 0}"> 
	            		<span class="week" id="w6" >周六</span>
	            	</c:if>
	            	<c:if test="${shop.w7 == 1}"> 
	            		<span class="week_active" id="w7" >周日</span>
	            		<input type="hidden" name="w7" value="1" />
	            	</c:if>
	            	<c:if test="${shop.w7 == 0}"> 
	            		<span class="week" id="w7" >周日</span>
	            	</c:if>
	            	<c:if test="${shop.w1 == 1 && shop.w2 == 1 && shop.w3 == 1 && shop.w4 == 1 && shop.w5 == 1 && shop.w6 == 1 && shop.w7 == 1  }">
	            		<span id="seelct_all" class="week_active"  >全选</span>
	            	</c:if>
	            	<c:if test="${shop.w1 == 0 || shop.w2 == 0 || shop.w3 == 0 || shop.w4 == 0 || shop.w5 == 0 || shop.w6 == 0 || shop.w7 == 0  }">
	            		<span id="seelct_all"  >全选</span>
	            	</c:if>
	            	<div id="zhou"><input type="hidden"></div>
                </div>
                <li>
                    <span class="span_font">店铺描述</span>
                    <a href="javascript:void(0);">
                    	<textarea class="shop_des" placeholder="服务第一，品质保障" name="summary">${shop.summary}</textarea>
                    </a>
                </li>
            </ul>
            <div class="submitbox">
            	<a href="javascript:;">
            		<input type="button" value="完成" class="set_save" id="setting_submit">
            	</a>
            </div>
        </div>
</form>

<script type="text/javascript">


//赋值地址
function getarea(){
	var provinceVal = $('#select_province option:selected').text();
	var provinceId = $('#select_province option:selected') .val();
	$("#province").val(provinceId);
	$("#province_txt").html(provinceVal);
	var cityVal = $('#select_city option:selected').text();
	var cityId = $('#select_city option:selected') .val();
	$("#city").val(cityId);
	$("#city_txt").html(cityVal);
	var addr = $(".shop_addr_details").val();
	$("#address").val(addr);
	var addressCity = provinceVal+cityVal+addr;
	$("#addressCity").val(addressCity);
	//$(".shop_address").slideToggle();
};

function cityName(city){
	var code = $("#select_province").val();
	$.ajax({  
	   		type: "POST",  
	        url: '<%=basePath %>index/jsonCity',  
	        data: "code="+code,
	        success: function(data){
	        var json = eval("("+data+")"); 
 			var option = "";
	        $.each(json.des, function (i, item) {
                   //循环获取数据      
                   var id = item.areaId; 
                   var name = item.name;  
                   if(city !=null && city != "" && city == id){
		               option += "<option value='"+id+"' selected='selected'>"+name+"</option>";
                   }else if(name != '县' && name !='市' && name != '省直辖县级行政单位'){
                   		if(name == '市辖区'){
                   			name = item.parentName;
                   		}
	                   option += "<option value='"+id+"'>"+name+"</option>";
                   }
               });  
				$("#select_city").html(option); 
	              getarea();
	              //$("#city_txt").html(name);
				var cityNa = $("#select_city").val();
				if(null == cityNa ){
					$("#select_city").attr("disabled",true).css({"background-color":"white"});
				}else{
					$("#select_city").attr("disabled",false);
				}
			}  
	});  
}

//store-type
$(function(city){

	var province = ${shop.province};
	var city = ${shop.city};
	if(province != null && province != ""){
		cityName(city);
	}
	
	// add by oyja
	 function slideOption(obj, show_obj) {
		$(obj).click(function() {
			$(show_obj).slideToggle();
		});
		return false;
	}
	
	function get_val(obj1, obj2) {
		$(obj1).click(function() {
			var content = $(this).html();
			var t = $(this).attr("target");
			$("#"+t).val($(this).attr("vid"));
			$(obj2).val(content);
			$(this).closest('div').slideUp();
		});
		return false;
	}
	//下拉
	$("#weekly4").click(function(){
		$(".server_scope").slideToggle(600);
		var weekly4 = $("#weekly4");
        if($(weekly4).attr("class") == "set_arrows"){
        	$(weekly4).attr("class","set_arrows1");
        }else{
        	$(weekly4).attr("class","set_arrows");
        }
	});
	$("#weekly3").click(function(){
		$(".shop_address_2").slideToggle(600);
		var weekly3 = $("#weekly3");
        if($(weekly3).attr("class") == "set_arrows"){
        	$(weekly3).attr("class","set_arrows1");
        }else{
        	$(weekly3).attr("class","set_arrows");
        }
	});
	$("#weekly2").click(function(){
		$(".shop_type_list").slideToggle(600);
		var weekly2 = $("#weekly2");
        if($(weekly2).attr("class") == "set_arrows"){
        	$(weekly2).attr("class","set_arrows1");
        }else{
        	$(weekly2).attr("class","set_arrows");
        }
	});
    $("#weekly").click(function() {
        $(".type_sort03").slideToggle(600);
        var weekly = $("#weekly");
        if($(weekly).attr("class") == "set_arrows"){
        	$(weekly).attr("class","set_arrows1");
        }else{
        	$(weekly).attr("class","set_arrows");
        }
       
    });
    // add by oyja
    $(".type_sort03 span.week").click(function() {
        if ($(this).hasClass("week_active")) {
            $(this).removeClass("week_active").addClass("week");
            $("#seelct_all").removeClass("week_active");
            //
            var id = $(this).attr('id');
            $(".type_sort03 input[name='"+id+"']").remove();
        } else {
            $(this).addClass("week_active").removeClass("week");
             var count = $(".week_active").length;
	        if(count == 7){
	       	 $("#seelct_all").addClass("week_active");
	        }
            //$("#seelct_all").addClass("week_active");
            //
            var name = $(this).attr('id');
            $("#zhou").append('<input type="hidden" id="'+name+'" name="'+name+'" value="1" />');
        }
        
        
    });
    //选中
    $(".type_sort03 span.week_active").click(function() {
        if ($(this).hasClass("week_active")) {
            $(this).removeClass("week_active").addClass("week");
            $("#seelct_all").removeClass("week_active");
            //
            var id = $(this).attr('id');
            $(".type_sort03 input[name='"+id+"']").remove();
            
        } else {
            $(this).addClass("week_active").removeClass("week");
            var count = $(".week_active").length;
	        if(count == 7){
	       	 $("#seelct_all").addClass("week_active");
	        }
            //$("#seelct_all").addClass("week_active");
            //
            var name = $(this).attr('id');
            $("#zhou").append('<input type="hidden" id="'+name+'" name="'+name+'" value="1" />');
        }
        
    });
    
    var ii = 1;
    $('#seelct_all').click(function() {
       var this_ = $('.type_sort03 .week');
       var this_2 = $('.type_sort03 .week_active');

        if (this_.hasClass('week_active')) {
            this_.removeClass("week_active");
//          	alert(3336666);
            $("#zhou input").remove();
            
            if( ii == 2 ){
            	$('.type_sort03 .week').addClass('week_active');
            	ii = Number(ii + 1) ;
            	return ;
            }
            if(ii == 3){
            	ii = Number(ii + 2) ;
            	return ;
            }
//            alert(ii);
            if(ii % 2 == 0 ){
            	ii = Number(ii + 1) ;
            	return ;
            }
             
            if(this_.hasClass('week')){
            	$('.type_sort03 .week').addClass('week_active');
            	$(".type_sort03 input").remove();
           		$("#zhou").append('<input type="hidden" id="w1" name="w1" value="1" />');
				$("#zhou").append('<input type="hidden" id="w2" name="w2" value="1" />').append('<input type="hidden" id="w3" name="w3" value="1" />').append('<input type="hidden" id="w4" name="w4" value="1" />')
            	.append('<input type="hidden" id="w5" name="w5" value="1" />').append('<input type="hidden" id="w6" name="w6" value="1" />').append('<input type="hidden" id="w7" name="w7" value="1" />');
            	ii = Number(ii + 1) ;
            }
             
        } else {
//              alert(3345);
            $('#seelct_all').attr('class',"week_active");
            
            $('.type_sort03 .week').addClass('week_active');
            $('.type_sort03 .week_active').addClass('week');
           
            if(this_.hasClass('week_active')){
//            	alert(333);
            	var id = $(this).attr('id');
            	$(".type_sort03 input").remove();
            	$("#zhou").append('<input type="hidden" id="w1" name="w1" value="1" />');
				$("#zhou").append('<input type="hidden" id="w2" name="w2" value="1" />').append('<input type="hidden" id="w3" name="w3" value="1" />').append('<input type="hidden" id="w4" name="w4" value="1" />')
	            	.append('<input type="hidden" id="w5" name="w5" value="1" />').append('<input type="hidden" id="w6" name="w6" value="1" />').append('<input type="hidden" id="w7" name="w7" value="1" />');
             	ii = Number(ii + 3) ;
            }else {
//            	alert(445);
            	this_2.removeClass("week_active");
            	$("#seelct_all").removeClass("week_active");
	        	$("#zhou input").remove();
	        	$(".type_sort03 input").remove();
	        	ii = Number(ii + 1) ;
            }
           
        }
    });
    
    
    slideOption('.shop_type', '.shop_type_list');
    slideOption('.server_scope_input', '.server_scope')
    slideOption('.shop_address_box', '.shop_address');
    get_val('.shop_type_list dd','.shop_type');
    get_val('.server_scope dd','.server_scope_input');
    
    $('#setting_submit').click(function(){
        var name=$('#shop_name').val();
        var tel= $('#shop_tel').val();
        var address = $("#address").val();
        if (!$.trim(name)) {
            alert("店铺名不能为空");
            $('#shop_name').focus();
            return false;
        }
        if (!$.trim(tel)) {
            alert("电话不能为空");
            $('#shop_tel').focus();
            return false;
        };
        if ($.trim(tel).length < 7) {
            alert("电话是7到13位数字");
            $('#shop_tel').focus();
            return false;
        };
        if (isNaN(tel)) {
			alert('你输入的含有其它字符,电话号码只能为数字');
			return false;
		};
		
        if (!$.trim(address)) {
            alert("地址不能为空");
            $('#address').focus();
            return false;
        };
        //接口
        var path = '<%=basePath%>shop/editSave';
 		$('#shopForm').attr("action", path).submit();
       /* $.ajax({
            type: "post",
            url: "",
            data: $('#shop_setting_form').serialize(), //form的序列化
            success: function(data) {
                // var data = $.parseJSON(data);
                if (data.state) {
                    alert(data.msg);
                }
            },
            error: function() {

            }
        });*/
        
    });
    
    $(".shop_type_list dd, .server_scope dd").on("click",function(){
		var _this = $(this);
		_this.addClass("yellow");
		_this.siblings().removeClass("yellow");
	})
});
</script>
       
</body>
<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>
