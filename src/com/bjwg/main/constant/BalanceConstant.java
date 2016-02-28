package com.bjwg.main.constant;
/**
 * 钱包常量
 * @author Allen
 * @version 创建时间：2015-6-11 下午03:06:09
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class BalanceConstant {

	/**
	 * 余额记录状态 - 正常
	 */
	public static short B_STATUS_NORMAL = 1;
	/**
	 * 余额记录状态 - 已锁定
	 */
	public static short B_STATUS_LOCK = 2;
	
	/**
	 * 余额变更类型 - 在线支付
	 */
	public static byte CHANGE_TYPE_PAY = 1;
	/**
	 * 余额变更类型 - 收入
	 */
	public static byte CHANGE_TYPE_GET = 2;
	/**
	 * 余额变更类型 - 提现
	 */
	public static byte CHANGE_TYPE_TRANSFER = 3;
	/**
	 * 余额变更类型 - 退款
	 */
	public static byte CHANGE_TYPE_BACK = 4;
	/**
	 * 余额变更类型 - 返现
	 */
	public static byte CHANGE_TYPE_BACK2 = 5;
	/**
	 * 余额变更类型 - 支出（后台修改）
	 */
	public static byte CHANGE_TYPE_OUT = 6;
	
	
	/**
	 * 提现记录状态 - 新增
	 */
	public static byte W_STATUS_NEW = 1;
	/**
	 * 提现记录状态 - 审核通过
	 */
	public static byte W_STATUS_PASS = 2;
	/**
	 * 提现记录状态 - 审核不通过
	 */
	public static byte W_STATUS_NOPASS = 3;
	
	
	

	/**
	 * json-支付密码输入错误次数key
	 */
	public static String PPW_ERROR_COUNT_KEY = "pw_incorrect_count";
	/**
	 * json-支付密码输入错误日期(以天为单位)key
	 */
	public static String PPW_ERROR_DATE_KEY = "pw_incorrect_date";
	
	
	/**
	 * 余额变更关联类型 - 1:抢购购买
	 */
	public static byte RELATION_TYPE_ORDER = 1;
	/**
	 * 余额变更关联类型 - 2:委托寄卖
	 */
	public static byte RELATION_TYPE_SALE = 2;
	/**
	 * 余额变更关联类型 - 3:提现
	 */
	public static byte RELATION_TYPE_TRANSFER = 3;
	/**
	 * 余额变更关联类型 - 4:收益
	 */
	public static byte RELATION_TYPE_REWARDS = 4;
}
