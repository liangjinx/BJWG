<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="__page_name__" value="收货地址" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script src="resources/js/pc/address/addressManage.js"></script>

<script>
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
</script>
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
	<jsp:param value="7" name="nav"/>
</jsp:include>
<!--mypig_left_nav -->
<div class="right_main">
	<div class="my_pig_tit bg_f6"><!--my_pig_tit -->
    	<img src="resources/images/pc/nav_tit_bg.png" alt="收货地址管理"/>
        <div class="pig_tit"><p>收货地址管理</p></div>
    </div><!--my_pig_tit -->
	<div class="pig_tit_box">
    	<img src="resources/images/pc/point1.png" alt="点"/><p>修改收货地址</p><img src="resources/images/pc/point1.png" alt="点"/>
    </div>
    <form method="post" id="form">
    <input type="hidden" name="addressId" value="${address.addressId }"/>
    <div class="address_box">
    	<p class="p_tit"><span> * </span> 收件人姓名:</p><input type="text" name="contactMan" class="text_input" value="${address.contactMan }" maxLength=15/>
    </div>
    <div class="address_box">
    	<p class="p_tit"><span> * </span>  收货地址:</p>
    	<select name="province" id="province" onChange="cityName();">
    		<c:forEach items="${provinceList}" var="p">
    			<option value="${p.areaId}" <c:if test="${address.province == p.areaId}">selected="selected"</c:if>>${p.name}</option>
    		</c:forEach>
    	</select>
        <select id="city" name="city">
        	<c:forEach items="${cityList}" var="p">
    			<option value="${p.areaId}" <c:if test="${address.city == p.areaId}">selected="selected"</c:if>>${p.name}</option>
    		</c:forEach>
        </select>
    </div>
    <div class="address_box">
    	<p class="p_tit"><span> * </span> 详细地址:</p><textarea name="address" class="" maxLength=80>${address.address}</textarea>
    </div>
      <div class="address_box">
    	<p class="p_tit"><span> * </span> 手机号码:</p><input type="text" name="contactPhone" class="text_input" value="${address.contactPhone}" maxLength=11/>
    </div>
     <div class="address_box">
    	<p class="p_tit">&nbsp;</p><input type="checkbox" name="isDefault" value="1" ${address.isDefault==1?'checked':'' }/> 设置为默认地址
    </div>
    <div class="address_box">
    	<p class="p_tit">&nbsp;</p><input type="button" value="保存" class="address_box_but" id="btnEditSave"/>
    </div>
    </form>
</div>
<div class="clear"></div>
</div>
<!-- 中间部分-->
<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->
</body>
</html>


<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>地址编辑</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script language="JavaScript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<script>
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
							$("#city_txt").html("<option value='1' selected='selected'>选择市</option>");
							$("#city").attr("disabled",true);
						}else{
							$("#city").attr("disabled",false);
						}
					}  
			});  
		}
		

	
	</script>
  </head>
  
  <body>
    <h3>地址编辑</h3>
    <div>
    	<form action="pv/address/saveEditAddress" method="post" id="form">
    		<input type="hidden" name="addressId" value="${address.addressId }"/>
    		<div>收件人姓名:<input type="text" name="contactMan" value="${address.contactMan }"></div>
    		<div>
    			收货地址:
    			<select name="province" id="province" onChange="cityName();">
    				<c:forEach items="${provinceList}" var="p">
    					<option value="${p.areaId}" <c:if test="${address.province == p.areaId}">selected="selected"</c:if>>${p.name}</option>
    				</c:forEach>
    			</select>
    			<select name="city" id="city">
    				<option></option>
    			</select>
    		</div>
    		<div>详细地址:<input type="text" name="address" value="${address.address}"/></div>
    		<div>手机号码:<input type="text" name="contactPhone" value="${address.contactPhone}"/></div>
    		<div>默认:<input type="checkbox" name="isDefault" value="1" ${address.isDefault==1?'checked':'' }/></div>
    		<div><button type="button" id="btnSave">保存</button></div>
    	</form>
    </div>
    
    
  </body>
</html>
-->