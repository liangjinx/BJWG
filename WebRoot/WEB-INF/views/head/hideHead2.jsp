<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 

	String link_source = request.getParameter("link_source");
	
	if(link_source != "" && link_source != null){
		request.getSession().setAttribute("link_source",link_source);
	}
%>

<script type="text/javascript">
$(function(){
	if(/MicroMessenger/i.test(navigator.userAgent)){
		$(".head").css('display','none');
		$("#tele_content").css({"padding": "0 0 55px","top":"15px"});
		$("#wrapper").css("top","15px");
	}else if (/Android/i.test(navigator.userAgent)) {
		$(".head").css('display','none');
		$("#tele_content").css({"padding": "0 0 55px","top":"15px"});
		$("#wrapper").css("top","15px");
	}else if (/webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
		if('${sessionScope.link_source}' == 'ios'){
			$(".head").css('display','none');
			$("#tele_content").css({"padding": "0 0 55px","top":"15px"});
			$("#wrapper").css("top","15px");
		}
	}else {
		$(".head").css('display','none');
		$("#tele_content").css({"padding": "0 0 55px","top":"15px"});
		$("#wrapper").css("top","15px");
	}
});
</script>
