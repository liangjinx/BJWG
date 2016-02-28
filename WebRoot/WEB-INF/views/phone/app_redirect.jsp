<%@page import="com.bjwg.main.util.MyUtils"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="com.bjwg.main.util.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%
	String tag = StringUtils.isNotEmpty(request.getParameter("tag")) ? request.getParameter("tag") : (String)request.getAttribute("tag");
	System.out.println("tag:"+tag);
	//判断是否为ios
	boolean isIOS = MyUtils.isIosPhone(request);
	String iosUrl = "";
	JSONObject obj = (JSONObject)request.getAttribute("jsonObject");
	if(isIOS){
		iosUrl = "'OC://login_success?"+(obj != null ? URLEncoder.encode(obj.toString() , "UTF-8") : null)+"'";
	}
	System.out.println("isIOS:"+(isIOS ? "<body onload=\"window.location.href="+iosUrl+"\"></body>" : "<body onload=window.O2OHOME.SkipOutWebview('','',"+tag+",'"+(obj != null ? obj.toString() : null)+"')></body>"));
 %>
<%= isIOS ? "<body onload=\"window.location.href="+iosUrl+"\"></body>" : "<body onload=window.O2OHOME.SkipOutWebview('','',"+tag+",'"+(obj != null ? obj.toString() : null)+"')></body>"%>

</html>