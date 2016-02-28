<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="__page_name__" value="关于我们" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/public.css"/>
<link rel="stylesheet" href="resources/css/pc/active.css"/>
	<style>
		
        .section p{
            text-indent: 2em;
            font-size: 16px;
            color: #666;
        }
        .section img{
            display: block;
            margin: 10px auto;
        }
    </style>
    
     <script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script src="resources/js/pc/active.js"></script>
<script>
	$(function(){
	
	/*加减*/
		
		$("#sub1").click(function(){
		
		
	if($("#count1").val()<=1){
	alert("您的操作有误");
	}
	else{
	var count=$("#count1").val()-1;
	
	$("#count1").val(count);
	}
	
	});
	$("#add1").click(function(){
	
	if($("#count1").val()>=300){
	alert("请给别人留点机会");
	}else{

	var count=parseInt($("#count1").val())+1;
	
	$("#count1").val(count);
	
	}
	
	});	
	
	
	$("#sub2").click(function(){
		
		
	if($("#count2").val()<=1){
	alert("您的操作有误");
	}
	else{
	var count=$("#count2").val()-1;
	
	$("#count2").val(count);
	}
	
	});
	$("#add2").click(function(){
	
	if($("#count2").val()>=300){
	alert("请给别人留点机会");
	}else{

	var count=parseInt($("#count2").val())+1;
	
	$("#count2").val(count);
	
	}
	
	});	
	
	
	
	

	
	});
	

</script>
    
</head>
<body>

	r<!--banner_box -->
	<jsp:include page="../header.jsp"></jsp:include>
	<!--banner_box -->
	<!--导航栏-->
	<jsp:include page="../nav.jsp">
		<jsp:param value="6" name="nav"/>
	</jsp:include>

<div id="indexDiv" class="active_div">

<h1><img src="resources/images/pc/active_text.png" alt="活动主题"/></h1>

<div class="shop1">
<span class="periods">第${periods1}期</span>
<span class="floatImg"><img src="resources/images/pc/active_back2.png" alt="商品1"/><br/>
<button id="button1"><img src="resources/images/pc/active_button.png" alt="点击抢购"/></button>
</span>

  <span class="floatText">
  <input type="hidden" id="activeId1" value="${ac1.activeId}">
  <ul>
   <li>品牌:${ac1.brand}</li>
    <li>名称:${ac1.name}</li>
    <li>重量:${ac1.weight}</li>
    <li>价值:${ac1.price}</li>
       <li>剩余数量:<span id="remindCount1"></span></li>
  </ul>
   <p id="clickShop1">
  1元抢猪头，抢的多中奖几率<br/>越大，请输入购号数量：<br/>
  <img src="resources/images/pc/sub.png" alt="减" id="sub1"/><input type="text" size="2px" class="count" id="count1" name="count1" value="1"/><img src="resources/images/pc/add.png" alt="加" id="add1"/>
  <img src="resources/images/pc/affirm.png" alt="确定" id="affirm1"/>
 </p>
  </span>
 	
  



</div>
<div class="shop2">
<span class="periods">第${periods2}期</span>
<span class="floatImg"><img src="resources/images/pc/active_back1.png" alt="商品2"/><br/>
<button id="button2"><img src="resources/images/pc/active_button.png" alt="点击抢购"/></button>
</span>
  <span class="floatText">
  <input type="hidden" id="activeId2" value="${ac2.activeId}">
  <ul>
    <li>品牌:${ac2.brand}</li>
    <li>名称:${ac2.name}</li>
    <li>重量:${ac2.weight}</li>
    <li>价值:${ac2.price}</li>
     <li>剩余数量:<span id="remindCount2"></span></li>
  </ul>
  
   <p id="clickShop2">
 1元抢猪腿，抢的多中奖几率<br/>越大，请输入购号数量：<br/>
  <img src="resources/images/pc/sub.png" alt="减" id="sub2"/><input type="text" size="2px" class="count" name="count2" id="count2" value="1"/><img src="resources/images/pc/add.png" alt="加" id="add2"/>
     <img src="resources/images/pc/affirm.png" alt="确定" id="affirm2"/>
</p>
 </span>


</div>
<div id="clear"></div>

<div class="active_text">
<div class="explain">
说明:抢猪头、猪腿活动。猪头、猪腿价值一元起，共300个号码，您支付1元即可获得一个随机中奖号码，买的越多中奖几率越高，售完即开奖，看谁运气好！</div>
</div>

<div class="winningList">
润民第一	期抢猪头、猪腿活动中奖名单：
<br/>
<div class="list">
<table class="winning">
<c:if test="${!empty aw1}">

<tr>
<td colspan="2">
   第${periods1-1}期抢猪头中奖用户:
</td>
</tr>

    <tr>
      <td>中奖手机:${aw1.phone}</td>
     
      <td>中奖编号:${aw1.winningCode}</td>
    </tr>


</c:if>

<c:if test="${!empty aw2}">

<td colspan="2">
   第${periods1-1}期抢猪头中奖用户:
</td>
    <tr>
      <td>中奖手机:${aw2.phone}</td>
     
      <td>中奖编号:${aw2.winningCode}</td>
    </tr>


</c:if>
  </table>
</div>
</div>
<div class="intro">
<p>润民集团简介:<br/>${ac2.intro}</p>


</div>

</div>	
		
		
		
		
		
	
	
		
	<jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>