package com.bjwg.main.controller.pc;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.base.Pages;
import com.bjwg.main.base.PhoneBaseData;
import com.bjwg.main.chinapay.util.SignUtil;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.DictConstant;
import com.bjwg.main.constant.OrderConstant;
import com.bjwg.main.constant.SysConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.DictDetail;
import com.bjwg.main.model.Order;
import com.bjwg.main.model.OrderAddress;
import com.bjwg.main.model.PanicbuyProject;
import com.bjwg.main.model.SysConfig;
import com.bjwg.main.model.UserAddress;
import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.service.CommonService;
import com.bjwg.main.service.DictService;
import com.bjwg.main.service.MyEarningsService;
import com.bjwg.main.service.OrderService;
import com.bjwg.main.service.PanicbuyProjectService;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.service.UserService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.SMSUtil;
import com.bjwg.main.util.StringUtils;
import com.sun.jndi.url.corbaname.corbanameURLContextFactory;

/**
 * @author Carter
 * @version 创建时间：2015-9-22 下午02:25:17
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Controller("pc_order_controller")
@Scope("prototype")
public class OrderController extends BaseController {

	@Autowired
	OrderService orderService;
	
	@Autowired
	SysConfigService sysConfigService;
	
	@Autowired
	PanicbuyProjectService panicbuyProjectService;
	
	@Autowired
	MyEarningsService myEarningsService;
	
	@Autowired
	DictService dictService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	CommonService commonService;
	
	/**
	 * 订单列表
	 * @param status
	 * @return
	 */
	@RequestMapping(value="/pc/pv/order/list",method = {RequestMethod.POST,RequestMethod.GET})
	public String list(String status){

		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			byte queryStatus = StringUtils.isEmptyNo(status) ? 0 : Byte.valueOf(status);
			
			Pages<Order> pages = new Pages<Order>();
			pages.setCurrentPage(currentPage);
			pages.setPerRows(5);
			orderService.queryPage(userId,queryStatus,pages,true);
			request.setAttribute("orderList", pages.getRoot());
			request.setAttribute("pager", MyUtils.calcPagerNum(pages.getPerRows(), pages.getCountRows(), pages.getCurrentPage(), 6));
			
			request.setAttribute("status", queryStatus);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("个人订单列表 ",e);
			this.notifyMsg(request, Status.serverError);
		}
		return "pc/order/list";
	}
	
	
	
	/**
	 * 订单列表
	 * @param status
	 * @return
	 */
	@RequestMapping(value="/pc/pv/epuser/list",method = {RequestMethod.POST,RequestMethod.GET})
	public String list2(String status){

		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			byte queryStatus = StringUtils.isEmptyNo(status) ? 0 : Byte.valueOf(status);
			
			Pages<Order> pages = new Pages<Order>();
			pages.setCurrentPage(currentPage);
			pages.setPerRows(5);
			orderService.queryPage(userId,queryStatus,pages,true);
			request.setAttribute("orderList", pages.getRoot());
			request.setAttribute("pager", MyUtils.calcPagerNum(pages.getPerRows(), pages.getCountRows(), pages.getCurrentPage(), 6));
			
			request.setAttribute("status", queryStatus);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("个人订单列表 ",e);
			this.notifyMsg(request, Status.serverError);
		}
		return "pc/epuser/list";
	}
	
	
	
	
	
	
	
	/**
	 * 订单详情
	 * @return
	 */
	@RequestMapping(value="/pc/pv/order/detail",method = {RequestMethod.POST,RequestMethod.GET})
	public String detail(Long orderId){
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			Order order = orderService.selectByPrimaryKey(userId, orderId);
			
			if(null != order){
				
				Date currentTime = new Date();
				
				if(currentTime.before(order.getOverTime())){
					//计算剩余支付时间
					long leftSecs = MyUtils.calcSecs(currentTime, order.getOverTime());
					request.setAttribute("leftSecs", leftSecs);
				}
				
				//如果是屠宰配送的订单会有收货地址
				if(order.getType().intValue()==2 || order.getType().intValue()==3){
					OrderAddress address = orderService.queryOrderAddress(orderId);
					
					String provinceName = PhoneBaseData.getInstance().getArea_V2Name(address.getProvince()+"");
					String cityName = PhoneBaseData.getInstance().getArea_V2Name(address.getCity()+"");
					String detail = address.getAddress();
					
					if (provinceName == "null" || provinceName == null) {
						provinceName = "";
					}
					if (cityName == "null" || cityName == null) {
						cityName = "";
					}
					if (provinceName.equals(cityName)) {
						cityName = "";
					}
					address.setAddress(provinceName + cityName + detail);
					request.setAttribute("address", address);
				}
			}
			request.setAttribute("overTime", order.getOverTime().getTime());
			
			request.setAttribute("order", order);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("订单详情 ",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "pc/order/detail";
	}

	/**
	 * 订单取消
	 * @param orderId
	 * @return
	 * @throws JSONException 
	 */
	@RequestMapping(value="/pc/pv/order/cancel",method = {RequestMethod.POST,RequestMethod.GET}, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String cancel(Long orderId) throws JSONException{
		try {
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			Map<String, Object> map = orderService.updateOrderCancel(userId,orderId);
			
			Status status = (Status)map.get("status");
			
			this.putJsonStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("取消订单 ",e);
			this.putJsonStatus(Status.serverError);
		}
		return this.outputJson();
	}
	
	/**
	 * 订单删除
	 * @param orderId
	 * @return
	 * @throws JSONException
	 */
	@RequestMapping(value="/pc/pv/order/del",method = {RequestMethod.POST,RequestMethod.GET}, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String delete(Long orderId) throws JSONException{
		try {
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			Status status = orderService.updateOrderDelete(userId,orderId);
			
			this.putJsonStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("删除订单 ",e);
			this.putJsonStatus(Status.serverError);
		}
		return this.outputJson();
	}
	
	/**
	 * 确认收货
	 * @param orderId
	 * @return
	 * @throws JSONException
	 */
	@RequestMapping(value="/pc/pv/order/confirm",method = {RequestMethod.POST,RequestMethod.GET},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String orderConfirm(Long orderId) throws JSONException{
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			Status status = orderService.updateOrderConfirmReceive(userId,orderId);
			
			this.putJsonStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("确认收货 ",e);
			this.putJsonStatus(Status.serverError);
		}
		return this.outputJson();
	}
	
	/**
	 * 订单提交确认
	 * @param projectId
	 * @param num
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/pc/pv/order/submitConfirm",method = {RequestMethod.POST,RequestMethod.GET})
	public String submitConfirm(Long projectId, Integer num) throws Exception {
		
		UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		
		Long userId = null != user ? user.getUserId() : null;
		
		PanicbuyProject project = panicbuyProjectService.selectByPrimaryKey(projectId);
		if(project==null){
			return "redirect:/pc/pnv/inShopping";
		}
		
		request.setAttribute("proj", project);
		request.setAttribute("num", num);
		request.setAttribute("leftCount", project.getLeftNum());
		//用户协议
		request.setAttribute("protocol", commonService.selectProtocol("BJWG_SERVICE_PROTOCOL.TYPE.PROJECT"));
		
		return "/pc/order/orderConfirm";
	}
	
	/**
	 * 订单提交
	 * @param projectId
	 * @param num
	 * @param remark
	 * @return
	 * @throws JSONException 
	 */
	@RequestMapping(value="/pc/pv/order/submit",method = {RequestMethod.POST,RequestMethod.GET}, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String orderSubmit(Long projectId, Integer num, String remark) throws JSONException{
		
		Status status = null;
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			Map<String, Object> map = orderService.insert(userId,projectId.toString(),num.toString(),remark);
			
			status = (Status)map.get("status");
			
			Order order = (Order)map.get("order");
			
			
			if(Status.success == status){
				
				request.setAttribute("order", order);
				
				String limitHous = sysConfigService.queryOneValue(SysConstant.ORDER_PAY_OVER_LIMIT_HOURS);
				
				SMSUtil.sendOne(user.getBindPhone(), "尊敬的客户：您于"+MyUtils.getYYYYMMDDHHmmss(0)+"在八戒王国下单成功，订单编号为:"+order.getOrderCode()+"，请于"+limitHous+"分钟内支付，否则订单将自动取消。");
				
				this.putJsonData(new JSONObject().put("redirectUrl", "pc/pv/order/choosePay?orderId="+order.getOrderId()));
			}
			this.putJsonStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("提交订单出错",e);
			this.putJsonStatus(Status.serverError);
		}
		return this.outputJson();
	}
	
	/**
	 * 选择支付方式
	 * @param orderId
	 * @return
	 */
	@RequestMapping(value="/pc/pv/order/choosePay",method = {RequestMethod.POST,RequestMethod.GET})
	public String choosePay(Long orderId){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			//根据查询id
			Order order = orderService.queryByOrderId(orderId.toString()); 
			
			//查询账户余额 付款
//			Wallet wallet = walletService.queryByUserId(userId);
			
			//余额是否可支付
//			request.setAttribute("walletCanPay", (wallet != null && order !=null && wallet.getMoney().doubleValue() >= order.getTotalMoney().doubleValue()));
			
//			if(null != wallet){
//				
//				request.setAttribute("balance", wallet);
//			}
			if(null != order){
				
				if(order == null || null == user || order.getUserId().longValue() != user.getUserId().longValue()){
					
					this.notifyMsg(request, Status.orderDataError);
					
					return "redirect:/pc/pv/order/list";
				}
				if(order.getStatus() != OrderConstant.ORDER_STATUS_1 && order.getStatus() != OrderConstant.ORDER_STATUS_2){
					
					this.notifyMsg(request, Status.orderCannotPay);
					
					return "redirect:/pc/pv/order/list";
				}
				
				//订单id
				request.setAttribute("order", order);
				
				//支付超时
				if(order.getOverTime().before(new Date())){
					
					//this.notifyMsg(request, Status.orderCannotPayOverTime);
					
					//return this.orderList(request);
					request.setAttribute("overTime", true);
				}
				String limitMin = sysConfigService.queryOneValue(SysConstant.ORDER_PAY_OVER_LIMIT_HOURS);
				
				request.setAttribute("limitMin", limitMin);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("选择支付出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "/pc/order/choosePay";
	}
	
	/**
	 * 余额支付
	 * @param orderId
	 * @param password
	 * @return
	 * @throws JSONException 
	 */
	@RequestMapping(value="/pc/pv/order/walletPay",method = {RequestMethod.POST,RequestMethod.GET},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String walletPay(Long orderId, String password) throws JSONException{
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			Status status = orderService.updateOrderPayed(orderId.toString(), userId ,password);
			
			if(Status.success == status){
				
				//跳转订单列表页面
				//return orderDetail(request);
			}
			this.putJsonStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("余额支付出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return this.outputJson();
	}
	
	/**
	 * 支付宝支付
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/pc/pv/order/alipayPay",method = {RequestMethod.POST,RequestMethod.GET})
	public String alipayPay(Long orderId){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/oralipayPay -- > user:"+user + " --> userId:"+userId);
			
			request.setAttribute("orderId", orderId);
			
			//查询订单信息
			Order order = orderService.queryByOrderId(orderId.toString());
			
			if(order == null || null == user || order.getUserId().longValue() != user.getUserId().longValue()){
				
				this.notifyMsg(request, Status.orderDataError);
				
				return "redirect:/pc/pv/order/list";
			}
			if(order.getStatus() != OrderConstant.ORDER_STATUS_1 && order.getStatus() != OrderConstant.ORDER_STATUS_2){
				
				this.notifyMsg(request, Status.orderCannotPay);
				
				return "redirect:/pc/pv/order/list";
			}
			
			//支付超时
			if(order.getOverTime().before(new Date())){
				
				this.notifyMsg(request, Status.orderCannotPayOverTime);
				
				return this.detail(orderId);
			}
			
			Order updateOrder = new Order();
			//更新状态为付款中
			updateOrder.setStatus(OrderConstant.ORDER_STATUS_2);
			updateOrder.setOrderId(order.getOrderId());
			orderService.updateByPrimaryKeySelective(updateOrder);
			
			request.setAttribute("order", order);
			
			request.setAttribute("projectUrl", sysConfigService.queryOneValue(SysConstant.PROJECT_ACCESS_URL_PC));
			
			String[] aplipayConfig = sysConfigService.queryAlipayKey();
			
			request.setAttribute("ap", aplipayConfig[0]);
			request.setAttribute("apk", aplipayConfig[1]);
			request.setAttribute("as", aplipayConfig[2]);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("支付宝支付出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "/pc/pay/alipayapi";
	}
	
	/*private static final String transResvered = "trans_";
	private static final String cardResvered = "card_"; 
	private static final String transResveredKey = "TranReserved";
	private static final String cardResveredKey = "CardTranData"; */
	private static final String signatureField = "Signature";
	
	/**
	 * 银联支付
	 * @param orderId
	 * @return
	 */
	@RequestMapping(value="/pc/pv/order/unionpayPay",method = {RequestMethod.POST,RequestMethod.GET})
	public String unionpayPay(Long orderId){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/pc/pv/order/unionpayPay -- > user:"+user + " --> userId:"+userId);
			
			//查询订单信息
			Order order = orderService.queryByOrderId(orderId.toString());
			if(order == null || null == user || order.getUserId().longValue() != user.getUserId().longValue()){
				this.notifyMsg(request, Status.orderDataError);
				return "redirect:/pc/pv/order/list";
			}
			
			if(order == null || null == user || order.getUserId().longValue() != user.getUserId().longValue()){
				
				this.notifyMsg(request, Status.orderDataError);
				
				return "redirect:/pc/pv/order/list";
			}
			if(order.getStatus() != OrderConstant.ORDER_STATUS_1 && order.getStatus() != OrderConstant.ORDER_STATUS_2){
				
				this.notifyMsg(request, Status.orderCannotPay);
				
				return "redirect:/pc/pv/order/list";
			}
			
			//支付超时
			if(order.getOverTime().before(new Date())){
				this.notifyMsg(request, Status.orderCannotPayOverTime);
				return this.detail(orderId);
			}
			
			Order updateOrder = new Order();
			//更新状态为付款中
			updateOrder.setStatus(OrderConstant.ORDER_STATUS_2);
			updateOrder.setOrderId(order.getOrderId());
			orderService.updateByPrimaryKeySelective(updateOrder);
			
			//Enumeration<String> requestNames = request.getParameterNames(); 
			//交易扩展域信息
			//JSONObject transResvedJson = new JSONObject();
			//有卡信息域信息-需要签名加密
			//JSONObject cardInfoJson = new JSONObject();
			
			String projectUrl = sysConfigService.queryOneValue(SysConstant.PROJECT_ACCESS_URL_PC);
			
			Map<String, Object> sendMap = new HashMap<String,Object>();
			//商户id
			sendMap.put("MerId", sysConfigService.queryOneValue(SysConstant.UNIONPAY_PARTNER_KEY));
			
			System.out.println("order.get"+order.getOrderCode());
			//订单号
			sendMap.put("MerOrderNo", order.getOrderCode());
			//订单金额(分)
			sendMap.put("OrderAmt", Integer.toString(order.getTotalMoney().multiply(BigDecimal.valueOf(100)).intValue()));
			Date now = new Date();
			//交易日期(8位数字，为订单提交日期)
			sendMap.put("TranDate", new SimpleDateFormat("yyyyMMdd").format(now));
			//交易时间 (6位数字，为订单提交时间)
			sendMap.put("TranTime", new SimpleDateFormat("HHmmss").format(now));
			//交易类型(网银支付交易为0001)
			sendMap.put("TranType", "0001");
			//业务类型(固定值)
			sendMap.put("BusiType", "0001");
			//版本号(8位数字，支付接口版本号)
			sendMap.put("Version", "20140728");
			//交易币种
			sendMap.put("CurryNo", "CNY");
			//接入类型 (1位数字，默认:0,表示接入类型[0:以商户身份接入；1:以机构身份接入])
			sendMap.put("AccessType", "0");
			//支付成功跳转URL
			sendMap.put("MerPageUrl", projectUrl + "/pc/pv/order/detail?orderId=" + order.getOrderId());
			//后台通知URL
			sendMap.put("MerBgUrl", projectUrl + "/pc/unionpay/notify");
			
			
			/*while(requestNames.hasMoreElements()){
				String key = requestNames.nextElement();
				String value = request.getParameter(key);
				
				//过滤空值
				if(StringUtil.isEmpty(value)){
					continue;
				}
				
				if(key.startsWith(transResvered)){
					//组装交易扩展域
					key = key.substring(transResvered.length());
					transResvedJson.put(key, value);
				}else if(key.startsWith(cardResvered)){
					//组装有卡交易信息域
					key = key.substring(cardResvered.length());
					cardInfoJson.put(key, value);
				}else{
					sendMap.put(key, value);
				}
				sendMap.put(key, value);
			}
			String transResvedStr = null;
			String cardResvedStr = null;
			if(cardInfoJson.length()!=0)
				cardResvedStr=cardInfoJson.toString();
			if(transResvedJson.length()!=0)
				transResvedStr = transResvedJson.toString();
			//敏感信息加密处理
			if(StringUtil.isNotEmpty(cardResvedStr)){
				cardResvedStr = SignUtil.decryptData(cardResvedStr);
				sendMap.put(cardResveredKey, cardResvedStr);
			}
			if(StringUtil.isNotEmpty(transResvedStr)){
				sendMap.put(transResveredKey, transResvedStr);
			}*/
			//商户签名
			String signature = SignUtil.sign(sendMap);
			sendMap.put(signatureField, signature);
			
			System.out.println(sendMap);
			for(Map.Entry<String, Object> entry:sendMap.entrySet()){
				request.setAttribute(entry.getKey(), entry.getValue());
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("银联支付出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		return "/pc/pay/unionpayapi";
	}
	
	/**
	 * 银联支付(无卡)
	 * @param orderId
	 * @return
	 */
	@RequestMapping(value="/pc/pv/order/unionpayPay2",method = {RequestMethod.POST,RequestMethod.GET})
	public String unionpayPay2(Long orderId){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/pc/pv/order/unionpayPay -- > user:"+user + " --> userId:"+userId);
			
			//查询订单信息
			Order order = orderService.queryByOrderId(orderId.toString());
			if(order == null || null == user || order.getUserId().longValue() != user.getUserId().longValue()){
				this.notifyMsg(request, Status.orderDataError);
				return "redirect:/pc/pv/order/list";
			}
			
			if(order == null || null == user || order.getUserId().longValue() != user.getUserId().longValue()){
				
				this.notifyMsg(request, Status.orderDataError);
				
				return "redirect:/pc/pv/order/list";
			}
			if(order.getStatus() != OrderConstant.ORDER_STATUS_1 && order.getStatus() != OrderConstant.ORDER_STATUS_2){
				
				this.notifyMsg(request, Status.orderCannotPay);
				
				return "redirect:/pc/pv/order/list";
			}
			
			//支付超时
			if(order.getOverTime().before(new Date())){
				this.notifyMsg(request, Status.orderCannotPayOverTime);
				return this.detail(orderId);
			}
			
			Order updateOrder = new Order();
			//更新状态为付款中
			updateOrder.setStatus(OrderConstant.ORDER_STATUS_2);
			updateOrder.setOrderId(order.getOrderId());
			orderService.updateByPrimaryKeySelective(updateOrder);
			
			//Enumeration<String> requestNames = request.getParameterNames(); 
			//交易扩展域信息
			//JSONObject transResvedJson = new JSONObject();
			//有卡信息域信息-需要签名加密
			//JSONObject cardInfoJson = new JSONObject();
			
			String projectUrl = sysConfigService.queryOneValue(SysConstant.PROJECT_ACCESS_URL_PC);
			
			Map<String, Object> sendMap = new HashMap<String,Object>();
			//商户id
			//sendMap.put("MerId", sysConfigService.queryOneValue(SysConstant.UNIONPAY_PARTNER_KEY));
			sendMap.put("MerId", "899901510082935");
			//订单号
			sendMap.put("MerOrderNo", order.getOrderCode());
			//订单金额(分)
			sendMap.put("OrderAmt", Integer.toString(order.getTotalMoney().multiply(BigDecimal.valueOf(100)).intValue()));
			Date now = new Date();
			//交易日期(8位数字，为订单提交日期)
			sendMap.put("TranDate", new SimpleDateFormat("yyyyMMdd").format(now));
			//交易时间 (6位数字，为订单提交时间)
			sendMap.put("TranTime", new SimpleDateFormat("HHmmss").format(now));
			//交易类型(网银支付交易为0001)
			sendMap.put("TranType", "0001");
			//业务类型(固定值)
			sendMap.put("BusiType", "0001");
			//版本号(8位数字，支付接口版本号)
			sendMap.put("Version", "20140728");
			//交易币种
			sendMap.put("CurryNo", "CNY");
			//接入类型 (1位数字，默认:0,表示接入类型[0:以商户身份接入；1:以机构身份接入])
			sendMap.put("AccessType", "0");
			//支付成功跳转URL
			sendMap.put("MerPageUrl", projectUrl + "/pc/pv/order/detail?orderId=" + order.getOrderId());
			//后台通知URL
			sendMap.put("MerBgUrl", projectUrl + "/pc/unionpay/notify2");
			
			
			/*while(requestNames.hasMoreElements()){
				String key = requestNames.nextElement();
				String value = request.getParameter(key);
				
				//过滤空值
				if(StringUtil.isEmpty(value)){
					continue;
				}
				
				if(key.startsWith(transResvered)){
					//组装交易扩展域
					key = key.substring(transResvered.length());
					transResvedJson.put(key, value);
				}else if(key.startsWith(cardResvered)){
					//组装有卡交易信息域
					key = key.substring(cardResvered.length());
					cardInfoJson.put(key, value);
				}else{
					sendMap.put(key, value);
				}
				sendMap.put(key, value);
			}
			String transResvedStr = null;
			String cardResvedStr = null;
			if(cardInfoJson.length()!=0)
				cardResvedStr=cardInfoJson.toString();
			if(transResvedJson.length()!=0)
				transResvedStr = transResvedJson.toString();
			//敏感信息加密处理
			if(StringUtil.isNotEmpty(cardResvedStr)){
				cardResvedStr = SignUtil.decryptData(cardResvedStr);
				sendMap.put(cardResveredKey, cardResvedStr);
			}
			if(StringUtil.isNotEmpty(transResvedStr)){
				sendMap.put(transResveredKey, transResvedStr);
			}*/
			//商户签名
			String signature = com.bjwg.main.chinapay2.util.SignUtil.sign(sendMap);
			sendMap.put(signatureField, signature);
			
			System.out.println(sendMap);
			for(Map.Entry<String, Object> entry:sendMap.entrySet()){
				request.setAttribute(entry.getKey(), entry.getValue());
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("银联支付出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		return "/pc/pay/unionpayapi2";
	}
	
	/**
	 * 回报选择
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pv/order/paybackChoose",method = {RequestMethod.GET,RequestMethod.POST})
	public String paybackChoose(Long projectId, Integer way) throws Exception{
		
		try {
			this.setAttr(request);
			request.setAttribute("projectId", projectId);
			request.setAttribute("way", way);
			
			List<String> codeList = null;
			
			List<SysConfig> configList = null;
			
			//codeList = new ArrayList<String>(Arrays.asList(SysConstant.REPAY_TYPE+"_"+repayTypeId));
			codeList = new ArrayList<String>();
			
			//粗分割规格
			request.setAttribute("diviList", dictService.queryListByParentCode(DictConstant.THICK_TYPE));
			
			List<DictDetail> dics = dictService.queryListByParentCode(DictConstant.THICK_TYPE);
			
			codeList.add(SysConstant.DIVISION_THICK_FEE);
			codeList.add(SysConstant.DIVISION_THIN_FEE);
			codeList.add(SysConstant.PACKAGE_FEE);
			codeList.add(SysConstant.PACKAGE_SPECS);
			
			configList = sysConfigService.queryList(codeList);
			
			//粗分割价格
			request.setAttribute("divi_big_price", configList.get(0).getValue());
			//细分割价格
			request.setAttribute("divi_small_price", configList.get(1).getValue());
			//真空包装价格
			request.setAttribute("divi_pkg_price", configList.get(2).getValue());
			
			List<String> specList = new ArrayList<String>();
			for (SysConfig sysConfig : configList) {
				if(SysConstant.PACKAGE_SPECS.equals(sysConfig.getCode())){
					specList.addAll(Arrays.asList(sysConfig.getValue().split(",")));
					break;
				}
			}
			
			//真空包装规格
			request.setAttribute("packageList", specList);
			
			request.setAttribute("configList", configList);
			
			
			//查询猪肉券额度配置项与使用地区
			codeList = new ArrayList<String>(Arrays.asList(SysConstant.REPAY_TYPE,SysConstant.PIG_COUPON_MONEY,SysConstant.PIG_COUPON_CAN_USE_CITY));
			configList = sysConfigService.queryList(codeList);
			
			for (SysConfig sysConfig : configList) {
				
				if(sysConfig.getCode().equals(SysConstant.PIG_COUPON_CAN_USE_CITY)){
					
					String[] citys = sysConfig.getValue().split(",");
					
					StringBuffer stringBuffer = new StringBuffer("");
					
					for (String city : citys) {
						
						stringBuffer.append(PhoneBaseData.getInstance().getArea_V2Name(city)+",");
					}
					
					//猪肉券限领地区
					request.setAttribute("limitCity", stringBuffer.substring(0,stringBuffer.length() - 1));
				}else if(sysConfig.getCode().equals(SysConstant.PIG_COUPON_MONEY)){
					request.setAttribute("ticketMoney", sysConfig.getValue());
				}
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("选择回报方式",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		//入口页面
		return "/pc/order/paybackChoose";
	}
	
	/**
	 * 保存回报选择
	 * @param payback
	 * @param projectId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pv/order/savePaybackChoose",method = {RequestMethod.GET,RequestMethod.POST})
	public String savePaybackChoose(Integer payback,Integer lastPayback, Long projectId) throws Exception{
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			//分割类型
			String divisionType = request.getParameter("divisionType");
			
			//分割类型明细(几分体)
			String divisionTypeDetail = request.getParameter("divisionTypeDetail");
			
			//包装规格
			String packageSpec = request.getParameter("packageSpec");
			
			//如果是1,4回报方式直接保存, 2,3需要提交订单
			Map<String, Object> map = myEarningsService.saveRepayType(userId, payback.toString(), projectId.toString(), divisionType, divisionTypeDetail, packageSpec);
			
			Status status = (Status)map.get("status");
			
			if(Status.success == status){
				
				if(payback.intValue() == 2 || payback.intValue() == 3){
					request.setAttribute("dataMap", map);
					
					//将参数放入到session中，因为这里会选择收货地址，可能会经过多次跳转，每次页面传参十分麻烦。
					/*Map<String, String> sessionMap = new HashMap<String, String>();
					sessionMap.put("repayTypeId", payback.toString());
					sessionMap.put("queryProjectId", projectId.toString());
					sessionMap.put("divisionType", divisionType);
					sessionMap.put("divisionTypeDetail", divisionTypeDetail);
					sessionMap.put("packageSpec", packageSpec);
					request.getSession().setAttribute("wlsaveRepayTypeSessionMap", sessionMap);*/
					
					/*UserAddress address = (UserAddress)map.get("userAddress");
					if(address != null){
						
						address.setAddress(MyUtils.getCompleteAddress(address.getProvince(), address.getCity(), address.getAddress()));
						
						map.put("userAddress",address);
					}*/
					
					//查询用户地址列表
					List<UserAddress> addressList = userService.getUserId(user.getUserId());
					List<UserAddress> userList = new ArrayList<UserAddress>();
					if (!MyUtils.isListEmpty(addressList)) {
						for (UserAddress userAddress : addressList) {
							// 拼接地址
							String provinceName = PhoneBaseData.getInstance().getArea_V2Name(userAddress.getProvince()+"");
							String cityName = PhoneBaseData.getInstance().getArea_V2Name(userAddress.getCity()+"");

							if (provinceName == "null" || provinceName == null) {
								provinceName = "";
							}
							if (cityName == "null" || cityName == null) {
								cityName = "";
							}
							if (provinceName.equals(cityName)) {
								cityName = "";
							}
							userAddress.setAddress(provinceName + cityName + userAddress.getAddress());

							userList.add(userAddress);
							
							//如果是默认地址则排序至第一个
							if(userAddress.getIsDefault()==1){
								UserAddress address = userList.get(0);
								userList.set(0, userAddress);
								userList.set(userList.size()-1, address);
							}
						}
						
					}
					request.setAttribute("addressList", userList);
					
					request.setAttribute("payback", payback);
					request.setAttribute("projectId", projectId);
					request.setAttribute("divisionType", divisionType);
					request.setAttribute("divisionTypeDetail", divisionTypeDetail);
					request.setAttribute("packageSpec", packageSpec);
					
					//屠宰配送费用订单提交页
					return "/pc/order/paybackOrderConfirm";
				}
				return this.paybackChoose(projectId, payback);
			}
			
			this.notifyMsg(request, status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("选择回报方式",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return this.paybackChoose(projectId, lastPayback);
	}
	
	/**
	 * 活猪配送
	 * @param projectId
	 * @param addressId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pv/order/payback3OrderSubmit",method = {RequestMethod.GET,RequestMethod.POST})
	public String payback3OrderSubmit(Long projectId, Long addressId) throws Exception{
		
		try {
			
			this.setAttr(request);
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			Map<String, Object> map = orderService.insertPigOrder(userId,projectId.toString(),addressId.toString());
			
			Status status = (Status)map.get("status");
			
			if(Status.success == status){
				
				Order order = (Order)map.get("order");
				
				if(OrderConstant.ORDER_STATUS_4 == order.getStatus()){
					
					return "redirect:/pc/pv/order/detail?orderId="+order.getOrderId();
				}else{
					
					return "redirect:/pc/pv/order/choosePay?orderId="+order.getOrderId();
				}
			}
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("选择回报方式",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		//屠宰计算所有费用的页面
		//return wlsaveRepayType(request);
		return "redirect:/pc/pv/user/farm";
	}

	/**
	 * 屠宰配送
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pv/order/payback2OrderSubmit",method = {RequestMethod.GET,RequestMethod.POST})
	public String payback2OrderSubmit() throws Exception{
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			String queryProjectId = request.getParameter("projectId");
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
				
				return "redirect:/pc/pv/order/choosePay?orderId="+order.getOrderId();
			}
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("选择回报方式",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		//屠宰计算所有费用的页面
		return "";
	}
	
	
}















