package com.bjwg.main.controller.pc;


import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.cache.PhoneCodeCache;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.constant.VerifyCodeConstant;
import com.bjwg.main.model.User;
import com.bjwg.main.model.VerifyPhone;
import com.bjwg.main.service.LoginService;
import com.bjwg.main.service.VerifyPhoneService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.JsonUtils;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.RedirectHelper;
import com.bjwg.main.util.SMSUtil;
import com.bjwg.main.util.StringUtils;

/**
 * @author chen
 * @version 创建时间：2015-4-10 下午08:29:01
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：手机验证码
 */
@Controller("pc_verify_phone_controller")
@Scope("prototype")
public class VerifyPhoneController extends BaseController{
	
	@Autowired
	private VerifyPhoneService verifyPhoneService;
	@Resource
	private LoginService loginService;
	
	
	/**
	 * 发送验证码到手机
	 * @param phone
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/pc/pnv/sendVerifyCode",method = RequestMethod.POST ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public String verifyCode(String phone,HttpServletRequest request){
		
		org.json.JSONObject jsonObject = new org.json.JSONObject();
		try
		{
			
			Map<String, Object> map = verifyPhoneService.sendVerifyCode(phone,request.getParameter("type"));
			
			Status status = (Status)map.get("status");
			
			jsonObject = JsonUtils.getJsonObject(status);
			
			if(map.containsKey("leftTime")){
				
				jsonObject.put("leftTime", map.get("leftTime"));
			}
			
		}catch (Exception e) {
			jsonObject = JsonUtils.getJsonObject(Status.verifyCodeSendFail);
			e.printStackTrace();
			logger.error("发送验证码到手机出错",e);
		}
		
		return jsonObject.toString();
	}
	
	

	/**
	 * 匹配手机和发送的验证码
	 * @param request
	 * @return   正确返回个人中心   错误重新发送验证码
	 * @throws Exception 
	 * @throws  
	 
	@RequestMapping(value="/matching",method = {RequestMethod.POST,RequestMethod.GET} )
	public String getMatching(VerifyPhone verifyPhone ,HttpServletRequest request) throws Exception{
		try {
			
			//手机号码	I - L：11 - N
			String phone = request.getParameter("phone");
			//验证码		I - L： 4 -N
			String code = request.getParameter("verifyCode");
			//类型
			String type = request.getParameter("type");
			
			request.setAttribute("type", type);
			
			String msg = null;
			//验证数据
			if(null != verifyPhone && userId != null && userId > 0)
			{
				if(StringUtils.isNotEmpty(phone)){
					
//					Pattern pattern = Pattern.compile("^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|170|145|147)+\\d{8})$");
					
					if(MyUtils.isMobileNO2(phone)){
						
						msg = verifyPhoneService.updateBind(userId,Long.valueOf(phone), code,null,null,VerifyCodeConstant.VERIFY_CODE_BINDING,request);
					}else{
						msg = "请输入有效的手机号码！";
					}
				}else{
					
					msg = "请输入手机号码！";
				}
				request.setAttribute("bindModel", msg);
				if(StringUtils.isNotEmpty(msg)){
					return "/user/binding";
				}
				
				user.setPhone(phone);
				request.getSession().setAttribute(CommConstant.SESSION_MANAGER, user);
				
				if(MyUtils.isPhone(request)){
					JSONObject jsonObject = loginService.queryWhenAppAfterLogin(request,user);
					request.setAttribute("jsonObject", jsonObject);
				}
				//0代表登录成功
				return RedirectHelper.redirct(request,0);
				
			}
			// 1  区评论  2 我要开战  3 收藏
			if("1".equals(type))
			{
				return "user/store.evaluate";
			}else if ("2".equals(type))
			{
				return "shop/store.set-up-shop";
			}else if ("3".equals(type))
			{
				return "redirect:/index/goodsDetailShop?id="+shopId;
			}
			//验证
			request.setAttribute("verifyPhone", verifyPhone);
			request.setAttribute("verifyError", "验证失败，请重新验证手机号");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("发送验证码到手机出错",e);
		}
		return "/user/binding";
	}
	*/
	

	/**
	 * 匹配手机和发送的验证码
	 * @param request
	 * @return   正确返回个人中心   错误重新发送验证码
	 * @throws Exception 
	 * @throws  
	 
	@RequestMapping(value="/matching2",method = {RequestMethod.POST,RequestMethod.GET} )
	public String getMatching2(VerifyPhone verifyPhone ,HttpServletRequest request) throws Exception{
		
		try {
			
			//手机号码	I - L：11 - N
			String phone = request.getParameter("phone");
			//验证码		I - L： 4 -N
			String code = request.getParameter("verifyCode");
			//类型
			String type = request.getParameter("type");
			request.setAttribute("type", type);
			
			String msg = null;
			//验证数据
			if(null != verifyPhone)
			{
				verifyPhone.setVerifyCode(null);
				verifyPhone.setPhoneNo(Long.valueOf(phone));
				//验证
				request.setAttribute("verifyPhone", verifyPhone);
				if(StringUtils.isNotEmpty(phone)){
					
//					Pattern pattern = Pattern.compile("^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|170|145|147)+\\d{8})$");
					if(MyUtils.isMobileNO2(phone)){
						
						msg = verifyPhoneService.updateBind(null,Long.valueOf(phone), code,null,null,VerifyCodeConstant.VERIFY_CODE_UNBINDING,request);
					}else{
						msg = "请输入有效的手机号码！";
					}
				}else{
					
					msg = "请输入手机号码！";
				}
				request.setAttribute("bindModel", msg);
				if(StringUtils.isNotEmpty(msg)){
					return "/user/unbinding";
				}
				
				request.setAttribute("message", "解绑成功");
//				return "/user/binding";
				
				//解绑成功后，自动绑定，同时登录
				User user = (User)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
				user.setPhone(phone);
				request.getSession().setAttribute(CommConstant.SESSION_MANAGER,user);
				
				//0代表登录成功
				return RedirectHelper.redirct(request,0);
			}
			request.setAttribute("verifyError", "验证失败，请重新验证手机号");
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("验证发送的验证码出错",e);
		}
		
		return "user/phone_change2";
	}
	
	*/
	
	/**
	 * 跳转至解绑手机号页面
	 * @param request
	 * @return
	 
	@RequestMapping(value="unbinding",method = {RequestMethod.POST,RequestMethod.GET})
	public String unbinding(HttpServletRequest request ){
		VerifyPhone verifyPhone = new VerifyPhone();
		String phone = request.getParameter("phone");
		if(StringUtils.isNotEmpty(phone)){
			verifyPhone.setPhoneNo(Long.valueOf(phone));
			request.setAttribute("verifyPhone", verifyPhone);
		}
		return "user/unbinding";
	}*/
	/**
	 * 跳转至设置绑定手机号页面(专门为app开发的)
	 * @param request
	 * @return
	 
	@RequestMapping(value="binding",method = {RequestMethod.POST,RequestMethod.GET})
	public String binding(HttpServletRequest request ){
		return "user/binding";
	}
	*/
	
	
	
	
}
