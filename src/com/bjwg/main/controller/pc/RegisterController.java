package com.bjwg.main.controller.pc;

import java.math.BigDecimal;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.constant.BalanceConstant;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.LoginConstants;
import com.bjwg.main.constant.OperateConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.User;
import com.bjwg.main.model.Wallet;
import com.bjwg.main.security.UserMananger;
import com.bjwg.main.service.CommonService;
import com.bjwg.main.service.UserService;
import com.bjwg.main.service.WalletService;
import com.bjwg.main.util.CookieHelper;
import com.bjwg.main.util.JsonUtils;
import com.bjwg.main.util.MD5;

/**
 * @author Carter
 * @version 创建时间：Sep 14, 2015 2:35:37 PM
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Controller("pc_register_controller")
@Scope("prototype")
public class RegisterController extends BaseController {

	@Autowired
	UserService userService;
	
	@Autowired
	CommonService commonService;
	@Autowired
	WalletService walletService;
	
	
	@RequestMapping(value="/pc/pnv/regPage",method = {RequestMethod.POST,RequestMethod.GET})
	public String regPage() throws Exception {
		//用户协议
		request.setAttribute("protocol", commonService.selectProtocol("BJWG_SERVICE_PROTOCOL.TYPE.USER"));
		return "/pc/register";
	}
	
	@RequestMapping(value="/pc/pnv/register",method = {RequestMethod.POST} ,produces = "application/json;charset=utf-8")
	@ResponseBody
	public String register() throws Exception{
		JSONObject jsonObject = new JSONObject();
		try {
			
			String phone = request.getParameter("phone");
			String password = request.getParameter("password");
			String verifyCode = request.getParameter("verifyCode");
			//邀请码
			String inviteCode = (String)request.getSession().getAttribute(CommConstant.SESSION_INVITECODE);
			
			
			Map<String, Object> map = userService.insertUser(phone,password,verifyCode,request.getRemoteAddr(),null,inviteCode);
			Status status = (Status)map.get("status");
			if(status == Status.success){
				
				User user = (User)map.get("user");
				request.getSession().setAttribute(CommConstant.SESSION_LOGIN_TYPE, OperateConstant.LOGIN_PHONE);
				
				String token = UserMananger.getInst().add(user.getUserId(), user.getUsername(), user.getPhone(),user.getNickname(),user.getSex(),user.getHeadImg(),user.getInviteCode(),user.getQrCode(),null);
				request.getSession().setAttribute(CommConstant.SESSION_MANAGER, UserMananger.getInst().getUser(token));
				//cookie生命周期为12小时
				CookieHelper.addCookie(response, CommConstant.SESSION_APP_TOKEN, token, 12 * 60 *60);
				
				request.setAttribute("messageCode", Status.success.getCode());
			request.setAttribute("message", "注册成功");
				
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
			
			}/*else{
				
				this.notifyMsg(request, status);
				return "user/register";
			}*/
			jsonObject = JsonUtils.getJsonObject(status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("用户注册 出错",e);
		}
		return jsonObject.toString();
	}
	
	
	
}

