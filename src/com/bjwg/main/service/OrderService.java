package com.bjwg.main.service;

import java.util.Map;

import net.sf.json.JSONObject;

import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.Order;
import com.bjwg.main.model.OrderAddress;
import com.bjwg.main.model.OrderExtFee;

public interface OrderService {

	/**
	 * 根据订单id查询订单
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	Order selectByPrimaryKey(Long orderId) throws Exception;
	

	/**
	 * 提交订单
	 * @param userId
	 * @param projectId
	 * @param purchaseNum
	 * @param remark
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> insert(Long userId, String projectId, String purchaseNum,String remark) throws Exception;

	/**
	 * 根据订单id查询订单
	 * @param orderIdStr
	 * @return
	 * @throws Exception
	 */
	Order queryByOrderId(String orderIdStr) throws Exception;

	/**
	 * 余额支付
	 * @param orderIdStr
	 * @param userId
	 * @param payPassword
	 * @return
	 * @throws Exception
	 */
	Status updateOrderPayed(String orderIdStr, Long userId, String payPassword) throws Exception;

	/**
	 * 检测支付宝支付结果数据是否符合本地订单支付
	 * @param out_trade_no 商户订单号 - 对应订单编号
	 * @param trade_no - 支付宝交易号（唯一）
	 * @param trade_status
	 * @return
	 * @throws Exception
	 */
	public Status updateOrderAlipay(String out_trade_no, String trade_no, JSONObject jsonObject) throws Exception;
	
	/**
	 * 中断支付宝支付请求
	 * @param orderId
	 * @param userId
	 * @throws Exception
	 */
	public Order updateOrderBreakAlipayPay(Long orderId, Long userId) throws Exception;
	
	
	/**
	 * 检测微信支付结果数据是否符合本地订单支付
	 * @param out_trade_no 商户订单号 - 对应订单编号
	 * @param trade_no - 交易号（唯一）
	 * @param paramsMap
	 * @return
	 * @throws Exception
	 */
	public Status updateOrderWx(String out_trade_no, String trade_no, Map<String, String> paramsMap) throws Exception;
	
	
	public int updateByPrimaryKeySelective(Order record) throws Exception;


	/**
	 * 查询我的订单
	 * @param userId
	 * @param queryStatus
	 * @param pages
	 * @param isPage 是否分页查询
	 * @return
	 */
	public Pages<Order> queryPage(Long userId, byte queryStatus,Pages<Order> pages,boolean isPage) throws Exception;

	/**
	 * 取消订单
	 * @param userId
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> updateOrderCancel(Long userId, Long orderId) throws Exception;
	
	/**
	 * 删除用户订单
	 * @param userId
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public Status updateOrderDelete(Long userId,Long orderId) throws Exception;
	/**
	 * 确认收货
	 * @param userId
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public Status updateOrderConfirmReceive(Long userId,Long orderId) throws Exception;
	
	/**
	 * 中断微信支付
	 * @param orderId
	 * @param userId
	 * @return 
	 * @throws Exception
	 */
	Order updateOrderBreakWxPay(Long orderId, Long userId) throws Exception;


	/**
	 * 屠宰配送生成订单
	 * @param userId
	 * @param queryProjectId
	 * @param divisionType
	 * @param divisionTypeDetail
	 * @param packageSpec
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> insertSlaughterOrder(Long userId, String queryProjectId,
			String divisionType, String divisionTypeDetail, String packageSpec,String addressId) throws Exception;


	/**
	 * 领活猪生成订单
	 * @param userId
	 * @param queryProjectId
	 * @param addressId
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> insertPigOrder(Long userId, String queryProjectId,String addressId) throws Exception;
	
	/**
	 * 测试支付入口
	 * @return
	 * @throws Exception
	 */
	public Status testPay(String orderIdStr,Long userId) throws Exception;
	
	/**
	 * 查询订单的额外费用信息
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public OrderExtFee selectOrderExtFee(Long orderId) throws Exception;


	/**
	 * 银联支付
	 * @param out_trade_no
	 * @param trade_no
	 * @param jsonObject
	 * @return
	 * @throws Exception
	 */
	Status updateOrderUnionpay(String out_trade_no, String trade_no, JSONObject jsonObject) throws Exception;


	/**
	 * 查询订单的收货地址
	 * @param orderId
	 * @return
	 */
	OrderAddress queryOrderAddress(Long orderId);


	Order selectByPrimaryKey(Long userId, Long orderId) throws Exception;
	
	
}
