package com.bjwg.main.constant;
/**
 * 订单常量
 * @author Allen
 * @version 创建时间：2015-6-10 下午04:00:24
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class OrderConstant {

	
	
	/**
	 * 订单状态 - 取消
	 */
	public static byte ORDER_STATUS_0 = -1;
	/**
	 * 订单状态 - 新增，未付款
	 */
	public static byte ORDER_STATUS_1 = 1;
	/**
	 * 订单状态 - 付款中
	 */
	public static byte ORDER_STATUS_2 = 2;
	/**
	 * 订单状态 - 已付款
	 */
	public static byte ORDER_STATUS_3 = 3;
	/**
	 * 订单状态 - 已选择回报方式，待收货
	 */
	public static byte ORDER_STATUS_4 = 4;
	/**
	 * 订单状态 - 已确认收货
	 */
	public static byte ORDER_STATUS_5 = 5;
	
	
	/**
	 * 订单 是否前台显示 - Y - 1
	 */
	public static byte IS_FRONT_SHOW_Y = 1;
	/**
	 * 订单 是否前台显示 - N - 0
	 */
	public static byte IS_FRONT_SHOW_N = 0;
	
	
	
	
	/**
	 * 支付方式 - 支付宝支付
	 */
	public static byte PAY_TYPE_1 = 1;
	/**
	 * 支付方式 - 微信支付
	 */
	public static byte PAY_TYPE_2 = 2;
	/**
	 * 支付方式 - 账户余额支付
	 */
	public static byte PAY_TYPE_3 = 3;
	/**
	 * 支付方式 - 银联支付
	 */
	public static byte PAY_TYPE_4 = 4;
	
	/**
	 * 支付宝交易状态 - WAIT_BUYER_PAY - 交易创建，等待买家付款。
	 */
	public static String ALIPAY_TRADE_WAIT_BUYER_PAY = "WAIT_BUYER_PAY";
	/**
	 * 支付宝交易状态 - TRADE_CLOSED z 在指定时间段内未支付时关闭的交易；z 在交易完成全额退款成功时关闭的交易。
	 */
	public static String ALIPAY_TRADE_TRADE_CLOSED = "TRADE_CLOSED";
	/**
	 * 支付宝交易状态 - TRADE_SUCCESS -交易成功，且可对该交易做操作，如：多级分润、退款等。
	 */
	public static String ALIPAY_TRADE_TRADE_SUCCESS = "TRADE_SUCCESS";
	/**
	 * 支付宝交易状态 - TRADE_PENDING - 等待卖家收款（买家付款后，如果卖家账号被冻结）。
	 */
	public static String ALIPAY_TRADE_TRADE_PENDING = "TRADE_PENDING";
	/**
	 * 支付宝交易状态 - TRADE_FINISHED - 交易成功且结束，即不可再做任何操作
	 */
	public static String ALIPAY_TRADE_TRADE_FINISHED = "TRADE_FINISHED";
	
	
	/**
	 * 订单类型 1 - 抢购
	 */
	public static byte ORDER_TYPE_1 = 1;
	/**
	 * 订单类型 2 - 屠宰配送
	 */
	public static byte ORDER_TYPE_2 = 2;
	/**
	 * 订单类型 3 - 领活猪
	 */
	public static byte ORDER_TYPE_3 = 3;
	/**
	 * 订单处理状态 - 0 未处理
	 */
	public static byte ORDER_DEAL_STATUS_0 = 0;
	/**
	 * 订单处理状态 - 1 已处理
	 */
	public static byte ORDER_DEAL_STATUS_1 = 1;
	
	
	/**
	 * 回报方式 - 1:委托寄卖
	 */
	public static byte REWARDS_1 = 1;
	/**
	 * 回报方式 - 2:屠宰配送
	 */
	public static byte REWARDS_2 = 2;
	/**
	 * 回报方式 - 3:领取活猪
	 */
	public static byte REWARDS_3 = 3;
	/**
	 * 回报方式 - 4:领取2300元／头的猪肉券
	 */
	public static byte REWARDS_4 = 4;
}
