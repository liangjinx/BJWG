<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>编辑服务人员</title>
    
	
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
	<!--[if IE]> 
    	<link href="<%=basePath %>resources/css/ie.css" rel="stylesheet">
    <![endif]-->
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/module.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/swiper3.07.min.css">
	
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/city.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/validate.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/uploadFile.js"></script>
	<c:choose>
	<c:when test="${not empty waiter.idCardImg1 }">
		<style>
			.leftbox .jia img, .leftbox .jia2 img, .leftbox .jia3 img, .leftbox .jia4 img { width: 100%; padding-top: 0;}
			.banner_box { position: fixed;}
			.leftbox .pic, .leftbox .pic2, .leftbox .pic3, .leftbox .pic4 { font-size: 1.4rem;}
			.reference .cankao { font-size: 1.4rem;}
		</style>
	</c:when>
	</c:choose>
  </head>
  <body>
  	<div class="head">
        <a href="javascript:history.back(-1)" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回上一步"></a>
        <p>编辑服务人员</p>
    </div>
    <form action="<%=basePath%>shop/waiterSave" method="post" id="projectForm" name="projectForm" onsubmit="return checkFormData(1);" enctype="multipart/form-data">
    	 <input type="hidden" name="shopId" id="shopId" value="${shopId }">
    	 <input type="hidden" name="waiterId" id="waiterId" value="${waiter.waiterId }">
    	 
         <div class="enterprise_content">
            <div class="enterprise_main">
            	<div class="name_license">
                    <div class="company_name">
                        <label>姓&nbsp;&nbsp;&nbsp;名:</label>
                        <input type="text" name="name" id="name" maxlength="40" value="${waiter.name }" placeholder="请输你的真实姓名">
                    </div>
                    <div class="company_license">
                        <label>身份证:</label>
                        <input type="tel" name="idCard" id="idCard" maxlength="18" value="${waiter.idCard }" placeholder="请输入你的身份证号码">
                    </div>
                </div>
                <div class="licenses_box">
                    <div class="license_picbox">
                        <div class="leftbox">
                            <p class="jia">
	                            <c:choose>
	                            	<c:when test="${not empty waiter.idCardImg1 }">
			                            <img id="img_1" height="88px" width="118px" src="http://img.hzd.com${waiter.idCardImg1 }" alt="添加营业执照清晰照"></p>
			                            <p class="pic" id="pic_1">身份证正面照</p>
			                            <input type="hidden" name="w_idCard1_1" id="w_idCard1_1" class="" value="${waiter.idCardImg1 }">
			                            <input type="file" id="w_idCard1" accept="image/*" capture="camera" class="inputfile" name="w_idCard1" >
	                            	</c:when>
	                            	<c:otherwise>
			                            <img id="img_1" src="<%=basePath %>resources/images/jia.png" alt="添加营业执照清晰照"></p>
			                            <p class="pic" id="pic_1">身份证正面照</p>
			                            <input type="hidden" name="" class="">
			                            <input type="file" id="w_idCard1" accept="image/*" capture="camera" class="inputfile" name="w_idCard1">
	                            	</c:otherwise>
	                            </c:choose>
                        </div>
                        <div class="leftbox">
                            <p class="jia">
	                            <c:choose>
	                            	<c:when test="${not empty waiter.idCardImg2 }">
			                            <img id="img_2" height="88px" width="118px" src="http://img.hzd.com${waiter.idCardImg2 }" alt="添加营业执照清晰照"></p>
			                            <p class="pic" id="pic_2">身份证反面照</p>
			                            <input type="hidden" name="w_idCard2_1" id="w_idCard2_1" class="" value="${waiter.idCardImg2 }">
			                            <input type="file" id="w_idCard2" accept="image/*" capture="camera"  class="inputfile" name="w_idCard2">
	                            	</c:when>
	                            	<c:otherwise>
			                            <img id="img_2" src="<%=basePath %>resources/images/jia.png" alt="添加营业执照清晰照"></p>
			                            <p class="pic" id="pic_2">身份证反面照</p>
			                            <input type="hidden" name="" class="">
			                            <input type="file" id="w_idCard2" accept="image/*" capture="camera"  class="inputfile" name="w_idCard2">
	                            	</c:otherwise>
	                            </c:choose>
                        </div>
                        <div class="leftbox">
                            <p class="jia">
                            	<c:choose>
	                            	<c:when test="${not empty waiter.idCardImg3 }">
			                            <img id="img_3" height="88px" width="118px" src="http://img.hzd.com${waiter.idCardImg3 }" alt="添加营业执照清晰照"></p>
			                            <p class="pic" id="pic_3">手持身份证照</p>
			                            <input type="hidden" name="w_idCard3_1" id="w_idCard3_1" class="" value="${waiter.idCardImg3 }">
			                            <input type="file" id="w_idCard3" accept="image/*" capture="camera" class="inputfile" name="w_idCard3">
	                            	</c:when>
	                            	<c:otherwise>
		                            	<img id="img_3" src="<%=basePath %>resources/images/jia.png" alt="添加营业执照清晰照">
			                            <p class="pic" id="pic_3">手持身份证照</p>
			                            <input type="hidden" name="" class="">
			                            <input type="file" id="w_idCard3" accept="image/*" capture="camera" class="inputfile" name="w_idCard3">
	                            	</c:otherwise>
	                            </c:choose>
                            </p>
                        </div>
                        <div class="leftbox">
                            <p class="jia">
                            	<c:choose>
	                            	<c:when test="${not empty waiter.headImg }">
			                            <img id="img_4" height="88px" width="118px" src="http://img.hzd.com${waiter.headImg }" alt="添加营业执照清晰照"></p>
			                            <p class="pic" id="pic_4">个人头像</p>
			                            <input type="hidden" name="w_idCard4_1" id="w_idCard4_1" class="" value="${waiter.headImg }">
			                            <input type="file" id="w_idCard4" accept="image/*" capture="camera" class="inputfile" name="w_headImg">
	                            	</c:when>
	                            	<c:otherwise>
		                            	<img id="img_4" src="<%=basePath %>resources/images/jia.png" alt="添加营业执照清晰照">
			                            <p class="pic" id="pic_4">个人头像</p>
			                            <input type="hidden" name="" class="">
			                            <input type="file" id="w_idCard4" accept="image/*" capture="camera" class="inputfile" name="w_headImg">
	                            	</c:otherwise>
	                            </c:choose>
                            </p>
                        </div>
                        
                        <div class="reference">
                                <p class="cankao">参考提示</p>
                                <div class="banner_box">
                                    <div class="swiper-container">
                                        <div class="swiper-wrapper">
                                            <div class="swiper-slide">
                                            	<div class="header">
                                                    <em>身份证正面照</em><img src="<%=basePath %>resources/images/close.png" alt="关闭" id="closes" class="closes">
                                                </div>
                                            	<img src="<%=basePath %>resources/images/zheng_1.png" alt="身份证正面照">
                                            </div>
                                            <div class="swiper-slide">
                                            	<div class="header">
                                                    <em>身份证反面照</em><img src="<%=basePath %>resources/images/close.png" alt="关闭" id="closes" class="closes">
                                                </div>
                                            	<img src="<%=basePath %>resources/images/zheng_2.png" alt="身份证反面照">
                                            </div>
                                            <div class="swiper-slide">
                                            	<div class="header">
                                                    <em>手持身份证照</em><img src="<%=basePath %>resources/images/close.png" alt="关闭" id="closes" class="closes">
                                                </div>
                                                <img src="<%=basePath %>resources/images/zheng_3.png" alt="手持身份证照">
                                            </div>
                                            <div class="swiper-slide">
                                            	<div class="header">
                                                    <em>正脸照</em><img src="<%=basePath %>resources/images/close.png" alt="关闭" id="closes" class="closes">
                                                </div>
                                                <img src="<%=basePath %>resources/images/zheng_4.png" alt="正脸照">
                                            </div>
                                        </div>
                                        <div class="swiper-button-prev"></div>
                                        <div class="swiper-button-next"></div>
                                    </div>
                                </div>
                            </div>
                    </div>
                </div>
                <div class="tijiao_box">
                    <input type="submit" value="提交" class="tijiao">
                    <p>提交之后我们将在三个工作日内进行审核</p>
                    <p>请耐心等候认证结果</p>
                </div>
            </div>
        </div>
    </form>
    <div class="mask"></div>
    <!--
    	个人头像：<input type="file" id="w_idCard4" name="w_idCard4"><br>
    	联系地址 省份：
    		<select id="province" name="province" onchange="cityName('<%=basePath%>',this.value)">
    			<c:forEach items="${requestScope.provinceList }" var="pr">
    				<option value="${pr.areaId}" parent="${pr.parent }">${pr.name }</option>
    			</c:forEach>
    		</select><br>
    	联系地址 城市：
    		<select name="city" id="select_city" >
    		</select>
    	<br>
    	具体地址：<input type="text" id="address" name="address" value="龙岗区丹竹头"><br>
    	联系电话：<input type="text" id="phone" name="phone" value="13544250134"><br>
    	<input type="submit" name="提交" id="submitBtn" value="提交">
    -->
    </form>
  </body>
  
  <script language="javascript" src="<%=basePath %>resources/js/swiper3.07.min.js"></script>
  <script type="text/javascript">
  	/*$(function(){
		if(/MicroMessenger/i.test(navigator.userAgent)){
			$(".head").css('display','none');
		}else if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
		
						
		}else {
			$(".head").css('display','none');
		}
	});*/
  	$(document).ready(function(){
  		var messsageCode = '${requestScope.messageCode}';
  		var messsage = '${requestScope.message}';
  		if(messsage != ''){
  			alert(messsage);
  		}
  	});
  	
  	$(function(){
  		$("#w_idCard1").change(function(){
			fileChange(this,'w_idCard1','attestation_personage',1);
	    });
  		$("#w_idCard2").change(function(){
			fileChange(this,'w_idCard2','attestation_personage',2);
	    });
  		$("#w_idCard3").change(function(){
			fileChange(this,'w_idCard3','attestation_personage',3);
	    });
  		$("#w_idCard4").change(function(){
			fileChange(this,'w_idCard4','attestation_personage',4);
	    });
  	
		$('.cankao').on('click',function(){
			$('.banner_box, .mask').show();
			var mySwiper = new Swiper('.swiper-container',{
				loop: true,
				prevButton: '.swiper-button-prev',
				nextButton: '.swiper-button-next',
			})   
		});
		$('#closes, .mask').on('click',function(){
			$('.banner_box, .mask').hide();
		});
	});
	
	
