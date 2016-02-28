package com.bjwg.main.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.VerifyPhone;

/**
 * @author chen
 * @version 创建时间：2015-4-15 下午06:30:21
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：手机验证码
 */

public interface VerifyPhoneService{
	
	/**
	 * 验证手机号的验证码是否有效
	 * @param verifyCode
	 * @param username
	 * @return
	 * @throws Exception
	 */
	Status validateCode(String verifyCode, String username,short type) throws Exception;

	/**
	 * 发送短信验证码
	 * @param phone
	 * @param parameter
	 * @throws Exception
	 */
	Map<String, Object> sendVerifyCode(String phone, String parameter) throws Exception;
	
	/**
	 * 修改绑定新手机号
	 * @param userId
	 * @param phone
	 * @param code
	 * @param password
	 * @param ip
	 * @param type
	 * @return
	 * @throws Exception
	 */
	public Status updateBindNewPhone(Long userId, String phone, String code,short type) throws Exception;
	
	/**
	 * 绑定手机号
	 * @param verifyPhone
	 * @return
	 * @throws Exception
	 
	String updateBind(Long userId, Long phone, String code,String password,String ip,short type,HttpServletRequest request) throws Exception;
	*/
	/**
	 * 
	 * @param long1
	 * @param userId
	 * @return
	 
	int findPhone(Long phone, Long userId,short type);
	
	boolean save(VerifyPhone entity) throws Exception;*/
	
	/**
	 * 验证手机号和发送的验证码
	 * @param request
	 * @param type
	 * @return
	 * @throws Exception
	 
	Status updateVerifyValidate(HttpServletRequest request, short type) throws Exception;*/
	

}
