package com.bjwg.main.controller.pc;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bjwg.main.alipay.config.AlipayConfig;
import com.bjwg.main.alipay2.util.AlipayNotify;
import com.bjwg.main.base.BaseController;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.ActiveOrder;
import com.bjwg.main.service.ActiveService;
import com.bjwg.main.service.OrderService;

import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.util.XmlParseUtil;

/**
 * 支付宝回调控制器
 * @author Allen
 * @version 创建时间：2015-6-12 下午05:39:40
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Controller("pc_alipay_controller")
@RequestMapping("/pc/alipay")
@Scope("prototype")
public class AlipayController extends BaseController{

	@Resource
	private OrderService orderService;
	@Resource
	private SysConfigService sysConfigService;
	@Autowired
	private ActiveService activeService;
	
	

	/**
	 * 支付宝异步通知回调
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/notify",method = {RequestMethod.GET,RequestMethod.POST})
	public void asynchNotify(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		try {
			
			//获取支付宝POST过来反馈信息
			Map<String,String> params = new HashMap<String,String>();
			Map requestParams = request.getParameterMap();
			for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
				String name = (String) iter.next();
				String[] values = (String[]) requestParams.get(name);
				String valueStr = "";
				for (int i = 0; i < values.length; i++) {
					valueStr = (i == values.length - 1) ? valueStr + values[i]
							: valueStr + values[i] + ",";
				}
				//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
				//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
				params.put(name, valueStr);
				logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n>>>>>支付宝异步通知结果:\n");
				logger.info(">>>>>>>>>>>>>>>name："+name+",value:"+valueStr);
			}

			//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
			
			//RSA签名解密
		   	/*if(AlipayConfig.sign_type.equals("0001")) {
		   		params = AlipayNotify.decrypt(params);
		   	}*/
		   	
			//XML解析notify_data数据
			//Document doc_notify_data = DocumentHelper.parseText(params.get("notify_data"));
			
			//JSONObject jsonObject = XmlParseUtil.parseAlipayNotifyData(doc_notify_data);
		   	
		   	JSONObject jsonObject = JSONObject.fromObject(params);
			
			logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n>>>>>支付宝异步通知结果:"+jsonObject.toString()+"\n");
			
			//商户订单号
			//String out_trade_no = doc_notify_data.selectSingleNode( "//notify/out_trade_no" ).getText();

			//支付宝交易号
			//String trade_no = doc_notify_data.selectSingleNode( "//notify/trade_no" ).getText();

			//交易状态
			//String trade_status = doc_notify_data.selectSingleNode( "//notify/trade_status" ).getText();
			
			//商户订单号
			String out_trade_no = jsonObject.optString("out_trade_no");
			
			

			//支付宝交易号
			String trade_no = jsonObject.optString("trade_no");//
              
			//交易状态
			String trade_status = jsonObject.optString("trade_status");
			
			logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n>>>>>out_trade_no:"+out_trade_no+",trade_no:"+trade_no+",trade_status:"+trade_status);

			//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//

			PrintWriter out = response.getWriter();
			
			String[] alipayConfig = sysConfigService.queryAlipayKey();
			
			if(AlipayNotify.verify(params)){//验证成功
				
				System.out.println(">>>>>>>>>>>>>>支付宝签名验证成功\n");
				logger.info(">>>>>>>>>>>>>>支付宝签名验证成功\n");
				//////////////////////////////////////////////////////////////////////////////////////////
				//请在这里加上商户的业务逻辑程序代码

				//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
				
				Status status = null;
				
				if(trade_status.equals("TRADE_FINISHED")){
					//判断该笔订单是否在商户网站中已经做过处理
						//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
						//如果有做过处理，不执行商户的业务程序
						
					//注意：
					//该种交易状态只在两种情况下出现
					//1、开通了普通即时到账，买家付款成功后。
					//2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。
					status = orderService.updateOrderAlipay(out_trade_no,trade_no,jsonObject); 
					
					
					if(status == Status.success){
						
						out.println("success");	//请不要修改或删除
					}
				} else if (trade_status.equals("TRADE_SUCCESS")){
					
					System.out.println(">>>>>>>>>>>>>>before updateOrderAlipay\n");
					//判断该笔订单是否在商户网站中已经做过处理
						//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
						//如果有做过处理，不执行商户的业务程序
						
					//注意：
					//该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。
					status = orderService.updateOrderAlipay(out_trade_no,trade_no,jsonObject);
					
					if(status == Status.success){
						
						out.println("success");	//请不要修改或删除
					}
				}

				//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
					

				//////////////////////////////////////////////////////////////////////////////////////////
			}else{//验证失败
				System.out.println(">>>>>>>>>>>>>>支付宝签名验证失败\n");
				out.println("fail");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("支付宝异步通知回调",e);
		}
	}
	
	
	
	
	/**
	 * 支付宝异步通知回调
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/notify2",method = {RequestMethod.GET,RequestMethod.POST})
	public String asynchNotify2(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
	
		try {
			
			//获取支付宝POST过来反馈信息
			Map<String,String> params = new HashMap<String,String>();
			Map requestParams = request.getParameterMap();
			for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
				String name = (String) iter.next();
				String[] values = (String[]) requestParams.get(name);
				String valueStr = "";
				for (int i = 0; i < values.length; i++) {
					valueStr = (i == values.length - 1) ? valueStr + values[i]
							: valueStr + values[i] + ",";
				}
				//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
				//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
				params.put(name, valueStr);
				logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n>>>>>支付宝异步通知结果:\n");
				logger.info(">>>>>>>>>>>>>>>name："+name+",value:"+valueStr);
			}

			//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
			
			//RSA签名解密
		   	/*if(AlipayConfig.sign_type.equals("0001")) {
		   		params = AlipayNotify.decrypt(params);
		   	}*/
		   	
			//XML解析notify_data数据
			//Document doc_notify_data = DocumentHelper.parseText(params.get("notify_data"));
			
			//JSONObject jsonObject = XmlParseUtil.parseAlipayNotifyData(doc_notify_data);
		   	
		   	JSONObject jsonObject = JSONObject.fromObject(params);
			
			logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n>>>>>支付宝异步通知结果:"+jsonObject.toString()+"\n");
			
			//商户订单号
			//String out_trade_no = doc_notify_data.selectSingleNode( "//notify/out_trade_no" ).getText();

			//支付宝交易号
			//String trade_no = doc_notify_data.selectSingleNode( "//notify/trade_no" ).getText();

			//交易状态
			//String trade_status = doc_notify_data.selectSingleNode( "//notify/trade_status" ).getText();
			
			//商户订单号
			String out_trade_no = jsonObject.optString("out_trade_no");

			//支付宝交易号
			String trade_no = jsonObject.optString("trade_no");//

			//交易状态
			String trade_status = jsonObject.optString("trade_status");
			
			logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n>>>>>out_trade_no:"+out_trade_no+",trade_no:"+trade_no+",trade_status:"+trade_status);

			//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//

			PrintWriter out = response.getWriter();
			
			String[] alipayConfig = sysConfigService.queryAlipayKey();
			
			if(AlipayNotify.verify(params)){//验证成功
				
				System.out.println(">>>>>>>>>>>>>>支付宝签名验证成功\n");
				logger.info(">>>>>>>>>>>>>>支付宝签名验证成功\n");
				//////////////////////////////////////////////////////////////////////////////////////////
				//请在这里加上商户的业务逻辑程序代码

				//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
				
				Status status = null;
				
				if(trade_status.equals("TRADE_FINISHED")){
					//判断该笔订单是否在商户网站中已经做过处理
						//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
						//如果有做过处理，不执行商户的业务程序
						
					//注意：
					//该种交易状态只在两种情况下出现
					//1、开通了普通即时到账，买家付款成功后。
					//2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。
					status = activeService.updateOrderAlipay(out_trade_no,trade_no,jsonObject); 
					
					
					
					if(status == Status.success){
						
						out.println("success");	//请不要修改或删除
					}
				} else if (trade_status.equals("TRADE_SUCCESS")){
					
					System.out.println(">>>>>>>>>>>>>>before updateOrderAlipay\n");
					//判断该笔订单是否在商户网站中已经做过处理
						//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
						//如果有做过处理，不执行商户的业务程序
						
					//注意：
					//该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。
					status = activeService.updateOrderAlipay(out_trade_no,trade_no,jsonObject);
					
					if(status == Status.success){
						
						out.println("success");	//请不要修改或删除
					return "redirect:/pc/pv/myWinningCode";
					}
				}

				//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
					

				//////////////////////////////////////////////////////////////////////////////////////////
			}else{//验证失败
				System.out.println(">>>>>>>>>>>>>>支付宝签名验证失败\n");
				out.println("fail");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("支付宝异步通知回调",e);
		}
		return "redirect:/pc/pv/myWinningCode";
	}
	
	
}
