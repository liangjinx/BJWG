package com.bjwg.main.constant;
/**
 * 跳转常量
 * @author Allen
 * @version 创建时间：2015-6-10 下午07:59:43
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class RedirectConstant {

	/**
	 * 登录页面
	 */
	public final static String LOGIN = "10000";
	/**
	 * 我的猪仔数页面 my_piglets
	 */
	public final static String MY_PIGLETS = "10005";
	/**
	 * 抢购页面
	 */
	public final static String BUY = "20001";
	/**
	 * 提交屠宰订单页面
	 */
	public final static String SUBMIT_SLAUGHTER_ORDER = "30001";
	/**
	 * 我的好友页面
	 */
	public final static String MY_FREINDS = "40001";
	/**
	 * 个人设置页面
	 */
	public final static String MY_SETTING = "50001";
	/**
	 * 我的猪肉券详情页面
	 */
	public final static String MY_COUPON_DETAIL = "60001";
	

	
	
	
	
	
	/**
	 * 登录页面
	 */
	public final static short REDIRECT_LOGIN = 1;
	
	/**
	 * pc登录页
	 */
	public final static short REDIRECT_LOGIN_PC = 2;
	
	/**
	 * 用户资料修改-跳转1-修改用户名
	 */
	public static int USER_INFO_MODIFY_USERNAME = 1;
	/**
	 * 用户资料修改-跳转1-修改手机号
	 */
	public static int USER_INFO_MODIFY_PHONE = 2;
	
	
	/**
	 * 我的钱包相关页面跳转 - 设置密码成功后跳转 ：我的银行卡列表
	 */
	public static int MY_WALLET_RETURN_BANK_CARD_LIST = 1;
	/**
	 * 我的钱包相关页面跳转 - 设置密码成功后跳转 ：提现页面
	 */
	public static int MY_WALLET_RETURN_TAKE_CASH = 2;
	/**
	 * 我的钱包相关页面跳转 - 提现输入支付密码成功后跳转：我的钱包
	 */
	public static int MY_WALLET_RETURN_INIT = 4;
	/**
	 * 我的钱包相关页面跳转 - 修改支付密码后跳转：我的钱包页面
	 */
	public static int MY_WALLET_RETURN_INIT2 = 5;
}
