<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
%>

  	<style type="text/css">
  		.message_info { position: fixed; left: 50%;top:50%; display: none; width: 90%; height: auto; border: 1px solid #efefef; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; transform: translate(-50%,-50%); -webkit-transform: translate(-50%,-50%); -moz-transform: translate(-50%,-50%); background-color: #fff; z-index: 100;}
		.title_info,
		.content_info { width: 90%; font-size: 1.6rem; color: #322c2c; text-align: center;}
		.title_info {  padding-bottom: 20px; margin: 20px auto; border-bottom: 1px solid #efefef; box-sizing: border-box; -webkit-box-sizing: border-box; -moz-box-sizing: border-box;}
		.content_info { margin: 20px auto; text-align: center;}
		.cancel,
		.ensure { width: 40%; height: 40px; line-height: 40px; font-size: 1.6rem; border: none; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px;}
		.cancel { margin-right: 5%; color: #322c2c; background-color: #dedede;}
		.ensure { margin-left: 5%; color: #fff; background-color: #ffb400;}
  	</style>
  
  	<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
  	<script type="text/javascript" src="<%=basePath %>resources/js/commontip.js"></script>
  	<script type="text/javascript">
	  	$(document).ready(function(){
	  		alertTip('${requestScope.msgType}','${requestScope.message}','${requestScope.messageCode}',true);
	  	});
  	</script>
  	
  	
	<div class="message_info">
		<div class="title_info" id="msg"></div>
		<div class="content_info">
			<input type="button" class="cancel" value="取消" />
			<input type="button" class="ensure" value="确定" />
		</div>
	</div>
	<div class="mark"></div>
  
  <script type="text/javascript">
  	$(document).ready(function(){
  		$(".cancel,.ensure").click(function(){
			$(".message_info, .mark").hide();
		});
  	})
  	function alertMsg(msg){
		$("#msg").html(msg);
		$(".message_info, .mark").show();
	}
  </script>