//检测数据
function checkFormData(type){
	
	var name = $.trim($("#name").val());
	var idCard = $.trim($("#idCard").val());
	var w_idCard1 = $.trim($("#w_idCard1").val());
	if(name == '' || name.length > 120){
		alert("请填写名称");
		return false;
	}
	
	if(idCard == '' || idCard.length > 18 || idCard.length < 15){
		alert("请填写正确的15位或18位身份证号");
		return false;
	}
	var myreg = /^[0-9+]\d{13,17}|[0-9+]\d{13,16}x/;
    if(!myreg.test($.trim(idCard)))
    {
        alert('请填写正确的15位或18位身份证号');
        return false;
    }
	/*if(!IdCardValidate($.trim(idCard))){
		alert("请填写正确的15位或18位身份证号");
		return false;
	}*/
	var w_idCard2 = $.trim($("#w_idCard2").val());
	var w_idCard3 = $.trim($("#w_idCard3").val());
	var w_idCard4 = $.trim($("#w_idCard4").val());
	var waiterId = $.trim($("#waiterId").val());
	if(waiterId != '' && waiterId > 0){
		w_idCard1 = $.trim($("#w_idCard1_1").val());
		w_idCard2 = $.trim($("#w_idCard2_1").val());
		w_idCard3 = $.trim($("#w_idCard3_1").val());
		w_idCard4 = $.trim($("#w_idCard4_1").val());
		if(w_idCard1 == ''){
			alert("请上传正面照");
			return false;
		}
		if(w_idCard2 == ''){
			alert("请上传反面照");
			return false;
		}
		if(w_idCard3 == ''){
			alert("请上传手持照");
			return false;
		}
		if(w_idCard4 == ''){
			alert("请上传个人头像");
			return false;
		}
	}else{
		if(w_idCard1 == ''){
			alert("请上传正面照");
			return false;
		}
		if(w_idCard2 == ''){
			alert("请上传反面照");
			return false;
		}
		if(w_idCard3 == ''){
			alert("请上传手持照");
			return false;
		}
		if(w_idCard4 == ''){
			alert("请上传个人头像");
			return false;
		}
	}
	
	$(".tijiao").attr("disable",true);
	return true;
}
		
  </script>
  <jsp:include page="../head/hideHead.jsp"></jsp:include>
  <jsp:include page="../common/commonTip.jsp"></jsp:include>
</html>
