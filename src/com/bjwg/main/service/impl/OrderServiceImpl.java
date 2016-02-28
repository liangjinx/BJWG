package com.bjwg.main.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.BalanceConstant;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.DictConstant;
import com.bjwg.main.constant.MessageConstant;
import com.bjwg.main.constant.OrderConstant;
import com.bjwg.main.constant.TypeConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.constant.SysConstant;
import com.bjwg.main.dao.OrderAddressDao;
import com.bjwg.main.dao.OrderDao;
import com.bjwg.main.dao.OrderExtFeeDao;
import com.bjwg.main.dao.PayDao;
import com.bjwg.main.model.DictDetail;
import com.bjwg.main.model.MyEarnings;
import com.bjwg.main.model.MyEarningsExample;
import com.bjwg.main.model.Order;
import com.bjwg.main.model.OrderAddress;
import com.bjwg.main.model.OrderExample;
import com.bjwg.main.model.OrderExtFee;
import com.bjwg.main.model.PanicbuyProject;
import com.bjwg.main.model.Pay;
import com.bjwg.main.model.SysConfig;
import com.bjwg.main.model.UserAddress;
import com.bjwg.main.model.Wallet;
import com.bjwg.main.model.WalletExample;
import com.bjwg.main.service.DictService;
import com.bjwg.main.service.MessageService;
import com.bjwg.main.service.MyEarningsService;
import com.bjwg.main.service.OrderService;
import com.bjwg.main.service.PanicbuyProjectService;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.service.UserService;
import com.bjwg.main.service.WalletService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.RandomUtils;
import com.bjwg.main.util.StringUtils;
import com.bjwg.main.util.ToolKit;
import com.bjwg.main.util.ValidateUtil;

@Service
public class OrderServiceImpl implements OrderService {

	@Resource
	private OrderDao orderDao;
	@Resource
	private SysConfigService sysConfigService;
	@Resource
	private DictService dictService;
	@Resource
	private MyEarningsService myEarningsService;
	@Resource
	private WalletService walletService;
	@Resource
	private PanicbuyProjectService panicbuyProjectService;
	@Resource
	private UserService userService;
	@Resource
	private PayDao payDao;
	@Resource
	private MessageService messageService;
	@Resource
	private OrderExtFeeDao orderExtFeeDao;
	@Resource
	private OrderAddressDao orderAddressDao;
	
	
	
