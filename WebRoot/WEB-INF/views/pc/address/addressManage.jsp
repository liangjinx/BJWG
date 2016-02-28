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
    	<img src="resources/images/pc/nav_tit_bg.png" alt=""/>
        <div class="pig_tit"><p>收货地址管理</p></div>
    </div><!--my_pig_tit -->
	<div class="pig_tit_box">
    	<img src="resources/images/pc/point1.png" alt="点"/><p>新增收货地址</p><img src="resources/images/pc/point1.png" alt="点"/>
    </div>
    <form method="post" id="form">
    <input type="hidden" name="addressId" />
    <div class="address_box">
    	<p class="p_tit"><span> * </span> 收件人姓名:</p><input type="text" name="contactMan" class="text_input" maxLength=15/>
    </div>
    <div class="address_box">
    	<p class="p_tit"><span> * </span>  收货地址:</p>
        <select id="province" name="province" onChange="cityName();">
        	<option value="">省/直辖市</option>
        	<c:forEach items="${provinceList}" var="p">
    			<option value=${p.areaId}>${p.name}</option>
    		</c:forEach>
        </select>
        <select id="city" name="city"></select>
    </div>
    <div class="address_box">
    	<p class="p_tit"><span> * </span> 详细地址:</p><textarea name="address" class="" maxLength=80></textarea>
    </div>
      <div class="address_box">
    	<p class="p_tit"><span> * </span> 手机号码:</p><input type="text" name="contactPhone" class="text_input" maxLength=11/>
    </div>
     <div class="address_box">
    	<p class="p_tit">&nbsp;</p><input type="checkbox" name="isDefault" value="1"/> 设置为默认地址
    </div>
    <div class="address_box">
    	<p class="p_tit">&nbsp;</p><input type="button" value="保存" class="address_box_but" id="btnSave"/>
    </div>
    </form>
    
<div class="pig_tit_box">
    <img src="resources/images/pc/point1.png" alt="点"/><p>新增收货地址</p><img src="resources/images/pc/point1.png" alt="点"/>
</div> 
<input type="hidden" value="${fn:length(addressList)}" name="savedCount"/>
<div class="basicinfo_ts m_top20"><p class="p_16">最多保存10个有效地址。已保存了${fn:length(addressList)}条记录，还能保存${10-fn:length(addressList)}条。</p></div>
  
<div class="address_tab_box">
	<table>
    	<tr class="th_tr">
        	<td style="width:15%;">收货人</td>
            <td style="width:50%;">收货地址</td>
            <td style="width:15%;">电话/手机</td>
            <td style="width:20%;">操作</td>
        </tr>
        <c:forEach items="${addressList}" var="userAddress">
					<tr>
						<td style="width:15%;">
							<c:if test="${userAddress.isDefault == 1 }">
								<p class="mr_tit">默认</p>
								<input type="hidden" id="default_addr_id" value="${userAddress.addressId}">
							</c:if>
							${userAddress.contactMan}
						</td>
						<td style="width:50%;">
							${userAddress.address}
						</td>
						<td style="width:15%;">
							${userAddress.contactPhone}
						</td>
						<td style="width:20%;" data-addr="${userAddress.addressId}">
							<a href="pc/pv/address/edit?addressId=${userAddress.addressId}">修改</a>&nbsp;<a href="javascript:;" class="btnDelete">删除</a>
						</td>
					</tr>
		</c:forEach>
    </table>
</div>   
</div>
<div class="clear"></div>
</div>

   
<!-- 中间部分-->
<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->
</body>

</html>





<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>地址管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script language="JavaScript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<script language="JavaScript" src="<%=basePath %>resources/js/pc/address/addressManage.js"></script>

  </head>
  
  <body>
  	<h3>地址管理</h3>
    <div>
    	<form action="pv/address/saveAddress" method="post" id="form">
    		<input type="hidden" name="addressId" />
    		<div>收件人姓名:<input type="text" name="contactMan"></div>
    		<div>
    			收货地址:
    			<select name="province" id="province" onChange="cityName();">
    				<c:forEach items="${provinceList}" var="p">
    					<option value=${p.areaId}>${p.name}</option>
    				</c:forEach>
    			</select>
    			<select name="city" id="city">
    				<option></option>
    			</select>
    		</div>
    		<div>详细地址:<input type="text" name="address"/></div>
    		<div>手机号码:<input type="text" name="contactPhone"/></div>
    		<div>默认:<input type="checkbox" name="isDefault" value="1"/></div>
    		<div><button type="button" id="btnSave">保存</button></div>
    	</form>
    </div>
    <hr>
    <div>
    	<table>
    		<tr>
    			<th>收货人</th>
    			<th>收货地址</th>
    			<th>电话/手机</th>
    			<th>操作</th>
    		</tr>
				<c:forEach items="${addressList}" var="userAddress">
					<tr>
						<td>
							<c:if test="${userAddress.isDefault == 1 }">
								<span style="color: red">默</span>
								<input type="hidden" id="default_addr_id" value="${userAddress.addressId}">
							</c:if>
							${userAddress.contactMan}
						</td>
						<td>
							${userAddress.address}
						</td>
						<td>
							${userAddress.contactPhone}
						</td>
						<td data-addr="${userAddress.addressId}">
							<a href="pv/address/edit?addressId=${userAddress.addressId}">修改</a>&nbsp;<a href="javascript:;" class="btnDelete">删除</a>
						</td>
					</tr>
				</c:forEach>
			</table>
    </div>
  </body>
</html>
--%>