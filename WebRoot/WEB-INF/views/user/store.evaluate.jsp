<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; %>
<!-- 导入 -->
<jsp:include page="../head/head.jsp"></jsp:include>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<title>用户评价</title>

<style type="text/css">
	input::-webkit-input-placeholder{ color: #858388 !impotant;}
	input::-moz-input-placeholder{ color: #858388 !impotant;}
	input::-ms-input-placeholder{ color: #858388 !impotant;}
	textarea::-webkit-input-placeholder{ color: #858388 !impotant;}
	textarea::-moz-input-placeholder{ color: #858388 !impotant;}
	textarea::-ms-input-placeholder{ color: #858388 !impotant;}
	input[type="submit"] { border:none;}
	.content{ width: 100%; background-color: white; overflow: hidden;}
	.content li{ width: 90%; margin: 0 auto; font-size: 1.5rem;}
	.content li textarea{ width: 95%; min-height: 150px; padding: 12px 0 0 15px; font-size: 1.5rem; color: #322c2c; border: 1px solid #d5d4d6; border-radius: 5px;}
	.content li .limit{ text-align: right; padding-right: 5px; color: #858386; font-size: 1.5rem;}
	.content li .titles{ padding-left: 20px;}
	.content li .starbox{ display: inline-block; height: 36px; line-height: 36px; margin-left: 20px;}
	.content li .starbox img{ vertical-align: sub;}
	.e_tijiao{ margin-bottom: 30px;}
	.e_tijiao li{ width: 90%; margin: 24px auto 10px; color: #858388;}
	.e_finish{ display: block; width: 94%; padding: 15px 0; margin: 0 auto; font-size: 1.8rem; color: #fff; border: none; border-radius: 5px; background-color: #ffb400; cursor:pointer;}
	.padt25{ padding-top: 25px !important;}
	.mb7{ margin-bottom: 7px !important;}
	#star1, #star2, #star3, #star4{ width: auto !important;}
</style>

<script type="text/javascript">
	/**
	* 限制输入的字数
	* textareaId 文本域ID名称
	* limitNum 限制输入的字数
	* tipId 提示剩余输入字数的对象的ID

	*/
	function limitInput(textareaId,limitNum,tipId) {
		var myText = document.getElementById(textareaId);
		var leftQuantity = document.getElementById(tipId);
		if(myText.value.length > limitNum) {
			var myString = myText.value + "";
			myText.value = myString.substring(0,limitNum);
		}
		leftQuantity.innerText = limitNum - myText.value.length;
	}
	
	//检测参数
	function checkValues(){
	
		var star_1 = $("#star_1").val();
		var star_2 = $("#star_2").val();
		var star_3 = $("#star_3").val();
		var star_4 = $("#star_4").val();
		var content = $.trim($("#content").val());
		if(star_1 == ""){
			alert("请给商家的质量进行评分");
			return false;
		}
		if(star_2 == ""){
			alert("请给商家的速度进行评分");
			return false;
		}
		if(star_3 == ""){
			alert("请给商家的服务进行评分");
			return false;
		}
		if(star_4 == ""){
			alert("请给商家的态度进行评分");
			return false;
		}
		if(content == ""){
			alert("请写一下您对这个商家的评价");
			return false;
		}
		return true;
	}
	
</script>

</head>

<body>
	<div class="head">
		<a href="javascript:history.back(-1)" class="head_back">
			<img src="<%=basePath %>resources/images/back.png" alt="返回" />
		</a>
		<p>评论</p>
	</div>
	<form  id="commentForm" action="<%=basePath%>comment/addComment" method="post" onsubmit="return checkValues();">

		<input type="hidden" name="userId" id="userId" value="${session_manager.userId}">
		<input type="hidden" name="shopId" id="shopId" value="${shopId}">
		<input type="hidden" name="orderId" id="orderId" value="${orderId}">
		
	    <ul class="content">
	    	<li class="padt25">
	        	<a href="javascript:void(0);">
	        		<textarea class="" id="content" name="content" placeholder="写下一句你对这个商家的评价吧！" maxlength="2000" 
	        			onfocus="limitInput('content',70,'tipId');"
	        			onkeyup="limitInput('content',70,'tipId');"
	        			onkeydown="limitInput('content',70,'tipId');"
	        			onmouseout="limitInput('content',70,'tipId');"></textarea>
	        	</a>
	        	<p class="limit"><em id="tipId">0</em>/70</p>
	        </li>
	        <li class="mb7"><span class="titles">评分</span></li>
	         <li class="mb7">
	        	<label class="titles">质量</label>
	            <div class="starbox">
	                <div id="star1"></div>
					<div id="result1"></div>
					<input type="hidden" id="star_1" name="quality" id="quality" value="5"/>
	            </div>    
	        </li>
	        <li class="mb7">
	        	<label class="titles">速度</label>
	            <div class="starbox">
	                <div id="star2"></div>
					<div id="result2"></div>
					<input type="hidden" id="star_2" name="speed" id="speed" value="5"/>
	            </div>    
	        </li>
	        <li class="mb7">
	        	<label class="titles">服务</label>
	            <div class="starbox">
	                <div id="star3"></div>
					<div id="result3"></div>
					<input type="hidden" id="star_3" name="service" id="service" value="5"/>
	            </div>    
	        </li>
	        <li class="mb7">
	        	<label class="titles">态度</label>
	            <div class="starbox">
	                <div id="star4"></div>
					<div id="result4"></div>
					<input type="hidden" id="star_4" name="attitude" id="attitude" value="5"/>
	            </div>    
	        </li>
	    </ul>
	    <ul class="e_tijiao">
	        <li>
	           <a href="javascript:void(0);"><input type="submit" name="" class="e_finish"  value="完成"  /></a>
	        </li>
	    </ul>
    </form>
</body>
<jsp:include page="../head/hideHead.jsp"></jsp:include>
</html>
<script src="<%=basePath %>resources/js/jquery.star.js"></script>
<script>
	rat('star1','result1',1);
	rat('star2','result2',2);
	rat('star3','result3',3);
	rat('star4','result4',4);
	function rat(star,result,m){
	
	star= '#' + star;
	result= '#' + result;
	$(result).hide();//将结果DIV隐藏
		$(star).raty({
			hints: ['10','20', '30', '40', '50'],
			path: "/resources/images",
			starOff: 'star-dark.png',
			starOn: 'star-bright.png',
			size: 24,
			start: 40,
			showHalf: true,
			target: result,
			score:5,
			targetKeep : true,//targetKeep 属性设置为true，用户的选择值才会被保持在目标DIV中，否则只是鼠标悬停时有值，而鼠标离开后这个值就会消失
			click: function (score, evt) {
				//第一种方式：直接取值
//				alert('你的评分是'+score+'分');
				$("#star_"+m).val(score);
			}
		});
	
	};
	$(document).ready(function(){
  		var messsageCode = '${requestScope.messageCode}';
  		var messsage = '${requestScope.message}';
  		if(messsage != ''){
  			alert(messsage);
  		}
  	});
</script>
