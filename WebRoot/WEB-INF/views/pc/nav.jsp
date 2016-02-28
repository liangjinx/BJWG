<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="nav_box">
	<div class="center">
		<a class="logo_box"><img src="resources/images/pc/logo_img01.png" alt="八戒王国online"/></a>
		<span class="logo_boots">
		<br/>	<br/>
		润民集团旗下<br/>
		<p style="color: black;">互联网+养猪平台</p>
		
		</span>
        <ul class="nav_ul">
        	<li><a href="<%=basePath%>" class="${param.nav==1?'hover_nav_a':''}">首页</a></li>
            <li><a href="<%=basePath%>pc/pnv/products" class="${param.nav==2?'hover_nav_a':''}">产品介绍</a></li>
            <li><a href="<%=basePath%>pc/pnv/inShopping" class="${param.nav==3?'hover_nav_a':''}"><span style="color:red;">抢猪仔</span></a></li>
            <li><a href="<%=basePath%>pc/pnv/realFarm" class="${param.nav==4?'hover_nav_a':''}">实时猪场</a></li>
                 <li><a href="http://shop.szrunmin.com" class="${param.nav==0?'hover_nav_a':''}">八戒商城</a></li>
             <c:if test="${empty path}">
            <li><a href="<%=basePath%>pc/pv/user/farm" class="${param.nav==5?'hover_nav_a':''}">我的猪场</a></li>
           </c:if>
           <c:if test="${!empty path}">
<li><a href="<%=basePath%>${path}" class="${param.nav==5?'hover_nav_a':''}">我的猪场</a></li>    
           </c:if>
            
            
            <!--
            <li class="about_ym">
            <a class="about_ym_a ${param.nav==6?'hover_nav_a':''}">关于润民</a>
            	<div class="sub_nav">
                	<a href="<%=basePath%>pc/pnv/about">润民集团</a>
                	<a href="<%=basePath%>pc/pnv/about2">润民金融</a>
                </div>
            </li>
            -->
            <li><a href="<%=basePath%>pc/pnv/news" class="${param.nav=='7'?'hover_nav_a':''}">资讯导航</a></li>
            <li><a href="<%=basePath%>pc/pnv/runminIntro" class="${param.nav=='6'?'hover_nav_a':''}">关于我们</a></li>
        </ul>
        <div class="clear"></div>
    </div>
	<div class="clear"></div>
</div>
