package com.bjwg.main.base;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.util.StringUtils;
import com.bjwg.main.util.ToolKit;

/**
 * @author chen
 * @version 创建时间：2015-4-7 上午10:17:25
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */

public class BaseController {
		
	public static final Logger  logger = LoggerFactory.getLogger("LOGISTICS-COMPONENT"); 
	
	//图片服务器域名
	public static final String webrootImg = ToolKit.getInstance().getSingleConfig("imgUrl");
	
	//本地
//	public static final String webroot = ToolKit.getInstance().getSingleConfig("projectUrl");
	//处理图片大小
//	public static String SHOP_LOGO = "@160h_160w_1e_1c";//店铺logo
	//轮播图
//	public static String SHOP_SLIDE_IMAGE = "@400h_720w_1e_1c|watermark=1&object=dXBsb2FkL3N5cy9tYXJrX2ljb24xLnBuZ0AyMFA=&t=60&p=7";
	//服务
//	public static String SHOP_SERVICE_LOGO = "@122h_122w_1e_1c";
	//用户logo
//	public static String USER_HEAD_IMAGE = "@160h_160w_1e_1c";
	//水印
//	public static String MARK_ICON_BASE64_CODE = "|watermark=1&object=dXBsb2FkL3N5cy9tYXJrX2ljb24ucG5nQDIwUA==&t=100&x=10&y=10&p=9";
//	public static String MARK_ICON_BASE64_CODE = "|watermark=1&object=dXBsb2FkL3N5cy9tYXJrX2ljb25fMy5wbmdAMjBQ&t=60&p=7";


	/**
	 * 返回页面提示
	 * @param request
	 * @param status
	 */
	public void notifyMsg(HttpServletRequest request , Status status){
		if(status != Status.success){
			request.setAttribute("messageCode", status.getCode());
			request.setAttribute("message", status.getMsg());
			request.setAttribute("msgType", 0);
		}else{
			
			request.setAttribute("msgType", 1);
		}
	}
	/**
	 * 返回页面提示- 跳转页面时传递msgCode参数
	 * @param request
	 * @param status
	 */
	public void notifyMsgByRedirectCode(HttpServletRequest request){
		
		String msgCode = request.getParameter("msgCode");
		
		if(StringUtils.isNotEmpty(msgCode)){

			this.notifyMsg(request, Status.getStatus(Integer.valueOf(msgCode)));
		}
	}
	/**
	 * 参数原封不动传递
	 * @param request
	 * @param status
	 */
	public void setAttr(HttpServletRequest request){

		Map<String, String[]> map = request.getParameterMap();
		
		if(null != map){
			
			
			for (Map.Entry<String, String[]> m : map.entrySet()) {
				
				request.setAttribute(m.getKey(), m.getValue().length > 1 ? m.getValue() : m.getValue()[0]);
			}
		}
	}

	
	//当前页码
	public int currentPage = 1;
	//页大小
	public int perRows = 10;
	
	protected HttpServletRequest request;
	
	protected HttpServletResponse response;
	
	@ModelAttribute
	public void setReqAndRes(HttpServletRequest request, HttpServletResponse response) throws JSONException
	{
		try {
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			
			//页码参数自动注入
			if(request != null && request.getParameter("currentPage") != null && !request.getParameter("currentPage").equals("")){
		        this.currentPage = Integer.valueOf(request.getParameter("currentPage"));
		    }
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		this.request = request;
		this.response = response;
		this.jsonResponseResult = new JSONObject();
		this.putJsonStatus(Status.success);
	}
	
	protected JSONObject jsonResponseResult;
	
	/**
	 * 获取一个jsonObject实例,默认已经封装了success请求结果
	 * @return
	 * @throws JSONException
	 */
	/*public JSONObject getJsonInstance() throws JSONException
	{
		return this.putJsonStatus(new JSONObject(), Status.success);
	}*/
	
	/**
	 * 设置json请求结果
	 * @param jsonResult
	 * @param data
	 * @return
	 * @throws JSONException
	 */
	public JSONObject putJsonStatus(Status jsonResult) throws JSONException
	{
		JSONObject obj = this.jsonResponseResult;
		obj.put("status", jsonResult.getStatus()).
			put("msg", jsonResult.getCode()).
			put("data", obj.has("data")? 
						obj.getJSONObject("data").put("text", jsonResult.getMsg()): 
						new JSONObject().put("text", jsonResult.getMsg()));

		return obj;
	}
	
	/**
	 * 设置json响应数据
	 * @param request
	 * @param object
	 * @throws Exception
	 */
	public void putJsonData(JSONObject data) throws Exception
	{	
		JSONObject object = this.jsonResponseResult;
		object.put("data", data.put("text", object.getJSONObject("data").get("text")));
	}
	
	/**
	 * 返回json数据
	 * @param request
	 * @param object
	 * @throws JSONException 
	 * @throws Exception
	 */
	public String outputJson() throws JSONException
	{	
		//this.request.setAttribute("jsonString", object.put("timestamp", Long.toString(new Date().getTime())));
		return this.jsonResponseResult.put("timestamp", Long.toString(new Date().getTime())).toString();
	}
	
}
