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
    
    <title>商家认证页面</title>
    
    <meta http-equiv="content-type" content="text/html" charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="好站点,商家认证,填写企业信息">
	<meta http-equiv="description" content="商家认证页面">
	
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
	<!--[if IE]> 
    	<link href="<%=basePath %>resources/css/ie.css" rel="stylesheet">
    <![endif]-->
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/module.css">
	
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/city.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/validate.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/shop_auth.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/uploadFile.js"></script>
  </head>
  
  <body>
  
  	<div class="head">
        <a href="javascript:history.back(-1)" class="head_back"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
        <p>商家认证</p>
    </div>
    <form action="<%=basePath%>auth/save" method="post" id="projectForm" name="projectForm" enctype="multipart/form-data" onsubmit="return checkFormData(2);">
    	<input type="hidden" name="type" id="type" value="2">
    	<input type="hidden" name="shopId" id="shopId" value="${shopId }">
    	<input type="hidden" name="authId" id="authId" value="${infoAuth.authId }">
    	<!--
    		<input type="hidden" name="redirectUri" id="redirectUri" value="${redirectUri }">
    	
        -->
        <div class="enterprise_content">
            <div class="enterprise_main">
            	<div class="name_license">
                    <div class="company_name">
                        <label>公司名称:</label>
                        <input type="text" name="name" id="name" maxlength="120" placeholder="请输入公司全称" value="${infoAuth.name }">
                    </div>
                    <div class="company_license w100">
                        <label>注&nbsp;&nbsp;册&nbsp;&nbsp;号:</label>
                        <input type="tel" name="credentialsNo" id="credentialsNo" maxlength="15" placeholder="请输入营业执照上的注册号" value="${infoAuth.credentialsNo }">
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
		                            <p class="pic">营业执照</p>
		                            <input type="hidden" name="img_auth1_1" id="img_auth1_1" class="" value="${infoAuth.img_auth1 }">
		                            <input type="file" id="img_auth1" class="inputfile" name="img_auth1" accept="image/*" capture="camera">
                        		</c:when>
                        		<c:otherwise>
		                            <p class="jia"><img id="img_1" src="<%=basePath %>resources/images/jia.png" alt="添加营业执照清晰照"></p>
		                            <p class="pic">营业执照</p>
		                            <input type="hidden" name="" class="">
		                            <input type="file" id="img_auth1" class="inputfile" name="img_auth1" accept="image/*" capture="camera">
                        		</c:otherwise>
                        	</c:choose>
                        </div>
                        <div class="rightbox">
                            <p class="explain">营业执照上信息无遮挡，清晰可见，不得任何软件处理</p>
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
        <!--
            
            
            
    	
    	联系地址 省份：
    		<select id="province" name="province" onchange="cityName('<%=basePath%>',this.value)">
    			<c:forEach items="${requestScope.provinceList }" var="pr">
    				<option value="${pr.areaId}" parent="${pr.parent }">${pr.name }</option>
    			</c:forEach>
    		</select><br>
    	联系地址 城市：
    		<select name="city" id="select_city" >
    		</select>
    	具体地址：<input type="text" id="address" name="address" value="龙岗区丹竹头"><br>
    	联系电话：<input type="text" id="phone" name="phone" value="13544250134"><br>
    	-->
    </form>
    
  </body>
  
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
			fileChange(this,'img_auth1','attestation_enterprise');
	    });
	});
  </script>
  
  <jsp:include page="../head/hideHead.jsp"></jsp:include>
  <jsp:include page="../common/commonTip.jsp"></jsp:include>
  <jsp:include page="../head/down_app.jsp"></jsp:include>
</html>
