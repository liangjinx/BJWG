package com.bjwg.main.constant;
/**
 * 验证码类型常量
 * @author Allen
 * @version 创建时间：2015-6-2 下午05:21:33
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class VerifyCodeConstant {

	/**
	 * 类型-绑定手机号发送的验证码
	 */
	public final static short VERIFY_CODE_BINDING = 1;
	
	/**
	 * 类型-注册发送的验证码
	 */
	public final static short VERIFY_CODE_REGISTER = 2;
	/**
	 * 类型-找回密码发送的验证码
	 */
	public final static short VERIFY_CODE_PASSWORD = 3;
	/**
	 * 类型-更换手机号发送的确认旧手机的验证码
	 */
	public final static short VERIFY_CODE_PHONECHANGE_OLD = 4;
	/**
	 * 类型-更换新手机号发送的验证码
	 */
	public final static short VERIFY_CODE_PHONECHANGE_NEW = 5;
	/**
	 * 类型-解除绑定手机号
	 */
	public final static short VERIFY_CODE_UNBINDING = 6;
}
