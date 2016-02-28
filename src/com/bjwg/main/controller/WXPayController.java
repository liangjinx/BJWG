package com.bjwg.main.controller;

import java.io.PrintWriter;
import java.util.SortedMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.service.OrderService;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.RequestHandler;
import com.bjwg.main.weixin.MessageUtil;

/**
 * 微信支付
 * @author Allen
 * @version 创建时间：2015-6-13 下午04:02:17
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Controller
@RequestMapping("/wxpay")
@Scope("prototype")
public class WXPayController extends BaseController{

	@Resource
	private OrderService orderService;
	@Resource
	private SysConfigService sysConfigService;
	
	/**
	 * 微信支付异步通知回调
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/notify",method = {RequestMethod.GET,RequestMethod.POST})
	public void payInit(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		
		SortedMap<String, String> paramsMap = MessageUtil.parseXml2(request);
	
		PrintWriter out = response.getWriter();
		
		String msg = "";
		if(paramsMap != null && paramsMap.size() > 0){
			
			String return_code = paramsMap.get("return_code");
			
			//交易成功
			if("SUCCESS".equals(return_code.toUpperCase())){
				
				String[] wxs = sysConfigService.queryWxAppidAndAppKey();
				//验证签名
				RequestHandler requestHandler = new RequestHandler(request, response);
				requestHandler.init(wxs[0], wxs[1], wxs[2]);
				String sign = requestHandler.createSign(paramsMap);
				
				if(sign.equals(paramsMap.get("sign"))){
					
					Status status = orderService.updateOrderWx(paramsMap.get("out_trade_no"), paramsMap.get("transaction_id"), paramsMap);
					
					if(status == Status.success){
						
						msg = "OK";
					}
					
				}else{
					
					msg = "签名验证失败";
				}
			}else{
				
				msg = "返回的参数为交易失败";
			}
		}else{
			
			msg = "未获取到回调的参数值";
		}
		ConsoleUtil.println("msg:"+msg);
		if("OK".equals(msg)){
			
			out.print("<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA["+msg+"]]></return_msg></xml>");
		}else{
			
			out.print("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA["+msg+"]]></return_msg></xml>");
		}
		
//		return "wxpay/wx_pay_result";
	}
	
	
	
}
