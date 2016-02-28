package com.bjwg.main.controller.pc;

import java.net.URLDecoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.chinapay.util.SignUtil;
import com.bjwg.main.service.ActiveService;
import com.bjwg.main.service.OrderService;
import com.bjwg.main.service.SysConfigService;

/**
 * 银联回调控制器
 * @author Allen
 * @version 创建时间：2015-6-12 下午05:39:40
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Controller("pc_chinapay_controller")
@RequestMapping("/pc/unionpay")
@Scope("prototype")
public class UnionpayController extends BaseController{

	@Resource
	private OrderService orderService;
	@Resource
	private SysConfigService sysConfigService;
	@Autowired
	private ActiveService activeService;
	/**
	 * 银联异步通知回调
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/notify",method = {RequestMethod.GET,RequestMethod.POST})
	public void asynchNotify() throws Exception{
		try {
			//解析 返回报文
			Enumeration<String> requestNames = request.getParameterNames();
			Map<String, String> resultMap = new HashMap<String, String>();
			while(requestNames.hasMoreElements()){
				String name = requestNames.nextElement();
				String value = request.getParameter(name);
				value = URLDecoder.decode(value, "UTF-8");
				resultMap.put(name, value);
			}
			
			//验证签名
			if(SignUtil.verify(resultMap)){
				System.out.println("签名验证s");
				orderService.updateOrderUnionpay(resultMap.get("MerOrderNo"),resultMap.get("AcqSeqId"),JSONObject.fromObject(resultMap));
				
				response.getWriter().write("success");
			}else{
				response.getWriter().write("fail");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("银联异步通知回调",e);
		}
	}
	
	
	
	
	/**
	 * 银联异步通知回调bj
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/notifybj",method = {RequestMethod.GET,RequestMethod.POST})
	public String asynchNotifybj() throws Exception{
		try {
			
		
			//解析 返回报文
			Enumeration<String> requestNames = request.getParameterNames();
			Map<String, String> resultMap = new HashMap<String, String>();
			while(requestNames.hasMoreElements()){
				String name = requestNames.nextElement();
				
				
				String value = request.getParameter(name);
				value = URLDecoder.decode(value, "UTF-8");
				System.out.println("name="+value);
				resultMap.put(name, value);
			}
			
			
			System.out.println("签名验证");
			//验证签名
			if(SignUtil.verify(resultMap)){
				System.out.println("签名验证s");
				 activeService.updateOrderUnionpay(resultMap.get("MerOrderNo"),resultMap.get("AcqSeqId"),JSONObject.fromObject(resultMap));
				
				 return "redirect:/pc/pv/myWinningCode";
			}else{
				 activeService.updateOrderUnionpay(resultMap.get("MerOrderNo"),resultMap.get("AcqSeqId"),JSONObject.fromObject(resultMap));

				return "redirect:/pc/pv/myWinningCode";
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("银联异步通知回调",e);
		}
		return "redirect:/pc/pv/myWinningCode";

	}
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 银联异步通知回调(无卡)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/notify2",method = {RequestMethod.GET,RequestMethod.POST})
	public void asynchNotify2() throws Exception{
		try {
			//解析 返回报文
			Enumeration<String> requestNames = request.getParameterNames();
			Map<String, String> resultMap = new HashMap<String, String>();
			while(requestNames.hasMoreElements()){
				String name = requestNames.nextElement();
				String value = request.getParameter(name);
				value = URLDecoder.decode(value, "UTF-8");
				resultMap.put(name, value);
			}
			
			//验证签名
			if(com.bjwg.main.chinapay2.util.SignUtil.verify(resultMap)){
				
				orderService.updateOrderUnionpay(resultMap.get("MerOrderNo"),resultMap.get("AcqSeqId"),JSONObject.fromObject(resultMap));
				
				response.getWriter().write("success");
			}else{
				response.getWriter().write("fail");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("银联异步通知回调",e);
		}
	}
	
	
	
	

	/**
	 * 银联异步通知回调(无卡)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/notifybj2",method = {RequestMethod.GET,RequestMethod.POST})
	public String asynchNotifybj2() throws Exception{
		try {
			System.out.println("1111");
			//解析 返回报文
			Enumeration<String> requestNames = request.getParameterNames();
			Map<String, String> resultMap = new HashMap<String, String>();
			while(requestNames.hasMoreElements()){
				String name = requestNames.nextElement();
				String value = request.getParameter(name);
				value = URLDecoder.decode(value, "UTF-8");
				resultMap.put(name, value);
			}
			System.out.println("222222");
			//验证签名
			if(com.bjwg.main.chinapay2.util.SignUtil.verify(resultMap)){
			
        activeService.updateOrderUnionpay(resultMap.get("MerOrderNo"),resultMap.get("AcqSeqId"),JSONObject.fromObject(resultMap));
				
    	return "redirect:/pc/pv/myWinningCode";
			}else{
		        activeService.updateOrderUnionpay(resultMap.get("MerOrderNo"),resultMap.get("AcqSeqId"),JSONObject.fromObject(resultMap));

				return "redirect:/pc/pv/myWinningCode";
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("银联异步通知回调",e);
		}
		return "redirect:/pc/pv/myWinningCode";
	}
	
	
	
	
	
	
	
}















