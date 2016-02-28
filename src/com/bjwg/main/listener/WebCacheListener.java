package com.bjwg.main.listener;

import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.bjwg.main.cache.PhoneCodeCacheTask;
import com.bjwg.main.cache.UserCacheTask;
import com.bjwg.main.cache.WxTicketCacheTask;

/**
 * @author jun
 * @version 创建时间：2015-7-20 上午10:24:27
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：缓存启动监听器
 */
public class WebCacheListener implements ServletContextListener{
	private static Timer userTimer;//用户缓存计时器
	
	private static Timer phoneCodeTimer;//手机验证码计时器
	
	//微信jsapi_ticket缓存
	private static Timer wxTicketTimer;

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		if(userTimer!=null)userTimer.cancel();
		if(phoneCodeTimer!=null)phoneCodeTimer.cancel();
		if(wxTicketTimer!=null)wxTicketTimer.cancel();
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		if (userTimer == null)userTimer = new Timer(true);
		if(phoneCodeTimer==null)phoneCodeTimer=new Timer(true);
		if(wxTicketTimer==null)wxTicketTimer=new Timer(true);
		UserCacheTask t=new UserCacheTask();
		userTimer.schedule(t,10800000L,10800000L);//定时器每隔3小时检查一遍把超过12小时的用户缓存清理掉
//		userTimer.schedule(t,60000L,60000L);//测试1分钟1次
		PhoneCodeCacheTask t2=new PhoneCodeCacheTask();
		phoneCodeTimer.schedule(t2,300000L,300000L);//定时器每隔5分钟检查一遍把超过5分钟的手机验证码缓存清理掉
//		phoneCodeTimer.schedule(t2,60000L,60000L);//测试1分钟1次
		WxTicketCacheTask t3=new WxTicketCacheTask();
		wxTicketTimer.schedule(t3,50 * 60000L,50 * 60000L);//定时器每隔50分钟检查一遍把超过7000秒的ticket缓存清理掉
		
	}
}
