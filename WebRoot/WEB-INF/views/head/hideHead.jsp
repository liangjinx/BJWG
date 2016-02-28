<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 

	String link_source = request.getParameter("link_source");
	
	if(link_source != "" && link_source != null){
		request.getSession().setAttribute("link_source",link_source);
	}
%>

<!DOCTYPE html>
<html>
  <head>
  	<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript">
  	$(function(){
		if(/MicroMessenger/i.test(navigator.userAgent)){
			$(".head").css('display','none');
		}else if (/Android/i.test(navigator.userAgent)) {
			$(".head").css('display','none');
		}else if (/webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
						
			if('${sessionScope.link_source}' == 'ios'){
				$(".head").css('display','none');
			}
			
		}else {
			$(".head").css('display','none');
		}
	});
	</script>
  </head>
  
  <body>
  </body>
</html>
