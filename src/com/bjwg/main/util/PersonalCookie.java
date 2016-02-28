package com.bjwg.main.util;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 个人cookie
 * @author Allen
 * @version 创建时间：2015-8-14 上午11:20:32
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class PersonalCookie {

	//功能引导总开关
	public static String INTRODUCE_SWITCH = "introduce_switch";
	//功能引导明细开关
	public static String INTRODUCE_DETAIL_SWITCH = "introduce_detail_switch";
	
	//目前功能引导页：店铺管理1、服务管理2、订单管理3、服务人员管理4、我的钱包5。cookie名称取url地址。如：/index/manage - 店铺管理
	public static short c_s_store = 1;
	public static short c_s_service = 2;
	public static short c_s_order = 3;
	public static short c_s_waiter = 4;
	public static short c_s_wallet = 5;
	
	
	/**
	 * 获取功能引导开关
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static String getIntroduceSwitch(HttpServletRequest request) throws Exception{
		
		Cookie cookie = new CookieHelper().getCookieByName(request, INTRODUCE_SWITCH);
		
		return cookie != null ? cookie.getValue() : null;
	}
	/**
	 * 设置功能引导开关
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static void setIntroduceSwitch(HttpServletRequest request,HttpServletResponse response,String introduceSwitch) throws Exception{
		
		CookieHelper cookieHelper = new CookieHelper();
		
		cookieHelper.addCookie(response, INTRODUCE_SWITCH, introduceSwitch, -1);
		
		//刷新具体的功能指引 全部开启
		if("true".equals(introduceSwitch)){
			
			Map<String, Cookie> cMap = CookieHelper.ReadCookieMap(request);
			
			for (Map.Entry<String, Cookie> m : cMap.entrySet()) {
				
				if(m.getKey().startsWith(PersonalCookie.INTRODUCE_SWITCH+"_")){
					
					cookieHelper.addCookie(response, m.getKey(), "true", -1);
//					response.addCookie(m.getValue());
				}
				
			}
		}
	}
	
	/**
	 * 具体功能引导开关引导
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static String getIntroduceDetailSwitch(HttpServletRequest request,String index) throws Exception{
		
		String value = "true";
		
		Cookie cookie = new CookieHelper().getCookieByName(request, index);
		
		value = cookie == null ? "true" : cookie.getValue(); 
		
		return value;
	}
	
	/**
	 * 具体功能引导开关引导
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static void setIntroduceDetailSwitch(HttpServletRequest request,HttpServletResponse response,String introduceSwitch,String index) throws Exception{
		
		new CookieHelper().addCookie(response, index, introduceSwitch, -1);
		
		if("true".equals(getIntroduceSwitch(request))){
			
			//只要关闭了一个具体功能引导，就将总开关关闭掉
			if("false".equals(introduceSwitch)){
				
				setIntroduceSwitch(request,response,"false");
			}
		}
		
	}
}
