<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@taglib prefix= "form" uri= "http://www.springframework.org/tags/form" %>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=0.5,minimum-scale=0.5,maximum-scale=0.5, user-scalable=no">
<title>编辑服务</title>

<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	 	var fail = '${fail}';
		if(fail != null && fail != ""){
			if(fail == "-1"){
				alert("上传的图片只能在5M以内");
			}
		}
	});
</script>
</head>

<body>
	<div class="head">
    	<a class="head-back" href="javascript:history.back(-1)"><img src="<%=basePath %>resources/images/head-back.png"></a>
        <p>编辑服务分类</p>
    </div>
    
	<form id="form" action="" method="post">
 			<input type="text" name="shopId" value="${shopId }" >
 			<input type="hidden" name="scategoryId" id="scategoryId" value="${scategory.categoryId }" >
         	<input maxlength="28" type="text" name="name" id="name" value="${scategory.name }" placeholder="名称"><br/>
         	<textarea name="summary" maxlength="250" class="" id="summary" placeholder="详细说明">${scategory.summary }</textarea><br/>
            <a class="finish ml10" href="javascript:save();" >完成</a>
	 </form>
 
 <script type="text/javascript">
 //保存
 function save(){
    var name = $("#name").val();
    var price = $("#price").val();
    if ($.trim(name) == "") {
        alert("名称必须填写！");
        return false;
    }
    else {
    	var categoryId = $("#scategoryId").val();
    	var path = '<%=basePath%>service/scategoryAdd';
    	if(categoryId != '' && categoryId > 0){
    		path = '<%=basePath%>service/scategorySave';
    	}
 		$('#form').attr("action", path).submit();
    }
 }
 
/* $(function(){
		$("#avator").change(function(){
			var url=window.webkitURL.createObjectURL(this.files[0]);
			if (url) {
				$('#show_avatar').attr('src',url);
			}
		});
});*/
 
 
 </script>
 <jsp:include page="../head/hideHead.jsp"></jsp:include>
</body>
</html>
