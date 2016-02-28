package com.bjwg.main.controller;

import java.math.BigDecimal;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.constant.BalanceConstant;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.LoginConstants;
import com.bjwg.main.constant.OperateConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.User;
import com.bjwg.main.model.Wallet;
import com.bjwg.main.model.WeiXinUser;
import com.bjwg.main.security.UserMananger;
import com.bjwg.main.service.UserService;
import com.bjwg.main.service.WalletService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.CookieHelper;
import com.bjwg.main.util.MD5;
import com.bjwg.main.util.StringUtils;

/**
 * @author Allen
 * @version 创建时间：2015-4-13 下午04:53:58
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：用户
 */
@Controller
@Scope("prototype")
public class RegisterController extends BaseController{
	
	@Resource
	private UserService userService;
	@Resource
	WalletService walletService;
	
	/**
	 * 用户注册页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpnv/rsregisterInit",method = {RequestMethod.POST,RequestMethod.GET})
	public String registerInit(HttpServletRequest request){
		
		return "user/register";
	}
	
	
	/**
	 * 用户注册
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpnv/rsregister",method = {RequestMethod.POST,RequestMethod.GET})
	public String register(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		try {
			
			
			String phone = request.getParameter("phone");
			String password = request.getParameter("password");
			String verifyCode = request.getParameter("verifyCode");
			//邀请码
			String inviteCode = request.getParameter("inviteCode");
			if(StringUtils.isEmptyNo(inviteCode)){
				inviteCode = (String)request.getSession().getAttribute(CommConstant.SESSION_INVITECODE);
			}	
			
			WeiXinUser weiXinUser = (WeiXinUser)request.getSession().getAttribute(CommConstant.SESSION_WX_USER);
			
			ConsoleUtil.println("/wpnv/rsregister --- > phone:" + phone + ",rsregister-weiXinUser:"+weiXinUser);
			
			Map<String, Object> map = userService.insertUser(phone,password,verifyCode,request.getRemoteAddr(),weiXinUser,inviteCode);
			Status status = (Status)map.get("status");
			if(status == Status.success){
				
				if(StringUtils.isNotEmpty(inviteCode)){
					request.getSession().removeAttribute(CommConstant.SESSION_INVITECODE);
				}
				
				User user = (User)map.get("user");
				request.getSession().setAttribute(CommConstant.SESSION_LOGIN_TYPE, OperateConstant.LOGIN_PHONE);
				
				String openid = (String)request.getSession().getAttribute(CommConstant.SESSION_OPENID);
				
				String token = UserMananger.getInst().add(user.getUserId(), user.getUsername(), user.getPhone(),user.getNickname(),user.getSex(),user.getHeadImg(),user.getInviteCode(),user.getQrCode(),openid);
				request.getSession().setAttribute(CommConstant.SESSION_MANAGER, UserMananger.getInst().getUser(token));
				//cookie生命周期为12小时
				CookieHelper.addCookie(response, CommConstant.SESSION_APP_TOKEN, token, 12 * 60 *60);
				
				
				//注册成功自动为用户分配一个钱包
				//User user2=userService.selectByUsername(phone);
				Wallet wallet=new Wallet();
				wallet.setUserId(user.getUserId());
				wallet.setMoney(BigDecimal.ZERO);
				//默认初四密码为123456
				String payPassword="123456";
				wallet.setPayPassword(MD5.GetMD5Code(MD5.GetMD5Code(payPassword)+ LoginConstants.LOGIN_PASSWORD_PARAM));
				wallet.setStatus(BalanceConstant.B_STATUS_NORMAL);
				walletService.insert(wallet);	
				
				
				
				
				//0代表登录成功
				return "redirect:/wpnv/ixhome";
				
//				request.setAttribute("messageCode", Status.success.getCode());
//				request.setAttribute("message", "注册成功");
			}else{
				
				this.notifyMsg(request, status);
				return "user/register";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("用户注册 出错",e);
		}
		return "user/login";
	}
	

}
