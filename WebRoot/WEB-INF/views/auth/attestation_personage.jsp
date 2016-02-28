<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>个人认证页面</title>
    
    <meta http-equiv="content-type" content="text/html" charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="好站点,个人认证,填写个人信息">
	<meta http-equiv="description" content="个人认证页面">
	
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
	<!--[if IE]> 
    	<link href="<%=basePath %>resources/css/ie.css" rel="stylesheet">
    <![endif]-->
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/module.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/swiper3.07.min.css">
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/city.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/validate.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/shop_auth.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/uploadFile.js"></script>
  </head>
  <body>
  	<div class="head">
        <a href="javascript:history.back(-1)" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回上一步"></a>
        <p>个人认证</p>
    </div>
    <form action="<%=basePath%>auth/save" method="post" id="projectForm" name="projectForm" onsubmit="return checkFormData(1);" enctype="multipart/form-data">
    	 <input type="hidden" name="type" id="type" value="1">
    	 <input type="hidden" name="shopId" id="shopId" value="${shopId }">
    	 <input type="hidden" name="authId" id="authId" value="${infoAuth.authId }">
    	 <!--<input type="hidden" name="redirectUri" id="redirectUri" value="${redirectUri }">
        -->
        <div class="enterprise_content">
            <div class="enterprise_main">
            	<div class="name_license">
                    <div class="company_name">
                        <label>姓&nbsp;&nbsp;&nbsp;名:</label>
                        <input type="text" name="name" id="name" maxlength="40" placeholder="请输你的真实姓名" value="${infoAuth.name }">
                    </div>
                    <div class="company_license">
                        <label>身份证:</label>
                        <input type="tel" name="credentialsNo" id="credentialsNo" maxlength="18" placeholder="请输入你的身份证号码" value="${infoAuth.credentialsNo }">
                    </div>
                </div>
                <div class="licenses_box">
                    <div class="license_picbox">
                        <div class="leftbox">
                        	<c:choose>
                        		<c:when test="${not empty infoAuth.credentialsPath }">
		                            <p class="jia">
		                            	<img id="img_1" style="width: 118px; height: 88px; vertical-align: initial; padding-top: 0px;" src="http://img.hzd.com${infoAuth.img_auth1 }" alt="身份证正面照">
		                            </p>
		                            <p class="pic" id="pic_1">身份证正面照</p>
		                            <input type="hidden" name="img_auth1_1" id="img_auth1_1" class="" value="${infoAuth.img_auth1 }">
		                            <input type="file" id="img_auth1" accept="image/*" capture="camera" class="inputfile" name="img_auth1">
                        		</c:when>
                        		<c:otherwise>
		                            <p class="jia"><img id="img_1" src="<%=basePath %>resources/images/jia.png" alt="身份证正面照"></p>
		                            <p class="pic" id="pic_1">身份证正面照</p>
		                            <input type="hidden" name="" class="">
		                            <input type="file" id="img_auth1" accept="image/*" capture="camera" class="inputfile" name="img_auth1">
                        		</c:otherwise>
                        	</c:choose>
                        </div>
                        <div class="leftbox">
                        	<c:choose>
                        		<c:when test="${not empty infoAuth.credentialsPath }">
		                            <p class="jia">
		                            	<img id="img_2" style="width: 118px; height: 88px; vertical-align: initial; padding-top: 0px;" src="http://img.hzd.com${infoAuth.img_auth2 }" alt="身份证反面照">
		                            </p>
		                            <p class="pic" id="pic_2">身份证反面照</p>
		                            <input type="hidden" name="img_auth2_1" id="img_auth2_1" class="" value="${infoAuth.img_auth2 }">
		                            <input type="file" id="img_auth2" accept="image/*" capture="camera"  class="inputfile" name="img_auth2">
                        		</c:when>
                        		<c:otherwise>
		                            <p class="jia"><img id="img_2" src="<%=basePath %>resources/images/jia.png" alt="身份证反面照"></p>
		                            <p class="pic" id="pic_2">身份证反面照</p>
		                            <input type="hidden" name="" class="">
		                            <input type="file" id="img_auth2" accept="image/*" capture="camera"  class="inputfile" name="img_auth2">
                        		</c:otherwise>
                        	</c:choose>
                        </div>
                        <div class="leftbox">
                        	<c:choose>
                        		<c:when test="${not empty infoAuth.credentialsPath }">
		                            <p class="jia">
		                            	<img id="img_3" style="width: 118px; height: 88px; vertical-align: initial; padding-top: 0px;" src="http://img.hzd.com${infoAuth.img_auth3 }" alt="身份证反面照">
		                            </p>
		                            <p class="pic" id="pic_3">手持身份证照</p>
		                            <input type="hidden" name="img_auth3_1" id="img_auth3_1" class="" value="${infoAuth.img_auth3 }">
		                            <input type="file" id="img_auth3" accept="image/*" capture="camera" class="inputfile" name="img_auth3">
                        		</c:when>
                        		<c:otherwise>
		                            <p class="jia"><img id="img_3" src="<%=basePath %>resources/images/jia.png" alt="添加营业执照清晰照"></p>
		                            <p class="pic" id="pic_3">手持身份证照</p>
		                            <input type="hidden" name="" class="">
		                            <input type="file" id="img_auth3" accept="image/*" capture="camera" class="inputfile" name="img_auth3">
                        		</c:otherwise>
                        	</c:choose>
                        </div>
                        <div class="leftbox">
                        	<c:choose>
                        		<c:when test="${not empty infoAuth.credentialsPath }">
		                            <p class="jia">
		                            	<img id="img_4" style="width: 118px; height: 88px; vertical-align: initial; padding-top: 0px;" src="http://img.hzd.com${infoAuth.img_auth4 }" alt="身份证反面照">
		                            </p>
		                            <p class="pic" id="pic_4">个人头像</p>
		                            <input type="hidden" name="img_auth4_1" id="img_auth4_1" class="" value="${infoAuth.img_auth4 }">
		                            <input type="file" id="img_auth4" accept="image/*" capture="camera" class="inputfile" name="img_auth4">
                        		</c:when>
                        		<c:otherwise>
		                            <p class="jia"><img id="img_4" src="<%=basePath %>resources/images/jia.png" alt="添加营业执照清晰照"></p>
		                            <p class="pic" id="pic_4">个人头像</p>
		                            <input type="hidden" name="" class="">
		                            <input type="file" id="img_auth4" accept="image/*" capture="camera" class="inputfile" name="img_auth4">
                        		</c:otherwise>
                        	</c:choose>
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
                <div class="province_address">
                    <div class="province_box">
                        <label class="province_l">联系地址:</label>
                        <div class="province_r">
                            <select id="province" name="province" onchange="cityName('<%=basePath%>',this.value)" class="province" >
                               <c:forEach items="${requestScope.provinceList }" var="pr">
				    				<option value="${pr.areaId}" parent="${pr.parent }" <c:if test="${infoAuth.province ==  pr.areaId}">selected="selected"</c:if>>${pr.name }</option>
				    			</c:forEach>
                            </select>
                            <div id="province_txt">选择省份</div>
                        </div>
                        <div class="city_r">
                            <select name="city" id="select_city" onchange="cityTxt();">
                            </select>
                            <div id="city_txt"></div>
                        </div>
                    </div>
                    <div class="address">
                        <label class="font_hidden">具体地址:</label>
                        <input type="text" id="address" name="address" placeholder="请输入具体地址" value="${infoAuth.address }">
                    </div>
                </div>
                <div class="phone_box">
                    <div class="phone">
                        <label>联系电话:</label>
                        <input maxlength="12" type="tel" id="phone" name="phone" placeholder="请输入座机号或者手机号" value="${infoAuth.phone }">
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
    	个人头像：<input type="file" id="img_auth4" name="img_auth4"><br>
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
  	$(function(){
		/*if(/MicroMessenger/i.test(navigator.userAgent)){
			$(".head").css('display','none');
		}else if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
		
						
		}else {
			$(".head").css('display','none');
		}*/
		if('${infoAuth.authId }' != ''){
			cityName('<%=basePath%>','${infoAuth.province }');
		}
	});
  	$(document).ready(function(){
  		var messsageCode = '${requestScope.messageCode}';
  		var messsage = '${requestScope.message}';
  		if(messsage != ''){
  			alert(messsage);
  		}
  	});
  	
  	$(function(){
  		$("#img_auth1").change(function(){
			fileChange(this,'img_auth1','attestation_personage',1);
	    });
  		$("#img_auth2").change(function(){
			fileChange(this,'img_auth2','attestation_personage',2);
	    });
  		$("#img_auth3").change(function(){
			fileChange(this,'img_auth3','attestation_personage',3);
	    });
  		$("#img_auth4").change(function(){
			fileChange(this,'img_auth4','attestation_personage',4);
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
	
	
  </script>
  <jsp:include page="../head/hideHead.jsp"></jsp:include>
  <jsp:include page="../common/commonTip.jsp"></jsp:include>
  <jsp:include page="../head/down_app.jsp"></jsp:include>
</html>
