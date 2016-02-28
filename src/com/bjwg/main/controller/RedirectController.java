package com.bjwg.main.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.RedirectConstant;
import com.bjwg.main.constant.SourceConstant;
import com.bjwg.main.model.User;
import com.bjwg.main.service.LoginService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.StringUtils;

/**
 * @author Allen
 * @version 创建时间：2015-6-10 下午07:57:57
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Controller
@RequestMapping("/redirect")
@Scope("prototype")
public class RedirectController {

	@Resource
	private LoginService loginService;
	/**
	 * 检测店铺或用户是否已认证
	 * @param request
	 * @param user_id
	 * @param page
	 * @param pagesize
	 * @param token
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(method = {RequestMethod.GET,RequestMethod.POST})
	public String commonRedirect(HttpServletRequest request) throws Exception
	{
		String redirectType = request.getParameter("redirectType");
		
		String redirect = "home";
			
		ConsoleUtil.println("redirectType:"+redirectType);
		
		if(StringUtils.isNotEmpty(redirectType)){
			switch (Short.valueOf(redirectType)) {
			case RedirectConstant.REDIRECT_LOGIN:
				
				redirect = "user/login";
				break;
			case 2:
				redirect = "redirect:pnv/login";
				break;
			case 3:
//				redirect = "login";
				break;
			case 4:
//				redirect = "user/binding";
				break;
			case 5:
				
				redirect = "user/set_password";
				break;
			case 6:
				
					
				redirect = "user/set_password";
				
				break;
			default:
				break;
			}
		}
		return redirect;
	}
	
}
