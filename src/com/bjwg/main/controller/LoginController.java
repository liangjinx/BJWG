package com.bjwg.main.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.OperateConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.QQUser;
import com.bjwg.main.model.User;
import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.security.UserMananger;
import com.bjwg.main.service.LoginService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.CookieHelper;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.StringUtils;

/**
 * 登录
 * @author Allen
 * @version 创建时间：2015-6-3 下午12:08:57
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Controller
@Scope("prototype")
public class LoginController extends BaseController{

	@Resource 
	private LoginService loginService;
	
	/**
	 * 登录 - 跳转
	 * @param request
	 * @return
	 
	@RequestMapping(value="/login/login_init",method = {RequestMethod.POST,RequestMethod.GET})
	public String login_init(HttpServletRequest request) throws Exception{
		
		MyUtils.appParamsToJsonSetSession(request, CommConstant.SESSION_APP_PARAM);
		
		return "user/user-login";
	}*/
	
	/**
	 * qq登录页面，拉取qq信息
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpnv/lgqq",method = {RequestMethod.POST,RequestMethod.GET})
	public String qqlogin(HttpServletRequest request) throws Exception{
		
		return "user/qq_login";
	}
	/**
	 * 登录操作
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpnv/lging",method = {RequestMethod.POST,RequestMethod.GET})
	public String login(HttpServletRequest request,HttpServletResponse response) throws Exception{
		try {
			
			String type = request.getParameter("type");
			Map<String, Object> map = null;
			Status status = null;
			
			//1 是qq 登录，2表示微信登录(没用到)，3表示账号登录
			if((OperateConstant.LOGIN_QQ+"").equals(type)){
				
				QQUser qqUser = (QQUser)request.getSession().getAttribute(CommConstant.SESSION_QQ_USER);
				
				map = loginService.updateUserLogin(qqUser,null,null,OperateConstant.LOGIN_QQ,request.getRemoteAddr(),null);
				
			}else if((OperateConstant.LOGIN_PHONE+"").equals(type)){
				
				String username = request.getParameter("phone");
				String password = request.getParameter("password");
				
				User user = new User();
				user.setPhone(username);
				user.setPassword(password);
				
				map = loginService.updateUserLogin(null,null,user,OperateConstant.LOGIN_PHONE,request.getRemoteAddr(),null);
			}else{
				
				return "user/login";
			}
			
			ConsoleUtil.println(map);
			
			status = (Status)map.get("status");
			
			ConsoleUtil.println("成功进入0"+status);
			
			if(status == Status.success){
				User user = (User)map.get(CommConstant.SESSION_MANAGER);
				request.getSession().setAttribute(CommConstant.SESSION_LOGIN_TYPE, type);
				
				String openid = (String)request.getSession().getAttribute(CommConstant.SESSION_OPENID);
				
				String token = UserMananger.getInst().add(user.getUserId(), user.getUsername(), user.getPhone(),user.getNickname(),user.getSex(),user.getHeadImg(),user.getInviteCode(),user.getQrCode(),openid);
				request.getSession().setAttribute(CommConstant.SESSION_MANAGER, UserMananger.getInst().getUser(token));
				//cookie生命周期为12小时
				CookieHelper.addCookie(response, CommConstant.SESSION_APP_TOKEN, token, 12 * 60 *60);
				
				ConsoleUtil.println("/wpnv/lging -- >user："+user+"，openid："+openid+"，weixinUser："+request.getSession().getAttribute(CommConstant.SESSION_WX_USER));
				
				//判断是否为微信浏览器，且session中的weixinUser对象不存在
				if(request.getSession().getAttribute(CommConstant.SESSION_WX_USER) == null && MyUtils.isWx(request)){
					
					return "redirect:/wpnv/ixfirst";
					
				}
				
				
				//0代表登录成功
				return "redirect:/wpnv/ixhome";
			}else{
				this.notifyMsg(request, status);
				return "user/login";
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("登录出错", e);
		}
		return null;
	}
	
	
	/**
	 * 找回密码
	 */
	@RequestMapping(value="/wpnv/lgresetPassword",method = {RequestMethod.POST,RequestMethod.GET})
	public String resetPassword(HttpServletRequest request) throws Exception{
		return "user/reset_password";
	}
	/**
	 * 找回密码_保存
	 */
	@RequestMapping(value="/wpnv/lgsavePassword",method = {RequestMethod.POST,RequestMethod.GET})
	public String savePassword(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		String phone = request.getParameter("phone");
		String password = request.getParameter("password");
		String verifyCode = request.getParameter("verifyCode");
		
		Status status = loginService.savePassword(phone,password,verifyCode);
		
		if(status == Status.success){
			
			return login(request,response);
			
		}else{
			
			this.notifyMsg(request, status);
			
			return resetPassword(request);
		}
		
	}
	/**
	 * 退出登录
	 */
	@RequestMapping(value="/wpnv/lglogout",method = {RequestMethod.POST,RequestMethod.GET})
	public String logout(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		
		Long userId = null != user ? user.getUserId() : null;
		
		ConsoleUtil.println("/wpnv/lglogout -- > user:"+user + " --> userId:"+userId);
		//清楚cookie和session
		request.getSession().removeAttribute(CommConstant.SESSION_LOGIN_TYPE);
		request.getSession().removeAttribute(CommConstant.SESSION_MANAGER);
		request.getSession().removeAttribute(CommConstant.SESSION_APP_TOKEN);
		request.getSession().removeAttribute(CommConstant.SESSION_ALL_I_JOIN_PROJECT);
		request.getSession().removeAttribute(CommConstant.SESSION_USER_SET_PAY_PASSWORD);
		if(null != user && StringUtils.isNotEmpty(user.getToken())){
			
			UserMananger.getInst().removeUser(user.getToken());
		}
		//cookie生命周期为0，立刻清除掉
		CookieHelper.addCookie(response, CommConstant.SESSION_APP_TOKEN, "", 0);
		
		return "redirect:/wpnv/ixhome";
	}

}
