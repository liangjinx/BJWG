<%
 /**
  	2015-08-04 陆欣
 	ajax 添加服务分类公用页面（不做修改）
 */
%>
<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
<script src="<%=basePath %>resources/js/zepto.min.js"></script>
<style>
	/*content*/
    h1,h2,h3,h4,h5,h6{
		font-weight:normal;
		font-size:1.4rem;
	}
	html,body{
		width:100%;
		height:100%;
		overflow:hidden;
	}
	*{
		box-sizing: border-box;
		-webkit-box-sizing: border-box;
		-moz-box-sizing: border-box;
	}
	.d_content{bottom:48px;}
	.d_content_1{ padding:15px;bottom:0;}
	.management_classify_list{font-size:1.5rem;}
	.management_classify_list li{height:40px;line-height:40px;border-bottom:1px solid #e7e7e7;padding:0 10px;position:relative;}
	.management_classify_list li a{display:block;position:absolute;inline-block;top:0;}
	.management_classify_list li a:nth-child(2){right:80px;}
	.management_classify_list li a:nth-child(3){right:10px;}
	.management_classify_list li input{height:38px;140px;line-height:38px;border:none;border-radius:0;padding-left:5px;position:absolute;top:0;left:0;font-size:inherit;font-family: inherit;}
	.d_manage_footer{position:absolute;bottom:0;left:0;background:#fff;width:100%;height:48px;line-height:48px;text-align:center;border-top:1px solid #d6d6d6;color:#ffb200;}
	.add_classify{position:absolute;height:100%;width:100%;top:0;left:0;z-index:999;background:rgba(0,0,0,.3);display:none;}
	.add_classify_show{display:block;}
	.add_classify .add_classify_center{
		width:300px;height:200px;background:#fff;border-radius:4px;position:absolute;top:50%;left:50%;margin-top:-100px;margin-left:-150px;z-index:1001;
	}
	.add_classify_center p{height:60px;line-height:60px;text-indent:18px;}
	.add_classify_center input{display:block;margin-bottom:20px;margin:25px auto 0;border-radius:4px;}
	.add_classify_center .form_classify_name{height:40px;line-height:40px;border:1px solid #e3e3e3;width:90%;}
	.add_classify_center .form_classify_submit{width:50%;height:35px;line-height:35px;text-align:center;color:#fff;background:#ffb200;border:none;}
	.nothing_sotr { width: 90%; margin: 10px auto; font-size: 1.6rem; color: #322c2c; text-align: center;}
</style>

</head>

<body class="management">
	<div class="add_classify" id="add_classify">
		<div class="add_classify_center">
			<p>请填写分类名称</p>
			<form id="searchForm" name="searchForm" method="post" target="_self">
				<input type="hidden" id="sshopId" name="sshopId" value="${shopId }">
				<input type="hidden" name="scategoryId" id="scategoryId" value="" >
				<input type="text" 	name="sname" id="sname" value="" class="form_classify_name"/>
				<input type="button" value="完成" name="form_classify_submit" class="form_classify_submit" onclick="saveScategory();"/>
			</form>
		</div>
	</div>
</body>


 
<script type="text/javascript">
//检测select标签的值，执行相应的操作
function checkValueToOper(obj,v){
	if(v == -1){
		//显示编辑框
		editInit('','');
		//默认选中第一个
		var l = $(obj).find("option").length;
		if(l > 1){
			$(obj).get(0).selectedIndex = 0;
		}
	}
}
 //编辑初始化
 function editInit(scategoryId,name){
	$("#scategoryId").val(scategoryId);
	$("#sname").val(name);
	$('.add_classify').addClass('add_classify_show');
 }
 /**添加分类*/
$('.d_manage_footer,.edit_a').on('click', function(){
	$('.add_classify').addClass('add_classify_show');
})
/**点击“请填写分类名称”弹出框以外的地区，隐藏这个弹出框，遮罩层也自动隐藏**/
$(".add_classify").on("click",function(){
	$(".add_classify_center, .add_classify").removeClass('add_classify_show');
});
$('.add_classify_center').on('click',function(e){
	e.stopPropagation();
})
function saveScategory(){
	var name = $.trim($("#sname").val());
	if(name == ''){
		alert("请填写名称");
		return ;
	}
	var categoryId = $("#scategoryId").val();
   	var path = '<%=basePath%>service/scategoryAddAjax';
   	var shopId = ('${shopId}' == '' ? '${goods.shopId}' : '${shopId}');
   	$.ajax({
   		type: "POST",  
        url: path,  
        dataType:"json",
        data: 'shopId='+shopId+'&name='+name+'&random='+Math.random(),
        success: function(data){
        	//alert(data.code+"--"+data.id+"--"+data.name);
        	if("success" == data.code){
        		//追加option
        		var option = "<option value="+data.id+">"+data.name+"</option>";
        		var obj = $("#categoryId").find("option[value=-1]");
        		$(obj).before(option);
        		$("#categoryId").val(data.id);
        		$(".add_classify").click();
        	}else{
        		alert('添加失败');
        	}
		}  
   	});
	
}
 </script>   
    
</body>
</html>

