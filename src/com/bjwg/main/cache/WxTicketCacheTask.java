package com.bjwg.main.cache;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TimerTask;

import com.bjwg.main.model.Provalue;
import com.bjwg.main.model.WeiXinUser;
import com.bjwg.main.util.ConsoleUtil;

/**
 * @author jun
 * @version 创建时间：2015-7-22 下午06:04:11
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：微信ticket票据缓存定时器
 */
public class WxTicketCacheTask extends TimerTask{

	@Override
	public void run() {
		
		Map<String, Provalue> provalueMap = ProvalueCache.getProvalueMap();
		
		Map<String, WeiXinUser> wxCodeMap = WxCodeCache.getDataMap();
		
		if(provalueMap != null){
			
			Provalue provalue = null;
			
			List<String> keyList = new ArrayList<String>(); 
			
			for (Map.Entry<String, Provalue> map : provalueMap.entrySet()) {
				
				provalue = map.getValue();
				
				if(provalue != null){
					
					//超过7000秒，移除掉
					if(new Date().getTime() -  provalue.getCtime().getTime() >= 7000 * 1000l){
						
						keyList.add(map.getKey());
					}
				}
			}
			
			for (String k : keyList) {

				provalueMap.remove(k);
				
				ConsoleUtil.println("WxTicketCacheTask移除微信ticket缓存:"+k+"...");
			}
			
		}
		if(wxCodeMap != null){
			
			WeiXinUser weiXinUser = null;
			
			List<String> keyList = new ArrayList<String>(); 
			
			for (Map.Entry<String, WeiXinUser> map : wxCodeMap.entrySet()) {
				
				weiXinUser = map.getValue();
				
				if(weiXinUser != null){
					
					//超过10 * 60秒，移除掉 注意：code的有效期是5分钟
					if(new Date().getTime() -  weiXinUser.getCtime().getTime() >= 600 * 1000l){
						
						keyList.add(map.getKey());
					}
				}
			}
			
			for (String k : keyList) {
				
				wxCodeMap.remove(k);
				
				ConsoleUtil.println("WxTicketCacheTask移除微信code缓存:"+k+"...");
			}
			
		}
		
	}

}