	/**
	 * 提交订单
	 * @param userId
	 * @param projectId
	 * @param purchaseNum
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> insert(Long userId, String projectId, String purchaseNum,String remark) throws Exception{
		
		try {
			Map<String, Object> dataMap = new HashMap<String, Object>();
			
			Status status = Status.success;
			
			if(null == userId){
				
				status = Status.useridNullity;
				dataMap.put("status", status);
				return dataMap;
			}
			if(!ValidateUtil.validateInteger(projectId, false, 0, null)){
				
				status = Status.projectidNullity;
				dataMap.put("status", status);
				return dataMap;
			}
			if(!ValidateUtil.validateInteger(purchaseNum, false, 0, 9999)){
				
				status = Status.purchaseNumNullity;
				dataMap.put("status", status);
				return dataMap;
			}
			if(!ValidateUtil.validateString(remark, true, 0, 200)){
				
				status = Status.remarkNullity;
				dataMap.put("status", status);
				return dataMap;
			}
			
			//1.检测是否还有数量，是否过期
			PanicbuyProject project = panicbuyProjectService.selectCurrent(Long.valueOf(projectId));
			
			if(null == project){
				status = Status.dataNotExists;
				dataMap.put("status", status);
				return dataMap;
			}
			
			if(project.getLeftNum() == 0){
				status = Status.saleOverNullity;
				dataMap.put("status", status);
				return dataMap;
			}
			Short num = Short.valueOf(purchaseNum);
			if(project.getLeftNum().shortValue() < num){
				status = Status.saleNumNotEnough;
				dataMap.put("status", status);
				dataMap.put("leftNum", project.getLeftNum());
				return dataMap;
			}
			
			//查询是否已有选择屠宰配送和领活猪的订单，因为订单中有数量和费用信息了，所以不能让客户再抢购。必须先取消掉订单
			OrderExample example = new OrderExample();
			OrderExample.Criteria criteria = example.createCriteria();
			
			criteria.andUserIdEqualTo(userId);
			criteria.andTypeIn(new ArrayList<Byte>(Arrays.asList(OrderConstant.ORDER_TYPE_2,OrderConstant.ORDER_TYPE_3)));
			criteria.andStatusNotEqualTo(OrderConstant.ORDER_STATUS_0);
			criteria.andRelationIdEqualTo(Long.valueOf(projectId));
			
			if(orderDao.countByExample(example) > 0){
				
				dataMap.put("status", Status.cannotBuyPleaseCancelOrder);
				return dataMap;
			}
			
			//配置 支付超时时间
			String overLimitHour = sysConfigService.queryOneValue(SysConstant.ORDER_PAY_OVER_LIMIT_HOURS);
			
			Order order = new Order();
			order.setCtime(new Date());
			order.setNum(num);
			order.setOrderCode(RandomUtils.getOrderCode());
			if(StringUtils.isNotEmpty(overLimitHour)){
				//支付截止时间
				order.setOverTime(MyUtils.addDate2(order.getCtime(), Integer.valueOf(overLimitHour)));
			}
			//单价
			order.setPrice(project.getPrice().add(project.getOtherFee()));
			order.setProductImg(project.getImgs());
			order.setProductName(project.getName());
			order.setRelationId(project.getPaincbuyProjectId());
			order.setRelationName(project.getName());
			order.setRemark(remark);
			order.setStatus(OrderConstant.ORDER_STATUS_1);
			order.setTotalMoney(order.getPrice().multiply(new BigDecimal(order.getNum())));
			//抢购
			order.setType(OrderConstant.ORDER_TYPE_1);
			order.setUserId(userId);
			order.setSubOrderId(-1l);
			
			orderDao.insert(order);
			
			//减去抢购的数量
			panicbuyProjectService.updatePanicutBuyLeftNum(Long.valueOf(projectId), (short)-num);
			
			dataMap.put("order", order);
			dataMap.put("status", Status.success);
			
			return dataMap;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	
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
	public Map<String, Object> insertSlaughterOrder(Long userId, String queryProjectId,
			String divisionType, String divisionTypeDetail, String packageSpec,String addressId) throws Exception{
	
		try {
			
			Map<String, Object> map = myEarningsService.saveRepayType(userId, OrderConstant.REWARDS_2+"", queryProjectId, divisionType, divisionTypeDetail, packageSpec);
			
			Status status = (Status)map.get("status");
			
			if(Status.success != status){
				
				return map;
			}
			
			if(!ValidateUtil.validateInteger(addressId, false, 0, null)){
				
				map.put("status", Status.addressIdNullity);
				return map;
			}
			
			//查询收货地址
			UserAddress userAddress = userService.getAddressId(Long.valueOf(addressId));
			
			if(null == userAddress){
				
				map.put("status", Status.addressNotExist);
				return map;
			}
//			dataMap.put("singleDivisionMoney", singleDivisionMoney);
//			dataMap.put("singlePackageMoney", singlePackageMoney);
//			dataMap.put("singleSendMoney", singleSendMoney);
//			dataMap.put("singleTotalMoney", singleTotalMoney);
//			dataMap.put("divisionMoney", singleDivisionMoney.multiply(BigDecimal.valueOf(totalNum)));
//			dataMap.put("packageMoney", singlePackageMoney.multiply(BigDecimal.valueOf(totalNum)));
//			dataMap.put("sendMoney", singleSendMoney.multiply(BigDecimal.valueOf(totalNum)));
//			dataMap.put("totalMoney", totalMoney);
			
			//已经有一个未取消的屠宰和领活猪的订单就不能再生成了
			OrderExample example = new OrderExample();
			OrderExample.Criteria criteria = example.createCriteria();
			criteria.andRelationIdEqualTo(Long.valueOf(queryProjectId));
			criteria.andStatusNotEqualTo(OrderConstant.ORDER_STATUS_0);
			criteria.andTypeIn(new ArrayList<Byte>(Arrays.asList(OrderConstant.ORDER_TYPE_2,OrderConstant.ORDER_TYPE_3)));
			criteria.andUserIdEqualTo(userId);
			if(orderDao.countByExample(example) > 0){
				
				map.put("status", Status.cannotModifyRepayTypeBeforeCancelOrder);
				return map;
			}
			
			
			Date date = new Date();
			Order order = new Order();
//			order.setConfirmTime(confirmTime);
//			order.setPayTime();
//			order.setPayType();
			MyEarnings myEarnings = (MyEarnings)map.get("myEarnings");
			order.setCtime(date);
			order.setDays(Long.valueOf(myEarnings.getDays().toString()));
			order.setIsShow(OrderConstant.IS_FRONT_SHOW_Y);
			order.setNum((short)(myEarnings.getNum()- myEarnings.getPresentNum()));
			order.setOrderCode(RandomUtils.getOrderCode());
			BigDecimal price = (BigDecimal)map.get("singleTotalMoney");
			order.setPrice(price);
			PanicbuyProject project = panicbuyProjectService.selectByPrimaryKey(myEarnings.getPaincbuyProjectId());
			order.setProductImg(project.getImgs());
			order.setProductName(project.getName());
			order.setRelationId(myEarnings.getPaincbuyProjectId());
			order.setRelationName(myEarnings.getPaincbuyProjectName());
			order.setStatus(OrderConstant.ORDER_STATUS_1);
			order.setSubOrderId(-1l);
			order.setTotalMoney(price.multiply(BigDecimal.valueOf(order.getNum())));
			order.setType(OrderConstant.ORDER_TYPE_2);
			order.setUserId(userId);
			order.setRemark("选择屠宰配送自动生成订单");
			
			String nDays = (String)map.get("nDays");
			Date overTime = myEarnings.getEndTime();
			if(StringUtils.isNotEmpty(nDays)){
				
				overTime = MyUtils.dateFormat(MyUtils.addDate3(myEarnings.getEndTime(), -Integer.valueOf(nDays)) + " 00:00:00" ,0);
			}
			//支付截止时间(算到145天截止，146天没有支付则自动变成回报方式1-委托寄卖)
			order.setOverTime(overTime);
			
			orderDao.insert(order);
			
			OrderExtFee extFee = new OrderExtFee();
			extFee.setDivisionFee((BigDecimal)map.get("singleDivisionMoney"));
			extFee.setDivisionMode(StringUtils.isNotEmpty(divisionTypeDetail) ? Byte.valueOf(divisionTypeDetail) : 0);
			extFee.setDivisionType(new Byte(map.get("divisionTypeByte").toString()));
			extFee.setNum((int)order.getNum());
			extFee.setOrderId(order.getOrderId());
			extFee.setPackageFee((BigDecimal)map.get("singlePackageMoney"));
			extFee.setPackageNum((Integer)map.get("packageNum"));
			extFee.setPayMoney((BigDecimal)map.get("totalMoney"));
			extFee.setSlaughterFee((BigDecimal)map.get("singleSendMoney"));
			BigDecimal spec = (BigDecimal)map.get("packageSpec");
			extFee.setSpec(spec != null ? spec.intValue() : null);
			extFee.setWeight((BigDecimal)map.get("perWeight"));
//			extFee.setRemark();
			
			
			OrderAddress orderAddress = new OrderAddress();
			orderAddress.setAddress(userAddress.getAddress());
			orderAddress.setCity(userAddress.getCity());
			orderAddress.setLinkMan(userAddress.getContactMan());
			orderAddress.setLinkPhone(userAddress.getContactPhone());
			orderAddress.setOrderId(order.getOrderId());
			orderAddress.setProvince(userAddress.getProvince());
			orderAddress.setUserId(userId);
//			orderAddress.setRemark();
			
			orderExtFeeDao.insert(extFee);
			
			orderAddressDao.insert(orderAddress);
			
			MyEarnings updateEarnings = new MyEarnings();
			updateEarnings.setEarningsId(myEarnings.getEarningsId());
			updateEarnings.setDealType(OrderConstant.REWARDS_2);
			updateEarnings.setDealTime(date);
			updateEarnings.setBeforeDealType(myEarnings.getBeforeDealType());
			
			myEarningsService.updateByPrimaryKeySelective(updateEarnings);
			
			map.put("order", order);
			map.put("orderExtFee", extFee);
			map.put("orderAddress", orderAddress);
			map.put("status", Status.success);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	
	/**
	 * 领活猪生成订单
	 * @param userId
	 * @param queryProjectId
	 * @param addressId
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> insertPigOrder(Long userId, String queryProjectId,String addressId) throws Exception{
		
		try {
			
			Map<String, Object> map = myEarningsService.saveRepayType(userId, OrderConstant.REWARDS_3+"", queryProjectId, null, null, null);
			
			Status status = (Status)map.get("status");
			
			if(Status.success != status){
				
				return map;
			}
			
			if(!ValidateUtil.validateInteger(addressId, false, 0, null)){
				
				map.put("status", Status.addressIdNullity);
				return map;
			}
			
			//查询收货地址
			UserAddress userAddress = userService.getAddressId(Long.valueOf(addressId));
			
			if(null == userAddress){
				
				map.put("status", Status.addressNotExist);
				return map;
			}
			
			//已经有一个未取消的屠宰和领活猪的订单就不能再生成了
			OrderExample example = new OrderExample();
			OrderExample.Criteria criteria = example.createCriteria();
			criteria.andRelationIdEqualTo(Long.valueOf(queryProjectId));
			criteria.andStatusNotEqualTo(OrderConstant.ORDER_STATUS_0);
			criteria.andUserIdEqualTo(userId);
			criteria.andTypeIn(new ArrayList<Byte>(Arrays.asList(OrderConstant.ORDER_TYPE_2,OrderConstant.ORDER_TYPE_3)));
			if(orderDao.countByExample(example) > 0){
				
				map.put("status", Status.cannotModifyRepayTypeBeforeCancelOrder);
				return map;
			}
			
			Date date = new Date();
			Order order = new Order();
//			order.setConfirmTime(confirmTime);
//			order.setPayTime();
//			order.setPayType();
			MyEarnings myEarnings = (MyEarnings)map.get("myEarnings");
			order.setCtime(date);
			order.setDays(Long.valueOf(myEarnings.getDays().toString()));
			order.setIsShow(OrderConstant.IS_FRONT_SHOW_Y);
			order.setNum((short)(myEarnings.getNum() - myEarnings.getPresentNum()));
			order.setOrderCode(RandomUtils.getOrderCode());
			BigDecimal price = myEarnings.getMoney();
			order.setPrice(price);
			PanicbuyProject project = panicbuyProjectService.selectByPrimaryKey(myEarnings.getPaincbuyProjectId());
			order.setProductImg(project.getImgs());
			order.setProductName(project.getName());
			order.setRelationId(myEarnings.getPaincbuyProjectId());
			order.setRelationName(myEarnings.getPaincbuyProjectName());
			order.setStatus(OrderConstant.ORDER_STATUS_4);
			order.setSubOrderId(-1l);
			order.setTotalMoney(price.multiply(BigDecimal.valueOf(order.getNum())));
			order.setType(OrderConstant.ORDER_TYPE_3);
			order.setUserId(userId);
			order.setRemark("选择领活猪自动生成订单");
			
			String nDays = (String)map.get("nDays");
			Date overTime = myEarnings.getEndTime();
			if(StringUtils.isNotEmpty(nDays)){
				
				overTime = MyUtils.dateFormat(MyUtils.addDate3(myEarnings.getEndTime(), -Integer.valueOf(nDays)) + " 00:00:00" ,0);
			}
			//支付截止时间(算到145天截止，146天没有支付则自动变成回报方式1-委托寄卖)
			order.setOverTime(overTime);
			
			orderDao.insert(order);
			OrderAddress orderAddress = new OrderAddress();
			orderAddress.setAddress(userAddress.getAddress());
			orderAddress.setCity(userAddress.getCity());
			orderAddress.setLinkMan(userAddress.getContactMan());
			orderAddress.setLinkPhone(userAddress.getContactPhone());
			orderAddress.setOrderId(order.getOrderId());
			orderAddress.setProvince(userAddress.getProvince());
			orderAddress.setUserId(userId);
//			orderAddress.setRemark();
			
			orderAddressDao.insert(orderAddress);
			
			MyEarnings updateEarnings = new MyEarnings();
			updateEarnings.setEarningsId(myEarnings.getEarningsId());
			updateEarnings.setDealType(OrderConstant.REWARDS_3);
			updateEarnings.setDealTime(date);
			updateEarnings.setBeforeDealType(myEarnings.getBeforeDealType());
			
			myEarningsService.updateByPrimaryKeySelective(updateEarnings);
			
			map.put("order", order);
			map.put("orderAddress", orderAddress);
			map.put("status", Status.success);
			return map;
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
			
	/**
	 * 根据订单id查询订单
	 * @param orderIdStr
	 * @return
	 * @throws Exception
	 */
	public Order queryByOrderId(String orderIdStr) throws Exception{
		
		if(!ValidateUtil.validateInteger(orderIdStr, false, 0, null)){
			
			return null;
		}
		
		return orderDao.selectByPrimaryKey(Long.valueOf(orderIdStr));
	}
	
	
	
