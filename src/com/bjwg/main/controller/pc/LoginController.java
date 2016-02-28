package com.bjwg.main.controller.pc;

import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.OperateConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.User;
import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.security.UserMananger;
import com.bjwg.main.service.LoginService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.CookieHelper;
import com.bjwg.main.util.JsonUtils;
import com.bjwg.main.util.StringUtils;
import com.sun.org.apache.xpath.internal.operations.And;

/**
 * @author Carter
 * @version 创建时间：Sep 14, 2015 2:34:34 PM
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Controller("pc_login_controller")
@Scope("prototype")
public class LoginController extends BaseController {

	@Autowired
	LoginService loginService;
	
	/**
	 * 登录页
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pnv/loginPage",method = {RequestMethod.POST,RequestMethod.GET})
	public String loginPage() throws Exception {
		return "/pc/login";
	}
	
	
	/*//跳转抽奖
	
		@RequestMapping(value="/loginLottery",method = {RequestMethod.POST,RequestMethod.GET})
		public String loginLottery() throws Exception {
			return "/loginLottery";
		}*/
	
	
	
	
	
		@RequestMapping(value="/pc/pnv/login",method = {RequestMethod.POST},produces = "application/json; charset=utf-8")
		@ResponseBody
		public String login() throws Exception{
			JSONObject jsonObject = new JSONObject();
			try {
				String type = request.getParameter("type");
				Map<String, Object> map = null;
				Status status = null;
			
				if((OperateConstant.LOGIN_PHONE+"").equals(type)){
					
					String username = request.getParameter("phone");
					String password = request.getParameter("password");
					
					User user = new User();
					user.setPhone(username);
					user.setPassword(password);
					
					map = loginService.updateUserLogin(null, null, user,OperateConstant.LOGIN_PHONE, request.getRemoteAddr(), null);
				
				
				}
				
				else if((OperateConstant.LOGIN_EP+"").equals(type)){
					String username = request.getParameter("username");
					String password = request.getParameter("password");
					
					User user = new User();
					user.setUsername(username);
					user.setPassword(password);
				
					map = loginService.updateUserLogin(null, null, user,OperateConstant.LOGIN_EP, request.getRemoteAddr(), null);
				}
				
				
				
				
				
				
				
				/*else{
					
					return "user/login";
				}
				
				ConsoleUtil.println(map);*/
				status = (Status)map.get("status");
				System.out.println("status="+status);
				if(status == Status.success){
				
					User user = (User)map.get(CommConstant.SESSION_MANAGER);
					
					request.getSession().setAttribute("Userlottery", user);
					
				/**
				 * 判断是否企业用户	
				 */
					if(!"4".equals(type)){
			if(user.getFlag()==2){
				jsonObject = JsonUtils.getJsonObject(Status.ep);
				return jsonObject.toString();
			}
					}
					else{
						if(user.getFlag()==1){
							jsonObject = JsonUtils.getJsonObject(Status.ep2);
							return jsonObject.toString();
					}else{
					
					request.getSession().setAttribute("path", "pc/pv/epuser/farm");
					}
					
					}
					
					System.out.println("--------------------");
					request.getSession().setAttribute("user_id", user.getUserId());
					request.getSession().setAttribute("username", user.getUsername());
					
					request.getSession().setAttribute(CommConstant.SESSION_LOGIN_TYPE, type);
					String token = UserMananger.getInst().add(user.getUserId(), user.getUsername(), user.getPhone(),user.getNickname(),user.getSex(),user.getHeadImg(),user.getInviteCode(),user.getQrCode(),null);
					request.getSession().setAttribute(CommConstant.SESSION_MANAGER, UserMananger.getInst().getUser(token));
					request.getSession().setAttribute(CommConstant.SESSION_APP_TOKEN, token);
					String autoLogin = request.getParameter("autoLogin");
					if(autoLogin!= null && autoLogin.equals("1")){
						//cookie生命周期为100天
						CookieHelper.addCookie(response, CommConstant.SESSION_APP_TOKEN, token, 2400 * 60 *60);
					}
					//0代表登录成功
					//return "redirect:/wpnv/ixhome";
				}/*else{
					this.notifyMsg(request, status);
					return "user/login";
				}
				*/
				
			
				jsonObject = JsonUtils.getJsonObject(status);
			
			} catch (Exception e) {
				e.printStackTrace();
				logger.error("登录出错", e);
			}
		
			return jsonObject.toString();
		}
	
	/**
	 * 忘记密码页
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pnv/forgetPwd",method = {RequestMethod.POST,RequestMethod.GET})
	public String forgetPwd() throws Exception {
		return "/pc/forgetPwd";
	}
	
	/**
	 * 忘记密码保存
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pnv/forgetPwdSave",method = {RequestMethod.POST,RequestMethod.GET},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String savePassword() throws Exception{
		
		String phone = request.getParameter("phone");
		String password = request.getParameter("password");
		String verifyCode = request.getParameter("verifyCode");
		
		Status status = loginService.savePassword(phone,password,verifyCode);
		
		this.putJsonStatus(status);
		
		return this.outputJson();
	}
	
	
	
	/**企业
	 * 忘记密码页
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pnv/epforgetPwd",method = {RequestMethod.POST,RequestMethod.GET})
	public String epforgetPwd() throws Exception {
		return "/pc/epforgetPwd";
	}
	
	
	
	
	
	/**
	 * 退出登录
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pnv/login_out",method = {RequestMethod.POST,RequestMethod.GET})
	public String logout() throws Exception{
		
		UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		
		Long userId = null != user ? user.getUserId() : null;
		
		ConsoleUtil.println("/wpnv/lglogout -- > user:"+user + " --> userId:"+userId);
		//清楚cookie和session
		request.getSession().removeAttribute("user_id");
		request.getSession().removeAttribute("username");
		request.getSession().removeAttribute("path");
		request.getSession().removeAttribute("Userlottery");
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
		
		return "redirect:/";
	}
	
}

