package com.bjwg.main.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.QQUser;
import com.bjwg.main.model.User;
import com.bjwg.main.model.WeiXinUser;

/**
 * @author chen
 * @version 创建时间：2015-4-2 下午04:55:08
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：用户
 */

public interface LoginService{

	
	/**
	 * 登录
	 * @param QQUser
	 * @param User
	 * @param WeiXinUser
	 * @param type 1 是qq 登录，2表示微信登录(没用到)，3表示账号登录
	 * @param verifyCode 验证码
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> updateUserLogin(QQUser qquser,WeiXinUser weiXinUser,User user,short type,String ip,String verifyCode) throws Exception;

	/**
	 * 找回密码_保存
	 * @param phone
	 * @param password
	 * @param verifyCode
	 * @return
	 * @throws Exception
	 */
	public Status savePassword(String phone,String password,String verifyCode) throws Exception;
	
	/**
	 * 手机app登录后需要查询的数据
	 * @param user
	 * @return
	 * @throws Exception
	 
	public JSONObject queryWhenAppAfterLogin(HttpServletRequest request,User user) throws Exception;
	*/

}
