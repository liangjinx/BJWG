<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>我的消息</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/css/layout_2.css">
<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
<script src="<%=basePath %>resources/js/zepto.min.js"></script>

<style type="text/css">
	.content{ width: 100%; overflow: hidden;}
	.content ul{ overflow: hidden;}
	.content ul li{ position: relative; float: left; width: 100%; min-height: 60px; border-bottom: 1px solid #efefef; background-color: white; transition:all 0.25s;-webkit-transition:all 0.25s; box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box;}
	.li_swipeleft{transform:translate3d(-122px,0,0);-webkit-transform:translate3d(-122px,0,0)}
	.left_imgbox, .right_fontbox{ float: left; }
	.left_imgbox{ width: 80px; min-height: 80px; margin: 14px; text-align: center;}
	.left_imgbox img{  width: 80px; height: 80px; vertical-align: middle; border-radius: 50%; -webkit-border-radius: 50%; -moz-border-radius: 50%; -o-border-radius: 50%;}
	.right_fontbox{ width: 65%;min-height: 90px; color: #858585;}
	/*.right_fontbox{ width: 94%; margin-left: 3%; min-height: 90px; color: #858585;}*/
	.right_fontbox .r_title{ display: block; float: left; width: 90%; padding: 14px 0 10px; margin-left: 5%; color: #322c2c; font-size: 1.6rem; overflow: hidden;}
	.right_fontbox .r_time { display: block; float: right; margin-top: 5px; font-size: 1.2rem; color: #858386;}
	.right_fontbox .description{ float: left; width: 94%; margin-left: 3%; height: 50px; padding-bottom: 5px; overflow: hidden;}
	.right_fontbox .description img { width: 15px; margin-right: 2px;}
	.right_fontbox .description span { margin-left: 3px; font-size: 1.2rem; color: #858386;} 
	.list_delete{position:absolute;left:100%;top:0;height:108px;width:122px;text-align:center;border-bottom: 1px solid #ccc;background:#fbb102;display:-webkit-box;-webkit-box-align:center;-webkit-box-pack:center;}
	.list_delete img{width:26px;}
	.mt100{ margin-top:100px;}
	.li_nothing{ margin-top:10px; text-align: center; background-color: #dfdfdd !important;}
	.font_nothing{ margin-top:30px; padding-left: 30px; font-size: 1.6rem; text-align: center; color:#272728;}
	.ui-loader h1{ display: none;}
	.favorite_sort { width: 100%; height: 50px; line-height: 50px; margin-bottom: 15px; background-color: #fff;}
	.favorite_merchant, .favorite_serve { float: left; width: 50%; height: 40px; line-height: 40px; margin-top: 5px; font-size: 1.6rem; text-align: center;}
	.favorite_merchant { color: #322c2c; border-right: 1px solid #dedede; box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box;}
	.favorite_serve { color: #ffb402;}
	.no_thing {padding: 30px 0;color: #322c2c;font-size: 1.6rem;text-align: center;height: 30px;line-height: 30px;background-color: #fff;}
	.message_info { position: fixed; left: 50%; top:50%; display: none; width: 80%; height: auto; border: 1px solid #efefef; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; transform: translate(-50%,-50%); -webkit-transform: translate(-50%,-50%); -moz-transform: translate(-50%,-50%); background: url(/resources/images/share-bd.png) #fff center center no-repeat; background-size: 140px auto; z-index: 100;}
	.title_info,
	.content_info { width: 90%; /*font-size: 1.6rem; color: #322c2c;*/ text-align: center;}
	.title_info { /*padding-bottom: 20px;*/ margin: 57px auto 0; font-size: 1.6rem; color: #322c2c; /*border-bottom: 1px solid #efefef; box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box;*/}
	.content_info { margin: 10px auto 24px; text-align: center;}
	.cancel,
	.ensure { width: 80px; height: 40px; line-height: 40px; font-size: 1.4rem; border: none; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; background: none;}
	.cancel { margin-right: 15px; color: #858386;}
	.ensure { margin-left: 15px; color: #322c2c;}
</style>

<script type="text/javascript">
	function query(url,id){
		$("#id").val(id);
		$("#searchForm").attr("action",url).submit();
	}
</script>

</head>

<body>
	<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
	<header class="head">
        <a href="<%=basePath %>wpv/urstoreMe" class="head_back" data-ajax="false"><img src="<%=basePath %>resources/images/back.png" alt="返回"></a>
        <p>我的消息</p>
    </header>
    <div class="content">
        <ul>
			<c:choose>
				<c:when test="${fn:length(list) > 0}">
					<c:forEach items="${list }" var="l" varStatus="status">
						<li>
							<input type="hidden" id="messageId${status.index+1 }" name="messageIds" value="${l.bulletinId }">
			            	<div class="left_imgbox">
			            		<img src="<%=basePath %>resources/images/system_info_01.png">
			            	</div>
			            	<div class="right_fontbox">
			                    <p class="r_title">
		                    		<span class="r_time"><fmt:formatDate value='${l.ctime}' pattern='yyyy-MM-dd' /></span>
			                    </p>
			                    <p class="description">
			                    	${l.title }
			                    </p>
			                    <p class="description">
			                    	${l.content }
			                    </p>
								<div class="list_delete"><img src="<%=basePath %>resources/images/shopping_11.png" alt="删除"></div>
			            	</div>
			            </li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p class="no_thing">您尚未有消息记录</p>
				</c:otherwise>
			</c:choose>
        </ul>
    </div>

</body>
</html>
