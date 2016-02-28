<%@page import="com.bjwg.main.util.MyUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

boolean isPhone = MyUtils.isPhone(request);
request.setAttribute("isPhone",isPhone);
boolean isIosPhone = MyUtils.isIosPhone(request);
request.setAttribute("isIosPhone",isIosPhone);
request.setAttribute("basePath",basePath);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
</html>
