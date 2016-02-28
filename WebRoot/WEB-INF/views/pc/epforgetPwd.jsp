<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="忘记密码" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="./meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/login.css"/>

<style type="text/css">
    .d1{
    background-image: url("resources/images/pc/login-bd-2.jpg");
    width: 1800px;
    height: 500px
    }
    
    .d2{
    width:250px;
    height:0px;

   font-size:18px;
  
    margin-left: 60%;
    
    background-color: white;
    text-align: center;
    }

   .d3{
    
    }

</style>
</head>
<body>

<!--banner_box -->
<jsp:include page="header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="nav.jsp">
	<jsp:param value="1" name="nav"/>
</jsp:include>
<!-- 导航栏-->

<!-- content start -->

<div class="d1">
	
	<div class="d2">
	<img alt="忘记密码" src="resources/images/pc/forgetPwd.png">
	</div>
		


</div>

<!-- content end -->

<!--底部 -->
<jsp:include page="footer.jsp"></jsp:include>
<!--底部 -->

</body>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script src="resources/js/pc/forgetPwd.js"></script>
<!--<script src="js/login.js"></script>
--><script>

	/* $(function(){
		
		/*placeholder兼容IE
		var doc=document,inputs=doc.getElementsByTagName('input'),supportPlaceholder='placeholder'in doc.createElement('input'),placeholder=function(input){var text=input.getAttribute('placeholder'),defaultValue=input.defaultValue;
	    if(defaultValue==''){
	        input.value=text}
	        input.onfocus=function(){
	            if(input.value===text){this.value=''}};
	            input.onblur=function(){if(input.value===''){this.value=text}}};
	            if(!supportPlaceholder){
	                for(var i=0,len=inputs.length;i<len;i++){var input=inputs[i],text=input.getAttribute('placeholder');
	                if(input.type==='text'&&text){placeholder(input)}
	    }} */
		
		/*注册*/
		/*$('.forg-submit').on('click', function(){
			
			var phone = $('.phone').val(),
				code = $('.auth-code').val(),
				pass1 = $('.password1').val(),
				pass2 = $('.password2').val();
			
			if(checkPhone(phone) && checkCode(code) && checkPassword(pass1, pass2)){
				//注册成功
				console.log('111111');
				return true;
			}else{
				return false;
			}
			
		})
	
	}) */
	
</script>

</html>