	/**
	 * 支付订单(余额支付)
	 * @return
	 * @throws Exception
	 */
	public Status updateOrderPayed(String orderIdStr,Long userId,String payPassword) throws Exception{
		
		try {
			//订单id
			if(!ValidateUtil.validateInteger(orderIdStr, false, 1, null)){
				
				return Status.orderIdNullity;
			}
			//用户id
			if(null == userId || userId <= 0){
				
				return Status.login_first;
			}
			//支付密码
			if(!ValidateUtil.validateString(payPassword, false, 6, 6)){
				
				return Status.payPasswordNullity;
			}
			//查询订单信息，检测订单所属用户、状态、核对金额
			Order order = orderDao.selectByPrimaryKey(Long.valueOf(orderIdStr));
			
			if(order == null || order.getUserId().longValue() != userId.longValue()){
				
				return Status.orderNotExist;
			}
			//只有未付款的订单才能付款
			if(order.getStatus() != OrderConstant.ORDER_STATUS_1){
				
				return Status.orderCannotPay;
			}
			//支付超时
			if(order.getOverTime().before(new Date())){
				
				return Status.orderCannotPayOverTime;
			}
			//根据用户id和支付密码查询余额记录
			WalletExample example = new WalletExample();
			WalletExample.Criteria criteria = example.createCriteria();
			criteria.andUserIdEqualTo(userId);
			//查询余额记录
			List<Wallet> walletList = walletService.selectByExample(example);
			
			if(MyUtils.isListEmpty(walletList)){
				
				return Status.balanceNotExist;
			}
			Wallet wallet = walletList.get(0);
			
			if(StringUtils.isEmptyNo(wallet.getPayPassword())){
				
				return Status.payPasswordNotExist;
			}
			//检测用户输入的支付密码是否正确，若错误则更新错误次数，同一天错误的最大次数为BalanceConstant.PAY_PASSWORD_LIMIT_ERROR_COUNT
			Status status = walletService.updateWalletPWErrorCount(wallet.getJson(), payPassword, wallet.getPayPassword(), wallet.getWalletId());
			
			if(status != Status.success){
				
				return status;
			}
			
			//余额是否充足
			if(wallet.getMoney().doubleValue() < order.getTotalMoney().doubleValue()){
				
				return Status.moneyNotEnough;
			}
			
			BigDecimal leftMoney = wallet.getMoney().subtract(order.getTotalMoney());
			
			//生成余额变更记录
			walletService.insertWalletChange(wallet.getWalletId(), wallet.getMoney(), order.getTotalMoney(), leftMoney, 
					BalanceConstant.CHANGE_TYPE_PAY, userId, order.getOrderId(),BalanceConstant.RELATION_TYPE_ORDER);
			
			//更新余额记录
			Wallet updateBalance = new Wallet();
			updateBalance.setWalletId(wallet.getWalletId());
			updateBalance.setMoney(leftMoney);
			walletService.updateByPrimaryKeySelective(updateBalance);
			
			//更新订单状态
			Order updateOrder = new Order();
			updateOrder.setOrderId(order.getOrderId());
			updateOrder.setPayType(OrderConstant.PAY_TYPE_3);
			updateOrder.setStatus(OrderConstant.ORDER_STATUS_2);
			updateOrder.setPayTime(new Date());
			
			//抢购订单要插入或更新收益记录(我参与的项目记录)
			if(OrderConstant.ORDER_TYPE_1 == order.getType()){
				
				this.insertMyEarningsAfterPay(order.getUserId(), order.getRelationId(), order);
				
				//屠宰配送的订单
			}else if(OrderConstant.ORDER_TYPE_2 == order.getType()){
				
				this.updateMyEarningBySlaughter(order.getUserId(), order.getRelationId());
				
				updateOrder.setStatus(OrderConstant.ORDER_STATUS_4);
			}
			
			orderDao.updateByPrimaryKeySelective(updateOrder);
			
			messageService.insertMessage(order.getUserId(), "您的订单"+order.getOrderCode()+"使用余额支付成功", MessageConstant.SYS_MESSAGE_1, order.getOrderId(), MessageConstant.MSG_RELATION_ID_ORDER);
			
			
			return Status.success;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	/**
	 * 屠宰配送的订单支付后，更新我的收益记录，确定回报方式等信息
	 * @param userId
	 * @param relationId
	 * @param order
	 * @throws Exception
	 */
	private void updateMyEarningBySlaughter(Long userId, Long relationId) throws Exception{
		
		try {
			
			//插入我的收益（我参与的项目）记录
			MyEarningsExample earningsExample = new MyEarningsExample();
			MyEarningsExample.Criteria criteria2 = earningsExample.createCriteria();
			criteria2.andUserIdEqualTo(userId);
			criteria2.andPaincbuyProjectIdEqualTo(relationId);
			
			List<MyEarnings> myEarningsList = myEarningsService.selectByExample(earningsExample);
			
			MyEarnings myEarnings = myEarningsList.get(0);
			
			MyEarnings updateEarnings = new MyEarnings();
			updateEarnings.setDealStatus(CommConstant.DEAL_STATUS_1);
			updateEarnings.setDealTime(new Date());
			updateEarnings.setEarningsId(myEarnings.getEarningsId());
			
			myEarningsService.updateByPrimaryKeySelective(updateEarnings);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	/**
	 * 中断支付宝支付请求
	 * @param orderId
	 * @param userId
	 * @throws Exception
	 */
	public Order updateOrderBreakAlipayPay(Long orderId, Long userId) throws Exception{
		
		try {
			Order order = null;
			//查询订单信息
			if(orderId != null && orderId > 0){
				
				order = orderDao.selectByPrimaryKey(orderId);
					
				//支付宝付款中，修改成未支付
				if(order != null && order.getUserId().longValue() == userId && order.getStatus() == OrderConstant.ORDER_STATUS_2){
				
					Order order2 = new Order();
					order2.setStatus(OrderConstant.ORDER_STATUS_1);
					order2.setOrderId(orderId);
					orderDao.updateByPrimaryKeySelective(order2);
					
					ConsoleUtil.println(new Date() +"   updateOrderBreakAlipayPay --> order_id:"+order.getOrderId()+",user_id:"+order.getUserId()+",order_code:"+order.getOrderCode()+",order_status:"+order.getStatus());
				}
			}
			
			return order;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	/**
	 * 检测支付宝支付结果数据是否符合本地订单支付
	 * @param out_trade_no 商户订单号 - 对应订单编号
	 * @param trade_no - 支付宝交易号（唯一）
	 * @param trade_status
	 * @return
	 * @throws Exception
	 */
	public Status updateOrderAlipay(String out_trade_no, String trade_no, JSONObject jsonObject) throws Exception{
		
		try {
			OrderExample example = new OrderExample();
			OrderExample.Criteria criteria = example.createCriteria();
			criteria.andOrderCodeEqualTo(out_trade_no);
			//查询订单信息
			List<Order> orderList = orderDao.selectByExample(example);
			
			if(!MyUtils.isListEmpty(orderList)){
				
				
				//查询支付记录
				Pay pay = payDao.selectByPrimaryKey(trade_no);
				
				//没有支付记录则添加，无需判断支付状态，因为控制器控制了只能是支付成功了才会进入此方法
				if(pay == null){
					
					pay = new Pay();
					pay.setTradeNo(trade_no);
					pay.setBuyer(jsonObject.optString("buyer_email"));
					pay.setGmtCreateTime(MyUtils.dateFormat(jsonObject.optString("gmt_create"), 0));
					pay.setGmtPayTime(MyUtils.dateFormat(jsonObject.optString("gmt_payment"), 0));
					pay.setOrderCode(out_trade_no);
					pay.setPayType(OrderConstant.PAY_TYPE_1);
					pay.setSeller(jsonObject.optString("seller_id"));
					pay.setSourceData(jsonObject.toString());
					pay.setTotalMoney(new BigDecimal(jsonObject.optString("total_fee")));
					pay.setTradeStatus(jsonObject.optString("trade_status"));
					
					//添加支付记录
					payDao.insert(pay);
				}
				
				Order order = orderList.get(0);
				
				ConsoleUtil.println(new Date() +"   updateOrderAlipay --> order_id:"+order.getOrderId()+",user_id:"+order.getUserId()+",order_code:"+order.getOrderCode()+",order_status:"+order.getStatus());
				//付款中状态
				if(order.getStatus() == OrderConstant.ORDER_STATUS_2 || order.getStatus() == OrderConstant.ORDER_STATUS_1){
						
					//修改订单状态
					Order updateOrder = new Order();
					updateOrder.setOrderId(order.getOrderId());
					updateOrder.setStatus(OrderConstant.ORDER_STATUS_3);
					updateOrder.setPayType(OrderConstant.PAY_TYPE_1);
					updateOrder.setPayTime(new Date());
					
					ConsoleUtil.println("ordertype:"+order.getType());
					//抢购订单要插入或更新收益记录(我参与的项目记录)
					if(OrderConstant.ORDER_TYPE_1 == order.getType()){
						
						ConsoleUtil.println("ordertype1:true");
						
						this.insertMyEarningsAfterPay(order.getUserId(), order.getRelationId(), order);
					
						//屠宰配送的订单
					}else if(OrderConstant.ORDER_TYPE_2 == order.getType()){
						
						ConsoleUtil.println("ordertype2:true");
						
						this.updateMyEarningBySlaughter(order.getUserId(), order.getRelationId());
						
						updateOrder.setStatus(OrderConstant.ORDER_STATUS_4);
					}
					
					orderDao.updateByPrimaryKeySelective(updateOrder);
					
					messageService.insertMessage(order.getUserId(), "您的订单"+order.getOrderCode()+"使用支付宝支付成功，支付宝交易号为："+trade_no, MessageConstant.SYS_MESSAGE_1, order.getOrderId(), MessageConstant.MSG_RELATION_ID_ORDER);
					
					return Status.success;
				}
				
				return Status.dataNotExists;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return Status.serverError;
	}
	
	/**
	 * 银联支付
	 * @param out_trade_no 订单编号
	 * @param trade_no 银联流水号
	 * @param jsonObject
	 * @return
	 * @throws Exception
	 */
	@Override
	public Status updateOrderUnionpay(String out_trade_no, String trade_no, JSONObject jsonObject) throws Exception{
		try {
			OrderExample example = new OrderExample();
			OrderExample.Criteria criteria = example.createCriteria();
			criteria.andOrderCodeEqualTo(out_trade_no);
			//查询订单信息
			List<Order> orderList = orderDao.selectByExample(example);
			
			if(!MyUtils.isListEmpty(orderList)){
				
				
				//查询支付记录
				Pay pay = payDao.selectByPrimaryKey(trade_no);
				
				//没有支付记录则添加，无需判断支付状态，因为控制器控制了只能是支付成功了才会进入此方法
				if(pay == null){
					
					pay = new Pay();
					pay.setTradeNo(trade_no);
					//银联回调数据没有类似字段
					pay.setBuyer("");
					pay.setGmtCreateTime(MyUtils.dateFormat(jsonObject.optString("TranDate") + jsonObject.optString("TranTime"), 4));
					pay.setGmtPayTime(MyUtils.dateFormat(jsonObject.optString("CompleteDate") + jsonObject.optString("CompleteTime"), 4));
					pay.setOrderCode(out_trade_no);
					pay.setPayType(OrderConstant.PAY_TYPE_4);
					pay.setSeller(jsonObject.optString("MerId"));
					pay.setSourceData(jsonObject.toString());
					pay.setTotalMoney(new BigDecimal(jsonObject.optString("OrderAmt")).divide(new BigDecimal(100)));
					pay.setTradeStatus(jsonObject.optString("OrderStatus"));
					
					//添加支付记录
					payDao.insert(pay);
				}
				
				Order order = orderList.get(0);
				
				
				//付款中状态
				if(order.getStatus() == OrderConstant.ORDER_STATUS_2 || order.getStatus() == OrderConstant.ORDER_STATUS_1){
						
					//修改订单状态
					Order updateOrder = new Order();
					updateOrder.setOrderId(order.getOrderId());
					updateOrder.setStatus(OrderConstant.ORDER_STATUS_3);
					updateOrder.setPayType(OrderConstant.PAY_TYPE_4);
					updateOrder.setPayTime(new Date());
					
					ConsoleUtil.println("ordertype:"+order.getType());
					//抢购订单要插入或更新收益记录(我参与的项目记录)
					if(OrderConstant.ORDER_TYPE_1 == order.getType()){
						
						ConsoleUtil.println("ordertype1:true");
						
						this.insertMyEarningsAfterPay(order.getUserId(), order.getRelationId(), order);
					
						//屠宰配送的订单
					}else if(OrderConstant.ORDER_TYPE_2 == order.getType()){
						
						ConsoleUtil.println("ordertype2:true");
						
						this.updateMyEarningBySlaughter(order.getUserId(), order.getRelationId());
						
						updateOrder.setStatus(OrderConstant.ORDER_STATUS_4);
					}
					
					orderDao.updateByPrimaryKeySelective(updateOrder);
					
					messageService.insertMessage(order.getUserId(), "您的订单"+order.getOrderCode()+"使用银联支付成功，银联交易号为："+trade_no, MessageConstant.SYS_MESSAGE_1, order.getOrderId(), MessageConstant.MSG_RELATION_ID_ORDER);
					
					return Status.success;
				}
				
				return Status.dataNotExists;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return Status.serverError;
	}
	
	
	/**
	 * 支付成功后插入我的收益（我参与的项目）记录
	 * @param userId
	 * @param projectId
	 * @param order
	 * @throws Exception
	 */
	private void insertMyEarningsAfterPay(Long userId ,Long projectId,Order order) throws Exception{
		
		try {
			
			//插入我的收益（我参与的项目）记录
			MyEarningsExample earningsExample = new MyEarningsExample();
			MyEarningsExample.Criteria criteria2 = earningsExample.createCriteria();
			criteria2.andUserIdEqualTo(userId);
			criteria2.andPaincbuyProjectIdEqualTo(projectId);
			
			List<MyEarnings> myEarningsList = myEarningsService.selectByExample(earningsExample);
			
			ConsoleUtil.println("myEarningsList size:"+myEarningsList);
			
			List<String> codeList = new ArrayList<String>(Arrays.asList(SysConstant.YEAR_RETURN_RATE,SysConstant.GROW_UP_DAYS));
			
			List<SysConfig> cfList = sysConfigService.queryList(codeList);
			
			Integer days = 0;
			BigDecimal rate = BigDecimal.ZERO;
			
			//两个配置项都有
			if(!MyUtils.isListEmpty(cfList) && cfList.size() == 2){
				
				for (SysConfig sconf : cfList) {
					
					if(SysConstant.GROW_UP_DAYS.equals(sconf.getCode())){
						
						days = Integer.valueOf(sconf.getValue());
						
					}else{
						
						rate = new BigDecimal(sconf.getValue());
					}
					
				}
			}
			BigDecimal expectEarning = BigDecimal.ZERO;
			//有多个订单同一期则进行叠加
			if(!MyUtils.isListEmpty(myEarningsList)){
				
				ConsoleUtil.println("myEarningsList update:"+myEarningsList);
				
				MyEarnings myEarnings = myEarningsList.get(0);
				
				//预期收益 = 总成本 * 年收益率 * 时间 /360天 
				expectEarning = myEarnings.getExpectEarning().add(
													myEarnings.getMoney().multiply(BigDecimal.valueOf(order.getNum())).multiply(myEarnings.getRate().divide(BigDecimal.valueOf(100)))
													.multiply(BigDecimal.valueOf(myEarnings.getDays())).divide(BigDecimal.valueOf(360),4,BigDecimal.ROUND_HALF_UP));
				//累加数量，预期收益
				MyEarnings updateEarnings = new MyEarnings();
				updateEarnings.setNum(myEarnings.getNum()+order.getNum());
				updateEarnings.setExpectEarning(expectEarning);
				updateEarnings.setEarningsId(myEarnings.getEarningsId());
				
				myEarningsService.updateByPrimaryKeySelective(updateEarnings);
			}else{
				
				MyEarnings myEarnings = new MyEarnings();
				myEarnings.setDays(days);
				myEarnings.setRate(rate);
				myEarnings.setBeginTime(order.getCtime());
				myEarnings.setEndTime(MyUtils.dateFormat4(MyUtils.addDate3(myEarnings.getBeginTime(), myEarnings.getDays()),0));
				myEarnings.setMoney(order.getPrice());
				myEarnings.setNum(order.getNum().intValue());
				
				//预期收益 = 总成本 * 年收益率 * 时间 /360天 
				expectEarning = myEarnings.getMoney().multiply(BigDecimal.valueOf(myEarnings.getNum())).multiply(myEarnings.getRate().divide(BigDecimal.valueOf(100)))
													.multiply(BigDecimal.valueOf(myEarnings.getDays())).divide(BigDecimal.valueOf(360),4,BigDecimal.ROUND_HALF_UP);
				myEarnings.setExpectEarning(expectEarning);
				myEarnings.setPaincbuyProjectId(order.getRelationId());
				myEarnings.setPaincbuyProjectName(order.getRelationName());
				myEarnings.setPresentNum(0);
//				myEarnings.setRemark(remark);
				myEarnings.setUserId(userId);
				myEarnings.setDealStatus(CommConstant.DEAL_STATUS_0);
				myEarningsService.insert(myEarnings);
				
				ConsoleUtil.println("myEarningsList insert:"+myEarningsList);
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		}
		
	}
	
	
	/**
	 * 检测微信支付结果数据是否符合本地订单支付
	 * @param out_trade_no 商户订单号 - 对应订单编号
	 * @param trade_no - 交易号（唯一）
	 * @param paramsMap
	 * @return
	 * @throws Exception
	 */
	public Status updateOrderWx(String out_trade_no, String trade_no, Map<String, String> paramsMap) throws Exception{
		
		try {
			OrderExample example = new OrderExample();
			OrderExample.Criteria criteria = example.createCriteria();
			criteria.andOrderCodeEqualTo(out_trade_no);
			//查询订单信息
			List<Order> orderList = orderDao.selectByExample(example);
			
			if(!MyUtils.isListEmpty(orderList)){
				
				//查询支付记录
				Pay pay = payDao.selectByPrimaryKey(trade_no);
				
				//没有支付记录则添加，无需判断支付状态，因为控制器控制了只能是支付成功了才会进入此方法
				if(pay == null){
					
					pay = new Pay();
					pay.setTradeNo(trade_no);
					pay.setBuyer(paramsMap.get("openid"));
					pay.setGmtCreateTime(MyUtils.dateFormat(paramsMap.get("time_end"), 4));
					pay.setGmtPayTime(MyUtils.dateFormat(paramsMap.get("time_end"), 4));
					pay.setOrderCode(out_trade_no);
					pay.setPayType(OrderConstant.PAY_TYPE_2);
					pay.setSeller(paramsMap.get("mch_id"));
					pay.setSourceData(paramsMap.get("jsonObject"));
					//以分为单位的，需要除以100
					pay.setTotalMoney(new BigDecimal(paramsMap.get("total_fee")).divide(new BigDecimal(100)));
					pay.setTradeStatus(paramsMap.get("result_code"));
					
					//添加支付记录
					payDao.insert(pay);
				}
				
				Order order = orderList.get(0);
				
				ConsoleUtil.println(new Date() +"   updateOrderWx --> order_id:"+order.getOrderId()+",user_id:"+order.getUserId()+",order_code:"+order.getOrderCode()+",order_status:"+order.getStatus());
				
				//付款中状态
				if(order.getStatus() == OrderConstant.ORDER_STATUS_2 || order.getStatus() == OrderConstant.ORDER_STATUS_1){
					
					//修改订单状态
					Order updateOrder = new Order();
					updateOrder.setOrderId(order.getOrderId());
					updateOrder.setStatus(OrderConstant.ORDER_STATUS_3);
					updateOrder.setPayType(OrderConstant.PAY_TYPE_2);
					updateOrder.setPayTime(new Date());
					
					//抢购订单要插入或更新收益记录(我参与的项目记录)
					if(OrderConstant.ORDER_TYPE_1 == order.getType()){
						
						this.insertMyEarningsAfterPay(order.getUserId(), order.getRelationId(), order);
						
						//屠宰配送的订单
					}else if(OrderConstant.ORDER_TYPE_2 == order.getType()){
						
						this.updateMyEarningBySlaughter(order.getUserId(), order.getRelationId());
						
						updateOrder.setStatus(OrderConstant.ORDER_STATUS_4);
					}
					
					orderDao.updateByPrimaryKeySelective(updateOrder);
					
					messageService.insertMessage(order.getUserId(), "您的订单"+order.getOrderCode()+"使用微信支付成功，微信订单号为："+trade_no, MessageConstant.SYS_MESSAGE_1, order.getOrderId(), MessageConstant.MSG_RELATION_ID_ORDER);
				}
				
				paramsMap.put("userId", order.getUserId()+"");
				return Status.success;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return Status.serverError;
	}
	
	
	/**
	 * 中断微信支付
	 * @param orderId
	 * @param userId
	 * @throws Exception
	 */
	public Order updateOrderBreakWxPay(Long orderId, Long userId) throws Exception{
		
		try {
			Order order = null;
			//查询订单信息
			if(orderId != null && orderId > 0){
				
				order = orderDao.selectByPrimaryKey(orderId);
					
				//微信付款中，修改成未支付
				if(order != null && order.getUserId().longValue() == userId && order.getStatus() == OrderConstant.ORDER_STATUS_2){
				
					Order order2 = new Order();
					order2.setStatus(OrderConstant.ORDER_STATUS_1);
					order2.setOrderId(orderId);
					orderDao.updateByPrimaryKeySelective(order2);
					
					ConsoleUtil.println(new Date() +"   updateOrderBreakWxPay --> order_id:"+order.getOrderId()+",user_id:"+userId+",order_code:"+order.getOrderCode()+",order_status:"+order.getStatus());
				}
			}
			
			return order;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	
	public int updateByPrimaryKeySelective(Order record) throws Exception{
		
		try {
			
			return orderDao.updateByPrimaryKeySelective(record);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	
	
	/**
	 * 查询我的订单
	 * @param userId
	 * @param queryStatus
	 * @param pages
	 * @param isPage 是否分页查询
	 * @return
	 */
	public Pages<Order> queryPage(Long userId, byte queryStatus,Pages<Order> pages,boolean isPage) throws Exception{
		
		OrderExample example = new OrderExample();
		OrderExample.Criteria criteria = example.createCriteria();
		
		criteria.andUserIdEqualTo(userId);
		example.setOrderByClause("order_id desc");
		
		if(queryStatus > 0){
			
			criteria.andStatusEqualTo(queryStatus);
		}
		criteria.andIsShowEqualTo(OrderConstant.IS_FRONT_SHOW_Y);
		
		if(isPage){
			int count = orderDao.countByExample(example);
			pages.setCountRows(count);
			example.setPage(pages);
		}
		List<Order> list = orderDao.selectByExample(example);
		
		if(null == pages){
			pages = new Pages<Order>();
		}
		pages.setRoot(list);
		return pages;
	}
	
	
	

	/**
	 * 取消用户订单
	 * @param userId
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateOrderCancel(Long userId,Long orderId) throws Exception{
		
		try {
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			if(orderId == null || orderId <= 0){
				
				map.put("status", Status.orderIdNullity);
				
				return map;
			}
			
			//查询订单，检测所属用户及订单状态
			Order order = orderDao.selectByPrimaryKey(orderId);
			
			if(order == null || order.getUserId().longValue() != userId.longValue() ){
				//订单不存在
				map.put("status", Status.orderNotExist);
				
				return map;
			}
			Byte isShow = null;
			//只能未支付 / 活猪待确认收货 才能取消
			if(order.getStatus() == OrderConstant.ORDER_STATUS_1 || order.getStatus() == OrderConstant.ORDER_STATUS_4){
				
				//取消抢购要还原数量
				if(order.getType() == OrderConstant.ORDER_TYPE_1 && order.getStatus() == OrderConstant.ORDER_STATUS_1){
				
					String content = "您的订单编号为【"+order.getOrderCode()+"】的订单取消成功";
					
					messageService.insertMessage(userId, content, MessageConstant.SYS_MESSAGE_1, orderId, MessageConstant.MSG_RELATION_ID_ORDER);
					
					//还原抢购数量(20151008 业务需求变更，取消订单不需要)
//					panicbuyProjectService.updatePanicutBuyLeftNum(order.getRelationId(), order.getNum());
					
					//屠宰配送未支付 或 领活猪待确认收货     置空 回报类型
				}else if((order.getType() == OrderConstant.ORDER_TYPE_2 && order.getStatus() == OrderConstant.ORDER_STATUS_1) 
						|| (order.getType() == OrderConstant.ORDER_TYPE_3 && order.getStatus() == OrderConstant.ORDER_STATUS_4)){
					
					MyEarningsExample example = new MyEarningsExample();
					MyEarningsExample.Criteria criteria = example.createCriteria();
					criteria.andPaincbuyProjectIdEqualTo(order.getRelationId());
					criteria.andUserIdEqualTo(userId);
					criteria.andDealStatusEqualTo(CommConstant.DEAL_STATUS_0);
					List<MyEarnings> myEarningList = myEarningsService.selectByExample(example);
					
					String ndays = sysConfigService.queryOneValue(SysConstant.CONFIRM_REWARDS_BEFORE_N_DAYS);
					
					if(!MyUtils.isListEmpty(myEarningList)){
						
						MyEarnings myEarnings = myEarningList.get(0);
						
						//领活猪超过135天不能取消了，只能系统自动取消掉订单转成回报方式1
						if(order.getType() == OrderConstant.ORDER_TYPE_3){
							
							Date d = MyUtils.dateFormat(MyUtils.addDate3(myEarnings.getEndTime(), -Integer.valueOf(ndays)) + " 00:00:00",0);
							
							if(d.before(new Date())){
								
								map.put("status", Status.orderCannotCancelOverTime);
								
								return map;
							}
						}
						
						MyEarnings updateEarnings = new MyEarnings();
						updateEarnings.setEarningsId(myEarnings.getEarningsId());
						updateEarnings.setDealType(null);
						updateEarnings.setBeforeDealType(myEarnings.getDealType());

						updateEarnings.setRemark("用户于" +MyUtils.getYYYYMMDDHHmmss(0) + " 取消订单将回报方式重置为空");
						myEarningsService.updateDealType(updateEarnings);
						
						isShow = OrderConstant.IS_FRONT_SHOW_N;
					}
					
				}else{
					
					map.put("status", Status.orderCannotCancel);
					
					return map;
				}
			}else{
				
				map.put("status", Status.orderCannotCancel);
				
				return map;
			}
			
			Order upOrder = new Order();
			upOrder.setOrderId(orderId);
			upOrder.setStatus(OrderConstant.ORDER_STATUS_0);
			if(null != isShow){
				
				upOrder.setIsShow(isShow);
			}
			orderDao.updateByPrimaryKeySelective(upOrder);
			
			map.put("status", Status.success);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	
	/**
	 * 删除用户订单
	 * @param userId
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public Status updateOrderDelete(Long userId,Long orderId) throws Exception{
		
		try {
			if(orderId == null || orderId <= 0){
				return Status.orderIdNullity;
			}
			
			//查询订单，检测所属用户及订单状态
			Order order = orderDao.selectByPrimaryKey(orderId);
			
			if(order == null || order.getUserId().longValue() != userId.longValue() ){
				//订单不存在
				return Status.orderNotExist;
			}
			//删除订单的条件：已取消的订单 和 已完成的订单 可以删除掉
			//所有订单最后的状态是已完成
			if((order.getStatus() != OrderConstant.ORDER_STATUS_0
					&& order.getStatus() != OrderConstant.ORDER_STATUS_5)
					|| order.getIsShow() != OrderConstant.IS_FRONT_SHOW_Y){
				return Status.orderCannotDelete;
			}
				
			String content = "您的订单编号为【"+order.getOrderCode()+"】的已支付的订单删除成功";
			
			messageService.insertMessage(userId, content, MessageConstant.SYS_MESSAGE_1, orderId, MessageConstant.MSG_RELATION_ID_ORDER);
			
			Order upOrder = new Order();
			upOrder.setOrderId(orderId);
			upOrder.setIsShow(OrderConstant.IS_FRONT_SHOW_N);
			orderDao.updateByPrimaryKeySelective(upOrder);
			
			return Status.success;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	/**
	 * 确认收货
	 * @param userId
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public Status updateOrderConfirmReceive(Long userId,Long orderId) throws Exception{
		
		try {
			if(orderId == null || orderId <= 0){
				
				return Status.orderIdNullity;
			}
			
			//查询订单，检测所属用户及订单状态
			Order order = orderDao.selectByPrimaryKey(orderId);
			
			if(order == null || order.getUserId().longValue() != userId.longValue() ){
				
				//订单不存在
				return Status.orderNotExist;
			}
			//删除订单的条件：已取消的订单 和 已完成的订单 可以删除掉
			//所有订单最后的状态是已完成
			if(order.getStatus() != OrderConstant.ORDER_STATUS_4){
				
				return Status.orderCannotConfirmReceive;
			}
			
			//查询订单对应的收益记录(只有活猪和屠宰配送才会有待收货的订单)
			MyEarningsExample example = new MyEarningsExample();
			MyEarningsExample.Criteria criteria = example.createCriteria();
			
			criteria.andUserIdEqualTo(userId);
			criteria.andPaincbuyProjectIdEqualTo(order.getRelationId());
			
			List<MyEarnings> earningsList = myEarningsService.selectByExample(example);
			
			if(MyUtils.isListEmpty(earningsList)){
				
				return Status.myJoinedProjectNotExist;
			}
			
			MyEarnings myEarnings = earningsList.get(0);
			
			MyEarnings updateEarnings = new MyEarnings();
			updateEarnings.setEarningsId(myEarnings.getEarningsId());
			updateEarnings.setDealStatus(CommConstant.DEAL_STATUS_1);
			updateEarnings.setDealTime(new Date());
			//计算延期天数
			Long intevalDay = MyUtils.calcDays(myEarnings.getEndTime(), updateEarnings.getDealTime());
			if(intevalDay > 0){
				updateEarnings.setOverTime(updateEarnings.getDealTime());
				updateEarnings.setOverDays(intevalDay.intValue());
			}
			
			String content = "您的订单编号为【"+order.getOrderCode()+"】的订单确认收货成功";
			
			messageService.insertMessage(userId, content, MessageConstant.SYS_MESSAGE_1, orderId, MessageConstant.MSG_RELATION_ID_ORDER);
			
			Order upOrder = new Order();
			upOrder.setOrderId(orderId);
			upOrder.setStatus(OrderConstant.ORDER_STATUS_5);
			orderDao.updateByPrimaryKeySelective(upOrder);
			
			myEarningsService.updateByPrimaryKeySelective(updateEarnings);
			
			return Status.success;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 根据订单id查询订单
	 */
	public Order selectByPrimaryKey(Long orderId) throws Exception{
		if(null == orderId || orderId <= 0){
			return null;
		}
		return orderDao.selectByPrimaryKey(orderId);
	}
	
	@Override
	public Order selectByPrimaryKey(Long userId, Long orderId) throws Exception{
		if(null == orderId || orderId <= 0){
			return null;
		}
		OrderExample orderExample = new OrderExample();
		OrderExample.Criteria criteria = orderExample.createCriteria();
		criteria.andUserIdEqualTo(userId);
		criteria.andOrderIdEqualTo(orderId);
		
		List<Order> orders = orderDao.selectByExample(orderExample);
		
		return orders!=null?orders.get(0):null;
	}
	
	
	/**
	 * 测试支付入口
	 * @return
	 * @throws Exception
	 */
	public Status testPay(String orderIdStr,Long userId) throws Exception{
		
		try {
			
			String test = ToolKit.getInstance().getSingleConfig("test");
			
			if("yes".equals(test)){
				
				//订单id
				if(!ValidateUtil.validateInteger(orderIdStr, false, 1, null)){
					
					return Status.orderIdNullity;
				}
				//用户id
				if(null == userId || userId <= 0){
					
					return Status.login_first;
				}
				//查询订单信息，检测订单所属用户、状态、核对金额
				Order order = orderDao.selectByPrimaryKey(Long.valueOf(orderIdStr));
				
				if(order == null || order.getUserId().longValue() != userId.longValue()){
					
					return Status.orderNotExist;
				}
				//只有未付款的订单才能付款
				if(order.getStatus() != OrderConstant.ORDER_STATUS_1){
					
					return Status.orderCannotPay;
				}
				//支付超时
				if(order.getOverTime().before(new Date())){
					
					return Status.orderCannotPayOverTime;
				}
				
				//更新订单状态
				Order updateOrder = new Order();
				updateOrder.setOrderId(order.getOrderId());
				updateOrder.setPayType(OrderConstant.PAY_TYPE_3);
				updateOrder.setStatus(OrderConstant.ORDER_STATUS_3);
				updateOrder.setPayTime(new Date());
				
				//抢购订单要插入或更新收益记录(我参与的项目记录)
				if(OrderConstant.ORDER_TYPE_1 == order.getType()){
					
					this.insertMyEarningsAfterPay(order.getUserId(), order.getRelationId(), order);
					
					//屠宰配送的订单
				}else if(OrderConstant.ORDER_TYPE_2 == order.getType()){
					
					this.updateMyEarningBySlaughter(order.getUserId(), order.getRelationId());
					
					updateOrder.setStatus(OrderConstant.ORDER_STATUS_4);
				}
				
				orderDao.updateByPrimaryKeySelective(updateOrder);
				
				messageService.insertMessage(order.getUserId(), "您的订单"+order.getOrderCode()+"使用测试支付接口成功", MessageConstant.SYS_MESSAGE_1, order.getOrderId(), MessageConstant.MSG_RELATION_ID_ORDER);
			}
			
			
			return Status.success;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	/**
	 * 查询订单的额外费用信息
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public OrderExtFee selectOrderExtFee(Long orderId) throws Exception{
		
		OrderExtFee orderExtFee = orderExtFeeDao.selectByPrimaryKey(orderId);
		
		return orderExtFee;
	}
	
	@Override
	public OrderAddress queryOrderAddress(Long orderId){
		return orderAddressDao.selectByPrimaryKey(orderId);
	}
	
	
	
	
	
}
