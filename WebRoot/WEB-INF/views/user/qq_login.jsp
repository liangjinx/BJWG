<%@page import="com.bjwg.main.constant.CommConstant"%>
<%@page import="com.bjwg.main.model.QQUser"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.bjwg.main.util.MD5"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.bjwg.main.util.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	
	
	String appId = "101223574"; 
	String appKey = "e86fa91246a907becba4ba36c841a6f7"; 
	//回调地址
	String qq_redirect_uri="http://testweixin.hzd.com/login/qq_login";
	//state参数用于防止CSRF攻击，成功授权后回调时会原样带回
	String state = MD5.GetMD5Code(new Random(4).nextInt()+"");
	
	//String redirectUri = request.getParameter("redirectUri");
	
	//System.out.println("redirectUri:" + request.getParameter("redirectUri") +"，state："+state);
	//if(StringUtils.isNotEmpty(redirectUri)){
	//	request.getSession().setAttribute(state,redirectUri);
	//}
	
	//返回的code
	String code = request.getParameter("code");
	
	if(!StringUtils.isNotEmpty(code)){
		//step1获取Authorization Code
		String authorizeUrl = "https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id="+appId+"&redirect_uri="+URLEncoder.encode(qq_redirect_uri)+"&state="+state;
		PrintWriter writer = response.getWriter();
		writer.print("<script>window.location.href='"+authorizeUrl+"'</script>");
	}else if(state.equals(request.getParameter("state"))){
	
		//Step2：通过Authorization Code获取Access Token
		String tokenUrl = "https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id="+appId+"&client_secret="+appKey+"&code="+code+"&redirect_uri="+URLEncoder.encode(qq_redirect_uri);
		InputStreamReader inputStreamReader = null;
		try{
		
			URL url = new URL(tokenUrl);
			StringBuffer readOneLineBuff = new StringBuffer("");
			URLConnection connection = url.openConnection();
			connection.setConnectTimeout(60 * 1000);
			inputStreamReader = new InputStreamReader(connection.getInputStream());
			BufferedReader reader = new BufferedReader(inputStreamReader);
			String line = "";
			while((line = reader.readLine()) != null){
	            readOneLineBuff.append(line);
	        }
	        if(inputStreamReader != null){
	        	inputStreamReader.close();
	        }
	        String result = readOneLineBuff.toString();
	        readOneLineBuff = new StringBuffer("");
			System.out.println("result == " +result);
			
			//出错，页面打印错误信息
			if(result.contains("callback") && result.contains("error")){
				result = result.replace("callback", "").replace("(", "").replace(")", "").replace(";", "");
				JSONObject object = JSONObject.fromObject(result.trim());
				request.setAttribute("messageCode",object.getString("error"));
				request.setAttribute("message",object.getString("error_description"));
				
			}else{
			
				//解析数据，获取access_token
				String access_token = result.substring(result.indexOf("access_token") + 13 ,result.indexOf("&expires_in"));
				System.out.println("access_token == " +access_token);
				request.getSession().setAttribute("access_token",access_token);
				
				//step3 获取openid
				if(StringUtils.isNotEmpty(access_token)){
					
					String openIdUrl = "https://graph.qq.com/oauth2.0/me?access_token="+access_token;
					url = new URL(openIdUrl);
					connection = url.openConnection();
					connection.setConnectTimeout(60 * 1000);
					inputStreamReader = new InputStreamReader(connection.getInputStream());
					reader = new BufferedReader(inputStreamReader);
					line = "";
					while((line = reader.readLine()) != null){
			            readOneLineBuff.append(line);
			        }
			        if(inputStreamReader != null){
			        	inputStreamReader.close();
			        }
			        result = readOneLineBuff.toString();
			        readOneLineBuff = new StringBuffer("");
			        
			        System.out.println("openId result == " +result);
			        
			        if(result.contains("callback")){
			        	//出错，打印错误信息
			        	if(result.contains("error")){
							result = result.substring(result.indexOf("callback") + 8);
							result = result.replace("callback", "").replace("(", "").replace(")", "").replace(";", "");
							JSONObject object = JSONObject.fromObject(result.trim());
							request.setAttribute("messageCode",object.getString("error"));
							request.setAttribute("message",object.getString("error_description"));
						}else{
				        	result = result.substring(result.indexOf("callback") + 8);
				        	result = result.replace("(","").replace(")","").replace("callback","").replace(";","");
					        System.out.println("openId result == " +result.trim());
					        JSONObject object = JSONObject.fromObject(result.trim());
					        if(object.containsKey("error")){
					        	request.setAttribute("messageCode",object.getString("error"));
					        }
					        String openId = object.getString("openid");
					        System.out.println("openId == " +openId);
					        request.getSession().setAttribute("openId",openId);
					        
					        //step4 拉取用户信息
					        String infoUrl = "https://graph.qq.com/user/get_user_info?access_token="+access_token+"&oauth_consumer_key="+appId+"&openid="+openId+"&format=json";
					        url = new URL(infoUrl);
							connection = url.openConnection();
							connection.setConnectTimeout(60 * 1000);
							inputStreamReader = new InputStreamReader(connection.getInputStream());
							reader = new BufferedReader(inputStreamReader);
							line = "";
							while((line = reader.readLine()) != null){
					            readOneLineBuff.append(line);
					        }
					        if(inputStreamReader != null){
					        	inputStreamReader.close();
					        }
					        result = readOneLineBuff.toString();
					        
					        System.out.println("userinfo result == " +result);
					        if(StringUtils.isNotEmpty(result)){
					        	
					        	object = JSONObject.fromObject(result.trim());
					        	
					        	if(object.getInt("ret") != 0){
					        		
					        		request.setAttribute("messageCode",object.getInt("ret"));
					        		request.setAttribute("message",object.getString("msg"));
					        	}else{
						        	QQUser qqUser = new QQUser();
									qqUser.setOpenid(openId);
									qqUser.setIsYellowYearVip("1".equals(object.optString("is_yellow_year_vip")) ? (short)1 : (short)0);
									qqUser.setFigureurlQq1(object.optString("figureurl_qq_1"));
									qqUser.setFigureurlQq2(object.optString("figureurl_qq_2"));
									qqUser.setNickname(object.optString("nickname"));
									qqUser.setYellowVipLevel(Short.valueOf(object.optString("yellow_vip_level")));
									qqUser.setFigureurl(object.optString("figureurl"));
									qqUser.setFigureurl1(object.optString("figureurl_1"));
									qqUser.setFigureurl2(object.optString("figureurl_2"));
									qqUser.setVip("1".equals(object.optString("vip")) ? (short)1 : (short)0);
									qqUser.setVipLevel(Short.valueOf(object.optString("level")));
									qqUser.setIsYellowVip("1".equals(object.optString("is_yellow_vip")) ? (short)1 : (short)0);
									qqUser.setSex("男".equals(object.optString("gender")) ? (short)1 : (short)2);
									qqUser.setProvince(object.optString("province"));
									qqUser.setCity(object.optString("city"));
									
						        	request.getSession().setAttribute(CommConstant.SESSION_QQ_USER,qqUser);
							        //拉取成功后关闭当前窗口，直接提交父窗口的Form表单
									PrintWriter writer = response.getWriter();
									writer.print("<script>window.location.href='"+basePath+"wp/logining?type=1&urlCode="+state+"';</script>");
					        	}
					        }else{
					        	request.setAttribute("messageCode","can not get user info");
					        	request.setAttribute("message","无法获取用户信息");
					        }
					        
			        	}
			        }
				}
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(inputStreamReader != null){
				inputStreamReader.close();
			}
		}
	}
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<script type="text/javascript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
	</head>
	<body>
		<br>
		<c:if test="${requestScope.messageCode != null && requestScope.messageCode != ''}">
			qq登录失败，错误码：${requestScope.messageCode } - ${requestScope.message }
		</c:if>
</body>
</html>
