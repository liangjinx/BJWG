package com.bjwg.main.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.base.Pages;
import com.bjwg.main.base.PhoneBaseData;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.DictConstant;
import com.bjwg.main.constant.OrderConstant;
import com.bjwg.main.constant.StatusConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.constant.SysConstant;
import com.bjwg.main.model.MyEarnings;
import com.bjwg.main.model.MyEarningsExample;
import com.bjwg.main.model.Order;
import com.bjwg.main.model.SysConfig;
import com.bjwg.main.model.UserAddress;
import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.model.WeiXinUser;
import com.bjwg.main.model.WeiXinUserExample;
import com.bjwg.main.service.DictService;
import com.bjwg.main.service.MyEarningsService;
import com.bjwg.main.service.OrderService;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.service.UserService;
import com.bjwg.main.service.WalletService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.GetWxOrderno;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.RandomUtils;
import com.bjwg.main.util.RequestHandler;
import com.bjwg.main.util.SMSUtil;
import com.bjwg.main.util.Sha1Util;
import com.bjwg.main.util.StringUtils;

/**
 * @author Allen
 * @version 创建时间：2015-4-13 下午04:53:58
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：用户
 */
@Controller
@Scope("prototype")
public class OrderController extends BaseController{
	
	@Resource
	private OrderService orderService;
	@Resource
	private DictService dictService;
	@Resource
	private WalletService walletService;
	@Resource
	private UserService userService;
	@Resource
	private SysConfigService sysConfigService;
	@Resource
	private MyEarningsService myEarningsService;
	
	
	/**
	 * 费用详情说明
	 */
	@RequestMapping(value="/wpv/orFeeDetail",method = {RequestMethod.GET,RequestMethod.POST})
	public String wlFeeDetail(HttpServletRequest request) throws Exception{
		
		try {
			
			this.setAttr(request);
			
			request.setAttribute("config", sysConfigService.queryOne(SysConstant.FEE_DETAIL_DESCRIPTION));
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("费用清单",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		
		return "repay/pay_back_charge_list";
	}
	/**
	 * 选择回报方式入口 / 进入具体的回报方式 
	 */
	@RequestMapping(value="/wpv/orchooseRepayType",method = {RequestMethod.GET,RequestMethod.POST})
	public String wlchooseRepayType(HttpServletRequest request) throws Exception{
		
		try {
			
			this.setAttr(request);
			
			String repayTypeId = request.getParameter("repayTypeId");
			
			String queryProjectId = request.getParameter("queryProjectId");
			
			List<String> codeList = null;
			
			List<SysConfig> configList = null;
			
			if(StringUtils.isNotEmpty(repayTypeId)){
				
				codeList = new ArrayList<String>(Arrays.asList(SysConstant.REPAY_TYPE+"_"+repayTypeId));
				
				//屠宰配送
				if("2".equals(repayTypeId)){
					
					codeList.add(SysConstant.DIVISION_THICK_FEE);
					codeList.add(SysConstant.DIVISION_THIN_FEE);
					codeList.add(SysConstant.PACKAGE_FEE);
					codeList.add(SysConstant.PACKAGE_SPECS);
					
					request.setAttribute("dictList", dictService.queryListByParentCode(DictConstant.THICK_TYPE));
				}else if("4".equals(repayTypeId)){
					
					codeList.add(SysConstant.PIG_COUPON_MONEY);
				}
				
				configList = sysConfigService.queryList(codeList);
				
				//屠宰配送
				if("2".equals(repayTypeId)){
					
					List<String> specList = new ArrayList<String>();
					for (SysConfig sysConfig : configList) {
						if(SysConstant.PACKAGE_SPECS.equals(sysConfig.getCode())){
							specList.addAll(Arrays.asList(sysConfig.getValue().split(",")));
							break;
						}
					}
					
					request.setAttribute("specList", specList);
				}
				
				request.setAttribute("configList", configList);
				
				
				//具体回报方式页面
				return "repay/pig_pay_back_detail";
			}else{
				
				codeList = new ArrayList<String>(Arrays.asList(SysConstant.REPAY_TYPE,SysConstant.PIG_COUPON_MONEY,SysConstant.PIG_COUPON_CAN_USE_CITY));
				
				configList = sysConfigService.queryList(codeList);
				
				request.setAttribute("configList", configList);
				
				for (SysConfig sysConfig : configList) {
					
					if(sysConfig.getCode().equals(SysConstant.PIG_COUPON_CAN_USE_CITY)){
						
						String[] citys = sysConfig.getValue().split(",");
						
						StringBuffer stringBuffer = new StringBuffer("");
						
						for (String city : citys) {
							
							stringBuffer.append(PhoneBaseData.getInstance().getArea_V2Name(city)+",");
						}
						
						request.setAttribute("limitCity", stringBuffer.substring(0,stringBuffer.length() - 1));
						
						break;
					}
				}
				
				if(StringUtils.isNotEmpty(queryProjectId)){
					
					UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
					
					Long userId = null != user ? user.getUserId() : null;
					
					ConsoleUtil.println("/wpnv/uraddMyFriends -- > user:"+user + " --> userId:"+userId);
					
					//查询指定期是否已选择了汇报方式
					MyEarningsExample example = new MyEarningsExample();
					MyEarningsExample.Criteria criteria = example.createCriteria();
					criteria.andPaincbuyProjectIdEqualTo(Long.valueOf(queryProjectId));
					criteria.andUserIdEqualTo(userId);
					List<MyEarnings> earningList = myEarningsService.selectByExample(example);
					
					request.setAttribute("myEarnings", MyUtils.isListEmpty(earningList) ? null : earningList.get(0));
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("选择回报方式",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		//入口页面
		return "repay/pig_pay_back";
	}
	/**
	 * 保存选择的回报方式
	 */
	@RequestMapping(value="/wpv/orsaveRepayType",method = {RequestMethod.GET,RequestMethod.POST})
	public String wlsaveRepayType(HttpServletRequest request) throws Exception{
		
		try {
			
			this.setAttr(request);
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/uraddMyFriends -- > user:"+user + " --> userId:"+userId);
			
			String repayTypeId = request.getParameter("repayTypeId");
			
			String queryProjectId = request.getParameter("queryProjectId");
			
			//分割类型
			String divisionType = request.getParameter("divisionType");
			
			//分割类型明细
			String divisionTypeDetail = request.getParameter("divisionTypeDetail");
			
			//包装规格
			String packageSpec = request.getParameter("packageSpec");
			
			Map<String, Object> map = myEarningsService.saveRepayType(userId,repayTypeId,queryProjectId,divisionType,divisionTypeDetail,packageSpec);
			
			Status status = (Status)map.get("status");
			
			if(Status.success == status){
				
				if("2".equals(repayTypeId) || "3".equals(repayTypeId)){
					request.setAttribute("dataMap", map);
					
					//将参数放入到session中，因为这里会选择收货地址，可能会经过多次跳转，每次页面传参十分麻烦。
					Map<String, String> sessionMap = new HashMap<String, String>();
					sessionMap.put("repayTypeId", repayTypeId);
					sessionMap.put("queryProjectId", queryProjectId);
					sessionMap.put("divisionType", divisionType);
					sessionMap.put("divisionTypeDetail", divisionTypeDetail);
					sessionMap.put("packageSpec", packageSpec);
					sessionMap.put("endModifyTime", request.getParameter("endModifyTime"));
					request.getSession().setAttribute("wlsaveRepayTypeSessionMap", sessionMap);
					
					UserAddress address = (UserAddress)map.get("userAddress");
					
					if(address != null){
						
						address.setAddress(MyUtils.getCompleteAddress(address.getProvince(), address.getCity(), address.getAddress()));
						
						map.put("userAddress",address);
					}
					
					//屠宰计算所有费用的页面
					return "order/affirm_shopping_address";
				}
				return "redirect:/wpnv/ixpigGrow?queryProjectId="+queryProjectId+"&msgCode=1";
			}
			
			this.notifyMsg(request, status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("选择回报方式",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return wlchooseRepayType(request);
	}
	/**
	 * 返回屠宰/领活猪确认提交订单页面
	 */
	@RequestMapping(value="/wpv/orbackSlaughterOrder",method = {RequestMethod.GET,RequestMethod.POST})
	public String backSlaughterOrder(HttpServletRequest request) throws Exception{
		
		try {
			
			this.setAttr(request);
			
			//将参数放入到session中，因为这里会选择收货地址，可能会经过多次跳转，每次页面传参十分麻烦。
			Map<String, String> sessionMap = (HashMap<String, String>)request.getSession().getAttribute("wlsaveRepayTypeSessionMap");
			
			String repayTypeId = null;
			
			String queryProjectId = null;
			
			//分割类型
			String divisionType = null;
			
			//分割类型明细
			String divisionTypeDetail = null;
			
			//包装规格
			String packageSpec = null;
			
			String pageSource = request.getParameter("pageSource");
			
			ConsoleUtil.println("pageSource:"+pageSource);
			
			if(!MyUtils.isMapEmpty(sessionMap)){
				repayTypeId = sessionMap.get("repayTypeId");
				queryProjectId = sessionMap.get("queryProjectId");
				divisionType = sessionMap.get("divisionType");
				divisionTypeDetail = sessionMap.get("divisionTypeDetail");
				packageSpec = sessionMap.get("packageSpec");
				String endModifyTime = sessionMap.get("endModifyTime");
				request.setAttribute("repayTypeId", repayTypeId);
				request.setAttribute("queryProjectId", queryProjectId);
				request.setAttribute("divisionType", divisionType);
				request.setAttribute("divisionTypeDetail", divisionTypeDetail);
				request.setAttribute("packageSpec", packageSpec);
				request.setAttribute("endModifyTime", endModifyTime);
			}
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/uraddMyFriends -- > user:"+user + " --> userId:"+userId);
			
			Map<String, Object> map = myEarningsService.saveRepayType(userId,repayTypeId,queryProjectId,divisionType,divisionTypeDetail,packageSpec);
			
			Status status = (Status)map.get("status");
			
			if(Status.success == status){
				
				if("2".equals(repayTypeId) || "3".equals(repayTypeId)){
					
					String queryAddressId = request.getParameter("queryAddressId");
					
					if(StringUtils.isNotEmpty(queryAddressId)){
						
						UserAddress address = userService.getAddressId(Long.valueOf(queryAddressId));
						
						if(address != null){
							
							address.setAddress(MyUtils.getCompleteAddress(address.getProvince(), address.getCity(), address.getAddress()));
						}
						
						map.put("userAddress", address);
					}
					
					request.setAttribute("dataMap", map);
					
					//屠宰计算所有费用的页面
					return "order/affirm_shopping_address";
				}
				return "redirect:/wpnv/ixpigGrow?queryProjectId="+queryProjectId;
			}
			
			this.notifyMsg(request, status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("选择回报方式",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return wlchooseRepayType(request);
	}
	/**
	 * 屠宰配送提交订单
	 */
	@RequestMapping(value="/wpv/orslaughterOrderSubmit",method = {RequestMethod.GET,RequestMethod.POST})
	public String wlslaughterOrderSubmit(HttpServletRequest request) throws Exception{
		
		try {
			
			this.setAttr(request);
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/uraddMyFriends -- > user:"+user + " --> userId:"+userId);
			
			String queryProjectId = request.getParameter("queryProjectId");
			
			//分割类型
			String divisionType = request.getParameter("divisionType");
			
			//分割类型明细
			String divisionTypeDetail = request.getParameter("divisionTypeDetail");
			
			//包装规格
			String packageSpec = request.getParameter("packageSpec");
			//收货地址id
			String addressId = request.getParameter("addressId");
			
			Map<String, Object> map = orderService.insertSlaughterOrder(userId,queryProjectId,divisionType,divisionTypeDetail,packageSpec,addressId);
			
			Status status = (Status)map.get("status");
			
			if(Status.success == status){
				
				Order order = (Order)map.get("order");
				
				return "redirect:/wpv/orchoosePay?orderId="+order.getOrderId();
			}
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("选择回报方式",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		//屠宰计算所有费用的页面
		return wlsaveRepayType(request);
	}
	
	
	/**
	 * 领活猪提交订单
	 */
	@RequestMapping(value="/wpv/wlpigOrderSubmit",method = {RequestMethod.GET,RequestMethod.POST})
	public String pigOrderSubmit(HttpServletRequest request) throws Exception{
		
		try {
			
			this.setAttr(request);
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/uraddMyFriends -- > user:"+user + " --> userId:"+userId);
			
			String queryProjectId = request.getParameter("queryProjectId");
			
			//收货地址id
			String addressId = request.getParameter("addressId");
			
			Map<String, Object> map = orderService.insertPigOrder(userId,queryProjectId,addressId);
			
			Status status = (Status)map.get("status");
			
			if(Status.success == status){
				
				Order order = (Order)map.get("order");
				
				if(OrderConstant.ORDER_STATUS_4 == order.getStatus()){
					
					return "redirect:/wpv/ororderDetail?orderId="+order.getOrderId();
				}else{
					
					return "redirect:/wpv/orchoosePay?orderId="+order.getOrderId();
				}
			}
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("选择回报方式",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		//屠宰计算所有费用的页面
		return wlsaveRepayType(request);
	}
	
	/**
	 * 提交订单
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/orsubmit",method = {RequestMethod.POST,RequestMethod.GET})
	public String orderSubmit(HttpServletRequest request){
		
		Status status = null;
		
		String projectId = request.getParameter("projectId");
		try {
			
			String purchaseNum = request.getParameter("purchaseNum");
			
			String remark = request.getParameter("remark");
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/ixRecentEarning -- > user:"+user + " --> userId:"+userId);
			
			Map<String, Object> map = orderService.insert(userId,projectId,purchaseNum,remark);
			
			status = (Status)map.get("status");
			
			Order order = (Order)map.get("order");
			
			if(Status.success == status){
				
				request.setAttribute("order", order);
				
				String limitHous = sysConfigService.queryOneValue(SysConstant.ORDER_PAY_OVER_LIMIT_HOURS);
				
				SMSUtil.sendOne(user.getBindPhone(), "尊敬的客户：您于"+MyUtils.getYYYYMMDDHHmmss(0)+"在八戒王国下单成功，订单编号为:"+order.getOrderCode()+"，请于"+limitHous+"分钟内支付，否则订单将自动取消。");
				
				return "redirect:/wpv/orchoosePay?orderId="+order.getOrderId();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("提交订单出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "redirect:/wpnv/ixPanicutBuyInit?queryProjectId="+projectId+"&msgCode="+status.getStatus();
	}
	/**
	 * 选择支付
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/orchoosePay",method = {RequestMethod.POST,RequestMethod.GET})
	public String choosePay(HttpServletRequest request){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/orchoosePay -- > user:"+user + " --> userId:"+userId);
			
			String orderIdStr= request.getParameter("orderId");
			
			//根据查询id
			Order order = orderService.queryByOrderId(orderIdStr); 
			
			//查询账户余额 付款
//			Wallet wallet = walletService.queryByUserId(userId);
			
			//余额是否可支付
//			request.setAttribute("walletCanPay", (wallet != null && order !=null && wallet.getMoney().doubleValue() >= order.getTotalMoney().doubleValue()));
			
//			if(null != wallet){
//				
//				request.setAttribute("balance", wallet);
//			}
			this.notifyMsgByRedirectCode(request);
			
			if(null != order){
				
				//订单id
				request.setAttribute("order", order);
				
				//支付超时
				if(order.getOverTime().before(new Date())){
					
					this.notifyMsg(request, Status.orderCannotPayOverTime);
					
					return this.orderList(request);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("选择支付出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "order/choose_pay";
	}
	
	/**
	 * 测试支付入口，正式环境要屏蔽的
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/ortestPay",method = {RequestMethod.POST,RequestMethod.GET})
	public String testPay(HttpServletRequest request){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/ortestPay -- > user:"+user + " --> userId:"+userId);
			
			String orderIdStr= request.getParameter("orderId");
			
			Status status = orderService.testPay(orderIdStr, userId);
			
			if(Status.success == status){
				
				//跳转订单列表页面
				return orderDetail(request);
			}
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("余额支付出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return this.choosePay(request);
	}
	/**
	 * 余额支付
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/orwalletPay",method = {RequestMethod.POST,RequestMethod.GET})
	public String walletPay(HttpServletRequest request){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/orwalletPay -- > user:"+user + " --> userId:"+userId);
			
			String orderIdStr= request.getParameter("orderId");
			
			String payPassword= request.getParameter("payPassword");
			
			Status status = orderService.updateOrderPayed(orderIdStr, userId ,payPassword);
			
			if(Status.success == status){
				
				//跳转订单列表页面
				return orderDetail(request);
			}
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("余额支付出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return this.choosePay(request);
	}
	/**
	 * 支付宝支付
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/oralipayPay",method = {RequestMethod.POST,RequestMethod.GET})
	public String alipayPay(HttpServletRequest request){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println(">>>1./wpnv/oralipayPay -- > user:"+user + " --> userId:"+userId);
			
			String orderIdStr= request.getParameter("orderId");
			
			request.setAttribute("orderId", orderIdStr);
			
			//查询订单信息
			Order order = orderService.queryByOrderId(orderIdStr);
			
			ConsoleUtil.println(">>>2./wpnv/oralipayPay -- > order:"+user + (order != null ? " --> time:"+order.getOverTime()+" ---> order_status:" + order.getStatus() : ""));
			
			if(order == null || null == user || order.getUserId().longValue() != user.getUserId().longValue()){
				
				this.notifyMsg(request, Status.orderDataError);
				
				return this.orderList(request);
			}
			
			//支付超时
			if(order.getOverTime().before(new Date())){
				
				this.notifyMsg(request, Status.orderCannotPayOverTime);
				
				return this.orderList(request);
			}
			
			if(order.getStatus() != OrderConstant.ORDER_STATUS_1 && order.getStatus() != OrderConstant.ORDER_STATUS_2){
				
				this.notifyMsg(request, Status.orderCannotPay);
				
				return this.orderList(request);
			}
			
			Order updateOrder = new Order();
			//更新状态为付款中
			updateOrder.setStatus(OrderConstant.ORDER_STATUS_2);
			updateOrder.setOrderId(order.getOrderId());
			orderService.updateByPrimaryKeySelective(updateOrder);
			
			request.setAttribute("order", order);
			
			request.setAttribute("projectUrl", sysConfigService.queryOneValue(SysConstant.PROJECT_ACCESS_URL));
			
			String[] aplipayConfig = sysConfigService.queryAlipayKey();
			
			request.setAttribute("ap", aplipayConfig[0]);
			request.setAttribute("apk", aplipayConfig[1]);
			request.setAttribute("as", aplipayConfig[2]);
			
			return "alipay/alipayapi";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("支付宝支付出错",e);
			this.notifyMsg(request, Status.requestAlipayPayFail);
		}
		return this.orderList(request);
	}
	
	/**
	 * 支付宝支付2
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/oralipayPay2",method = {RequestMethod.POST,RequestMethod.GET})
	public String alipayPay2(HttpServletRequest request){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println(">>>1./wpnv/oralipayPay2 -- > user:"+user + " --> userId:"+userId);
			
			String orderIdStr= request.getParameter("orderId");
			
			request.setAttribute("orderId", orderIdStr);
			
			//查询订单信息
			Order order = orderService.queryByOrderId(orderIdStr);
			
			ConsoleUtil.println(">>>2./wpnv/oralipayPay2 -- > order:"+user + (order != null ? " --> time:"+order.getOverTime()+" ---> order_status:" + order.getStatus() : ""));
			
			if(order == null || null == user || order.getUserId().longValue() != user.getUserId().longValue()){
				
				this.notifyMsg(request, Status.orderDataError);
				
				return this.choosePay(request);
			}
			
			//支付超时
			if(order.getOverTime().before(new Date())){
				
				this.notifyMsg(request, Status.orderCannotPayOverTime);
				
				return this.orderList(request);
			}
			
			if(order.getStatus() != OrderConstant.ORDER_STATUS_1 && order.getStatus() != OrderConstant.ORDER_STATUS_2){
				
				this.notifyMsg(request, Status.orderCannotPay);
				
				return this.choosePay(request);
			}
			
			Order updateOrder = new Order();
			//更新状态为付款中
			updateOrder.setStatus(OrderConstant.ORDER_STATUS_2);
			updateOrder.setOrderId(order.getOrderId());
			orderService.updateByPrimaryKeySelective(updateOrder);
			
			request.setAttribute("order", order);
			
			request.setAttribute("projectUrl", sysConfigService.queryOneValue(SysConstant.PROJECT_ACCESS_URL));
			
			String[] aplipayConfig = sysConfigService.queryAlipayKey();
			
			request.setAttribute("ap", aplipayConfig[0]);
			request.setAttribute("apk", aplipayConfig[1]);
			request.setAttribute("as", aplipayConfig[2]);
			
			return "pc/alipay/alipayapi";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("余额支付出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		return this.choosePay(request);
	}
	
	
	/**
	 * 中断支付宝支付请求
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/wpv/orbreakAlipayPay",method = {RequestMethod.POST,RequestMethod.GET})
	public String breakAlipayPay(Long orderId ,HttpServletRequest request) throws Exception{
		try {
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpv/breakPay -- > user:"+user + " --> userId:"+userId);
			
			String orderIdStr= request.getParameter("orderId");
			
			request.setAttribute("orderId", orderIdStr);
			
			orderService.updateOrderBreakAlipayPay(orderId,user.getUserId()); 
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("中断支付宝支付请求",e);
		}
		
		return this.choosePay(request);
	}
	
	/**
	 * 微信支付
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/orwxPay",method = {RequestMethod.POST,RequestMethod.GET})
	public String wxPay(HttpServletRequest request,HttpServletResponse response){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println(">>>1./wpnv/orwxPay -- > user:"+user + " --> userId:"+userId);
			
			String orderIdStr= request.getParameter("orderId");
			
			//查询订单信息
			Order order = orderService.queryByOrderId(orderIdStr);
			
			ConsoleUtil.println(">>>2./wpnv/orwxPay -- > order:"+user + (order != null ? " --> time:"+order.getOverTime()+" ---> order_status:" + order.getStatus() : ""));
			
			if(order== null || null == user || order.getUserId().longValue() != user.getUserId().longValue()){
				
				this.notifyMsg(request, Status.orderDataError);
				
				return this.orderList(request);
			}
			//支付超时
			if(order.getOverTime().before(new Date())){
				
				this.notifyMsg(request, Status.orderCannotPayOverTime);
				
				return this.orderList(request);
			}
			if(order.getStatus() != OrderConstant.ORDER_STATUS_1 && order.getStatus() != OrderConstant.ORDER_STATUS_2){
				
				this.notifyMsg(request, Status.orderCannotPay);
				
				return this.orderList(request);
			}
			
//			WeiXinUserExample weiXinUserExample = new WeiXinUserExample();
//			WeiXinUserExample.Criteria criteria = weiXinUserExample.createCriteria();
//			criteria.andUserIdEqualTo(user.getUserId());
//			
//			WeiXinUser wxUser = userService.selectByWeixinUserExample(weiXinUserExample);
			
			WeiXinUser wxUser = (WeiXinUser)request.getSession().getAttribute(CommConstant.SESSION_WX_USER);
			
			String openId = null;
			
			if(null == wxUser){
				
				openId = (String)request.getSession().getAttribute(CommConstant.SESSION_OPENID);
				
			}else{
				
				openId = wxUser.getOpenid();
			}
			
			if(StringUtils.isEmptyNo(openId)){
			
				openId = user.getOpenId();
			}
			
			ConsoleUtil.println(">>>3./wpnv/orwxPay -- > wxUser:"+wxUser + " ---> openId:" + openId);
			
			if(StringUtils.isEmptyNo(openId)){
				
				this.notifyMsg(request, Status.dataErrorAccessAgain);
				
				return this.orderList(request);
			}
			
			
			//网页授权后获取传递的参数
			String userIdtr = user.getUserId()+""; 	
			String orderNo = order.getOrderCode(); 	
//			String code = request.getParameter("code");
			//金额转化为分为单位
			String finalmoney = order.getTotalMoney().multiply(new BigDecimal(100)).intValue()+"";
			
			String[] wxs = sysConfigService.queryWxAppidAndAppKey();
			//商户相关资料 
			String appid = wxs[0];
			String appsecret = wxs[1];
			String partner = wxs[3];
			String partnerkey = wxs[2];
//			String openId =wxUser.getOpenid();
			ConsoleUtil.println("微信支付的用户openid为："+openId);
			//获取openId后调用统一支付接口https://api.mch.weixin.qq.com/pay/unifiedorder
			String currTime = MyUtils.getYYYYMMDDHHmmss(4);
			//8位日期
			String strTime = currTime.substring(8, currTime.length());
			//四位随机数
			String strRandom = RandomUtils.getNumAndWord(4);
			//10位序列号,可以自行调整。
			String strReq = strTime + strRandom;
			
			
			//商户号
			String mch_id = partner;
			//子商户号  非必输
//			String sub_mch_id="";
			//设备号   非必输
			String device_info="";
			//随机数 
			String nonce_str = strReq;
			
			//商品描述
			String body = order.getProductName();
			//附加数据
			String attach = userIdtr;
			//商户订单号
			String out_trade_no = orderNo;
			int intMoney = Integer.parseInt(finalmoney);
			
			//总金额以分为单位，不带小数点
			int total_fee = intMoney;
			//订单生成的机器 IP
			String spbill_create_ip = MyUtils.getIpAddr(request);
			//订 单 生 成 时 间   非必输
//			String time_start ="";
			//订单失效时间      非必输
//			String time_expire = "";
			//商品标记   非必输
//			String goods_tag = "";
			
			//这里notify_url是 支付完成后微信发给该链接信息，可以判断会员是否支付成功，改变订单状态等。
			String notify_url = sysConfigService.queryOneValue(SysConstant.PROJECT_ACCESS_URL) + "/wxpay/notify";
					
			String trade_type = "JSAPI";
			//非必输
//			String product_id = "";
			SortedMap<String, String> packageParams = new TreeMap<String, String>();
			packageParams.put("appid", appid);  
			packageParams.put("mch_id", mch_id);  
			packageParams.put("nonce_str", nonce_str);  
			packageParams.put("body", body);  
			packageParams.put("attach", attach);  
			packageParams.put("out_trade_no", out_trade_no);  
			
			//注意金额是以分为单位的
			packageParams.put("total_fee", finalmoney);  
			packageParams.put("spbill_create_ip", spbill_create_ip);  
			packageParams.put("notify_url", notify_url);  
			
			packageParams.put("trade_type", trade_type);  
			packageParams.put("openid", openId);  

			RequestHandler reqHandler = new RequestHandler(request, response);
			reqHandler.init(appid, appsecret, partnerkey);
			
			String sign = reqHandler.createSign(packageParams);
			String xml="<xml>"+
					"<appid>"+appid+"</appid>"+
					"<mch_id>"+mch_id+"</mch_id>"+
					"<nonce_str>"+nonce_str+"</nonce_str>"+
					"<sign>"+sign+"</sign>"+
					"<body><![CDATA["+body+"]]></body>"+
					"<attach>"+attach+"</attach>"+
					"<out_trade_no>"+out_trade_no+"</out_trade_no>"+
					"<total_fee>"+finalmoney+"</total_fee>"+
					"<spbill_create_ip>"+spbill_create_ip+"</spbill_create_ip>"+
					"<notify_url>"+notify_url+"</notify_url>"+
					"<trade_type>"+trade_type+"</trade_type>"+
					"<openid>"+openId+"</openid>"+
					"</xml>";
			ConsoleUtil.println("微信发起支付请求参数："+xml);
			String createOrderURL = "https://api.mch.weixin.qq.com/pay/unifiedorder";
			String prepay_id="";
			try {
				prepay_id = new GetWxOrderno().getPayNo(createOrderURL, xml);
				
				//预付款订单号重复的话就去上一次保存在数据库中的
				if(prepay_id.equals("error_OUT_TRADE_NO_USED")){
					
					prepay_id = order.getPrepayOrderCode();
				}else if(prepay_id.startsWith("error_") || StringUtils.isEmptyNo(prepay_id)){
					
					request.setAttribute("message", "统一支付接口获取预支付订单出错");
					ConsoleUtil.println("-----------------------\n统一支付接口获取预支付订单出错");
					return "redirect:/wpv/orchoosePay?orderId="+order.getOrderId()+"&msgCode="+Status.getWxPreOrderCodeFail.getStatus();
				}
			} catch (Exception e1) {
				e1.printStackTrace();
				logger.error("微信支付订单 - 跳转至微信",e1);
			}
			Order updateOrder = new Order();
			if(order.getPrepayOrderCode() == null){
				updateOrder.setPrepayOrderCode(prepay_id);
			}
			//更新状态为付款中
			updateOrder.setStatus(OrderConstant.ORDER_STATUS_2);
			updateOrder.setOrderId(order.getOrderId());
			orderService.updateByPrimaryKeySelective(updateOrder);
			
			SortedMap<String, String> finalpackage = new TreeMap<String, String>();
			String timestamp = Sha1Util.getTimeStamp();
			String prepay_id2 = "prepay_id="+prepay_id;
			String packages = prepay_id2;
			finalpackage.put("appId", appid);  
			finalpackage.put("timeStamp", timestamp);  
			finalpackage.put("nonceStr", nonce_str);  
			finalpackage.put("package", packages);  
			finalpackage.put("signType", "MD5");
			String finalsign = reqHandler.createSign(finalpackage);
			
			request.setAttribute("appId", appid);
			request.setAttribute("timeStamp", timestamp);
			request.setAttribute("nonceStr", nonce_str);
			request.setAttribute("package", packages);
			request.setAttribute("paySign", finalsign);
			request.setAttribute("order", order);
			request.setAttribute("orderId", order.getOrderId());
			
			return "wxpay/wx_pay";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("微信支付订单 - 跳转至微信",e);
			this.notifyMsg(request, Status.requestWxPayFail);
		}
		
		return orderList(request);
	}
	
	
	/**
	 * 中断微信支付请求
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/wpv/orbreakWxPay",method = {RequestMethod.POST,RequestMethod.GET})
	public String breakWxPay(Long orderId ,HttpServletRequest request) throws Exception{
		try {
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpv/breakWxPay -- > user:"+user + " --> userId:"+userId);
			
			String orderIdStr= request.getParameter("orderId");
			
			request.setAttribute("orderId", orderIdStr);
			
			orderService.updateOrderBreakWxPay(orderId,user.getUserId()); 
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("中断支付宝支付请求",e);
		}
		
		return this.choosePay(request);
	}
	
	
	/**
	 * 个人订单列表 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/orderList",method = {RequestMethod.POST,RequestMethod.GET})
	public String orderList( HttpServletRequest request){

		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpv/orderList -- > user:"+user + " --> userId:"+userId);
			
			String queryStatusStr = request.getParameter("queryStatus");
			
			byte queryStatus = StringUtils.isEmptyNo(queryStatusStr) ? 0 : Byte.valueOf(queryStatusStr);
			
			Pages<Order> pages = orderService.queryPage(userId,queryStatus,null,false);
			
			request.setAttribute("list", pages.getRoot());
			
			request.setAttribute("queryStatus", queryStatus);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("个人订单列表 ",e);
			this.notifyMsg(request, Status.serverError);
		}
		return "order/order_list";
	}
	
	/**
	 * 订单详情
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/ororderDetail",method = {RequestMethod.POST,RequestMethod.GET})
	public String orderDetail( HttpServletRequest request){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			String orderIdStr = request.getParameter("orderId");
			
			Long orderId = StringUtils.isNotEmpty(orderIdStr) ? Long.valueOf(orderIdStr) : null;
			
			Order order = orderService.selectByPrimaryKey(orderId);
			
			if(null != order){
				
				Date currentTime = new Date();
				
				if(currentTime.before(order.getOverTime())){
					
					//计算剩余支付时间
					long leftSecs = MyUtils.calcSecs(currentTime, order.getOverTime());
					
					request.setAttribute("leftSecs", leftSecs);
					
				}
				
				if(order.getType() != OrderConstant.ORDER_TYPE_1){
					
					request.setAttribute("orderExtFee", orderService.selectOrderExtFee(orderId));
					
				}
				
			}
			request.setAttribute("overTime", order.getOverTime().getTime());
			
			request.setAttribute("order", order);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("订单详情 ",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "order/order_details";
	}
	
	/**
	 * 取消订单
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/orcancel",method = {RequestMethod.POST,RequestMethod.GET})
	public String cancel( HttpServletRequest request){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpv/orcancel -- > user:"+user + " --> userId:"+userId);
			
			String orderIdStr = request.getParameter("orderId");
			
			Long orderId = StringUtils.isNotEmpty(orderIdStr) ? Long.valueOf(orderIdStr) : null;
			
			Map<String, Object> map = orderService.updateOrderCancel(userId,orderId);
			
			Status status = (Status)map.get("status");
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("取消订单 ",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return this.orderList(request);
	}
	/**
	 * 删除订单
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/ordelete",method = {RequestMethod.POST,RequestMethod.GET})
	public String delete( HttpServletRequest request){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			String orderIdStr = request.getParameter("orderId");
			
			Long orderId = StringUtils.isNotEmpty(orderIdStr) ? Long.valueOf(orderIdStr) : null;
			
			Status status = orderService.updateOrderDelete(userId,orderId);
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("删除订单 ",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return this.orderList(request);
	}
	/**
	 * 确认收货
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/orConfirm",method = {RequestMethod.POST,RequestMethod.GET})
	public String orderConfirm( HttpServletRequest request){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			String orderIdStr = request.getParameter("orderId");
			
			Long orderId = StringUtils.isNotEmpty(orderIdStr) ? Long.valueOf(orderIdStr) : null;
			
			Status status = orderService.updateOrderConfirmReceive(userId,orderId);
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("确认收货 ",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return this.orderList(request);
	}
	

	
}
