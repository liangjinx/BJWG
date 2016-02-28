<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@taglib prefix= "form" uri= "http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>编辑服务</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
<style type="text/css">
	/*input、textarea placeholder color*/
	input::-webkit-input-placeholder{ color: #858388;}
	input::-moz-input-placeholder{ color: #858388;}
	input::-ms-input-placeholder{ color: #858388;}
	textarea::-webkit-input-placeholder{ color: #858388;}
	textarea::-moz-input-placeholder{ color: #858388;}
	textarea::-ms-input-placeholder{ color: #858388;}
	/*touxiang*/
	#inputfile{ position: absolute; top: 0; left: 0; width: 102px; height: 102px; opacity: 0; z-index:9;}
	.shop_banner{ width: 100%; border-bottom: 1px solid #dedede; background-color: white; overflow: hidden; position:relative;}
	.user_box{ position: relative; float: left; width: 102px; height: 102px; margin: 20px 15px; background-color: #ffb400;}
	.user_box .p1{ position: absolute; bottom: 0; right: 0;}
	.shop_banner .p1 img{ width: 13px; padding: 5px; vertical-align: middle;}
	.shop_banner .p2{ position:absolute; line-height: 20px; font-size: 1.4rem; color: #fff; top:50px; left:20px; text-align:center;}
	.set_content li{padding:0 10px;height:38px;line-height:38px;border-bottom:1px solid #e7e7e7;vertical-align: top;position:relative;}
	.set_content input,.set_content select{height:34px;line-height:34px;border:none;background:inherit;width:70%;}
	/*submit button*/
	.submitbox{ width: 90%; margin: 5% auto; overflow: hidden;}
	.submitbox .set_save{ display: block; width: 100%; font-size: 1.6rem; color: #fff; background:#ffb200; height:40px; line-height:40px; border:none; border-radius:3px;}
	.set_arrows{ position:absolute; right:10px; top:12px; width: 8px; height: 13px; background: url(/resources/images/personalcenter_13.png) center center no-repeat; background-size: 100% 100%;}
	select{ border:none; appearance:none; -moz-appearance:none; -webkit-appearance:none; padding-right: 15px ;background: url(/resources/images/person-08.png) right center no-repeat; margin-left: 7%; width:75%;font-size:inherit;}
	select::-ms-expand{ display: none;}
	#avator { position: absolute; top:0; left: 0; width: 102px; height: 102px; opacity: 0; z-index: 10;}
	.ui-loader h1{ display: none;}
</style>
<script type="text/javascript" src="<%=basePath %>resources/js/uploadFile.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	 	var fail = '${fail}';
		if(fail != null && fail != ""){
			if(fail == "-1"){
				alert("上传的图片只能在5M以内");
			}
		}
		 //点击空白处关闭分享弹窗
	    $('.mask').click(function(){
	        $('.mask,.share_li1').hide();
	    });
	});
</script>
</head>

<body>
	<div class="head d_head">
    	<a class="head_back" href="<%=basePath%>service/listGoods?id=${goods.shopId }&type=3"></a>
        <p>编辑服务</p>
    </div>
    
    
    <form id="goodsForm" action="" method="post"  enctype="multipart/form-data" >
    	 <input type="hidden" name="serviceId" value="${goods.serviceId }" >
		 <input type="hidden" name="shopId" value="${goods.shopId }" >
		 <input type="hidden" name="saveAndEdit" value="edit" >
        <div class="shop_banner">
            <a href="javascript:void(0);">
                <div class="user_box" onclick="" <c:if test="${not empty goods.path}"> style="background: url(${goods.path})" </c:if>>
                <p class="p1">
                	<c:if test="${empty goods.path}">
	                	<img src="<%=basePath %>resources/images/setup_shop01.png" alt="添加店铺头像">
                	</c:if>
                </p>
                  <input type="hidden">
                  <input type="file" accept="image/*" capture="camera" name="imgFile" id="avator">
                </div>
            </a>
            <div class="p2">
            	<c:if test="${empty goods.path}">
					<p>主图</p>
					<p>620px*400px</p>
				</c:if>
            </div>
        </div>
        <div class="set_content">
            <ul>
                <li>
                    <span class="span_font">服务名称</span>
                    <input maxlength="28" type="text" name="name" class="" id="name" value="${goods.name }">
                    <form:errors path="goodsDetail.name" cssStyle="color:red"> </form:errors>
                </li>
                <li>
                    <span class="span_font">价格：￥</span>
                    <input  maxlength="5" type="tel" name="price" class="" id="price" value="${goods.price }" onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')">
                </li>
                 <li>
                    <span class="span_font">简介&nbsp;&nbsp;</span>
                   	<input type="textarea" name="summary" maxlength="250" class="" id="summary" value="${goods.summary }"></input>
                </li>
                 <li>
                    <span class="span_font">所属分类</span>
                    <select id="categoryId" name="categoryId" onchange="checkValueToOper(this,this.value);">
                    	<c:if test="${fn:length(requestScope.scategoryList) == 0 }">
	                		<option value="">选择分类</option>
                    	</c:if>
                    	<c:forEach items="${requestScope.scategoryList }" var="l">
                			<option value="${l.categoryId }" <c:if test="${goods.categoryId == l.categoryId}">selected="selected"</c:if> >${l.name }</option>
                		</c:forEach>
                		<option value="-1">添加分类+</option>
                    </select>
                     <div class="set_arrows"></div>
                </li>
                 <!--<li>
                    <span class="span_font">排序&#12288;&#12288;</span>
                   	<input maxlength="2"  type="tel" name="sort" class="" id="" value="${goods.sort}" onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" >
                </li>
            --></ul>
            <div class="submitbox">
            	<input type="button" value="完成" class="set_save" id="save_shop_setting" onclick="save();">
            </div>
        </div>
</form>
 
 
 <script type="text/javascript">
 //取消
 function cancel(){
 	$('#name').val('');
 	$('#price').val('');
 	$('#sort').val('');
 	$('#summary').val('');
 }
 //保存
 function save(){
    var name = $("#name").val();
    var price = $("#price").val();
    var categoryId = $("#categoryId").val();
    if ($.trim(name) == "" || $.trim(price) == "") {
        alert(" 服务的[名称]和[价格]必须填写！");
        return false;
    }
    if ($("#categoryId").val() == '-1'){
    	checkValueToOper($("#categoryId"),-1);
    }else if ($("#categoryId").val() == '' || $("#categoryId").val() == null) {
        alert("请选择分类");
        return false;
    }
    else {
    	var path = '<%=basePath%>service/save';
 		$('#goodsForm').attr("action", path).submit();
    }
 }
 
$(function(){
	$("#avator").change(function(){
		fileChange(this,'avator','goods_edit',null);
    });
});
 
 </script>
 <jsp:include page="../head/hideHead.jsp"></jsp:include>
 <jsp:include page="../common/commonTip.jsp"></jsp:include>
 <jsp:include page="../goods/scategory_add_ajax.jsp"></jsp:include>
</body>
</html>
