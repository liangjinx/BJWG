<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=0.5,minimum-scale=0.5,maximum-scale=0.5, user-scalable=no">
<title>搜索列表</title>

<style type="text/css">
	/*search: input placeholder color*/
	input::-webkit-input-placeholder{ color: #858585;}
	input::-moz-input-placeholder{ color: #858585;}
	input::-ms-input-placeholder{ color: #858585;}
	/*secrch box*/
	.search{ position: relative; top: 0; width: 65%; margin: 0px auto; /*height: 30px;*/  text-align: center;}
	.search-font{ font-size: 30px; color: #272728; position: absolute; top: 0; right: 40px;}
	.searcha{ width: 62%; height: 40px; padding-left: 45px; font-size: 22px; border: 1px solid #272728; border-radius: 20px;}
	.s_dian{ width: 30px; height: 40px; position: absolute; left: 12%;  top: 4px;}
	.s_dian img{ width: 20px; margin-top: 13px;}
	/*main: left-img, right-font, clean history*/
	.content{ width: 100%; overflow: hidden;}
	.content ul{ overflow: hidden;}
	.content ul li{ float: left; width: 100%; min-height: 160px; margin-bottom: 2px;  background-color: white; position: relative;}
	.left-imgbox, .right-fontbox{ float: left; min-height: 160px;}
	.left-imgbox{ width: 150px; line-height: 160px; margin: 5px 20px; text-align: center;}
	.left-imgbox img{ vertical-align: middle;}
	.right-fontbox{ width: 65%; min-height: 160px; color: #757575;}
	..right-fontbox a .r-title{ max-width: 300px; padding: 25px 0 5px; color: #392f3c; font-size: 26.87px; overflow: hidden;}
	.right-fontbox a .r-title em{ padding-left: 5px; font-family: "MS Serif", "New York", serif; color: #e60012;}
	.right-fontbox a .description{ max-width: 300px; height: 40px; margin-bottom: 15px; font-size: 20.15px; color: #858585;}
	.right-fontbox .calling{ position: absolute; top: 35px; right: 35px; overflow: hidden;}
	.right-fontbox .record{ position: absolute; bottom: 10px; right: 15px; font-size: 20.15px; overflow: hidden;}
	.record .map-span, .map-span1{ height: 20px; font-size: 20.15px; border-left: 1px solid #eae7e7;}
	.record .map-span b{ padding: 5px; color: #8e8790;}
	.record .map-span img{ padding-left: 5px; vertical-align: bottom;}
	.record .map-span1 b{ padding: 5px 0 0 5px;; color: #000;}
	.s-history{ display: block; width: 35%; margin: 10px auto; padding: 10px 20px; text-align: center;}
	.s-historyi{ width: 28px; vertical-align: sub;}
	.s-historyf{ font-size: 20.15px; padding-left: 4px; color: #272728;}
</style>
</head>

<body>
	<div class="head">
    	<a class="head-back" href="javascript:history.back(-1)"><img src="<%=basePath %>resources/images/head-back.png"></a>
		<div class="search" >
        	<a href="javascript:;"><input type="text" class="searcha" placeholder="保洁"></a>
            <div class="s_dian"><img src="<%=basePath %>resources/images/search.png"></div>
        </div>
        <span class="search-font" onclick="">搜索</span>
    </div>
    
    <div class="content">
    	<ul>
        	<li>
            	<a href="<%=basePath%>index/goodsDetail?id=1"><div class="left-imgbox"><img src="<%=basePath %>resources/images/favorite-img.png"></div></a>
                <div class="right-fontbox">
                	<a href="<%=basePath%>index/goodsDetail?id=1"><p class="r-title">家家保洁<em>V</em></p>
                    <p class="description">店铺描述店铺描述店铺描述点秒杀</p></a>
                    <p class="calling"><a href="javascript:;"><img src="<%=basePath %>resources/images/y-phone.png" ></a></p>
                    <div class="record">
                    	<span class="map-span1"><b>50</b>人拨打</span>
                    	<span class="map-span"><img src="<%=basePath %>resources/images/map-icon.png"><b>13km</b></span>
                    </div>
                </div>
            </li>
        </ul>
        <a class="s-history" onclick=""><img src="<%=basePath %>resources/images/search-del1.png" class="s-historyi"><span class="s-historyf">清空历史纪录</span></a>
    </div>
    
</body>
</html>
