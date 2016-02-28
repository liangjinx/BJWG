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
	/*set up store*/
	.set-content{ width: 100%; overflow: hidden;}
	/*store: name, phone, type,address, scope, describe*/
	.set-content ul{ width: 100%; padding: 10px 0 10px; background-color: white;}
	.set-content ul li{ width: 90%; line-height: 68px; margin: 0 auto; border-bottom: 1px solid #d5d4d6; overflow: hidden;}
	.set-content li .span-font{ display: inline-block; width: 16%; padding-left: 1%; color: #392f3c; font-size: 24.79px;}
	.set-content li input, .set-content li textarea{ color: #858388;}
	.set-content li input{ width: 72%; padding: 1% 0 1% 5%; font-size: 24.79px; border: none;}
	.set-content li textarea{ width: 96%; min-height: 180px; margin: 0 auto; margin-left: 1%; padding: 3% 0 2% 2%; font-size: 22px; border: 1px solid #d5d4d6; border-radius: 5px; letter-spacing: 1.5px;}
	.star-time, .end-time{ width: 10% !important; padding-left: 0 !important; border: 1px solid #d5d4d6 !important;}
	.star-time{ margin: 0 5px;}
	.end-time{ margin-left: 5px;}
	/*right icon*/
	.set-arrows, .set-arrows1,.set-map{ position: absolute; top: 13px; right: 7px;}
	.set-arrows{ width: 42px; height: 42px; background: url(/resources/images/person-08.png) center center no-repeat; background-size: 100% 100%;}
	.set-arrows1{ width: 42px; height: 42px; background: url(/resources/images/person-081.png) center center no-repeat; background-size: 100% 100%;}
	.set-map{ width: 38px; height: 38px; background: url(/resources/images/set-mapicon.png) center center no-repeat; background-size: 100% 100%;}
	/*submit button*/
	.submitbox{ width: 90%; margin: 0 auto; overflow: hidden;}
	.set-save{ display: block; width: 100%; padding: 20px 40px; font-size: 30px; color: #272728; border-radius: 15px; margin: 20px auto 10px; background-color: #eba123; border:none;}
	/*sundry*/
	.posi-rel{ position: relative;}
	.no-border{ border-bottom: none !important;}
	.ml5{ margin-left: 5%;}
	/*drop-down options*/
		/*radio*/
	.type-sort01{ display: none; width: 88%; margin: 0 auto 3%; color: #868586;}
	.type01{ display:inline-block; margin: 10px 5px 5px; text-align: center;}
	.type-sort02{ display: none; width: 88%; margin: 0 auto 3%; color: #868586;}
	.type02{ display:inline-block; margin: 10px 5px 5px; text-align: center;}
	input[type="radio"]{ width: 20px; height: 20px; vertical-align: bottom; margin-top: -1px; margin-bottom: 3px;}
	.type-sort03{ display: block; width: 88%; margin: 0 auto 3%; color: #868586;}
	.type-sort03 span{ font-size: 26px; color: #272728; background-color: #ccc; border: none; border-radius: 8px; padding: 3px 9px; margin: 14px 6px 5px 3px; display: inline-block;}
	.type-sort03 .week-active{ background-color: #eba123;}
	.type-sort01 em, .type-sort02 em, .type-sort03 em{ font-size: 24px;}
	.active{ background: url(/resources/images/person-081.png) center center no-repeat; background-size: 100% 100%;}
    select{ border:none; appearance:none; -moz-appearance:none; -webkit-appearance:none; padding-right: 15px ; margin-left: 5%; width:75%; height:60px; color: #858388; font-size: 24px;}
    select::-ms-expand{ display: none;}
    /*.address1{ display: inline-block;}*/
    .w-dp1{ width: 25% !important; padding-right: 0 !important;}
    .w-dp2{ width: 35% !important; margin-left: 5% !important;; padding-right: 0 !important;}
    .w-dp3{ width: 70% !important;}
    
    .pal18{ padding-left: 26%;}
</style>
</head>

<body>
	<div class="head">
    	<a class="head-back" href="<%=basePath%>index/manage"><img src="<%=basePath %>resources/images/head-back.png"></a>
        <p>店铺设置</p>
    </div>
  
 <form id="shopForm" action="" method="post" enctype="multipart/form-data" >
 
 	<input type="hidden" name="shopId" value="${shop.shopId}">
 	<input type="hidden" name="saveAndEdit" value="edit" >
 
    <div class="set-content">
    	<ul>
        	<li>
            	<span class="span-font" >店铺名称</span>
                <a href="javascript:;"><input maxlength="28" type="text" class="" id="shop_name" name="name" value="${shop.name }" placeholder="必填" /></a>
                <form:errors path="shopDetail.name" cssStyle="color:red"> </form:errors>
            </li>           
             <li class="posi-rel store-type">
            	<span class="span-font">店铺类型</span>
            	
                <a href="javascript:;"><select name="categoryId" id="">
                	<c:forEach items="${categorys}" var="cate" >
                		<c:if test="${cate.categoryId <= 13}">
	                   		<option value="${cate.categoryId}" <c:if test="${shop.categoryId == cate.categoryId }" >selected="selected"</c:if> >${cate.name}</option>
                    	</c:if>
                    </c:forEach>
                </select></a>
	            <span class="set-arrows"></span>
            </li>
            <li class="posi-rel">
            	<span class="span-font" >店铺地址</span>
            	
            	<a href="javascript:;"><select class="w-dp1" name="province" id="select_province"  onchange="cityName(${shop.city})">
                    	<c:forEach items="${province}" var="pr" >
                    		<OPTION value="${pr.areaId}" <c:if test="${shop.province == pr.areaId }">selected="selected"</c:if> >${pr.name }</OPTION>
                    	</c:forEach>
                </select></a>
               	<a href="javascript:;"><select class="w-dp2" name="city" id="select_city" >
               		<OPTION value="-1" >--请选择--</OPTION>
               	</select></a>
            </li>
            <li>
            	<span class="span-font">详细地址</span>
            	<a class="address1" href="javascript:;">
                	<input type="text" class="w-dp3" id="address" name="address" value="${shop.address }" placeholder="" />
                </a>
                 <p class="pal18">
                 	<form:errors path="shopDetail.address" cssStyle="color:red"></form:errors>
                 </p>
            </li>
            <li>
            	<span class="span-font" >店铺电话</span>
                <a href="javascript:;"><input maxlength="13" type="tel" class="" id="shop_tel" name="phone" value="${shop.phone }" placeholder="请输入手机号或座机号" onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" /></a>
                <p class="pal18"><form:errors path="shopDetail.phone" cssStyle="color:red"> </form:errors></p>
            </li>
            <li class="posi-rel store-scope">
            	<span class="span-font">服务范围</span>
            	
                <a href="javascript:;"><select name="range" id="">
                    <option value="1" <c:if test="${shop.range == 1}">selected="selected"</c:if> >500M</option>
   					<option value="2" <c:if test="${shop.range == 2}">selected="selected"</c:if>  >1KM</option>
   					<option value="3" <c:if test="${shop.range == 3}">selected="selected"</c:if> >3KM</option>
   					<option value="4" <c:if test="${shop.range == 4}">selected="selected"</c:if> >5KM</option>
   					<option value="5" <c:if test="${shop.range == 5}">selected="selected"</c:if> >全城</option>
  						<option value="6" <c:if test="${shop.range == 6}">selected="selected"</c:if> >不限</option>
                </select></a>
	             <span class="set-arrows"></span>   
            </li>
            
            <li class="posi-rel store-time">
            	<span class="span-font">营业时间</span>
                <a href="javascript:;">
                <input type="time" class="star-time ml5" id="" name="sndtime" value="${shop.sndtime}">
                <em>-</em><input type="time" class="end-time" value="${shop.endtime}" name="endtime"></a>
                <span class="set-arrows1" id="weekly"></span>
            </li>
            <div class="type-sort03">
            
            	<c:if test="${shop.w1 == 1}"> <span class="week-active" id="w1" >周一</span>
            		<input type="hidden" name="w1" value="1" />
            	</c:if>
            	<c:if test="${shop.w1 == 0}"> <span class="week" id="w1" >周一</span> 
            	</c:if>
            	
            	<c:if test="${shop.w2 == 1}"> <span class="week-active" id="w2" >周二</span>
            		<input type="hidden" name="w2" value="1" />
            	</c:if>
            	<c:if test="${shop.w2 == 0}"> <span class="week" id="w2" >周二</span>
            	</c:if>
            	
            	<c:if test="${shop.w3 == 1}"> <span class="week-active" id="w3" >周三</span>
            		<input type="hidden" name="w3" value="1" />
            	</c:if>
            	<c:if test="${shop.w3 == 0}"> <span class="week" id="w3" >周三</span>
            	</c:if>
            	
            	<c:if test="${shop.w4 == 1}"> <span class="week-active" id="w4" >周四</span>
            		<input type="hidden" name="w4" value="1" />
            	</c:if>
            	<c:if test="${shop.w4 == 0}"> <span class="week" id="w4" >周四</span>
            	</c:if>
            	
            	<c:if test="${shop.w5 == 1}"> <span class="week-active" id="w5" >周五</span>
            		<input type="hidden" name="w5" value="1" />
            	</c:if>
            	<c:if test="${shop.w5 == 0}"> <span class="week" id="w5" >周五</span>
            	</c:if>
            	
            	<c:if test="${shop.w6 == 1}"> <span class="week-active" id="w6" >周六</span>
            		<input type="hidden" name="w6" value="1" />
            	</c:if>
            	<c:if test="${shop.w6 == 0}"> <span class="week" id="w6" >周六</span>
            	</c:if>
            	
            	<c:if test="${shop.w7 == 1}"> <span class="week-active" id="w7" >周日</span>
            		<input type="hidden" name="w7" value="1" />
            	</c:if>
            	<c:if test="${shop.w7 == 0}"> <span class="week" id="w7" >周日</span>
            	</c:if>
            	
            	<c:if test="${shop.w1 == 1 && shop.w2 == 1 && shop.w3 == 1 && shop.w4 == 1 && shop.w5 == 1 && shop.w6 == 1 && shop.w7 == 1  }">
            		<span id="seelct_all" class="week-active"  >全选</span>
            	</c:if>
            	
            	<c:if test="${shop.w1 == 0 || shop.w2 == 0 || shop.w3 == 0 || shop.w4 == 0 || shop.w5 == 0 || shop.w6 == 0 || shop.w7 == 0  }">
            		<span id="seelct_all"  >全选</span>
            	</c:if>
            	
            	<div id="zhou"><input type="hidden"></div>
            </div>
            
             <li class="no-border">
            	<span class="span-font">服务描述</span>
                <a href="javascript:;"><textarea type="text" class="" id="" name="summary" placeholder="描述一下你的店铺吧">${shop.summary}</textarea></a>
            </li>
        </ul>
         <div class="submitbox"><a href="javascript:;"><input type="button" value="完成" class="set-save" id="setting_submit"></a></div>
    </div>
</form>

<script type="text/javascript">

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

    $("#weekly").click(function() {
        $(".type-sort03").toggle(600);
        var weekly = $("#weekly");
        if($(weekly).attr("class") == "set-arrows"){
        	$(weekly).attr("class","set-arrows1");
        }else{
        	$(weekly).attr("class","set-arrows");
        }
       
    });
    // add by oyja
    $(".type-sort03 span.week").click(function() {
        if ($(this).hasClass("week-active")) {
            $(this).removeClass("week-active").addClass("week");
            $("#seelct_all").removeClass("week-active");
            //
        } else {
            $(this).addClass("week-active").removeClass("week");
             var count = $(".week-active").length;
	        if(count == 7){
	       	 $("#seelct_all").addClass("week-active");
	        }
            //$("#seelct_all").addClass("week-active");
            //
            var name = $(this).attr('id');
            $("#zhou").append('<input type="hidden" id="'+name+'" name="'+name+'" value="1" />');
        }
        
        
    });
    //选中
    $(".type-sort03 span.week-active").click(function() {
        if ($(this).hasClass("week-active")) {
            $(this).removeClass("week-active").addClass("week");
            $("#seelct_all").removeClass("week-active");
            //
            var id = $(this).attr('id');
            $(".type-sort03 input[name='"+id+"']").remove();
            
        } else {
            $(this).addClass("week-active").removeClass("week");
            var count = $(".week-active").length;
	        if(count == 7){
	       	 $("#seelct_all").addClass("week-active");
	        }
            //$("#seelct_all").addClass("week-active");
            //
            var name = $(this).attr('id');
            $("#zhou").append('<input type="hidden" id="'+name+'" name="'+name+'" value="1" />');
        }
        
    });
    
    var ii = 1;
    $('#seelct_all').click(function() {
       var this_ = $('.type-sort03 .week');
       var this_2 = $('.type-sort03 .week-active');

        if (this_.hasClass('week-active')) {
            this_.removeClass("week-active");
//          	alert(3336666);
            $("#zhou input").remove();
            
            if( ii == 2 ){
            	$('.type-sort03 .week').addClass('week-active');
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
            	$('.type-sort03 .week').addClass('week-active');
            	$(".type-sort03 input").remove();
           		$("#zhou").append('<input type="hidden" id="w1" name="w1" value="1" />');
				$("#zhou").append('<input type="hidden" id="w2" name="w2" value="1" />').append('<input type="hidden" id="w3" name="w3" value="1" />').append('<input type="hidden" id="w4" name="w4" value="1" />')
            	.append('<input type="hidden" id="w5" name="w5" value="1" />').append('<input type="hidden" id="w6" name="w6" value="1" />').append('<input type="hidden" id="w7" name="w7" value="1" />');
            	ii = Number(ii + 1) ;
            }
             
        } else {
//              alert(3345);
            $('#seelct_all').attr('class',"week-active");
            
            $('.type-sort03 .week').addClass('week-active');
            $('.type-sort03 .week-active').addClass('week');
           
            if(this_.hasClass('week-active')){
//            	alert(333);
            	var id = $(this).attr('id');
            	$(".type-sort03 input").remove();
            	$("#zhou").append('<input type="hidden" id="w1" name="w1" value="1" />');
				$("#zhou").append('<input type="hidden" id="w2" name="w2" value="1" />').append('<input type="hidden" id="w3" name="w3" value="1" />').append('<input type="hidden" id="w4" name="w4" value="1" />')
	            	.append('<input type="hidden" id="w5" name="w5" value="1" />').append('<input type="hidden" id="w6" name="w6" value="1" />').append('<input type="hidden" id="w7" name="w7" value="1" />');
             	ii = Number(ii + 3) ;
            }else {
//            	alert(445);
            	this_2.removeClass("week-active");
            	$("#seelct_all").removeClass("week-active");
	        	$("#zhou input").remove();
	        	$(".type-sort03 input").remove();
	        	ii = Number(ii + 1) ;
            }
           
        }
    });
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
});
</script>
       
</body>
</html>
