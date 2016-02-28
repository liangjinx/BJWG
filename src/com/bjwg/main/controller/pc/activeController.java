package com.bjwg.main.controller.pc;

import java.math.BigDecimal;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.chinapay.util.SignUtil;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.OrderConstant;
import com.bjwg.main.constant.SysConstant;

import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.Active;
import com.bjwg.main.model.ActiveOrder;
import com.bjwg.main.model.ActiveWinning;
import com.bjwg.main.model.Order;
import com.bjwg.main.model.User;

import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.service.ActiveService;
import com.bjwg.main.service.CommonService;
import com.bjwg.main.service.OrderService;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.service.UserService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.JsonUtils;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.RandomUtils;
import com.bjwg.main.util.SMSUtil;





/**
 * @author Carter
 * @version 创建时间：Sep 14, 2015 2:24:50 PM
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Controller("pc_active_controller")
@Scope("prototype")
public class activeController extends BaseController {


	
	@Autowired
	CommonService commonService;
	@Autowired
	ActiveService activeService;
	@Autowired
	SysConfigService sysConfigService;
	@Autowired
	UserService userService;
	/**
	 * 活动主页
	 * @return
	 */
	@RequestMapping(value = "/pc/pnv/activeIndex", method = { RequestMethod.GET,RequestMethod.POST })
	public String activeIndex(){
		
		Active ac1=activeService.selectByPrimaryKey(1L);
		Active ac2=activeService.selectByPrimaryKey(2L);
		request.setAttribute("ac1", ac1);
		request.setAttribute("ac2", ac2);
		
		/**
		 * 查询中奖期数
		 * 
		 */
		int i1=activeService.selectCount(1L);
		int i2=activeService.selectCount(2L);
	request.getSession().setAttribute("periods1", i1+1);
		request.getSession().setAttribute("periods2", i2+1);
		/**
		 * 查询中奖纪录
		 */
		List<ActiveWinning> activeWinnings1=activeService.selectWinningList(1L);
		ActiveWinning aw1=null;
		ActiveWinning aw2=null;
		if(activeWinnings1!=null &&activeWinnings1.size()>0){
			
 aw1=activeWinnings1.get(activeWinnings1.size()-1);
		}
		
		List<ActiveWinning> activeWinnings2=activeService.selectWinningList(2L);
		if(activeWinnings2!=null && activeWinnings2.size()>0){
			
		 aw2=activeWinnings2.get(activeWinnings2.size()-1);
				}
		request.setAttribute("aw1", aw1);
		request.setAttribute("aw2", aw2);
		/*List<Active> acts=activeService.selectList();
		System.out.println(acts.size());*/
		return "/pc/active/activeIndex";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 查询剩余号码个数
	 * 
	 */
	
	@RequestMapping(value = "/pc/pnv/remindCount", method = {RequestMethod.POST }, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String remindCount() throws JSONException{
	
		JSONObject jsonObject = new JSONObject();
		String activeId=request.getParameter("activeId");
		ActiveOrder activeOrder=new ActiveOrder();
		
		activeOrder.setActiveId(Long.valueOf(activeId));
		activeOrder.setStatus((byte)2);
		List<ActiveOrder> activeOrders=activeService.selectWinningCode(activeOrder);
		
		int remindCount=300-activeOrders.size();
		 
	
			 jsonObject=JsonUtils.getJsonObject(-114,"remindCount",remindCount);
			 
		
	            
		
		return jsonObject.toString();
	}
	
	
	
	
	
	
	
	
	/**
	 * 判断是否抢完
	 * @throws Exception 
	 * 
	 */
	@RequestMapping(value = "/pc/pnv/selectCount", method = {RequestMethod.POST }, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String selectCount() throws Exception{
	
		JSONObject jsonObject = new JSONObject();
		String activeId=request.getParameter("activeId");
		ActiveOrder activeOrder=new ActiveOrder();
		
		activeOrder.setActiveId(Long.valueOf(activeId));
		activeOrder.setStatus((byte)2);
		List<ActiveOrder> activeOrders=activeService.selectWinningCode(activeOrder);
		
		
		 
		 
		 if(activeOrders.size()<=300){
			jsonObject=JsonUtils.getJsonObject(Status.success);
			return jsonObject.toString();
		}
		 else{
			 int x=(int)(Math.random()*300);
			 ActiveOrder winningOrder=activeOrders.get(x);
			 /**
			  * 添加中奖纪录
			  */
			 User user=userService.getById(winningOrder.getUserId());
			 ActiveWinning activeWinning=new ActiveWinning();
			 activeWinning.setUserId(user.getUserId());
			 activeWinning.setPhone(user.getPhone());
			 activeWinning.setRealName(user.getUsername());
			 activeWinning.setWinningCode(winningOrder.getOrderId());
			 activeWinning.setActiveId(winningOrder.getActiveId());
			 activeService.insertWinning(activeWinning);
			 
		/**
		 * 删除纪录，开始新的一期
		 */
			
			 activeService.deleteAll(winningOrder.getActiveId());
			 
			 jsonObject=JsonUtils.getJsonObject(Status.restart);
			 
		 }
	            
		jsonObject=JsonUtils.getJsonObject(Status.buyFinish);
		return jsonObject.toString();
	}
	
	
	
	
	
	
	
	
	/**
	 * 购买猪头传递参数
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/pc/pnv/activeSub1", method = {RequestMethod.POST }, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String activeSub1() throws Exception{
		JSONObject jsonObject = new JSONObject();
		UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);

		if(user==null){
			jsonObject=JsonUtils.getJsonObject(Status.loginActive);
			
		}else{
			
			String activeId=request.getParameter("activeId");
			Active ac=activeService.selectByPrimaryKey(Long.parseLong(activeId));
		String count=request.getParameter("count");
		
		System.out.println("--------------");
		System.out.println("数量"+count);
		/**
		 * 判断是否留有这么多的号码
		 */
        ActiveOrder activeOrder2=new ActiveOrder();
		
		activeOrder2.setActiveId(Long.valueOf(activeId));
		activeOrder2.setStatus((byte)2);
		 List<ActiveOrder> activeOrders=activeService.selectWinningCode(activeOrder2);
		if((activeOrders.size()+(short)Integer.parseInt(count))>300){
			jsonObject=JsonUtils.getJsonObject(Status.outofCode);
			return jsonObject.toString();
		}
		
		
		//订单填充
		ActiveOrder activeOrder=new ActiveOrder();
		activeOrder.setCount((short)Integer.parseInt(count));
		activeOrder.setOrderCode(RandomUtils.getOrderCode());
		activeOrder.setActiveId(1L);
		activeOrder.setPrice(new BigDecimal(0.01));
		activeOrder.setStatus((byte)1);
		BigDecimal total=new BigDecimal(Integer.parseInt(count)).multiply(new BigDecimal(0.01));
		activeOrder.setTotalPrice(total);
		activeOrder.setUserId(user.getUserId());
		//订单生成
		//activeService.insertOrder(activeOrder);
	
		request.getSession().setAttribute("activeOrder", activeOrder);
		jsonObject=JsonUtils.getJsonObject(Status.success);
		
		}
		
		return jsonObject.toString();
	}
	
	
	
	/**
	 * 购买猪头传递参数
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/pc/pnv/activeSub2",method = {RequestMethod.POST }, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String activeSub2() throws Exception{
		JSONObject jsonObject = new JSONObject();
		UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);

		if(user==null){
			jsonObject=JsonUtils.getJsonObject(Status.loginActive);
			
		}else{
			
			String activeId=request.getParameter("activeId");
			Active ac=activeService.selectByPrimaryKey(Long.parseLong(activeId));
		String count=request.getParameter("count");
		
		
		
		/**
		 * 判断是否留有这么多的号码
		 */
        ActiveOrder activeOrder2=new ActiveOrder();
		
		activeOrder2.setActiveId(Long.valueOf(activeId));
		activeOrder2.setStatus((byte)2);
		 List<ActiveOrder> activeOrders=activeService.selectWinningCode(activeOrder2);
		if((activeOrders.size()+(short)Integer.parseInt(count))>300){
			jsonObject=JsonUtils.getJsonObject(Status.outofCode);
			return jsonObject.toString();
		}
		
		
		
		
		//订单填充
		ActiveOrder activeOrder=new ActiveOrder();
		activeOrder.setCount((short)Integer.parseInt(count));
		activeOrder.setOrderCode(RandomUtils.getOrderCode());
		activeOrder.setActiveId(2L);
	/*	DecimalFormat df = new DecimalFormat("0.00");
		df.format((new BigDecimal(0.01)));*/
		activeOrder.setPrice(new BigDecimal(0.01));
		
		
		System.out.println("price"+new BigDecimal(0.01));
		
		activeOrder.setStatus((byte)1);
		BigDecimal total=new BigDecimal(Integer.parseInt(count)).multiply(new BigDecimal(0.01));
		activeOrder.setTotalPrice(total);
		activeOrder.setUserId(user.getUserId());
		//订单生成
		//activeService.insertOrder(activeOrder);
		
		request.getSession().setAttribute("activeOrder", activeOrder);
		jsonObject=JsonUtils.getJsonObject(Status.success);
		
		}
		
		return jsonObject.toString();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 跳转确认订单
	 * 
	 */
	@RequestMapping(value = "/pc/active/orderConfirm", method = { RequestMethod.GET,RequestMethod.POST })
	public String orderConfirm(){
		ActiveOrder activeOrder=(ActiveOrder)request.getSession().getAttribute("activeOrder");

		DecimalFormat df = new DecimalFormat("0.00");
		
		   request.setAttribute("price",df.format((activeOrder.getPrice())));
		   request.setAttribute("totalPrice", df.format((activeOrder.getTotalPrice())));
		return "/pc/active/orderConfirm";
	}
	
	
	
	
	/**
	 * 订单提交
	 * @param projectId
	 * @param num
	 * @param remark
	 * @return
	 * @throws JSONException 
	 */
	@RequestMapping(value="/pc/pv/activeorder/submit",method = {RequestMethod.POST,RequestMethod.GET}, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String orderSubmit() throws JSONException{
		
		Status status = null;
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ActiveOrder activeOrder=(ActiveOrder)request.getSession().getAttribute("activeOrder");
		int flag=0;
			for (int i = 0; i <activeOrder.getCount(); i++) {
				if(i>0){
				activeOrder.setTotalPrice(new BigDecimal(0));}	
				
				flag=activeService.insertOrder(activeOrder);
			}
			
			 List<ActiveOrder> activeOrders=activeService.selectByCode(activeOrder.getOrderCode());
			activeOrder=activeOrders.get(0);
		if(flag>0){
			status=status.success;				
		}
		
		if(Status.success == status){
			request.getSession().removeAttribute("activeOrder");
				
				request.setAttribute("activeOrder", activeOrder);
				
				
				
				//SMSUtil.sendOne(user.getBindPhone(), "尊敬的客户：您于"+MyUtils.getYYYYMMDDHHmmss(0)+"在八戒王国下单成功，订单编号为:"+activeOrder.getOrderCode()+"，请于当天内支付，否则订单将自动取消。");
				
				this.putJsonData(new JSONObject().put("redirectUrl", "pc/pv/activeOrder/choosePay?orderId="+activeOrder.getOrderId()));
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
	@RequestMapping(value="/pc/pv/activeOrder/choosePay",method = {RequestMethod.POST,RequestMethod.GET})
	public String choosePay(Long orderId){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			//根据查询id
			ActiveOrder activeOrder=activeService.selectByorderId(orderId);
			
			//查询账户余额 付款
//			Wallet wallet = walletService.queryByUserId(userId);
			
			//余额是否可支付
//			request.setAttribute("walletCanPay", (wallet != null && order !=null && wallet.getMoney().doubleValue() >= order.getTotalMoney().doubleValue()));
			
//			if(null != wallet){
//				
//				request.setAttribute("balance", wallet);
//			}
			if(null != activeOrder){
				
				if(activeOrder == null || null == user || activeOrder.getUserId().longValue() != user.getUserId().longValue()){
					
					this.notifyMsg(request, Status.orderDataError);
					
					return "redirect:/pc/pnv/activeIndex";
				}
				/*if(activeOrder.getStatus() != OrderConstant.ORDER_STATUS_1 && activeOrder.getStatus() != OrderConstant.ORDER_STATUS_2){
					
					this.notifyMsg(request, Status.orderCannotPay);
					
					return "redirect:/pc/pv/order/list";
				}*/
				
				//订单id
				request.setAttribute("activeOrder", activeOrder);
				
				/*//支付超时
				if(activeOrder.getOverTime().before(new Date())){
					
					//this.notifyMsg(request, Status.orderCannotPayOverTime);
					
					//return this.orderList(request);
					request.setAttribute("overTime", true);
				}*/
				String limitMin = sysConfigService.queryOneValue(SysConstant.ORDER_PAY_OVER_LIMIT_HOURS);
				
				request.setAttribute("limitMin", limitMin);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("选择支付出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "/pc/active/choosePay";
	}
	
	
	
	/**
	 * 
	 * 三大支付方式
	 * 
	 */
	
	
	
	/**
	 * 支付宝支付
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/pc/pv/activeOrder/alipayPay",method = {RequestMethod.POST,RequestMethod.GET})
	public String alipayPay(Long orderId){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/oralipayPay -- > user:"+user + " --> userId:"+userId);
			
			request.setAttribute("orderId", orderId);
			
			//查询订单信息
			ActiveOrder activeOrder = activeService.selectByorderId(orderId);
			
			if(activeOrder == null || null == user || activeOrder.getUserId().longValue() != user.getUserId().longValue()){
				
				this.notifyMsg(request, Status.orderDataError);
				
				return "redirect:/pc/pnv/activeIndex";
			}
			/*if(activeOrder.getStatus() != OrderConstant.ORDER_STATUS_1 && order.getStatus() != OrderConstant.ORDER_STATUS_2){
				
				this.notifyMsg(request, Status.orderCannotPay);
				
				return "redirect:/pc/pv/order/list";
			}*/
			
		/*	//支付超时
			if(activeOrder.getOverTime().before(new Date())){
				
				this.notifyMsg(request, Status.orderCannotPayOverTime);
				
				return this.detail(orderId);
			}*/
			
			ActiveOrder updateOrder = new ActiveOrder();
			/*//更新状态为付款中
			updateOrder.setStatus(OrderConstant.ORDER_STATUS_2);
			updateOrder.setOrderId(updateOrder.getOrderId());
			activeService.updateStatus(updateOrder);
			*/
			request.setAttribute("activeOrder", activeOrder);
			
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
		
		return "/pc/active/alipayapi";
	}
	
	
private static final String signatureField = "Signature";

	/**
	 * 银联支付
	 * @param orderId
	 * @return
	 */
	@RequestMapping(value="/pc/pv/activeOrder/unionpayPay",method = {RequestMethod.POST,RequestMethod.GET})
	public String unionpayPay(Long orderId){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/pc/pv/order/unionpayPay -- > user:"+user + " --> userId:"+userId);
			
			//查询订单信息
			ActiveOrder activeOrder = activeService.selectByorderId(orderId);
			if(activeOrder == null || null == user || activeOrder.getUserId().longValue() != user.getUserId().longValue()){
				this.notifyMsg(request, Status.orderDataError);
				return "redirect:/pc/pnv/activeIndex";
			}
			
			
			/*if(order.getStatus() != OrderConstant.ORDER_STATUS_1 && order.getStatus() != OrderConstant.ORDER_STATUS_2){
				
				this.notifyMsg(request, Status.orderCannotPay);
				
				return "redirect:/pc/pv/order/list";
			}
			*/
			/*//支付超时
			if(activeOrder.getOverTime().before(new Date())){
				this.notifyMsg(request, Status.orderCannotPayOverTime);
				return this.detail(orderId);
			}
			*/
			/*Order updateOrder = new Order();
			//更新状态为付款中
			updateOrder.setStatus(OrderConstant.ORDER_STATUS_2);
			updateOrder.setOrderId(order.getOrderId());
			orderService.updateByPrimaryKeySelective(updateOrder);*/
			
			//Enumeration<String> requestNames = request.getParameterNames(); 
			//交易扩展域信息
			//JSONObject transResvedJson = new JSONObject();
			//有卡信息域信息-需要签名加密
			//JSONObject cardInfoJson = new JSONObject();
			
			String projectUrl = sysConfigService.queryOneValue(SysConstant.PROJECT_ACCESS_URL_PC);
			
			Map<String, Object> sendMap = new HashMap<String,Object>();
			//商户id
			sendMap.put("MerId", sysConfigService.queryOneValue(SysConstant.UNIONPAY_PARTNER_KEY));
			//订单号
			sendMap.put("MerOrderNo", activeOrder.getOrderCode());
			//订单金额(分)
			sendMap.put("OrderAmt", Integer.toString(activeOrder.getTotalPrice().multiply(BigDecimal.valueOf(100)).intValue()));
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
			sendMap.put("MerPageUrl",projectUrl+ "/pc/unionpay/notifybj");
			
			//后台通知URL
			sendMap.put("MerBgUrl",projectUrl+ "/pc/unionpay/notifybj");
			
			
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
		return "/pc/active/unionpayapi";
	}
	
	
	
	
	
	

	/**
	 * 银联支付(无卡)
	 * @param orderId
	 * @return
	 */
	@RequestMapping(value="/pc/pv/activeOrder/unionpayPay2",method = {RequestMethod.POST,RequestMethod.GET})
	public String unionpayPay2(Long orderId){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/pc/pv/order/unionpayPay -- > user:"+user + " --> userId:"+userId);
			
			//查询订单信息
			ActiveOrder activeOrder = activeService.selectByorderId(orderId);
			if(activeOrder == null || null == user || activeOrder.getUserId().longValue() != user.getUserId().longValue()){
				this.notifyMsg(request, Status.orderDataError);
				return "redirect:/pc/pnv/activeIndex";
			}
			
			
			/*if(order.getStatus() != OrderConstant.ORDER_STATUS_1 && order.getStatus() != OrderConstant.ORDER_STATUS_2){
				
				this.notifyMsg(request, Status.orderCannotPay);
				
				return "redirect:/pc/pv/order/list";
			}*/
			
			/*//支付超时
			if(order.getOverTime().before(new Date())){
				this.notifyMsg(request, Status.orderCannotPayOverTime);
				return this.detail(orderId);
			}*/
			
			/*Order updateOrder = new Order();
			//更新状态为付款中
			updateOrder.setStatus(OrderConstant.ORDER_STATUS_2);
			updateOrder.setOrderId(order.getOrderId());
			orderService.updateByPrimaryKeySelective(updateOrder);*/
			
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
			sendMap.put("MerOrderNo", activeOrder.getOrderCode());
			//订单金额(分)
			sendMap.put("OrderAmt", Integer.toString(activeOrder.getTotalPrice().multiply(BigDecimal.valueOf(100)).intValue()));
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
			sendMap.put("MerPageUrl", projectUrl + "/pc/unionpay/notifybj2");
			//后台通知URL
			sendMap.put("MerBgUrl", projectUrl + "/pc/unionpay/notifybj2");
			
			
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
		return "/pc/active/unionpayapi2";
	}
	

	
	/**
	 * 修改订单状态
	 * @return
	 */
	@RequestMapping(value = "/pc/pv/activeOrder/updateStatus", method = { RequestMethod.GET,RequestMethod.POST })
	public String updateStatus(){
		Long longid=(Long)request.getAttribute("yorderId");
	
		Long orderId=Long.valueOf(longid);
		request.getSession().removeAttribute("yorderId");
		ActiveOrder activeOrder=activeService.selectByorderId(orderId);
		activeOrder.setStatus((byte)2);
		activeService.updateStatus(activeOrder);
		
		
          UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		
		Long userId = null != user ? user.getUserId() : null;
		
		ConsoleUtil.println("/pc/pv/order/unionpayPay -- > user:"+user + " --> userId:"+userId);
		
		ActiveOrder activeOrder2=new ActiveOrder();
		activeOrder2.setUserId(userId);
		activeOrder2.setStatus((byte)2);
		activeOrder2.setActiveId(1L);
		List<ActiveOrder> activeOrders1=activeService.selectMywinningCode(activeOrder2);
		activeOrder2.setActiveId(2L);
		List<ActiveOrder> activeOrders2=activeService.selectMywinningCode(activeOrder2);
            
		request.setAttribute("myWinningCode1", activeOrders1);
		request.setAttribute("myWinningCode2", activeOrders2);
		
		return "/pc/active/myWinning";
	}
	
	
	/**
	 * 
	 * 查看总的开奖号码
	 */
	
	@RequestMapping(value = "/pc/pv/WinningCode", method = { RequestMethod.GET,RequestMethod.POST })
	public String selectCode(){
		
		UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		
		Long userId = null != user ? user.getUserId() : null;
		
		ConsoleUtil.println("/pc/pv/order/unionpayPay -- > user:"+user + " --> userId:"+userId);
		
		ActiveOrder activeOrder=new ActiveOrder();
		activeOrder.setActiveId((1L));
		activeOrder.setStatus((byte)2);
		List<ActiveOrder> activeOrders=activeService.selectWinningCode(activeOrder);
		
		ActiveOrder activeOrder2=new ActiveOrder();
		activeOrder2.setActiveId((2L));
		activeOrder2.setStatus((byte)2);
		List<ActiveOrder> activeOrders2=activeService.selectWinningCode(activeOrder);
		
		
		request.setAttribute("WinningCode1", activeOrders);
		request.setAttribute("WinningCode2", activeOrders2);
		return "redirect:/pc/pnv/activeIndex";
	}
	
	
	
	
	
	
	/**
	 * 
	 * 个人幸运号码查看
	 */
	
	@RequestMapping(value = "/pc/pv/myWinningCode", method = { RequestMethod.GET,RequestMethod.POST })
	public String selectMyCode(){
		
		UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		
		Long userId = null != user ? user.getUserId() : null;
		
		ConsoleUtil.println("/pc/pv/order/unionpayPay -- > user:"+user + " --> userId:"+userId);
		
		ActiveOrder activeOrder=new ActiveOrder();
		activeOrder.setUserId(userId);
		activeOrder.setStatus((byte)2);
		activeOrder.setActiveId(1L);
		List<ActiveOrder> activeOrders1=activeService.selectMywinningCode(activeOrder);
		activeOrder.setActiveId(2L);
		List<ActiveOrder> activeOrders2=activeService.selectMywinningCode(activeOrder);

		request.setAttribute("myWinningCode1", activeOrders1);
		request.setAttribute("myWinningCode2", activeOrders2);
		return "/pc/active/myWinning";
	}
	
	
	
}

