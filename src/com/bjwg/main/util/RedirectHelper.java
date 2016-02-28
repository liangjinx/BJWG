package com.bjwg.main.util;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import com.bjwg.main.constant.CommConstant;

/**
 * 地址跳转帮助类
 * @author Allen
 * @version 创建时间：2015-6-9 下午07:14:09
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class RedirectHelper {

	
	
	/**
	 * 地址跳转-公共处理
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static String redirct(HttpServletRequest request) throws Exception{ 
		JSONObject jsonObject = MyUtils.appParamsToJsonFromSession(request, CommConstant.SESSION_APP_PARAM);
//		String source = jsonObject.optString(CommConstant.SOURCE);
		String redirect_url = jsonObject.optString(CommConstant.REDIRECT_URL);
//		String tag = jsonObject.optString(CommConstant.SESSION_APP_TAG);
		//app端传递值isRedirect要跳转页面
		if(StringUtils.isNotEmpty(redirect_url)){
			
//			if("1".equals(source)){
			if(MyUtils.isPhone(request)){
				
//				request.setAttribute("tag",tag);
				return "phone/app_redirect";
			}else{
				
				ConsoleUtil.println("returnUrl:" + redirect_url);
				
				//登录成功后跳转认证页面
				return "redirect:"+redirect_url;
			}
				
		}else{
			
//			if("1".equals(source)){
			if(MyUtils.isPhone(request)){
//				request.setAttribute("tag",tag);
				return "phone/app_redirect";
			}else{
				
				return "redirect:/wpnv/ixhome";
			}
		}
		
	}
	/**
	 * 地址跳转-公共处理
	 * @param request
	 * @param tag
	 * @param redirect_url
	 * @return
	 * @throws Exception
	 */
	public static String redirct(HttpServletRequest request,Integer tag) throws Exception{
		
		JSONObject jsonObject = MyUtils.appParamsToJsonFromSession(request, CommConstant.SESSION_APP_PARAM);
		String redirect_url = jsonObject.optString(CommConstant.REDIRECT_URL);
		//app端传递值isRedirect要跳转页面
		if(StringUtils.isNotEmpty(redirect_url)){
			
			if(MyUtils.isPhone(request)){
				
				request.setAttribute("tag",tag+"");
				return "phone/app_redirect";
			}else{
				
				ConsoleUtil.println("returnUrl:" + redirect_url);
				
				//登录成功后跳转认证页面
				return "redirect:"+redirect_url;
			}
				
		}else{
			
			if(MyUtils.isPhone(request)){
				request.setAttribute("tag",tag+"");
				return "phone/app_redirect";
			}else{
				
				return "redirect:/wpnv/ixhome";
			}
		}
		
	}
	/**
	 * 地址跳转-公共处理
	 * @param request
	 * @param tag
	 * @param redirect_url
	 * @return
	 * @throws Exception
	 */
	public static String redirct(HttpServletRequest request,Integer tag,String redirect_url) throws Exception{
		
		//app端传递值isRedirect要跳转页面
		if(StringUtils.isNotEmpty(redirect_url)){
			
			if(MyUtils.isPhone(request)){
				
				request.setAttribute("tag", tag+"");
				return "phone/app_redirect";
			}else{
				
				ConsoleUtil.println("returnUrl:" + redirect_url);
				
				//登录成功后跳转认证页面
				return "redirect:"+redirect_url;
			}
			
		}else{
			
			if(MyUtils.isPhone(request)){
				
				request.setAttribute("tag", tag+"");
				return "phone/app_redirect";
			}else{
				
				return "redirect:/wpnv/ixhome";
			}
		}
		
	}
	
}
