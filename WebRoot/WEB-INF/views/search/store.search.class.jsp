<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 导入 -->
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>寻找服务、店家</title>

<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout.css">
<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>

<style type="text/css">
	/*search: input placeholder color*/
	input::-webkit-input-placeholder{ color: #858585;}
	input::-moz-input-placeholder{ color: #858585;}
	input::-ms-input-placeholder{ color: #858585;}
	/*secrch box*/
	.search{ position: relative; top: 0; width: 60%; height: 50px; line-height: 50px; margin: 0px auto; text-align: center;}
	.searcha{ width: 75%; height: 35px; padding-left: 25%; font-size: 1.4rem; border: 1px solid #272728; border-radius: 20px; outline: none;}
	.s_dian{ position: absolute; left: 8%;  top: 8px; width: 30px; height: 30px;}
	.s_dian img{ width: 25px;}
	.search_fontbox{ width: 70px; height: 50px; position: absolute; top: 0; right: 0; text-align: center;}
	.search_font{ font-size: 1.2em; color: #fff;}
	/*main: hot, history, clean history*/
	.content{ width: 100%; overflow: hidden;}
	.content ul{ padding: 20px 10px 0 10px; background-color: white; overflow: hidden;}
	.content ul li{ float: left; width: 22%; margin-bottom: 15px ; padding: 8px 4px; font-size: 0.85em; text-align: center; color: #79757f; border: 1px solid #d5d4d6; border-radius: 20px; box-sizing: border-box;}
	.content .hot-title{ width: 100%; margin-bottom: 15px; overflow: hidden;}
	.hot-title .hot-img{ width: 20px; margin-top: -1px; vertical-align: top;}
	.hot-title .hot-font{ padding-left: 5px; font-size: 1.6rem; color: #79757f;}
	.s-history{ display: block; width: 35%; margin: 20px auto; padding: 10px 20px; text-align: center;}
	.s-historyi{ width: 32px; vertical-align: sub;}
	.s-historyf{ font-size: 28px; padding-left: 4px; color: #272728;}
	/*sundry*/
	.mrp4{ margin-right: 4%;}
	.mt2{ margin-top: 2px;}
	.head_back img{ width:13px;height:24px;}
	.no_result {   width: 100%; padding: 45px 0 15px; font-size: 1.4rem; text-align: center; color: #858386; background-color: #fff;}
</style>

<script type="text/javascript">
	function querySearch(url,id){
		$("#class_id").val(id);
		$("#searchForm").attr("action",url).submit();
	}
</script>

</head>

<body>

		<div class="head">
	    	<a class="head_back" href="javascript:history.back(-1)"><img src="<%=basePath %>resources/images/back.png"></a>
	    	
	   <form action="<%=basePath%>index/getShopSearchList" id="searchForm_calss" method="post">	
	   		<input type="hidden" name="search_source" id="search_source" value="search_class">
	        <div class="search" >
	        	<a href="javascript:;"><input type="text" class="searcha" placeholder="寻找服务、店家" name="keyword" id="keyword" ></a>
	            <div class="s_dian"><img src="<%=basePath %>resources/images/search.png"></div>
	        </div>
	       <a href="javascript:;" class="search_fontbox"><span class="search_font" onclick="findSearch()" >搜索</span></a>
	   </form> 
	        
	    </div>
	    
	<form action="" id="searchForm" name="searchForm" method="post" target="_self">
		<input type="hidden" name="class_id" id="class_id" value="">
			    
			    <c:if test="${'yes' eq nothing }">
				    <div class="no_result">
				    	<p>没有搜索结果哦！</p>
				    	<p>试试下面的吧</p>
				    </div>
			    </c:if>
	    <div class="content">
	    	<ul>
	        	<div class="hot-title">
	            	<img class="hot-img" src="<%=basePath %>resources/images/search-hot.png"><span class="hot-font">热门搜索</span>
	            </div>
	            
	            <c:forEach items="${categories }" var="cate" varStatus="gory">
	            	
		            	<c:if test="${gory.index % 4 != 3 && cate.categoryId != 16}">
		            		<a href="javascript:querySearch('<%=basePath %>index/getShopSearchList',${cate.categoryId});"><li class="mrp4">${cate.name }</li></a>
		            	</c:if>
		            	
		            	<c:if test="${gory.index % 4 == 3 && cate.categoryId != 16}">
		            		<a href="javascript:querySearch('<%=basePath %>index/getShopSearchList',${cate.categoryId});"><li >${cate.name }</li></a>
		            	</c:if>
	            	 
	            </c:forEach>
	            <!--<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',1);"><li class="mrp4">外卖</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',2);"><li class="mrp4">送水</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',3);"><li class="mrp4">家政</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',4);"><li >维修</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',5);"><li class="mrp4">便利店</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',6);"><li class="mrp4">代驾</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',7);"><li class="mrp4">洗衣</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',8);"><li >下厨</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',9);"><li class="mrp4">装修</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',10);"><li class="mrp4">保健按摩</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',11);"><li class="mrp4">美容美甲</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',12);"><li >汽车服务</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',13);"><li class="mrp4">跑腿/配送</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',15);"><li class="mrp4">送花</li></a>
           		<a href="javascript:querySearch('http://192.168.10.57:8080/O2O_MAIN/index/getShopSearchList',16);"><li class="mrp4">技能交易</li></a>
	       		 -->
	       </ul>
	    </div>
	</form>
 <script type="text/javascript">
 
 function findSearch(){
 
	var name=$('#keyword').val();
    if (!$.trim(name)) {
        alert("搜索条件不能为空");
        $('#keyword').focus();
        return false;
    }
    //接口
    //var path = '<%=basePath%>index/getShopSearchList';
	$('#searchForm_calss').submit();
 }
 </script>   
</body>
</html>
